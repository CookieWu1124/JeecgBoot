package org.jeecg.modules.proposal.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.modules.proposal.entity.*;
import org.jeecg.modules.proposal.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 管理端 - 提案配置（四 Tab）
 */
@Slf4j
@Tag(name = "管理端-提案配置")
@RestController
@RequestMapping("/proposal/admin/config")
public class ProposalConfigController {

    @Autowired
    private IProposalDeptLeaderService deptLeaderService;
    @Autowired
    private IProposalCommitteeMemberService committeeMemberService;
    @Autowired
    private IProposalApproverService approverService;
    @Autowired
    private IProposalScoreDimensionService scoreDimensionService;

    @Operation(summary = "部门负责人-列表")
    @GetMapping("/deptLeader/list")
    public Result<IPage<ProposalDeptLeader>> deptLeaderList(ProposalDeptLeader entity,
                                                              @RequestParam(defaultValue = "1") Integer pageNo,
                                                              @RequestParam(defaultValue = "10") Integer pageSize,
                                                              HttpServletRequest req) {
        QueryWrapper<ProposalDeptLeader> qw = QueryGenerator.initQueryWrapper(entity, req.getParameterMap());
        qw.orderByAsc("dept_id");
        return Result.OK(deptLeaderService.page(new Page<>(pageNo, pageSize), qw));
    }

    @AutoLog(value = "管理端-提案配置-部门负责人-保存")
    @Operation(summary = "部门负责人-保存")
    @PostMapping("/deptLeader/save")
    public Result<String> deptLeaderSave(@RequestBody ProposalDeptLeader entity) {
        deptLeaderService.saveOrUpdate(entity);
        return Result.OK("保存成功");
    }

    @AutoLog(value = "管理端-提案配置-部门负责人-删除")
    @Operation(summary = "部门负责人-删除")
    @DeleteMapping("/deptLeader/delete")
    public Result<String> deptLeaderDelete(@RequestParam String id) {
        deptLeaderService.removeById(id);
        return Result.OK("删除成功");
    }

    @Operation(summary = "委员会成员-列表")
    @GetMapping("/committee/list")
    public Result<IPage<ProposalCommitteeMember>> committeeList(ProposalCommitteeMember entity,
                                                                 @RequestParam(defaultValue = "1") Integer pageNo,
                                                                 @RequestParam(defaultValue = "10") Integer pageSize,
                                                                 HttpServletRequest req) {
        QueryWrapper<ProposalCommitteeMember> qw = QueryGenerator.initQueryWrapper(entity, req.getParameterMap());
        qw.orderByAsc("sort_no", "seat_no");
        return Result.OK(committeeMemberService.page(new Page<>(pageNo, pageSize), qw));
    }

    @AutoLog(value = "管理端-提案配置-委员会-保存")
    @Operation(summary = "委员会成员-保存")
    @PostMapping("/committee/save")
    public Result<String> committeeSave(@RequestBody ProposalCommitteeMember entity) {
        committeeMemberService.saveOrUpdate(entity);
        return Result.OK("保存成功");
    }

    @AutoLog(value = "管理端-提案配置-委员会-删除")
    @Operation(summary = "委员会成员-删除")
    @DeleteMapping("/committee/delete")
    public Result<String> committeeDelete(@RequestParam String id) {
        committeeMemberService.removeById(id);
        return Result.OK("删除成功");
    }

    @Operation(summary = "批准人-列表")
    @GetMapping("/approver/list")
    public Result<List<ProposalApprover>> approverList() {
        QueryWrapper<ProposalApprover> qw = new QueryWrapper<>();
        qw.eq("approver_status", "active").orderByAsc("create_time");
        return Result.OK(approverService.list(qw));
    }

    @AutoLog(value = "管理端-提案配置-批准人-保存")
    @Operation(summary = "批准人-保存")
    @PostMapping("/approver/save")
    public Result<String> approverSave(@RequestBody ProposalApprover entity) {
        approverService.saveOrUpdate(entity);
        return Result.OK("保存成功");
    }

    @AutoLog(value = "管理端-提案配置-批准人-删除")
    @Operation(summary = "批准人-删除")
    @DeleteMapping("/approver/delete")
    public Result<String> approverDelete(@RequestParam String id) {
        approverService.removeById(id);
        return Result.OK("删除成功");
    }

    @Operation(summary = "评分维度-列表")
    @GetMapping("/scoreDimension/list")
    public Result<List<ProposalScoreDimension>> scoreDimensionList() {
        QueryWrapper<ProposalScoreDimension> qw = new QueryWrapper<>();
        qw.orderByAsc("sort_no");
        return Result.OK(scoreDimensionService.list(qw));
    }

    @AutoLog(value = "管理端-提案配置-评分维度-保存")
    @Operation(summary = "评分维度-保存")
    @PostMapping("/scoreDimension/save")
    public Result<String> scoreDimensionSave(@RequestBody ProposalScoreDimension entity) {
        scoreDimensionService.saveOrUpdate(entity);
        return Result.OK("保存成功");
    }

    @AutoLog(value = "管理端-提案配置-评分维度-删除")
    @Operation(summary = "评分维度-删除")
    @DeleteMapping("/scoreDimension/delete")
    public Result<String> scoreDimensionDelete(@RequestParam String id) {
        scoreDimensionService.removeById(id);
        return Result.OK("删除成功");
    }
}
