package org.jeecg.modules.proposal.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
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
import org.jeecg.modules.proposal.service.IProposalService;
import org.jeecg.modules.proposal.vo.ProposalDetailVo;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;

/**
 * 管理端 - 提案管理控制器
 */
@Slf4j
@Tag(name = "管理端-提案管理")
@RestController
@RequestMapping("/proposal/admin/manage")
public class ProposalManageController extends JeecgController<Proposal, IProposalService> {

    @Operation(summary = "分页列表查询")
    @GetMapping("/list")
    public Result<IPage<Proposal>> list(Proposal proposal,
                                        @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo,
                                        @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize,
                                        @RequestParam(name = "proposerName", required = false) String proposerName,
                                        HttpServletRequest req) {
        QueryWrapper<Proposal> queryWrapper = QueryGenerator.initQueryWrapper(proposal, req.getParameterMap());
        // 【提案管理】按提案人姓名模糊检索
        if (oConvertUtils.isNotEmpty(proposerName)) {
            queryWrapper.apply(
                    "proposer_id in (select id from sys_user where realname like concat('%',{0},'%'))",
                    proposerName.trim());
        }

        queryWrapper.orderByDesc("create_time");
        Page<Proposal> page = new Page<>(pageNo, pageSize);
        IPage<Proposal> pageList = service.page(page, queryWrapper);
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
}
