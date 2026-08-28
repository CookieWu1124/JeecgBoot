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
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;

/**
 * ??? - ???????
 */
@Slf4j
@Tag(name = "???-????")
@RestController
@RequestMapping("/proposal/admin/manage")
public class ProposalManageController extends JeecgController<Proposal, IProposalService> {

    @Operation(summary = "??????")
    @GetMapping("/list")
    public Result<IPage<Proposal>> list(Proposal proposal,
                                        @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo,
                                        @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize,
                                        @RequestParam(name = "proposerName", required = false) String proposerName,
                                        HttpServletRequest req) {
        QueryWrapper<Proposal> queryWrapper = QueryGenerator.initQueryWrapper(proposal, req.getParameterMap());
        //update-begin---author:cursor ---date:2026-08-28  for：【提案管理】按提案人姓名模糊检索-----------
        if (oConvertUtils.isNotEmpty(proposerName)) {
            queryWrapper.apply(
                    "proposer_id in (select id from sys_user where realname like concat('%',{0},'%'))",
                    proposerName.trim());
        }
        //update-end---author:cursor ---date:2026-08-28  for：【提案管理】按提案人姓名模糊检索-----------
        queryWrapper.orderByDesc("create_time");
        Page<Proposal> page = new Page<>(pageNo, pageSize);
        IPage<Proposal> pageList = service.page(page, queryWrapper);
        return Result.OK(pageList);
    }

    @AutoLog(value = "???-??-??")
    @Operation(summary = "????")
    @PostMapping("/add")
    public Result<String> add(@RequestBody Proposal proposal) {
        service.save(proposal);
        return Result.OK("????");
    }

    @AutoLog(value = "???-??-??")
    @Operation(summary = "????")
    @PutMapping("/edit")
    public Result<String> edit(@RequestBody Proposal proposal) {
        service.updateById(proposal);
        return Result.OK("????");
    }

    @AutoLog(value = "???-??-??")
    @Operation(summary = "????")
    @DeleteMapping("/delete")
    public Result<String> delete(@RequestParam(name = "id") String id) {
        service.removeById(id);
        return Result.OK("????");
    }

    @Operation(summary = "????")
    @GetMapping("/queryById")
    public Result<Proposal> queryById(@RequestParam(name = "id") String id) {
        Proposal proposal = service.getById(id);
        if (proposal == null) {
            return Result.error("???????");
        }
        return Result.OK(proposal);
    }
}
