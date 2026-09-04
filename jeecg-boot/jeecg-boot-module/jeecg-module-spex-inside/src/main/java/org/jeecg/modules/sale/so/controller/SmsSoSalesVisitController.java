package org.jeecg.modules.sale.so.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.sale.config.BaseException;
import org.apache.commons.collections.CollectionUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.modules.sale.so.entity.SmsSoSalesVisit;
import org.jeecg.modules.sale.so.service.ISmsSoSalesVisitService;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;

import org.jeecg.modules.sale.so.utils.PreDealUtils;
import org.jeecg.common.system.base.controller.JeecgController;
import org.jeecg.modules.sale.so.vo.MyTodoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Operation;

import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_N;
import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_Y;

/**
 * @Description: 项目拜访跟进记录
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 *
 */

@Tag(name="4-5项目拜访跟进记录")
@RestController
@RequestMapping("/sms/smsSoSalesVisit")
@Slf4j
public class SmsSoSalesVisitController extends JeecgController<SmsSoSalesVisit, ISmsSoSalesVisitService> {
	@Autowired
	private ISmsSoSalesVisitService smsSoSalesVisitService;

	@Autowired
	private PreDealUtils preDealUtils;

/**
	 * 分页列表查询
	 *
	 * @param smsSoSalesVisit
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */

	@Operation(summary="项目拜访跟进记录-分页列表查询", description="项目拜访跟进记录-分页列表查询")
	@GetMapping(value = "/list")
	public Result<?> queryPageList(SmsSoSalesVisit smsSoSalesVisit,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<SmsSoSalesVisit> queryWrapper = QueryGenerator.initQueryWrapper(smsSoSalesVisit, req.getParameterMap());
		queryWrapper.eq("active", ACTIVE_Y);
		queryWrapper.orderByDesc("create_time");
		Page<SmsSoSalesVisit> page = new Page<SmsSoSalesVisit>(pageNo, pageSize);
		IPage<SmsSoSalesVisit> pageList = smsSoSalesVisitService.page(page, queryWrapper);
		return Result.OK(pageList);
	}
	
/**
	 *   添加
	 *
	 * @param smsSoSalesVisit
	 * @return
	 */

	@AutoLog(value = "项目拜访跟进记录-添加")
	@Operation(summary="项目拜访跟进记录-添加", description="项目拜访跟进记录-添加")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody SmsSoSalesVisit smsSoSalesVisit) {
		preDealUtils.preAddDealEntityById(smsSoSalesVisit);
		smsSoSalesVisit.setActive(ACTIVE_Y);
		smsSoSalesVisitService.saveMain(smsSoSalesVisit);
		return Result.OK("添加成功！");
	}
	
/**
	 *  编辑
	 *
	 * @param smsSoSalesVisit
	 * @return
	 */

	@AutoLog(value = "项目拜访跟进记录-编辑")
	@Operation(summary="项目拜访跟进记录-编辑", description="项目拜访跟进记录-编辑")
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody SmsSoSalesVisit smsSoSalesVisit) {
		preDealUtils.preDealEntityById(smsSoSalesVisit);
		smsSoSalesVisitService.updateMain(smsSoSalesVisit);
		return Result.OK("编辑成功!");
	}
	
/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */

	@AutoLog(value = "项目拜访跟进记录-通过id删除")
	@Operation(summary="项目拜访跟进记录-通过id删除", description="项目拜访跟进记录-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		SmsSoSalesVisit qmsPlanCustomer = smsSoSalesVisitService.getById(id);
		if (Objects.isNull(qmsPlanCustomer)) return Result.error("未找到有效数据");

		//逻辑删除
		qmsPlanCustomer.setActive(ACTIVE_N);
		preDealUtils.preDealEntityById(qmsPlanCustomer);
		smsSoSalesVisitService.updateById(qmsPlanCustomer);
		return Result.OK("删除成功!");
	}
	
/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */

	@AutoLog(value = "项目拜访跟进记录-批量删除")
	@Operation(summary="项目拜访跟进记录-批量删除", description="项目拜访跟进记录-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		List<SmsSoSalesVisit> oldList = smsSoSalesVisitService.listByIds(Arrays.asList(ids.split(",")));
		if (CollectionUtils.isEmpty(oldList)) return Result.error("未找到有效数据");
		oldList.forEach(old -> {
			preDealUtils.preDealEntityById(old);
			old.setActive(ACTIVE_N);
		});
		smsSoSalesVisitService.updateBatchById(oldList);
		return Result.OK("批量删除成功!");
	}
	
/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */

	@Operation(summary="项目拜访跟进记录-通过id查询", description="项目拜访跟进记录-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<SmsSoSalesVisit> queryById(@RequestParam(name="id",required=true) String id) {
		SmsSoSalesVisit rdmMdmItemBrand = smsSoSalesVisitService.getById(id);
		if(rdmMdmItemBrand==null) {
			throw new BaseException(400, "未找到对应数据");
		}
		return Result.OK(rdmMdmItemBrand);
	}

/**
    * 导出excel
    *
    * @param request
    * @param smsSoSalesVisit
    */

	@Operation(summary="项目拜访跟进记录-导出", description="项目拜访跟进记录-导出")
	@GetMapping(value = "/exportXls")
    public ModelAndView exportXls(HttpServletRequest request, SmsSoSalesVisit smsSoSalesVisit) {
		List<SmsSoSalesVisit> list = smsSoSalesVisitService.exportList(smsSoSalesVisit, request.getParameterMap());
		return super.exportXls(request,SmsSoSalesVisit.class, list, "项目拜访跟进记录");
    }

/**
      * 通过excel导入数据
    *
    * @param request
    * @param response
    * @return
    */

    @RequestMapping(value = "/importExcel", method = RequestMethod.POST)
    public Result<?> importExcel(HttpServletRequest request, HttpServletResponse response) {
        return super.importExcel(request, response, SmsSoSalesVisit.class);
    }

    @AutoLog(value = "我的待办-项目待跟进")
    @Operation(summary = "我的待办：3天内待跟进项目")
    @GetMapping("/myTodoProject")
    public Result<IPage<MyTodoVO>> myTodoProject(
            @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo,
            @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize
    ){
        LoginUser user = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        String loginUserId = user.getUsername();
        Page<MyTodoVO> page = new Page<>(pageNo,pageSize);
        IPage<MyTodoVO> resultPage = smsSoSalesVisitService.queryMyTodo(page,loginUserId);
        return Result.OK(resultPage);
    }

    /**
     *  上级点评
     *
     * @param smsSoSalesVisit
     * @return
     */

    @AutoLog(value = "项目拜访跟进记录-上级点评")
    @Operation(summary="项目拜访跟进记录-上级点评", description="项目拜访跟进记录-上级点评")
    @PostMapping(value = "/comment")
    public Result<?> comment(@RequestBody SmsSoSalesVisit smsSoSalesVisit) {
        preDealUtils.preDealEntityById(smsSoSalesVisit);
        smsSoSalesVisitService.comment(smsSoSalesVisit);
        return Result.OK("成功!");
    }
}
