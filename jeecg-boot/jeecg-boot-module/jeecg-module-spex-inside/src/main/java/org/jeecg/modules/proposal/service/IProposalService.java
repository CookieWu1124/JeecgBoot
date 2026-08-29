package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.vo.ApplicationApprovalRequest;
import org.jeecg.modules.proposal.vo.CommitteeReviewRequest;
import org.jeecg.modules.proposal.vo.ProposalCreateRequest;
import org.jeecg.modules.proposal.vo.ProposalDetailVo;
import org.jeecg.modules.proposal.vo.app.ProposalHomeVo;

public interface IProposalService extends IService<Proposal> {

    String createDraft(ProposalCreateRequest request, LoginUser loginUser);

    void updateDraft(String id, ProposalCreateRequest request, LoginUser loginUser);

    void submit(String id, LoginUser loginUser);

    void withdraw(String id, LoginUser loginUser);

    ProposalDetailVo getDetail(String id, LoginUser loginUser);

    /** 管理端详情：不校验提案人权限，含申请书/附件/状态日志 */
    ProposalDetailVo getAdminDetail(String id);

    IPage<Proposal> listForUser(String tab, String title, int pageNo, int pageSize, LoginUser loginUser);

    ProposalHomeVo buildHome(LoginUser loginUser);

    // 【Phase2】委员并行审核
    /** 当前委员待审列表（PENDING_REVIEW 且本人未提交） */
    IPage<Proposal> listCommitteePending(int pageNo, int pageSize, LoginUser loginUser);

    /** 委员提交审核意见；全部完成后进入 PENDING_APPROVAL */
    void submitCommitteeReview(String proposalId, CommitteeReviewRequest request, LoginUser loginUser);

    // 【Phase2】批准人申请决策
    /** 批准人待核定列表（PENDING_APPROVAL） */
    IPage<Proposal> listApprovalPending(int pageNo, int pageSize, LoginUser loginUser);

    /** 申请批准决策：批准→PENDING_ASSIGN；不批准→REJECTED_FINAL */
    void submitApplicationApproval(String proposalId, ApplicationApprovalRequest request, LoginUser loginUser);
}
