package org.jeecg.modules.proposal.controller.app;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.proposal.entity.ProposalApprover;
import org.jeecg.modules.proposal.service.IProposalApproverService;
import org.jeecg.modules.proposal.service.IProposalStatusLogService;
import org.jeecg.modules.proposal.vo.app.ProposalMessageItemVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 小程序 - 消息动态（与我相关的 status_log + 已读）
 */
@Slf4j
@Tag(name = "小程序-消息")
@RestController
@RequestMapping("/proposal/app/message")
public class ProposalMessageController {

    @Autowired
    private IProposalStatusLogService statusLogService;
    @Autowired
    private IProposalApproverService approverService;

    @Operation(summary = "消息列表 scope=all|unread")
    @GetMapping("/list")
    public Result<IPage<ProposalMessageItemVo>> list(
            @RequestParam(defaultValue = "all") String scope,
            @RequestParam(defaultValue = "1") Integer pageNo,
            @RequestParam(defaultValue = "20") Integer pageSize) {
        LoginUser loginUser = currentUser();
        if (loginUser == null) {
            return Result.error("请先登录");
        }
        return Result.OK(statusLogService.pageUserMessages(
                scope, pageNo, pageSize, loginUser, isActiveApprover(loginUser.getId())));
    }

    @Operation(summary = "未读消息数量")
    @GetMapping("/unreadCount")
    public Result<Long> unreadCount() {
        LoginUser loginUser = currentUser();
        if (loginUser == null) {
            return Result.error("请先登录");
        }
        return Result.OK(statusLogService.countUnread(loginUser.getId(), isActiveApprover(loginUser.getId())));
    }

    @Operation(summary = "标记已读")
    @PutMapping("/{id}/read")
    public Result<String> markRead(@PathVariable("id") String id) {
        LoginUser loginUser = currentUser();
        if (loginUser == null) {
            return Result.error("请先登录");
        }
        //update-begin---author:spex ---date:2026-09-02  for：【消息已读】用户×status_log-----------
        statusLogService.markRead(id, loginUser, isActiveApprover(loginUser.getId()));
        //update-end---author:spex ---date:2026-09-02  for：【消息已读】用户×status_log-----------
        return Result.OK("ok");
    }

    private LoginUser currentUser() {
        return (LoginUser) SecurityUtils.getSubject().getPrincipal();
    }

    private boolean isActiveApprover(String userId) {
        return approverService.count(new LambdaQueryWrapper<ProposalApprover>()
                .eq(ProposalApprover::getUserId, userId)
                .eq(ProposalApprover::getApproverStatus, "active")) > 0;
    }
}
