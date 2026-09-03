package org.jeecg.modules.proposal.controller.app;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.proposal.service.IProposalService;
import org.jeecg.modules.proposal.vo.app.ProposalHomeVo;
import org.jeecg.modules.proposal.vo.app.ProposalMeSummaryVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 小程序 - 首页 / 我的
 */
@Slf4j
@Tag(name = "小程序-首页")
@RestController
@RequestMapping("/proposal/app")
public class ProposalHomeController {

    @Autowired
    private IProposalService proposalService;

    @Operation(summary = "首页统计+待办摘要+动态")
    @GetMapping("/home")
    public Result<ProposalHomeVo> home() {
        LoginUser loginUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        if (loginUser == null) {
            return Result.error("请先登录");
        }
        return Result.OK(proposalService.buildHome(loginUser));
    }

    @Operation(summary = "我的页：岗位行、角色标签、我的提案/采纳率/累计奖金")
    @GetMapping("/me/summary")
    public Result<ProposalMeSummaryVo> meSummary() {
        LoginUser loginUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        if (loginUser == null) {
            return Result.error("请先登录");
        }
        return Result.OK(proposalService.buildMeSummary(loginUser));
    }
}
