package org.jeecg.modules.proposal.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.service.IProposalService;
import org.jeecg.modules.proposal.vo.ApplicationApprovalRequest;
import org.jeecg.modules.proposal.vo.CommitteeReviewRequest;
import org.jeecg.modules.proposal.vo.ProposalCreateRequest;
import org.jeecg.modules.proposal.vo.ProposalDetailVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 共用 - 提案生命周期
 */
@Slf4j
@Tag(name = "提案业务")
@RestController
@RequestMapping("/proposal")
public class ProposalController {

    @Autowired
    private IProposalService proposalService;

    @AutoLog(value = "提案-发起")
    @Operation(summary = "发起提案（一次提交，进入审核中；无暂存）")
    @PostMapping("/create")
    public Result<String> create(@RequestBody ProposalCreateRequest request) {
        LoginUser loginUser = currentUser();
        String id = proposalService.createDraft(request, loginUser);
        return Result.OK(id);
    }

    @AutoLog(value = "提案-更新草稿")
    @Operation(summary = "更新草稿（申请段已取消暂存，调用将失败）")
    @PutMapping("/{id}/draft")
    public Result<String> updateDraft(@PathVariable String id, @RequestBody ProposalCreateRequest request) {
        proposalService.updateDraft(id, request, currentUser());
        return Result.OK("保存成功");
    }

    @AutoLog(value = "提案-提交申请")
    @Operation(summary = "提交申请（已并入发起；仅兼容历史草稿或重复提交）")
    @PutMapping("/{id}/submit")
    public Result<String> submit(@PathVariable String id) {
        proposalService.submit(id, currentUser());
        return Result.OK("提交成功");
    }

    @AutoLog(value = "提案-撤回")
    @Operation(summary = "撤回申请（申请段已取消，调用将失败）")
    @PostMapping("/{id}/withdraw")
    public Result<String> withdraw(@PathVariable String id) {
        proposalService.withdraw(id, currentUser());
        return Result.OK("撤回成功");
    }

    @Operation(summary = "提案列表")
    @GetMapping("/list")
    public Result<IPage<Proposal>> list(@RequestParam(defaultValue = "mine") String tab,
                                        @RequestParam(required = false) String title,
                                        @RequestParam(defaultValue = "1") Integer pageNo,
                                        @RequestParam(defaultValue = "10") Integer pageSize) {
        IPage<Proposal> pageList = proposalService.listForUser(tab, title, pageNo, pageSize, currentUser());
        return Result.OK(pageList);
    }

    @Operation(summary = "提案详情")
    @GetMapping("/{id}")
    public Result<ProposalDetailVo> detail(@PathVariable String id) {
        return Result.OK(proposalService.getDetail(id, currentUser()));
    }

    // 【Phase2】委员待审/提交意见
    @Operation(summary = "委员待审列表")
    @GetMapping("/review/committee/pending")
    public Result<IPage<Proposal>> committeePending(@RequestParam(defaultValue = "1") Integer pageNo,
                                                    @RequestParam(defaultValue = "10") Integer pageSize) {
        return Result.OK(proposalService.listCommitteePending(pageNo, pageSize, currentUser()));
    }

    @AutoLog(value = "提案-委员提交审核意见")
    @Operation(summary = "委员提交审核意见")
    @PostMapping("/review/committee/{proposalId}")
    public Result<String> submitCommitteeReview(@PathVariable String proposalId,
                                                @RequestBody CommitteeReviewRequest request) {
        proposalService.submitCommitteeReview(proposalId, request, currentUser());
        return Result.OK("审核意见已提交");
    }

    // 【Phase2】批准人待核定/申请决策
    @Operation(summary = "批准人待办列表")
    @GetMapping("/approval/pending")
    public Result<IPage<Proposal>> approvalPending(@RequestParam(defaultValue = "1") Integer pageNo,
                                                   @RequestParam(defaultValue = "10") Integer pageSize) {
        return Result.OK(proposalService.listApprovalPending(pageNo, pageSize, currentUser()));
    }

    @AutoLog(value = "提案-申请批准决策")
    @Operation(summary = "申请批准决策")
    @PostMapping("/approval/application/{proposalId}")
    public Result<String> submitApplicationApproval(@PathVariable String proposalId,
                                                    @RequestBody ApplicationApprovalRequest request) {
        proposalService.submitApplicationApproval(proposalId, request, currentUser());
        return Result.OK("决策已提交");
    }

    private LoginUser currentUser() {
        return (LoginUser) SecurityUtils.getSubject().getPrincipal();
    }
}
