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
import org.jeecg.modules.proposal.vo.app.ProposalMeSummaryVo;

public interface IProposalService extends IService<Proposal> {

    /** 一次提交，主表直接为审核中。 */
    String create(ProposalCreateRequest request, LoginUser loginUser);

    /** 已并入发起；已是审核中则幂等成功，其它状态拒绝。 */
    void submit(String id, LoginUser loginUser);

    ProposalDetailVo getDetail(String id, LoginUser loginUser);

    /** 管理端详情：不校验提案人权限，含申请书/附件/状态日志 */
    ProposalDetailVo getAdminDetail(String id);

    IPage<Proposal> listForUser(String tab, String title, int pageNo, int pageSize, LoginUser loginUser);

    ProposalHomeVo buildHome(LoginUser loginUser);

    /** 小程序「我的」：岗位行、配置角色标签、我的提案/采纳率/累计奖金 */
    ProposalMeSummaryVo buildMeSummary(LoginUser loginUser);

    // 【Phase2】委员并行审核
    /** 当前委员待审列表（PENDING_REVIEW 且本人未提交） */
    IPage<Proposal> listCommitteePending(int pageNo, int pageSize, LoginUser loginUser);

    /** 委员提交审核意见；全部完成后进入 PENDING_APPROVAL */
    void submitCommitteeReview(String proposalId, CommitteeReviewRequest request, LoginUser loginUser);

    // 【Phase2】批准人申请决策
    /** 批准人待核定列表（PENDING_APPROVAL）；非在任批准人返回空页 */
    IPage<Proposal> listApprovalPending(int pageNo, int pageSize, LoginUser loginUser);

    /** 申请批准决策：批准→APPROVED；不批准→REJECTED_FINAL。不进入待指派。 */
    void submitApplicationApproval(String proposalId, ApplicationApprovalRequest request, LoginUser loginUser);

    /**
     * 委员会名册删除成员后：在途（审核中）提案中，删除该委员未出结论的快照；已出结论保留；
     * 重算 review_progress，若已审满则进入待批准。新增委员不补在途快照（本方法不处理）。
     */
    void onCommitteeMemberRemoved(String reviewerUserId, LoginUser loginUser);
}
