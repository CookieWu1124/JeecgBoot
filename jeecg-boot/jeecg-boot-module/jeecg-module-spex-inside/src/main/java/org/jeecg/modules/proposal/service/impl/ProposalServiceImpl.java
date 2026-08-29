package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.jeecg.common.exception.JeecgBootBizTipException;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.*;
import org.jeecg.modules.proposal.enums.ProposalStatusEnum;
import org.jeecg.modules.proposal.mapper.ProposalMapper;
import org.jeecg.modules.proposal.service.*;
import org.jeecg.modules.proposal.util.ProposalAuditHelper;
import org.jeecg.modules.proposal.vo.ProposalCreateRequest;
import org.jeecg.modules.proposal.vo.ProposalDetailVo;
import org.jeecg.modules.proposal.vo.app.ProposalHomeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 提案主表 Service 实现
 */
@Service
public class ProposalServiceImpl extends ServiceImpl<ProposalMapper, Proposal> implements IProposalService {

    private static final int MAX_ATTACHMENTS = 4;
    private static final Set<String> TERMINAL_STATUSES = Set.of(
            ProposalStatusEnum.COMPLETED.getCode(),
            ProposalStatusEnum.REJECTED_FINAL.getCode(),
            ProposalStatusEnum.WITHDRAWN.getCode()
    );

    @Autowired
    private IProposalApplicationService applicationService;
    @Autowired
    private IProposalAttachmentService attachmentService;
    @Autowired
    private IProposalStatusLogService statusLogService;
    @Autowired
    private IProposalDeptLeaderService deptLeaderService;
    @Autowired
    private IProposalCommitteeMemberService committeeMemberService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String createDraft(ProposalCreateRequest request, LoginUser loginUser) {
        Proposal proposal = new Proposal();
        proposal.setTitle(trimToNull(request.getTitle()));
        proposal.setImprovementTypes(normalizeImprovementTypes(request.getImprovementTypes()));
        proposal.setDeptId(request.getDeptId());
        proposal.setTeamType(defaultTeamType(request.getTeamType()));
        proposal.setProposerId(loginUser.getId());
        proposal.setStatus(ProposalStatusEnum.DRAFT.getCode());
        proposal.setPlanRound(0);
        applyDeptLeader(proposal);
        ProposalAuditHelper.fillOnCreate(loginUser, proposal);
        save(proposal);

        saveOrUpdateApplication(proposal.getId(), request, loginUser, true);
        replaceAttachments(proposal.getId(), request.getAttachments(), loginUser);
        return proposal.getId();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateDraft(String id, ProposalCreateRequest request, LoginUser loginUser) {
        Proposal proposal = getOwnedDraft(id, loginUser);
        proposal.setTitle(trimToNull(request.getTitle()));
        proposal.setImprovementTypes(normalizeImprovementTypes(request.getImprovementTypes()));
        proposal.setDeptId(request.getDeptId());
        proposal.setTeamType(defaultTeamType(request.getTeamType()));
        applyDeptLeader(proposal);
        ProposalAuditHelper.fillOnUpdate(loginUser, proposal);
        updateById(proposal);

        saveOrUpdateApplication(id, request, loginUser, false);
        replaceAttachments(id, request.getAttachments(), loginUser);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void submit(String id, LoginUser loginUser) {
        Proposal proposal = getOwnedDraft(id, loginUser);
        ProposalApplication application = getApplication(id);
        validateSubmit(proposal, application);

        if (oConvertUtils.isEmpty(proposal.getDeptLeaderId())) {
            throw new JeecgBootBizTipException("该改善部门尚未配置负责人，无法提交");
        }

        long committeeTotal = committeeMemberService.count(new LambdaQueryWrapper<ProposalCommitteeMember>()
                .eq(ProposalCommitteeMember::getMemberStatus, "active"));
        if (committeeTotal <= 0) {
            throw new JeecgBootBizTipException("委员会名册为空，无法提交");
        }

        String fromStatus = proposal.getStatus();
        if (oConvertUtils.isEmpty(proposal.getProposalNo())) {
            proposal.setProposalNo(generateProposalNo());
        }
        proposal.setStatus(ProposalStatusEnum.PENDING_REVIEW.getCode());
        proposal.setReviewProgress("0/" + committeeTotal);
        ProposalAuditHelper.fillOnUpdate(loginUser, proposal);
        updateById(proposal);

        application.setSubmitTime(new Date());
        ProposalAuditHelper.fillOnUpdate(loginUser, application);
        applicationService.updateById(application);

        appendStatusLog(id, fromStatus, proposal.getStatus(), "SUBMIT", loginUser, "提交申请");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void withdraw(String id, LoginUser loginUser) {
        Proposal proposal = getById(id);
        if (proposal == null) {
            throw new JeecgBootBizTipException("提案不存在");
        }
        if (!loginUser.getId().equals(proposal.getProposerId())) {
            throw new JeecgBootBizTipException("仅提案人可撤回");
        }
        if (!ProposalStatusEnum.PENDING_REVIEW.getCode().equals(proposal.getStatus())) {
            throw new JeecgBootBizTipException("仅待审核状态可撤回");
        }

        String fromStatus = proposal.getStatus();
        proposal.setStatus(ProposalStatusEnum.WITHDRAWN.getCode());
        ProposalAuditHelper.fillOnUpdate(loginUser, proposal);
        updateById(proposal);
        appendStatusLog(id, fromStatus, proposal.getStatus(), "WITHDRAW", loginUser, "撤回申请");
    }

    @Override
    public ProposalDetailVo getDetail(String id, LoginUser loginUser) {
        Proposal proposal = getById(id);
        if (proposal == null) {
            throw new JeecgBootBizTipException("提案不存在");
        }
        assertCanView(proposal, loginUser);
        return buildDetailVo(proposal, false);
    }

    //update-begin---author:cursor ---date:2026-08-29  for：【提案管理】管理端详情含申请书与留痕-----------
    @Override
    public ProposalDetailVo getAdminDetail(String id) {
        Proposal proposal = getById(id);
        if (proposal == null) {
            throw new JeecgBootBizTipException("提案不存在");
        }
        return buildDetailVo(proposal, true);
    }

    private ProposalDetailVo buildDetailVo(Proposal proposal, boolean withStatusLogs) {
        String id = proposal.getId();
        ProposalDetailVo vo = new ProposalDetailVo();
        vo.setProposal(proposal);
        vo.setApplication(applicationService.getOne(new LambdaQueryWrapper<ProposalApplication>()
                .eq(ProposalApplication::getProposalId, id)));
        vo.setAttachments(attachmentService.list(new LambdaQueryWrapper<ProposalAttachment>()
                .eq(ProposalAttachment::getProposalId, id)
                .orderByAsc(ProposalAttachment::getSortNo)));
        if (withStatusLogs) {
            vo.setStatusLogs(statusLogService.list(new LambdaQueryWrapper<ProposalStatusLog>()
                    .eq(ProposalStatusLog::getProposalId, id)
                    .orderByDesc(ProposalStatusLog::getCreateTime)));
        }
        return vo;
    }
    //update-end---author:cursor ---date:2026-08-29  for：【提案管理】管理端详情含申请书与留痕-----------

    @Override
    public IPage<Proposal> listForUser(String tab, String title, int pageNo, int pageSize, LoginUser loginUser) {
        LambdaQueryWrapper<Proposal> qw = new LambdaQueryWrapper<>();
        qw.eq(Proposal::getProposerId, loginUser.getId());
        if (oConvertUtils.isNotEmpty(title)) {
            qw.like(Proposal::getTitle, title);
        }
        applyListTab(qw, tab);
        qw.orderByDesc(Proposal::getCreateTime);
        return page(new Page<>(pageNo, pageSize), qw);
    }

    @Override
    public ProposalHomeVo buildHome(LoginUser loginUser) {
        ProposalHomeVo vo = new ProposalHomeVo();
        vo.setGreeting(buildGreeting());
        vo.setUserName(loginUser.getRealname());
        vo.setDeptDesc(buildDeptDesc(loginUser));

        String userId = loginUser.getId();
        vo.setTodoCount(countDrafts(userId));
        vo.setDoingCount(countDoing(userId));
        vo.setDoneCount(countDone(userId));
        vo.setTodoItems(buildTodoItems(userId));
        vo.setFeeds(buildFeeds(userId));
        return vo;
    }

    private Proposal getOwnedDraft(String id, LoginUser loginUser) {
        Proposal proposal = getById(id);
        if (proposal == null) {
            throw new JeecgBootBizTipException("提案不存在");
        }
        if (!loginUser.getId().equals(proposal.getProposerId())) {
            throw new JeecgBootBizTipException("仅提案人可编辑草稿");
        }
        if (!ProposalStatusEnum.DRAFT.getCode().equals(proposal.getStatus())) {
            throw new JeecgBootBizTipException("仅草稿状态可编辑");
        }
        return proposal;
    }

    private ProposalApplication getApplication(String proposalId) {
        ProposalApplication application = applicationService.getOne(new LambdaQueryWrapper<ProposalApplication>()
                .eq(ProposalApplication::getProposalId, proposalId));
        if (application == null) {
            throw new JeecgBootBizTipException("申请书数据不存在");
        }
        return application;
    }

    private void saveOrUpdateApplication(String proposalId, ProposalCreateRequest request, LoginUser loginUser, boolean isCreate) {
        ProposalApplication application = applicationService.getOne(new LambdaQueryWrapper<ProposalApplication>()
                .eq(ProposalApplication::getProposalId, proposalId));
        if (application == null) {
            application = new ProposalApplication();
            application.setProposalId(proposalId);
            isCreate = true;
        }
        application.setCurrentSituation(trimToNull(request.getCurrentSituation()));
        application.setImprovementSuggestion(trimToNull(request.getImprovementSuggestion()));
        application.setEmail(trimToNull(request.getEmail()));
        if (isCreate) {
            ProposalAuditHelper.fillOnCreate(loginUser, application);
        } else {
            ProposalAuditHelper.fillOnUpdate(loginUser, application);
        }
        applicationService.saveOrUpdate(application);
    }

    private void replaceAttachments(String proposalId, List<ProposalCreateRequest.AttachmentItem> items, LoginUser loginUser) {
        attachmentService.remove(new LambdaQueryWrapper<ProposalAttachment>()
                .eq(ProposalAttachment::getProposalId, proposalId));
        if (items == null || items.isEmpty()) {
            return;
        }
        if (items.size() > MAX_ATTACHMENTS) {
            throw new JeecgBootBizTipException("现场图片最多上传 " + MAX_ATTACHMENTS + " 张");
        }
        int sort = 1;
        for (ProposalCreateRequest.AttachmentItem item : items) {
            if (item == null || oConvertUtils.isEmpty(item.getFileUrl())) {
                continue;
            }
            ProposalAttachment attachment = new ProposalAttachment();
            attachment.setProposalId(proposalId);
            attachment.setBizType("APPLICATION_IMAGE");
            attachment.setFileName(item.getFileName());
            attachment.setFileUrl(item.getFileUrl());
            attachment.setFileSize(item.getFileSize());
            attachment.setSortNo(sort++);
            ProposalAuditHelper.fillOnCreate(loginUser, attachment);
            attachmentService.save(attachment);
        }
    }

    private void applyDeptLeader(Proposal proposal) {
        proposal.setDeptLeaderId(null);
        if (oConvertUtils.isEmpty(proposal.getDeptId())) {
            return;
        }
        ProposalDeptLeader config = deptLeaderService.getOne(new LambdaQueryWrapper<ProposalDeptLeader>()
                .eq(ProposalDeptLeader::getDeptId, proposal.getDeptId()));
        if (config != null && oConvertUtils.isNotEmpty(config.getLeaderUserId())) {
            proposal.setDeptLeaderId(config.getLeaderUserId());
        }
    }

    private void validateSubmit(Proposal proposal, ProposalApplication application) {
        if (oConvertUtils.isEmpty(proposal.getTitle())) {
            throw new JeecgBootBizTipException("请填写提案名称");
        }
        if (proposal.getTitle().length() > 50) {
            throw new JeecgBootBizTipException("提案名称不能超过50字");
        }
        if (oConvertUtils.isEmpty(proposal.getImprovementTypes())) {
            throw new JeecgBootBizTipException("请选择改善性质");
        }
        if (oConvertUtils.isEmpty(proposal.getDeptId())) {
            throw new JeecgBootBizTipException("请选择改善部门");
        }
        if (oConvertUtils.isEmpty(application.getCurrentSituation())) {
            throw new JeecgBootBizTipException("请填写目前状况及问题");
        }
        if (oConvertUtils.isEmpty(application.getImprovementSuggestion())) {
            throw new JeecgBootBizTipException("请填写改善意见");
        }
        if (oConvertUtils.isEmpty(application.getEmail())) {
            throw new JeecgBootBizTipException("请填写通知邮箱");
        }
    }

    private void assertCanView(Proposal proposal, LoginUser loginUser) {
        if (loginUser.getId().equals(proposal.getProposerId())) {
            return;
        }
        if (loginUser.getId().equals(proposal.getImplementLeaderId())) {
            return;
        }
        throw new JeecgBootBizTipException("无权查看该提案");
    }

    private void applyListTab(LambdaQueryWrapper<Proposal> qw, String tab) {
        if (oConvertUtils.isEmpty(tab) || "all".equalsIgnoreCase(tab) || "mine".equalsIgnoreCase(tab)) {
            return;
        }
        if ("draft".equalsIgnoreCase(tab)) {
            qw.eq(Proposal::getStatus, ProposalStatusEnum.DRAFT.getCode());
            return;
        }
        if ("doing".equalsIgnoreCase(tab)) {
            qw.notIn(Proposal::getStatus, TERMINAL_STATUSES);
            qw.ne(Proposal::getStatus, ProposalStatusEnum.DRAFT.getCode());
            return;
        }
        if ("done".equalsIgnoreCase(tab)) {
            qw.in(Proposal::getStatus, ProposalStatusEnum.COMPLETED.getCode(),
                    ProposalStatusEnum.REJECTED_FINAL.getCode(),
                    ProposalStatusEnum.WITHDRAWN.getCode());
        }
    }

    private String generateProposalNo() {
        String datePart = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String prefix = datePart;
        Proposal latest = getOne(new LambdaQueryWrapper<Proposal>()
                .likeRight(Proposal::getProposalNo, prefix)
                .orderByDesc(Proposal::getProposalNo)
                .last("LIMIT 1"));
        int next = 1;
        if (latest != null && latest.getProposalNo() != null && latest.getProposalNo().length() >= 12) {
            try {
                next = Integer.parseInt(latest.getProposalNo().substring(8)) + 1;
            } catch (NumberFormatException ignored) {
                next = 1;
            }
        }
        if (next > 9999) {
            throw new JeecgBootBizTipException("当日提案编号已达上限");
        }
        return prefix + String.format("%04d", next);
    }

    private void appendStatusLog(String proposalId, String fromStatus, String toStatus,
                                 String action, LoginUser loginUser, String remark) {
        ProposalStatusLog log = new ProposalStatusLog();
        log.setProposalId(proposalId);
        log.setFromStatus(fromStatus);
        log.setToStatus(toStatus);
        log.setAction(action);
        log.setOperatorId(loginUser.getId());
        log.setRemark(remark);
        ProposalAuditHelper.fillOnCreate(loginUser, log);
        statusLogService.save(log);
    }

    private long countDrafts(String userId) {
        return count(new LambdaQueryWrapper<Proposal>()
                .eq(Proposal::getProposerId, userId)
                .eq(Proposal::getStatus, ProposalStatusEnum.DRAFT.getCode()));
    }

    private long countDoing(String userId) {
        return count(new LambdaQueryWrapper<Proposal>()
                .eq(Proposal::getProposerId, userId)
                .notIn(Proposal::getStatus, TERMINAL_STATUSES)
                .ne(Proposal::getStatus, ProposalStatusEnum.DRAFT.getCode()));
    }

    private long countDone(String userId) {
        return count(new LambdaQueryWrapper<Proposal>()
                .eq(Proposal::getProposerId, userId)
                .eq(Proposal::getStatus, ProposalStatusEnum.COMPLETED.getCode()));
    }

    private List<ProposalHomeVo.TodoItem> buildTodoItems(String userId) {
        List<Proposal> drafts = list(new LambdaQueryWrapper<Proposal>()
                .eq(Proposal::getProposerId, userId)
                .eq(Proposal::getStatus, ProposalStatusEnum.DRAFT.getCode())
                .orderByDesc(Proposal::getUpdateTime)
                .last("LIMIT 3"));
        return drafts.stream().map(p -> {
            ProposalHomeVo.TodoItem item = new ProposalHomeVo.TodoItem();
            item.setProposalId(p.getId());
            item.setProposalNo(p.getProposalNo());
            item.setTitle(p.getTitle());
            item.setStatus(p.getStatus());
            item.setStatusLabel(ProposalStatusEnum.DRAFT.getLabel());
            item.setActionHint("继续编辑并提交");
            return item;
        }).collect(Collectors.toList());
    }

    private List<ProposalHomeVo.FeedItem> buildFeeds(String userId) {
        List<Proposal> mine = list(new LambdaQueryWrapper<Proposal>()
                .eq(Proposal::getProposerId, userId)
                .orderByDesc(Proposal::getUpdateTime)
                .last("LIMIT 20"));
        if (mine.isEmpty()) {
            return Collections.emptyList();
        }
        Map<String, Proposal> proposalMap = mine.stream()
                .collect(Collectors.toMap(Proposal::getId, p -> p, (a, b) -> a, LinkedHashMap::new));
        List<ProposalStatusLog> logs = statusLogService.list(new LambdaQueryWrapper<ProposalStatusLog>()
                .in(ProposalStatusLog::getProposalId, proposalMap.keySet())
                .orderByDesc(ProposalStatusLog::getCreateTime)
                .last("LIMIT 5"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        return logs.stream().map(log -> {
            Proposal p = proposalMap.get(log.getProposalId());
            ProposalHomeVo.FeedItem feed = new ProposalHomeVo.FeedItem();
            feed.setProposalId(log.getProposalId());
            feed.setProposalNo(p != null ? p.getProposalNo() : null);
            feed.setTitle(p != null ? p.getTitle() : "");
            feed.setAction(log.getAction());
            feed.setRemark(log.getRemark());
            feed.setTime(log.getCreateTime() != null ? sdf.format(log.getCreateTime()) : null);
            return feed;
        }).collect(Collectors.toList());
    }

    private String buildGreeting() {
        Calendar cal = Calendar.getInstance();
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        if (hour < 12) {
            return "早上好";
        }
        if (hour < 18) {
            return "下午好";
        }
        return "晚上好";
    }

    private String buildDeptDesc(LoginUser loginUser) {
        if (oConvertUtils.isNotEmpty(loginUser.getOrgCode())) {
            return loginUser.getOrgCode();
        }
        return "";
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private String normalizeImprovementTypes(String value) {
        if (oConvertUtils.isEmpty(value)) {
            return null;
        }
        String trimmed = value.trim();
        if (trimmed.startsWith("[")) {
            return trimmed;
        }
        return trimmed;
    }

    private String defaultTeamType(String teamType) {
        return oConvertUtils.isEmpty(teamType) ? "PERSONAL" : teamType;
    }
}
