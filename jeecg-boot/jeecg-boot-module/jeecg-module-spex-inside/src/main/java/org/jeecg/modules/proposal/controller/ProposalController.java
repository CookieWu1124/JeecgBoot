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

    @AutoLog(value = "提案-创建草稿")
    @Operation(summary = "创建提案（草稿）")
    @PostMapping("/create")
    public Result<String> create(@RequestBody ProposalCreateRequest request) {
        LoginUser loginUser = currentUser();
        String id = proposalService.createDraft(request, loginUser);
        return Result.OK(id);
    }

    @AutoLog(value = "提案-更新草稿")
    @Operation(summary = "更新草稿")
    @PutMapping("/{id}/draft")
    public Result<String> updateDraft(@PathVariable String id, @RequestBody ProposalCreateRequest request) {
        proposalService.updateDraft(id, request, currentUser());
        return Result.OK("保存成功");
    }

    @AutoLog(value = "提案-提交申请")
    @Operation(summary = "提交申请")
    @PutMapping("/{id}/submit")
    public Result<String> submit(@PathVariable String id) {
        proposalService.submit(id, currentUser());
        return Result.OK("提交成功");
    }

    @AutoLog(value = "提案-撤回")
    @Operation(summary = "撤回申请")
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

    private LoginUser currentUser() {
        return (LoginUser) SecurityUtils.getSubject().getPrincipal();
    }
}
