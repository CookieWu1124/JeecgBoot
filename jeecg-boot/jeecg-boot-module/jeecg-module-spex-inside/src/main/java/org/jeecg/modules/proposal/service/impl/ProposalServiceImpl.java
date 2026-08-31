package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.jeecg.common.exception.JeecgBootBizTipException;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.*;
import org.jeecg.modules.proposal.enums.ProposalAction;
import org.jeecg.modules.proposal.enums.ProposalStatusEnum;
import org.jeecg.modules.proposal.mapper.ProposalMapper;
import org.jeecg.modules.proposal.service.*;
import org.jeecg.modules.proposal.util.ProposalAuditHelper;
import org.jeecg.modules.proposal.vo.ApplicationApprovalRequest;
import org.jeecg.modules.proposal.vo.CommitteeReviewRequest;
import org.jeecg.modules.proposal.vo.ProposalCreateRequest;
import org.jeecg.modules.proposal.vo.ProposalDetailVo;
import org.jeecg.modules.proposal.vo.app.ProposalHomeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
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
            ProposalStatusEnum.APPROVED.getCode()
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
    @Autowired
    private IProposalCommitteeReviewService committeeReviewService;
    @Autowired
    private IProposalApproverService approverService;
    @Autowired
    private IProposalApprovalRecordService approvalRecordService;
    @Autowired
    private ProposalStateMachine stateMachine;
    @Autowired
    private IProposalImprovementTypeService improvementTypeService;
    @Autowired
    private ProposalOrgFillHelper orgFillHelper;

    private static final String CONCLUSION_ADOPT = "ADOPT";
    private static final String CONCLUSION_REJECT = "REJECT";
    private static final String DECISION_APPROVE = "APPROVE";
    private static final String DECISION_REJECT = "REJECT";
    private static final String APPROVAL_STAGE_APPLICATION = "APPLICATION";

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String create(ProposalCreateRequest request, LoginUser loginUser) {
        Proposal proposal = new Proposal();
        proposal.setTitle(trimToNull(request.getTitle()));
        proposal.setImprovementTypes(normalizeImprovementTypes(request.getImprovementTypes()));
        proposal.setDeptId(request.getDeptId());
        proposal.setTeamType(defaultTeamType(request.getTeamType()));
        proposal.setProposerId(loginUser.getId());
        proposal.setStatus(ProposalStatusEnum.PENDING_REVIEW.getCode());
        proposal.setPlanRound(0);
        applyDeptLeader(proposal);
        if (oConvertUtils.isEmpty(proposal.getDeptLeaderId())) {
            throw new JeecgBootBizTipException("该改善部门尚未配置负责人，无法提交");
        }

        long committeeTotal = committeeMemberService.count(new LambdaQueryWrapper<ProposalCommitteeMember>()
                .eq(ProposalCommitteeMember::getMemberStatus, "active"));
        if (committeeTotal <= 0) {
            throw new JeecgBootBizTipException("委员会名册为空，无法提交");
        }
        proposal.setProposalNo(generateProposalNo());
        proposal.setReviewProgress("0/" + committeeTotal);
        ProposalAuditHelper.fillOnCreate(loginUser, proposal);
        save(proposal);

        saveOrUpdateApplication(proposal.getId(), request, loginUser, true);
        ProposalApplication application = getApplication(proposal.getId());
        validateSubmit(proposal, application);
        application.setSubmitTime(new Date());
        ProposalAuditHelper.fillOnUpdate(loginUser, application);
        applicationService.updateById(application);

        replaceAttachments(proposal.getId(), request.getAttachments(), loginUser);
        createReviewSnapshot(proposal, loginUser);
        stateMachine.recordEnter(proposal, ProposalAction.SUBMIT, loginUser, "提交申请");
        return proposal.getId();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void submit(String id, LoginUser loginUser) {
        Proposal existing = getById(id);
        if (existing == null) {
            throw new JeecgBootBizTipException("提案不存在");
        }
        if (!loginUser.getId().equals(existing.getProposerId())) {
            throw new JeecgBootBizTipException("仅提案人可提交");
        }
        if (ProposalStatusEnum.PENDING_REVIEW.getCode().equals(existing.getStatus())) {
            return;
        }
        throw new JeecgBootBizTipException("申请段已取消暂存，请通过发起接口提交");
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

    // 【提案管理】管理端详情含申请书与留痕
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
        // 在途单若缺快照则补种，便于详情/管理端展示
        if (ProposalStatusEnum.PENDING_REVIEW.getCode().equals(proposal.getStatus())) {
            ensureReviewSnapshot(proposal, null);
        }
        ProposalStatusEnum.attachLabel(proposal);
        improvementTypeService.attachTypeLabels(Collections.singletonList(proposal));
        ProposalDetailVo vo = new ProposalDetailVo();
        vo.setProposal(proposal);
        vo.setApplication(applicationService.getOne(new LambdaQueryWrapper<ProposalApplication>()
                .eq(ProposalApplication::getProposalId, id)));
        vo.setAttachments(attachmentService.list(new LambdaQueryWrapper<ProposalAttachment>()
                .eq(ProposalAttachment::getProposalId, id)
                .orderByAsc(ProposalAttachment::getSortNo)));
        if (withStatusLogs) {
            List<ProposalStatusLog> logs = statusLogService.list(new LambdaQueryWrapper<ProposalStatusLog>()
                    .eq(ProposalStatusLog::getProposalId, id)
                    .orderByDesc(ProposalStatusLog::getCreateTime));
            logs.forEach(this::fillStatusLogLabels);
            vo.setStatusLogs(logs);
        }
        vo.setCommitteeReviews(committeeReviewService.list(new LambdaQueryWrapper<ProposalCommitteeReview>()
                .eq(ProposalCommitteeReview::getProposalId, id)
                .orderByAsc(ProposalCommitteeReview::getCreateTime)));
        vo.setApplicationApproval(approvalRecordService.getOne(new LambdaQueryWrapper<ProposalApproval>()
                .eq(ProposalApproval::getProposalId, id)
                .eq(ProposalApproval::getStage, APPROVAL_STAGE_APPLICATION)));
        //update-begin---author:spex ---date:2026-08-31  for：【提案管理端】详情嵌套回显人员部门-----------
        orgFillHelper.fillDetail(vo);
        //update-end---author:spex ---date:2026-08-31  for：【提案管理端】详情嵌套回显人员部门-----------
        return vo;
    }

    // 【Phase2】委员待审列表与提交意见
    @Override
    public IPage<Proposal> listCommitteePending(int pageNo, int pageSize, LoginUser loginUser) {
        ensurePendingSnapshots();
        List<ProposalCommitteeReview> myPending = committeeReviewService.list(
                new LambdaQueryWrapper<ProposalCommitteeReview>()
                        .eq(ProposalCommitteeReview::getReviewerId, loginUser.getId())
                        .isNull(ProposalCommitteeReview::getConclusion));
        if (myPending.isEmpty()) {
            return new Page<>(pageNo, pageSize);
        }
        List<String> proposalIds = myPending.stream()
                .map(ProposalCommitteeReview::getProposalId)
                .distinct()
                .collect(Collectors.toList());
        LambdaQueryWrapper<Proposal> qw = new LambdaQueryWrapper<>();
        qw.in(Proposal::getId, proposalIds)
                .eq(Proposal::getStatus, ProposalStatusEnum.PENDING_REVIEW.getCode())
                .orderByDesc(Proposal::getCreateTime);
        return withStatusLabels(page(new Page<>(pageNo, pageSize), qw));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void submitCommitteeReview(String proposalId, CommitteeReviewRequest request, LoginUser loginUser) {
        if (request == null || oConvertUtils.isEmpty(request.getConclusion())) {
            throw new JeecgBootBizTipException("请选择审核结论");
        }
        String conclusion = request.getConclusion().trim().toUpperCase();
        if (!CONCLUSION_ADOPT.equals(conclusion) && !CONCLUSION_REJECT.equals(conclusion)) {
            throw new JeecgBootBizTipException("审核结论无效");
        }

        Proposal proposal = getById(proposalId);
        if (proposal == null) {
            throw new JeecgBootBizTipException("提案不存在");
        }
        // 委员逐条填意见不改 status，不能走 transit。
        stateMachine.assertStatus(proposal, ProposalStatusEnum.PENDING_REVIEW, "仅审核中状态可提交委员意见");

        ensureReviewSnapshot(proposal, loginUser);

        ProposalCommitteeReview row = committeeReviewService.getOne(new LambdaQueryWrapper<ProposalCommitteeReview>()
                .eq(ProposalCommitteeReview::getProposalId, proposalId)
                .eq(ProposalCommitteeReview::getReviewerId, loginUser.getId()));
        if (row == null) {
            throw new JeecgBootBizTipException("您不在本提案的审核名册中");
        }
        if (oConvertUtils.isNotEmpty(row.getConclusion())) {
            throw new JeecgBootBizTipException("您已提交过审核意见，不可修改");
        }

        if (CONCLUSION_ADOPT.equals(conclusion)) {
            if (request.getPlanRequired() == null) {
                throw new JeecgBootBizTipException("请选择是否形成改善计划书");
            }
            if (request.getPlanRequired() != 0 && request.getPlanRequired() != 1) {
                throw new JeecgBootBizTipException("计划书建议取值无效");
            }
            row.setPlanRequired(request.getPlanRequired());
            row.setAwardSuggestion(request.getAwardSuggestion());
            row.setComment(trimToNull(request.getComment()));
        } else {
            String comment = trimToNull(request.getComment());
            if (oConvertUtils.isEmpty(comment)) {
                throw new JeecgBootBizTipException("不采用时请填写综合评价");
            }
            row.setPlanRequired(null);
            row.setAwardSuggestion(null);
            row.setComment(comment);
        }

        row.setConclusion(conclusion);
        row.setReviewTime(new Date());
        ProposalAuditHelper.fillOnUpdate(loginUser, row);
        committeeReviewService.updateById(row);

        refreshReviewProgress(proposal, loginUser);
    }

    // 【Phase2】批准人待核定与申请决策
    @Override
    public IPage<Proposal> listApprovalPending(int pageNo, int pageSize, LoginUser loginUser) {
        assertActiveApprover(loginUser);
        LambdaQueryWrapper<Proposal> qw = new LambdaQueryWrapper<>();
        qw.eq(Proposal::getStatus, ProposalStatusEnum.PENDING_APPROVAL.getCode())
                .orderByDesc(Proposal::getUpdateTime);
        return withStatusLabels(page(new Page<>(pageNo, pageSize), qw));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void submitApplicationApproval(String proposalId, ApplicationApprovalRequest request, LoginUser loginUser) {
        assertActiveApprover(loginUser);
        if (request == null || oConvertUtils.isEmpty(request.getDecision())) {
            throw new JeecgBootBizTipException("请选择批准决策");
        }
        String decision = request.getDecision().trim().toUpperCase();
        if (!DECISION_APPROVE.equals(decision) && !DECISION_REJECT.equals(decision)) {
            throw new JeecgBootBizTipException("批准决策无效");
        }

        Proposal proposal = getById(proposalId);
        if (proposal == null) {
            throw new JeecgBootBizTipException("提案不存在");
        }
        long existed = approvalRecordService.count(new LambdaQueryWrapper<ProposalApproval>()
                .eq(ProposalApproval::getProposalId, proposalId)
                .eq(ProposalApproval::getStage, APPROVAL_STAGE_APPLICATION));
        if (existed > 0) {
            throw new JeecgBootBizTipException("该提案已完成申请批准决策，不可重复提交");
        }

        ProposalApproval record = new ProposalApproval();
        record.setProposalId(proposalId);
        record.setApproverId(loginUser.getId());
        record.setStage(APPROVAL_STAGE_APPLICATION);
        record.setDecision(decision);
        record.setApproveTime(new Date());

        if (DECISION_APPROVE.equals(decision)) {
            if (request.getPlanRequired() == null
                    || (request.getPlanRequired() != 0 && request.getPlanRequired() != 1)) {
                throw new JeecgBootBizTipException("请核定是否形成改善计划书");
            }
            record.setPlanRequired(request.getPlanRequired());
            record.setAwardAmount(request.getAwardAmount());
            record.setComment(trimToNull(request.getComment()));

            proposal.setPlanRequired(request.getPlanRequired());
            proposal.setAwardAmount(request.getAwardAmount());
            stateMachine.transit(proposal, ProposalAction.APPROVE, loginUser, "申请批准");
        } else {
            String comment = trimToNull(request.getComment());
            if (oConvertUtils.isEmpty(comment)) {
                throw new JeecgBootBizTipException("不批准时请填写原因");
            }
            record.setPlanRequired(null);
            record.setAwardAmount(null);
            record.setComment(comment);

            stateMachine.transit(proposal, ProposalAction.REJECT_FINAL, loginUser, comment);
        }

        ProposalAuditHelper.fillOnCreate(loginUser, record);
        approvalRecordService.save(record);
    }

    @Override
    public IPage<Proposal> listForUser(String tab, String title, int pageNo, int pageSize, LoginUser loginUser) {
        LambdaQueryWrapper<Proposal> qw = new LambdaQueryWrapper<>();
        qw.eq(Proposal::getProposerId, loginUser.getId());
        if (oConvertUtils.isNotEmpty(title)) {
            qw.like(Proposal::getTitle, title);
        }
        applyListTab(qw, tab);
        qw.orderByDesc(Proposal::getCreateTime);
        return withStatusLabels(page(new Page<>(pageNo, pageSize), qw));
    }

    @Override
    public ProposalHomeVo buildHome(LoginUser loginUser) {
        ProposalHomeVo vo = new ProposalHomeVo();
        vo.setGreeting(buildGreeting());
        vo.setUserName(loginUser.getRealname());
        vo.setDeptDesc(buildDeptDesc(loginUser));

        String userId = loginUser.getId();
        List<ProposalHomeVo.TodoItem> todoItems = buildHomeTodos(loginUser);
        vo.setTodoCount(countHomeTodos(loginUser));
        vo.setDoingCount(countDoing(userId));
        vo.setDoneCount(countDone(userId));
        vo.setTodoItems(todoItems);
        vo.setFeeds(buildFeeds(userId));
        return vo;
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
        improvementTypeService.assertEnabledCodes(proposal.getImprovementTypes());
        if (oConvertUtils.isEmpty(proposal.getDeptId())) {
            throw new JeecgBootBizTipException("请选择改善部门");
        }
        if (oConvertUtils.isEmpty(application.getCurrentSituation())) {
            throw new JeecgBootBizTipException("请填写目前状况及问题");
        }
        if (oConvertUtils.isEmpty(application.getImprovementSuggestion())) {
            throw new JeecgBootBizTipException("请填写改善意见");
        }
    }

    private void assertCanView(Proposal proposal, LoginUser loginUser) {
        if (loginUser.getId().equals(proposal.getProposerId())) {
            return;
        }
        if (loginUser.getId().equals(proposal.getImplementLeaderId())) {
            return;
        }
        // 【Phase2】快照委员可查看详情
        long asReviewer = committeeReviewService.count(new LambdaQueryWrapper<ProposalCommitteeReview>()
                .eq(ProposalCommitteeReview::getProposalId, proposal.getId())
                .eq(ProposalCommitteeReview::getReviewerId, loginUser.getId()));
        if (asReviewer > 0) {
            return;
        }
        // 尚无快照时：当前在任委员也可看（便于补种前打开）
        if (ProposalStatusEnum.PENDING_REVIEW.getCode().equals(proposal.getStatus())) {
            long onRoster = committeeMemberService.count(new LambdaQueryWrapper<ProposalCommitteeMember>()
                    .eq(ProposalCommitteeMember::getUserId, loginUser.getId())
                    .eq(ProposalCommitteeMember::getMemberStatus, "active"));
            if (onRoster > 0) {
                return;
            }
        }
        // 【Phase2】在任批准人可查看待批准及已决策提案
        if (isActiveApprover(loginUser.getId())) {
            return;
        }

        throw new JeecgBootBizTipException("无权查看该提案");
    }

    private void assertActiveApprover(LoginUser loginUser) {
        if (!isActiveApprover(loginUser.getId())) {
            throw new JeecgBootBizTipException("仅在任批准人可操作");
        }
    }

    private boolean isActiveApprover(String userId) {
        if (oConvertUtils.isEmpty(userId)) {
            return false;
        }
        return approverService.count(new LambdaQueryWrapper<ProposalApprover>()
                .eq(ProposalApprover::getUserId, userId)
                .eq(ProposalApprover::getApproverStatus, "active")) > 0;
    }

    // 【Phase2】委员审核快照与进度汇总
    private void createReviewSnapshot(Proposal proposal, LoginUser loginUser) {
        List<ProposalCommitteeMember> members = committeeMemberService.list(
                new LambdaQueryWrapper<ProposalCommitteeMember>()
                        .eq(ProposalCommitteeMember::getMemberStatus, "active")
                        .orderByAsc(ProposalCommitteeMember::getSortNo)
                        .orderByAsc(ProposalCommitteeMember::getSeatNo));
        if (members.isEmpty()) {
            throw new JeecgBootBizTipException("委员会名册为空，无法提交");
        }
        for (ProposalCommitteeMember member : members) {
            ProposalCommitteeReview row = new ProposalCommitteeReview();
            row.setProposalId(proposal.getId());
            row.setReviewerId(member.getUserId());
            if (loginUser != null) {
                ProposalAuditHelper.fillOnCreate(loginUser, row);
            } else {
                row.setTenantId(oConvertUtils.isEmpty(proposal.getTenantId()) ? "" : proposal.getTenantId());
                row.setActive("Y");
                row.setCreateBy("system");
                row.setUpdateBy("system");
            }
            if (oConvertUtils.isEmpty(row.getTenantId()) && oConvertUtils.isNotEmpty(proposal.getTenantId())) {
                row.setTenantId(proposal.getTenantId());
            }
            committeeReviewService.save(row);
        }
    }

    /** 若 PENDING_REVIEW 且无审核行，按当前在任名册补种 */
    private void ensureReviewSnapshot(Proposal proposal, LoginUser loginUser) {
        if (proposal == null || !ProposalStatusEnum.PENDING_REVIEW.getCode().equals(proposal.getStatus())) {
            return;
        }
        long exists = committeeReviewService.count(new LambdaQueryWrapper<ProposalCommitteeReview>()
                .eq(ProposalCommitteeReview::getProposalId, proposal.getId()));
        if (exists > 0) {
            return;
        }
        createReviewSnapshot(proposal, loginUser);
        long total = committeeReviewService.count(new LambdaQueryWrapper<ProposalCommitteeReview>()
                .eq(ProposalCommitteeReview::getProposalId, proposal.getId()));
        proposal.setReviewProgress("0/" + total);
        updateById(proposal);
    }

    private void ensurePendingSnapshots() {
        List<Proposal> pending = list(new LambdaQueryWrapper<Proposal>()
                .eq(Proposal::getStatus, ProposalStatusEnum.PENDING_REVIEW.getCode()));
        for (Proposal p : pending) {
            ensureReviewSnapshot(p, null);
        }
    }

    private void refreshReviewProgress(Proposal proposal, LoginUser loginUser) {
        List<ProposalCommitteeReview> rows = committeeReviewService.list(
                new LambdaQueryWrapper<ProposalCommitteeReview>()
                        .eq(ProposalCommitteeReview::getProposalId, proposal.getId()));
        int total = rows.size();
        int done = (int) rows.stream().filter(r -> oConvertUtils.isNotEmpty(r.getConclusion())).count();
        proposal.setReviewProgress(done + "/" + total);
        ProposalAuditHelper.fillOnUpdate(loginUser, proposal);

        if (total > 0 && done >= total) {
            stateMachine.transit(proposal, ProposalAction.COMMITTEE_DONE, loginUser, "委员审核全部完成");
        } else {
            updateById(proposal);
        }
    }

    private void applyListTab(LambdaQueryWrapper<Proposal> qw, String tab) {
        if (oConvertUtils.isEmpty(tab) || "all".equalsIgnoreCase(tab) || "mine".equalsIgnoreCase(tab)) {
            return;
        }
        if ("doing".equalsIgnoreCase(tab)) {
            qw.notIn(Proposal::getStatus, TERMINAL_STATUSES);
            return;
        }
        if ("done".equalsIgnoreCase(tab)) {
            qw.in(Proposal::getStatus, ProposalStatusEnum.COMPLETED.getCode(),
                    ProposalStatusEnum.REJECTED_FINAL.getCode(),
                    ProposalStatusEnum.APPROVED.getCode());
        }
    }

    private IPage<Proposal> withStatusLabels(IPage<Proposal> page) {
        if (page != null && page.getRecords() != null && !page.getRecords().isEmpty()) {
            page.getRecords().forEach(ProposalStatusEnum::attachLabel);
            improvementTypeService.attachTypeLabels(page.getRecords());
            //update-begin---author:spex ---date:2026-08-31  for：【待办卡片】嵌套人员部门与委员汇总-----------
            orgFillHelper.fillProposals(page.getRecords());
            fillCommitteeSummary(page.getRecords());
            //update-end---author:spex ---date:2026-08-31  for：【待办卡片】嵌套人员部门与委员汇总-----------
        }
        return page;
    }

    /**
     * 按委员已提交意见汇总：采用/不采用人数、计划书建议（采用票过半）、奖励建议众数。
     * 与批准页前端统计口径一致，供待办卡片直接展示。
     */
    private void fillCommitteeSummary(List<Proposal> records) {
        List<String> ids = records.stream()
                .map(Proposal::getId)
                .filter(oConvertUtils::isNotEmpty)
                .distinct()
                .collect(Collectors.toList());
        if (ids.isEmpty()) {
            return;
        }
        List<ProposalCommitteeReview> reviews = committeeReviewService.list(
                new LambdaQueryWrapper<ProposalCommitteeReview>()
                        .in(ProposalCommitteeReview::getProposalId, ids));
        Map<String, List<ProposalCommitteeReview>> grouped = reviews.stream()
                .collect(Collectors.groupingBy(ProposalCommitteeReview::getProposalId));
        for (Proposal proposal : records) {
            List<ProposalCommitteeReview> rows = grouped.getOrDefault(proposal.getId(), Collections.emptyList());
            int adopt = 0;
            int reject = 0;
            int planYes = 0;
            Map<BigDecimal, Integer> awardFreq = new HashMap<>();
            for (ProposalCommitteeReview row : rows) {
                String conclusion = row.getConclusion() == null ? "" : row.getConclusion().trim().toUpperCase();
                if (CONCLUSION_ADOPT.equals(conclusion)) {
                    adopt++;
                    if (Integer.valueOf(1).equals(row.getPlanRequired())) {
                        planYes++;
                    }
                    if (row.getAwardSuggestion() != null) {
                        BigDecimal key = row.getAwardSuggestion().setScale(2, RoundingMode.HALF_UP);
                        awardFreq.merge(key, 1, Integer::sum);
                    }
                } else if (CONCLUSION_REJECT.equals(conclusion)) {
                    reject++;
                }
            }
            proposal.setAdoptCount(adopt);
            proposal.setRejectCount(reject);
            if (adopt > 0) {
                proposal.setPlanRequiredSuggest(planYes * 2 >= adopt ? 1 : 0);
            }
            if (!awardFreq.isEmpty()) {
                proposal.setAwardSuggestAmount(pickModeAmount(awardFreq));
            }
        }
    }

    /** 众数；票数相同取较大金额。 */
    private static BigDecimal pickModeAmount(Map<BigDecimal, Integer> awardFreq) {
        BigDecimal best = null;
        int bestN = -1;
        for (Map.Entry<BigDecimal, Integer> entry : awardFreq.entrySet()) {
            int n = entry.getValue();
            BigDecimal amount = entry.getKey();
            if (n > bestN || (n == bestN && best != null && amount.compareTo(best) > 0)) {
                bestN = n;
                best = amount;
            }
        }
        return best;
    }

    private void fillStatusLogLabels(ProposalStatusLog log) {
        if (log == null) {
            return;
        }
        log.setFromStatusLabel(ProposalStatusEnum.labelOf(log.getFromStatus()));
        log.setToStatusLabel(ProposalStatusEnum.labelOf(log.getToStatus()));
        log.setActionLabel(ProposalAction.labelOf(log.getAction()));
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

    private long countDoing(String userId) {
        return count(new LambdaQueryWrapper<Proposal>()
                .eq(Proposal::getProposerId, userId)
                .notIn(Proposal::getStatus, TERMINAL_STATUSES));
    }

    private long countDone(String userId) {
        return count(new LambdaQueryWrapper<Proposal>()
                .eq(Proposal::getProposerId, userId)
                .in(Proposal::getStatus,
                        ProposalStatusEnum.APPROVED.getCode(),
                        ProposalStatusEnum.REJECTED_FINAL.getCode(),
                        ProposalStatusEnum.COMPLETED.getCode()));
    }

    /** 委员未审快照 + 批准人待核定，不走权限抛错，非角色即为 0。 */
    private long countHomeTodos(LoginUser loginUser) {
        long n = countCommitteeTodos(loginUser.getId());
        if (isActiveApprover(loginUser.getId())) {
            n += count(new LambdaQueryWrapper<Proposal>()
                    .eq(Proposal::getStatus, ProposalStatusEnum.PENDING_APPROVAL.getCode()));
        }
        return n;
    }

    private long countCommitteeTodos(String userId) {
        List<ProposalCommitteeReview> pending = committeeReviewService.list(
                new LambdaQueryWrapper<ProposalCommitteeReview>()
                        .eq(ProposalCommitteeReview::getReviewerId, userId)
                        .isNull(ProposalCommitteeReview::getConclusion));
        if (pending.isEmpty()) {
            return 0;
        }
        List<String> ids = pending.stream()
                .map(ProposalCommitteeReview::getProposalId)
                .filter(oConvertUtils::isNotEmpty)
                .distinct()
                .collect(Collectors.toList());
        if (ids.isEmpty()) {
            return 0;
        }
        return count(new LambdaQueryWrapper<Proposal>()
                .in(Proposal::getId, ids)
                .eq(Proposal::getStatus, ProposalStatusEnum.PENDING_REVIEW.getCode()));
    }

    private List<ProposalHomeVo.TodoItem> buildHomeTodos(LoginUser loginUser) {
        List<ProposalHomeVo.TodoItem> items = new ArrayList<>();
        List<String> reviewIds = committeeReviewService.list(
                        new LambdaQueryWrapper<ProposalCommitteeReview>()
                                .eq(ProposalCommitteeReview::getReviewerId, loginUser.getId())
                                .isNull(ProposalCommitteeReview::getConclusion))
                .stream()
                .map(ProposalCommitteeReview::getProposalId)
                .filter(oConvertUtils::isNotEmpty)
                .distinct()
                .collect(Collectors.toList());
        if (!reviewIds.isEmpty()) {
            List<Proposal> reviews = list(new LambdaQueryWrapper<Proposal>()
                    .in(Proposal::getId, reviewIds)
                    .eq(Proposal::getStatus, ProposalStatusEnum.PENDING_REVIEW.getCode())
                    .orderByDesc(Proposal::getCreateTime)
                    .last("LIMIT 5"));
            for (Proposal p : reviews) {
                items.add(toHomeTodo(p, "review", "出具审核意见"));
            }
        }
        if (isActiveApprover(loginUser.getId())) {
            List<Proposal> approvals = list(new LambdaQueryWrapper<Proposal>()
                    .eq(Proposal::getStatus, ProposalStatusEnum.PENDING_APPROVAL.getCode())
                    .orderByDesc(Proposal::getUpdateTime)
                    .last("LIMIT 5"));
            for (Proposal p : approvals) {
                items.add(toHomeTodo(p, "approve", "待核定"));
            }
        }
        return items.stream().limit(5).collect(Collectors.toList());
    }

    private static ProposalHomeVo.TodoItem toHomeTodo(Proposal p, String kind, String hint) {
        ProposalHomeVo.TodoItem item = new ProposalHomeVo.TodoItem();
        item.setProposalId(p.getId());
        item.setProposalNo(p.getProposalNo());
        item.setTitle(p.getTitle());
        item.setStatus(p.getStatus());
        item.setStatusLabel(ProposalStatusEnum.labelOf(p.getStatus()));
        item.setActionHint(hint);
        item.setKind(kind);
        return item;
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
            feed.setActionLabel(ProposalAction.labelOf(log.getAction()));
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
