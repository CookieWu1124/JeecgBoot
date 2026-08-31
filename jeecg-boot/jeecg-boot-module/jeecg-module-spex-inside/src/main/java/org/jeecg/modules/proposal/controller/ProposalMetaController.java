package org.jeecg.modules.proposal.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.ProposalDeptLeader;
import org.jeecg.modules.proposal.enums.ProposalStatusEnum;
import org.jeecg.modules.proposal.service.IProposalDeptLeaderService;
import org.jeecg.modules.proposal.service.IProposalImprovementTypeService;
import org.jeecg.modules.proposal.service.ProposalOrgFillHelper;
import org.jeecg.modules.proposal.vo.ImprovementDeptOption;
import org.jeecg.modules.proposal.vo.ImprovementTypeOption;
import org.jeecg.modules.proposal.vo.StatusOption;
import org.jeecg.modules.proposal.vo.UserBriefVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 共用 - 提案元数据（登录用户可访问，供小程序发起页等使用）
 */
@Slf4j
@Tag(name = "提案元数据")
@RestController
@RequestMapping("/proposal/meta")
public class ProposalMetaController {

    @Autowired
    private IProposalDeptLeaderService deptLeaderService;
    @Autowired
    private IProposalImprovementTypeService improvementTypeService;
    @Autowired
    private ProposalOrgFillHelper orgFillHelper;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Operation(summary = "改善部门选项（含负责人回显）")
    @GetMapping("/improvementDepts")
    public Result<List<ImprovementDeptOption>> improvementDepts() {
        List<ProposalDeptLeader> configs = deptLeaderService.list(
                new LambdaQueryWrapper<ProposalDeptLeader>().eq(ProposalDeptLeader::getActive, "Y"));
        if (configs == null || configs.isEmpty()) {
            return Result.OK(new ArrayList<>());
        }

        List<String> deptIds = configs.stream().map(ProposalDeptLeader::getDeptId)
                .filter(oConvertUtils::isNotEmpty).distinct().collect(Collectors.toList());
        List<String> leaderIds = configs.stream().map(ProposalDeptLeader::getLeaderUserId)
                .filter(oConvertUtils::isNotEmpty).distinct().collect(Collectors.toList());

        Map<String, String> deptNameMap = queryNameMap(
                "select id, depart_name as name from sys_depart where id in (%s)", deptIds);
        Map<String, String> userNameMap = queryNameMap(
                "select id, realname as name from sys_user where id in (%s)", leaderIds);

        List<ImprovementDeptOption> options = new ArrayList<>();
        for (ProposalDeptLeader cfg : configs) {
            ImprovementDeptOption opt = new ImprovementDeptOption();
            opt.setDeptId(cfg.getDeptId());
            opt.setDeptName(deptNameMap.getOrDefault(cfg.getDeptId(), cfg.getDeptId()));
            opt.setLeaderUserId(cfg.getLeaderUserId());
            boolean configured = oConvertUtils.isNotEmpty(cfg.getLeaderUserId());
            opt.setLeaderConfigured(configured);
            opt.setLeaderName(configured
                    ? userNameMap.getOrDefault(cfg.getLeaderUserId(), cfg.getLeaderUserId())
                    : null);
            options.add(opt);
        }
        return Result.OK(options);
    }

    @Operation(summary = "提案状态选项（枚举，非字典）")
    @GetMapping("/statuses")
    public Result<List<StatusOption>> statuses() {
        List<StatusOption> options = new ArrayList<>();
        for (ProposalStatusEnum item : ProposalStatusEnum.values()) {
            StatusOption opt = new StatusOption();
            opt.setCode(item.getCode());
            opt.setLabel(item.getLabel());
            opt.setTerminal(item.terminal());
            options.add(opt);
        }
        return Result.OK(options);
    }

    @Operation(summary = "改善性质选项（配置表，非字典；默认仅启用）")
    @GetMapping("/improvementTypes")
    public Result<List<ImprovementTypeOption>> improvementTypes(
            @RequestParam(name = "enabledOnly", defaultValue = "true") boolean enabledOnly) {
        return Result.OK(improvementTypeService.listOptions(enabledOnly));
    }

    //update-begin---author:spex ---date:2026-08-31  for：【提案管理端】选人后一次查出姓名/工号/部门/职位-----------
    @Operation(summary = "用户摘要（含所属部门名，逗号分隔 id）")
    @GetMapping("/userBriefs")
    public Result<List<UserBriefVo>> userBriefs(@RequestParam(name = "userIds") String userIds) {
        if (oConvertUtils.isEmpty(userIds)) {
            return Result.OK(new ArrayList<>());
        }
        List<String> ids = Arrays.stream(userIds.split(","))
                .map(String::trim)
                .filter(oConvertUtils::isNotEmpty)
                .distinct()
                .collect(Collectors.toList());
        Map<String, UserBriefVo> map = orgFillHelper.loadUsers(ids);
        List<UserBriefVo> list = new ArrayList<>();
        for (String id : ids) {
            UserBriefVo vo = map.get(id);
            if (vo != null) {
                list.add(vo);
            }
        }
        return Result.OK(list);
    }
    //update-end---author:spex ---date:2026-08-31  for：【提案管理端】选人后一次查出姓名/工号/部门/职位-----------

    private Map<String, String> queryNameMap(String sqlTemplate, List<String> ids) {
        if (ids == null || ids.isEmpty()) {
            return Map.of();
        }
        String placeholders = ids.stream().map(id -> "?").collect(Collectors.joining(","));
        String sql = String.format(sqlTemplate, placeholders);
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, ids.toArray());
        return rows.stream().collect(Collectors.toMap(
                r -> String.valueOf(r.get("id")),
                r -> r.get("name") == null ? "" : String.valueOf(r.get("name")),
                (a, b) -> a));
    }
}
