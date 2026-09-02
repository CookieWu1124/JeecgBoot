package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.common.exception.JeecgBootBizTipException;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.entity.ProposalStatusLog;
import org.jeecg.modules.proposal.entity.ProposalStatusLogRead;
import org.jeecg.modules.proposal.enums.ProposalAction;
import org.jeecg.modules.proposal.mapper.ProposalMapper;
import org.jeecg.modules.proposal.mapper.ProposalStatusLogMapper;
import org.jeecg.modules.proposal.service.IProposalStatusLogReadService;
import org.jeecg.modules.proposal.service.IProposalStatusLogService;
import org.jeecg.modules.proposal.util.ProposalAuditHelper;
import org.jeecg.modules.proposal.vo.app.ProposalMessageItemVo;
import org.jeecg.modules.proposal.vo.app.StatusLogFeedRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ProposalStatusLogServiceImpl extends ServiceImpl<ProposalStatusLogMapper, ProposalStatusLog>
        implements IProposalStatusLogService {

    @Autowired
    private IProposalStatusLogReadService statusLogReadService;
    @Autowired
    private ProposalMapper proposalMapper;

    @Override
    public List<ProposalStatusLog> listHomeFeeds(String userId, boolean approver, int limit) {
        if (oConvertUtils.isEmpty(userId) || limit <= 0) {
            return Collections.emptyList();
        }
        return baseMapper.selectHomeFeeds(userId, approver, limit);
    }

    @Override
    public IPage<ProposalMessageItemVo> pageUserMessages(String scope, int pageNo, int pageSize,
                                                         LoginUser loginUser, boolean approver) {
        String userId = loginUser.getId();
        boolean unreadOnly = "unread".equalsIgnoreCase(scope);
        int safePageNo = Math.max(pageNo, 1);
        int safePageSize = Math.min(Math.max(pageSize, 1), 100);
        int offset = (safePageNo - 1) * safePageSize;

        long total = baseMapper.countUserFeeds(userId, approver, unreadOnly);
        Page<ProposalMessageItemVo> page = new Page<>(safePageNo, safePageSize, total);
        if (total == 0) {
            page.setRecords(Collections.emptyList());
            return page;
        }

        List<StatusLogFeedRow> rows = baseMapper.selectUserFeeds(userId, approver, unreadOnly, offset, safePageSize);
        Set<String> proposalIds = rows.stream()
                .map(StatusLogFeedRow::getProposalId)
                .filter(oConvertUtils::isNotEmpty)
                .collect(Collectors.toCollection(LinkedHashSet::new));
        Map<String, Proposal> proposalMap = proposalIds.isEmpty()
                ? Collections.emptyMap()
                : proposalMapper.selectList(new LambdaQueryWrapper<Proposal>().in(Proposal::getId, proposalIds))
                .stream()
                .collect(Collectors.toMap(Proposal::getId, p -> p, (a, b) -> a));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        List<ProposalMessageItemVo> records = rows.stream().map(row -> {
            Proposal p = proposalMap.get(row.getProposalId());
            ProposalMessageItemVo item = new ProposalMessageItemVo();
            item.setId(row.getId());
            item.setProposalId(row.getProposalId());
            item.setProposalNo(p != null ? p.getProposalNo() : null);
            item.setTitle(p != null ? p.getTitle() : "");
            item.setAction(row.getAction());
            item.setActionLabel(ProposalAction.labelOf(row.getAction()));
            item.setRemark(row.getRemark());
            item.setTime(row.getCreateTime() != null ? sdf.format(row.getCreateTime()) : null);
            item.setUnread(row.getUnread() == null || row.getUnread() == 1);
            return item;
        }).collect(Collectors.toList());
        page.setRecords(records);
        return page;
    }

    @Override
    public long countUnread(String userId, boolean approver) {
        if (oConvertUtils.isEmpty(userId)) {
            return 0;
        }
        return baseMapper.countUserFeeds(userId, approver, true);
    }

    @Override
    public void markRead(String statusLogId, LoginUser loginUser, boolean approver) {
        if (oConvertUtils.isEmpty(statusLogId)) {
            throw new JeecgBootBizTipException("消息ID不能为空");
        }
        String userId = loginUser.getId();
        long related = baseMapper.countRelatedLog(statusLogId, userId, approver);
        if (related <= 0) {
            throw new JeecgBootBizTipException("消息不存在或无权操作");
        }
        long existed = statusLogReadService.count(new LambdaQueryWrapper<ProposalStatusLogRead>()
                .eq(ProposalStatusLogRead::getUserId, userId)
                .eq(ProposalStatusLogRead::getStatusLogId, statusLogId));
        if (existed > 0) {
            return;
        }
        ProposalStatusLogRead read = new ProposalStatusLogRead();
        read.setUserId(userId);
        read.setStatusLogId(statusLogId);
        read.setReadTime(new Date());
        ProposalAuditHelper.fillOnCreate(loginUser, read);
        statusLogReadService.save(read);
    }
}
