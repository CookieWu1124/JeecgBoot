package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.common.exception.JeecgBootBizTipException;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.entity.ProposalApprover;
import org.jeecg.modules.proposal.entity.ProposalCommitteeReview;
import org.jeecg.modules.proposal.entity.ProposalStatusLog;
import org.jeecg.modules.proposal.entity.ProposalStatusLogUnread;
import org.jeecg.modules.proposal.enums.ProposalAction;
import org.jeecg.modules.proposal.enums.ProposalStatusEnum;
import org.jeecg.modules.proposal.mapper.ProposalMapper;
import org.jeecg.modules.proposal.mapper.ProposalStatusLogMapper;
import org.jeecg.modules.proposal.service.IProposalApproverService;
import org.jeecg.modules.proposal.service.IProposalCommitteeReviewService;
import org.jeecg.modules.proposal.service.IProposalStatusLogService;
import org.jeecg.modules.proposal.service.IProposalStatusLogUnreadService;
import org.jeecg.modules.proposal.util.ProposalAuditHelper;
import org.jeecg.modules.proposal.vo.app.ProposalMessageItemVo;
import org.jeecg.modules.proposal.vo.app.StatusLogFeedRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ProposalStatusLogServiceImpl extends ServiceImpl<ProposalStatusLogMapper, ProposalStatusLog>
        implements IProposalStatusLogService {

    @Autowired
    private IProposalStatusLogUnreadService statusLogUnreadService;
    @Autowired
    private ProposalMapper proposalMapper;
    @Autowired
    private IProposalCommitteeReviewService committeeReviewService;
    @Autowired
    private IProposalApproverService approverService;

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
            item.setUnread(row.getUnread() != null && row.getUnread() == 1);
            return item;
        }).collect(Collectors.toList());
        page.setRecords(records);
        return page;
    }

    @Override
    public long countUnread(String userId) {
        if (oConvertUtils.isEmpty(userId)) {
            return 0;
        }
        return baseMapper.countUnreadByUser(userId);
    }

    @Override
    public void markRead(String statusLogId, LoginUser loginUser) {
        if (oConvertUtils.isEmpty(statusLogId)) {
            throw new JeecgBootBizTipException("消息ID不能为空");
        }
        // 幂等：无未读行也当成功
        statusLogUnreadService.physicalDelete(loginUser.getId(), statusLogId);
    }

    //update-begin---author:spex ---date:2026-09-02  for：【消息】全部已读-----------
    @Override
    public int markAllRead(LoginUser loginUser) {
        if (loginUser == null || oConvertUtils.isEmpty(loginUser.getId())) {
            throw new JeecgBootBizTipException("请先登录");
        }
        return statusLogUnreadService.physicalDeleteAllByUser(loginUser.getId());
    }
    //update-end---author:spex ---date:2026-09-02  for：【消息】全部已读-----------

    //update-begin---author:spex ---date:2026-09-02  for：【消息未读】status_log fan-out，排除操作人-----------
    @Override
    public void dispatchUnread(Proposal proposal, ProposalStatusLog log, LoginUser operator) {
        if (proposal == null || log == null || oConvertUtils.isEmpty(log.getId()) || operator == null) {
            return;
        }
        Set<String> recipients = resolveRecipients(proposal);
        recipients.remove(operator.getId());
        if (recipients.isEmpty()) {
            return;
        }
        for (String userId : recipients) {
            long existed = statusLogUnreadService.count(new LambdaQueryWrapper<ProposalStatusLogUnread>()
                    .eq(ProposalStatusLogUnread::getUserId, userId)
                    .eq(ProposalStatusLogUnread::getStatusLogId, log.getId()));
            if (existed > 0) {
                continue;
            }
            ProposalStatusLogUnread unread = new ProposalStatusLogUnread();
            unread.setUserId(userId);
            unread.setStatusLogId(log.getId());
            ProposalAuditHelper.fillOnCreate(operator, unread);
            statusLogUnreadService.save(unread);
        }
    }

    private Set<String> resolveRecipients(Proposal proposal) {
        Set<String> ids = new LinkedHashSet<>();
        if (oConvertUtils.isNotEmpty(proposal.getProposerId())) {
            ids.add(proposal.getProposerId());
        }
        if (oConvertUtils.isNotEmpty(proposal.getDeptLeaderId())) {
            ids.add(proposal.getDeptLeaderId());
        }
        List<ProposalCommitteeReview> reviews = committeeReviewService.list(
                new LambdaQueryWrapper<ProposalCommitteeReview>()
                        .eq(ProposalCommitteeReview::getProposalId, proposal.getId())
                        .select(ProposalCommitteeReview::getReviewerId));
        for (ProposalCommitteeReview review : reviews) {
            if (oConvertUtils.isNotEmpty(review.getReviewerId())) {
                ids.add(review.getReviewerId());
            }
        }
        // 待核定：通知在任批准人
        if (ProposalStatusEnum.PENDING_APPROVAL.getCode().equals(proposal.getStatus())) {
            List<ProposalApprover> approvers = approverService.list(
                    new LambdaQueryWrapper<ProposalApprover>()
                            .eq(ProposalApprover::getApproverStatus, "active")
                            .select(ProposalApprover::getUserId));
            for (ProposalApprover approver : approvers) {
                if (oConvertUtils.isNotEmpty(approver.getUserId())) {
                    ids.add(approver.getUserId());
                }
            }
        }
        return ids;
    }
    //update-end---author:spex ---date:2026-09-02  for：【消息未读】status_log fan-out，排除操作人-----------
}
