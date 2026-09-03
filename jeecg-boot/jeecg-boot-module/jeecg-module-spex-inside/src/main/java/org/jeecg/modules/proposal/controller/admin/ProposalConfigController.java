package org.jeecg.modules.proposal.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.common.exception.JeecgBootBizTipException;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.*;
import org.jeecg.modules.proposal.service.*;
import org.jeecg.modules.proposal.util.ProposalAuditHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 管理端 - 提案配置（六 Tab）
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
    @Autowired
    private IProposalImprovementTypeService improvementTypeService;
    @Autowired
    private IProposalHomeBroadcastService homeBroadcastService;
    @Autowired
    private IProposalService proposalService;
    @Autowired
    private ProposalOrgFillHelper orgFillHelper;

    @Operation(summary = "部门负责人-列表")
    @GetMapping("/deptLeader/list")
    public Result<IPage<ProposalDeptLeader>> deptLeaderList(ProposalDeptLeader entity,
                                                              @RequestParam(defaultValue = "1") Integer pageNo,
                                                              @RequestParam(defaultValue = "10") Integer pageSize,
                                                              HttpServletRequest req) {
        QueryWrapper<ProposalDeptLeader> qw = QueryGenerator.initQueryWrapper(entity, req.getParameterMap());
        qw.orderByAsc("dept_id");
        IPage<ProposalDeptLeader> page = deptLeaderService.page(new Page<>(pageNo, pageSize), qw);
        //update-begin---author:spex ---date:2026-08-31  for：【提案管理端】配置列表嵌套回显-----------
        orgFillHelper.fillDeptLeaders(page.getRecords());
        //update-end---author:spex ---date:2026-08-31  for：【提案管理端】配置列表嵌套回显-----------
        return Result.OK(page);
    }

    // 【提案改善】部门负责人保存：主键校验 + 缺 id 时按部门 upsert
    @AutoLog(value = "管理端-提案配置-部门负责人-保存")
    @Operation(summary = "部门负责人-保存")
    @PostMapping("/deptLeader/save")
    public Result<String> deptLeaderSave(@RequestBody ProposalDeptLeader entity) {
        entity.setDeptId(firstId(entity.getDeptId()));
        entity.setLeaderUserId(firstId(entity.getLeaderUserId()));
        if (oConvertUtils.isEmpty(entity.getDeptId()) && entity.getDept() != null) {
            entity.setDeptId(firstId(entity.getDept().getId()));
        }
        if (oConvertUtils.isEmpty(entity.getLeaderUserId()) && entity.getLeader() != null) {
            entity.setLeaderUserId(firstId(entity.getLeader().getId()));
        }
        if (oConvertUtils.isEmpty(entity.getDeptId())) {
            throw new JeecgBootBizTipException("deptId 必填，须为 sys_depart.id（不要传部门名称或路径）");
        }
        if (!orgFillHelper.deptExists(entity.getDeptId())) {
            throw new JeecgBootBizTipException("deptId 在部门表中不存在，须为 sys_depart.id，不能传部门名称、路径或 orgCode");
        }
        if (oConvertUtils.isNotEmpty(entity.getLeaderUserId()) && !orgFillHelper.userExists(entity.getLeaderUserId())) {
            throw new JeecgBootBizTipException("leaderUserId 在用户表中不存在，须为 sys_user.id，不能传工号、姓名或 username");
        }
        if (oConvertUtils.isEmpty(entity.getTenantId())) {
            entity.setTenantId(null);
        }
        if (oConvertUtils.isEmpty(entity.getActive())) {
            entity.setActive(null);
        }
        //update-begin---author:spex ---date:2026-09-01  for：【提案配置】部门负责人保存含逻辑删除行恢复-----------
        LoginUser loginUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        deptLeaderService.saveLeader(entity, loginUser);
        //update-end---author:spex ---date:2026-09-01  for：【提案配置】部门负责人保存含逻辑删除行恢复-----------
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
        IPage<ProposalCommitteeMember> page = committeeMemberService.page(new Page<>(pageNo, pageSize), qw);
        //update-begin---author:spex ---date:2026-08-31  for：【提案管理端】配置列表嵌套回显-----------
        orgFillHelper.fillCommitteeMembers(page.getRecords());
        //update-end---author:spex ---date:2026-08-31  for：【提案管理端】配置列表嵌套回显-----------
        return Result.OK(page);
    }

    // 【提案改善】配置保存补审计字段
    @AutoLog(value = "管理端-提案配置-委员会-保存")
    @Operation(summary = "委员会成员-保存")
    @PostMapping("/committee/save")
    public Result<String> committeeSave(@RequestBody ProposalCommitteeMember entity) {
        entity.setUserId(firstId(entity.getUserId()));
        //update-begin---author:spex ---date:2026-09-01  for：【提案配置】校验 userId，重加已移除委员走恢复-----------
        if (oConvertUtils.isEmpty(entity.getUserId())) {
            throw new JeecgBootBizTipException("userId 必填，须为 sys_user.id");
        }
        if (!orgFillHelper.userExists(entity.getUserId())) {
            throw new JeecgBootBizTipException("userId 在用户表中不存在，须为 sys_user.id，不能传工号、姓名或 username");
        }
        if (entity.getScoreEnabled() != null && entity.getScoreEnabled() == 0) {
            entity.setSeatNo(null);
        }
        LoginUser loginUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        committeeMemberService.saveMember(entity, loginUser);
        //update-end---author:spex ---date:2026-09-01  for：【提案配置】校验 userId，重加已移除委员走恢复-----------
        return Result.OK("保存成功");
    }

    @AutoLog(value = "管理端-提案配置-委员会-删除")
    @Operation(summary = "委员会成员-删除")
    @DeleteMapping("/committee/delete")
    public Result<String> committeeDelete(@RequestParam String id) {
        //update-begin---author:spex ---date:2026-09-03  for：【委员会】删委员同步在途未审快照-----------
        ProposalCommitteeMember member = committeeMemberService.getById(id);
        if (member == null) {
            throw new JeecgBootBizTipException("委员会成员不存在或已删除");
        }
        String reviewerUserId = member.getUserId();
        committeeMemberService.removeById(id);
        LoginUser loginUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        proposalService.onCommitteeMemberRemoved(reviewerUserId, loginUser);
        //update-end---author:spex ---date:2026-09-03  for：【委员会】删委员同步在途未审快照-----------
        return Result.OK("删除成功");
    }

    @Operation(summary = "批准人-列表")
    @GetMapping("/approver/list")
    public Result<List<ProposalApprover>> approverList() {
        QueryWrapper<ProposalApprover> qw = new QueryWrapper<>();
        qw.eq("approver_status", "active").orderByDesc("update_time").last("limit 1");
        List<ProposalApprover> list = approverService.list(qw);
        //update-begin---author:spex ---date:2026-08-31  for：【提案管理端】配置列表嵌套回显-----------
        orgFillHelper.fillApprovers(list);
        //update-end---author:spex ---date:2026-08-31  for：【提案管理端】配置列表嵌套回显-----------
        return Result.OK(list);
    }

    // 【提案改善】更换批准人：旧行 active=N，只保留一条有效
    @AutoLog(value = "管理端-提案配置-批准人-保存")
    @Operation(summary = "批准人-保存")
    @PostMapping("/approver/save")
    public Result<String> approverSave(@RequestBody ProposalApprover entity) {
        entity.setUserId(firstId(entity.getUserId()));
        if (oConvertUtils.isEmpty(entity.getUserId())) {
            throw new JeecgBootBizTipException("userId 必填，须为 sys_user.id");
        }
        if (!orgFillHelper.userExists(entity.getUserId())) {
            throw new JeecgBootBizTipException("userId 在用户表中不存在，须为 sys_user.id，不能传工号、姓名或 username");
        }
        entity.setApproverStatus("active");
        entity.setId(null);
        fillAudit(entity);
        approverService.replaceCurrent(entity);
        return Result.OK("保存成功");
    }

    @AutoLog(value = "管理端-提案配置-批准人-删除")
    @Operation(summary = "批准人-删除")
    @DeleteMapping("/approver/delete")
    public Result<String> approverDelete(@RequestParam String id) {
        approverService.removeById(id);
        return Result.OK("删除成功");
    }

    @Operation(summary = "改善性质-列表")
    @GetMapping("/improvementType/list")
    public Result<List<ProposalImprovementType>> improvementTypeList() {
        QueryWrapper<ProposalImprovementType> qw = new QueryWrapper<>();
        qw.orderByAsc("sort_no", "type_code");
        return Result.OK(improvementTypeService.list(qw));
    }

    @AutoLog(value = "管理端-提案配置-改善性质-保存")
    @Operation(summary = "改善性质-保存")
    @PostMapping("/improvementType/save")
    public Result<String> improvementTypeSave(@RequestBody ProposalImprovementType entity) {
        fillAudit(entity);
        improvementTypeService.saveConfig(entity);
        return Result.OK("保存成功");
    }

    @AutoLog(value = "管理端-提案配置-改善性质-删除")
    @Operation(summary = "改善性质-删除")
    @DeleteMapping("/improvementType/delete")
    public Result<String> improvementTypeDelete(@RequestParam String id) {
        improvementTypeService.deleteConfig(id);
        return Result.OK("删除成功");
    }

    @Operation(summary = "评分维度-列表")
    @GetMapping("/scoreDimension/list")
    public Result<List<ProposalScoreDimension>> scoreDimensionList() {
        QueryWrapper<ProposalScoreDimension> qw = new QueryWrapper<>();
        qw.orderByAsc("sort_no");
        return Result.OK(scoreDimensionService.list(qw));
    }

    // 【提案改善】配置保存补审计字段
    @AutoLog(value = "管理端-提案配置-评分维度-保存")
    @Operation(summary = "评分维度-保存")
    @PostMapping("/scoreDimension/save")
    public Result<String> scoreDimensionSave(@RequestBody ProposalScoreDimension entity) {
        fillAudit(entity);
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

    //update-begin---author:spex ---date:2026-09-03  for：【首页标语】配置 GET/POST-----------
    @Operation(summary = "首页标语-查询")
    @GetMapping("/homeBroadcast")
    public Result<ProposalHomeBroadcast> homeBroadcastGet() {
        LoginUser loginUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        return Result.OK(homeBroadcastService.getCurrent(loginUser));
    }

    @AutoLog(value = "管理端-提案配置-首页标语-保存")
    @Operation(summary = "首页标语-保存")
    @PostMapping("/homeBroadcast/save")
    public Result<String> homeBroadcastSave(@RequestBody ProposalHomeBroadcast entity) {
        LoginUser loginUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        homeBroadcastService.saveCurrent(entity, loginUser);
        return Result.OK("保存成功");
    }
    //update-end---author:spex ---date:2026-09-03  for：【首页标语】配置 GET/POST-----------

    private void fillAudit(ProposalBaseEntity entity) {
        LoginUser loginUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        if (oConvertUtils.isEmpty(entity.getId())) {
            ProposalAuditHelper.fillOnCreate(loginUser, entity);
        } else {
            ProposalAuditHelper.fillOnUpdate(loginUser, entity);
        }
    }

    private String firstId(String value) {
        if (oConvertUtils.isEmpty(value)) {
            return null;
        }
        String trimmed = value.trim();
        if (trimmed.contains(",")) {
            return trimmed.split(",")[0].trim();
        }
        return trimmed;
    }
}
