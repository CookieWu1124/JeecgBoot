package org.jeecg.modules.proposal.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.common.system.base.controller.JeecgController;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.enums.ProposalStatusEnum;
import org.jeecg.modules.proposal.service.IProposalImprovementTypeService;
import org.jeecg.modules.proposal.service.IProposalService;
import org.jeecg.modules.proposal.service.ProposalOrgFillHelper;
import org.jeecg.modules.proposal.vo.ProposalDetailVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 管理端 - 提案管理控制器
 */
@Slf4j
@Tag(name = "管理端-提案管理")
@RestController
@RequestMapping("/proposal/admin/manage")
public class ProposalManageController extends JeecgController<Proposal, IProposalService> {

    @Autowired
    private IProposalImprovementTypeService improvementTypeService;
    @Autowired
    private ProposalOrgFillHelper orgFillHelper;

    @Operation(summary = "分页列表查询")
    @GetMapping("/list")
    public Result<IPage<Proposal>> list(Proposal proposal,
                                        @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo,
                                        @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize,
                                        @RequestParam(name = "proposerName", required = false) String proposerName,
                                        @RequestParam(name = "deptName", required = false) String deptName,
                                        HttpServletRequest req) {
        //update-begin---author:spex ---date:2026-09-01  for：【提案管理】模糊筛选用 MP like，避开 QueryGenerator 剥首尾字符-----------
        String proposalNo = proposal.getProposalNo();
        String title = proposal.getTitle();
        String typeCode = proposal.getImprovementTypes();
        proposal.setProposalNo(null);
        proposal.setTitle(null);
        proposal.setImprovementTypes(null);
        QueryWrapper<Proposal> queryWrapper = QueryGenerator.initQueryWrapper(proposal, req.getParameterMap());
        applyLike(queryWrapper, Proposal::getProposalNo, proposalNo);
        applyLike(queryWrapper, Proposal::getTitle, title);
        applyLike(queryWrapper, Proposal::getImprovementTypes, typeCode);
        if (!applyIn(queryWrapper, Proposal::getDeptId, orgFillHelper.findDeptIdsByNameLike(deptName))) {
            return Result.OK(new Page<>(pageNo, pageSize));
        }
        if (!applyIn(queryWrapper, Proposal::getProposerId, orgFillHelper.findUserIdsByRealnameLike(proposerName))) {
            return Result.OK(new Page<>(pageNo, pageSize));
        }
        //update-end---author:spex ---date:2026-09-01  for：【提案管理】模糊筛选用 MP like，避开 QueryGenerator 剥首尾字符-----------

        queryWrapper.orderByDesc("create_time");
        Page<Proposal> page = new Page<>(pageNo, pageSize);
        IPage<Proposal> pageList = service.page(page, queryWrapper);
        if (pageList.getRecords() != null) {
            pageList.getRecords().forEach(ProposalStatusEnum::attachLabel);
            improvementTypeService.attachTypeLabels(pageList.getRecords());
            //update-begin---author:spex ---date:2026-08-31  for：【提案管理端】列表嵌套回显人员部门-----------
            orgFillHelper.fillProposals(pageList.getRecords());
            //update-end---author:spex ---date:2026-08-31  for：【提案管理端】列表嵌套回显人员部门-----------
        }
        return Result.OK(pageList);
    }

    @AutoLog(value = "管理端-添加-提案")
    @Operation(summary = "添加提案")
    @PostMapping("/add")
    public Result<String> add(@RequestBody Proposal proposal) {
        service.save(proposal);
        return Result.OK("添加成功");
    }

    @AutoLog(value = "管理端-编辑-提案")
    @Operation(summary = "编辑提案")
    @PutMapping("/edit")
    public Result<String> edit(@RequestBody Proposal proposal) {
        service.updateById(proposal);
        return Result.OK("编辑成功");
    }

    @AutoLog(value = "管理端-删除-提案")
    @Operation(summary = "删除提案")
    @DeleteMapping("/delete")
    public Result<String> delete(@RequestParam(name = "id") String id) {
        service.removeById(id);
        return Result.OK("删除成功");
    }

    @Operation(summary = "查询详情")
    @GetMapping("/queryById")
    public Result<ProposalDetailVo> queryById(@RequestParam(name = "id") String id) {
        // 【提案管理】详情对齐原型（申请书/留痕）
        return Result.OK(service.getAdminDetail(id));
    }

    private static void applyLike(QueryWrapper<Proposal> queryWrapper,
                                  SFunction<Proposal, ?> column,
                                  String value) {
        if (oConvertUtils.isNotEmpty(value)) {
            queryWrapper.lambda().like(column, value.trim());
        }
    }

    /** ids == null 表示未筛选；空列表表示无匹配 */
    private static boolean applyIn(QueryWrapper<Proposal> queryWrapper,
                                   SFunction<Proposal, ?> column,
                                   List<String> ids) {
        if (ids == null) {
            return true;
        }
        if (ids.isEmpty()) {
            return false;
        }
        queryWrapper.lambda().in(column, ids);
        return true;
    }
}
