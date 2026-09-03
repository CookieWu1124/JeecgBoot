package org.jeecg.modules.sale.so.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.modules.sale.config.BaseException;
import org.apache.commons.collections.CollectionUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.modules.sale.so.entity.SmsSoSalesProject;
import org.jeecg.modules.sale.so.service.ISmsSoSalesProjectService;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;

import org.jeecg.modules.sale.so.utils.PreDealUtils;
import org.jeecg.common.system.base.controller.JeecgController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Operation;

import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_N;
import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_Y;

/**
 * @Description: 客户销售项目跟进明细
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */

@Tag(name="4-4客户销售项目跟进明细")
@RestController
@RequestMapping("/sms/smsSoSalesProject")
@Slf4j
public class SmsSoSalesProjectController extends JeecgController<SmsSoSalesProject, ISmsSoSalesProjectService> {
	@Autowired
	private ISmsSoSalesProjectService smsSoSalesProjectService;

	@Autowired
	private PreDealUtils preDealUtils;

/**
	 * 分页列表查询
	 *
	 * @param smsSoSalesProject
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */

	@Operation(summary="客户销售项目跟进明细-分页列表查询", description="客户销售项目跟进明细-分页列表查询")
	@GetMapping(value = "/list")
	public Result<IPage<SmsSoSalesProject>> queryPageList(SmsSoSalesProject smsSoSalesProject,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<SmsSoSalesProject> queryWrapper = QueryGenerator.initQueryWrapper(smsSoSalesProject, req.getParameterMap());
		queryWrapper.eq("active", ACTIVE_Y);
		queryWrapper.orderByDesc("create_time");
		Page<SmsSoSalesProject> page = new Page<SmsSoSalesProject>(pageNo, pageSize);
		IPage<SmsSoSalesProject> pageList = smsSoSalesProjectService.page(page, queryWrapper);
		return Result.OK(pageList);
	}
	
/**
	 *   添加
	 *
	 * @param smsSoSalesProject
	 * @return
	 */

	@AutoLog(value = "客户销售项目跟进明细-添加")
	@Operation(summary="客户销售项目跟进明细-添加", description="客户销售项目跟进明细-添加")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody SmsSoSalesProject smsSoSalesProject) {
		preDealUtils.preAddDealEntityById(smsSoSalesProject);
		smsSoSalesProject.setActive(ACTIVE_Y);
		smsSoSalesProjectService.saveMain(smsSoSalesProject);
		return Result.OK("添加成功！");
	}
	
/**
	 *  编辑
	 *
	 * @param smsSoSalesProject
	 * @return
	 */

	@AutoLog(value = "客户销售项目跟进明细-编辑")
	@Operation(summary="客户销售项目跟进明细-编辑", description="客户销售项目跟进明细-编辑")
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody SmsSoSalesProject smsSoSalesProject) {
		preDealUtils.preDealEntityById(smsSoSalesProject);
		smsSoSalesProjectService.updateMain(smsSoSalesProject);
		return Result.OK("编辑成功!");
	}
	
/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */

	@AutoLog(value = "客户销售项目跟进明细-通过id删除")
	@Operation(summary="客户销售项目跟进明细-通过id删除", description="客户销售项目跟进明细-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		SmsSoSalesProject qmsPlanCustomer = smsSoSalesProjectService.getById(id);
		if (Objects.isNull(qmsPlanCustomer)) return Result.error("未找到有效数据");

		//逻辑删除
		qmsPlanCustomer.setActive(ACTIVE_N);
		preDealUtils.preDealEntityById(qmsPlanCustomer);
		smsSoSalesProjectService.updateById(qmsPlanCustomer);
		return Result.OK("删除成功!");
	}
	
/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */

	@AutoLog(value = "客户销售项目跟进明细-批量删除")
	@Operation(summary="客户销售项目跟进明细-批量删除", description="客户销售项目跟进明细-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		List<SmsSoSalesProject> oldList = smsSoSalesProjectService.listByIds(Arrays.asList(ids.split(",")));
		if (CollectionUtils.isEmpty(oldList)) return Result.error("未找到有效数据");
		oldList.forEach(old -> {
			preDealUtils.preDealEntityById(old);
			old.setActive(ACTIVE_N);
		});
		smsSoSalesProjectService.updateBatchById(oldList);
		return Result.OK("批量删除成功!");
	}
	
/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */

	@Operation(summary="客户销售项目跟进明细-通过id查询", description="客户销售项目跟进明细-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<SmsSoSalesProject> queryById(@RequestParam(name="id",required=true) String id) {
		SmsSoSalesProject rdmMdmItemBrand = smsSoSalesProjectService.getById(id);
		if(rdmMdmItemBrand==null) {
			throw new BaseException(400, "未找到对应数据");
		}
		return Result.OK(rdmMdmItemBrand);
	}

/**
    * 导出excel
    *
    * @param request
    * @param smsSoSalesProject
    */

	@Operation(summary="客户销售项目跟进明细-导出", description="客户销售项目跟进明细-导出")
	@GetMapping(value = "/exportXls")
    public ModelAndView exportXls(HttpServletRequest request, SmsSoSalesProject smsSoSalesProject) {
		List<SmsSoSalesProject> list = smsSoSalesProjectService.exportList(smsSoSalesProject, request.getParameterMap());
		return super.exportXls(request,SmsSoSalesProject.class, list, "客户销售项目跟进明细");
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
        return super.importExcel(request, response, SmsSoSalesProject.class);
    }

}
