package org.jeecg.modules.sale.so.controller;

import java.util.Arrays;
import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.common.system.base.controller.JeecgController;
import org.jeecg.modules.sale.config.BaseException;
import org.jeecg.modules.sale.so.dto.AuditDto;
import org.jeecg.modules.sale.so.utils.PreDealUtils;
import org.jeecg.modules.sale.so.utils.ShipNoGenerator;
import org.apache.commons.lang3.StringUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.modules.sale.so.entity.SmsSoSalesDinnerApply;
import org.jeecg.modules.sale.so.service.ISmsSoSalesDinnerApplyService;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Operation;

import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_Y;
import static org.jeecg.common.util.TokenUtils.getTokenByRequest;

/**
 * @Description: 商务宴请
 * @Author: jeecg-boot
 * @Date:   2026-08-05
 * @Version: V1.0
 */

@Tag(name="4-6商务宴请")
@RestController
@RequestMapping("/sms/smsSoSalesDinnerApply")
@Slf4j
public class SmsSoSalesDinnerApplyController extends JeecgController<SmsSoSalesDinnerApply, ISmsSoSalesDinnerApplyService> {
	@Autowired
	private ISmsSoSalesDinnerApplyService smsSoSalesDinnerApplyService;

	@Autowired
	private PreDealUtils preDealUtils;

	@Autowired
	private ShipNoGenerator shipNoGenerator;


/**
	 * 分页列表查询
	 *
	 * @param smsSoSalesDinnerApply
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */

	@Operation(summary="商务宴请-分页列表查询", description="商务宴请-分页列表查询")
	@GetMapping(value = "/list")
	public Result<IPage<SmsSoSalesDinnerApply>> queryPageList(SmsSoSalesDinnerApply smsSoSalesDinnerApply,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<SmsSoSalesDinnerApply> queryWrapper = QueryGenerator.initQueryWrapper(smsSoSalesDinnerApply, req.getParameterMap());
		queryWrapper.eq("active", ACTIVE_Y);
		queryWrapper.orderByDesc("create_time");
		Page<SmsSoSalesDinnerApply> page = new Page<SmsSoSalesDinnerApply>(pageNo, pageSize);
		IPage<SmsSoSalesDinnerApply> pageList = smsSoSalesDinnerApplyService.page(page, queryWrapper);
		return Result.OK(pageList);
	}
	
/**
	 *   保存
	 *
	 * @param smsSoSalesDinnerApply
	 * @return
	 */

	@AutoLog(value = "商务宴请-保存")
	@Operation(summary="商务宴请-保存", description="商务宴请-保存")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody SmsSoSalesDinnerApply smsSoSalesDinnerApply) {
		if (StringUtils.isEmpty(smsSoSalesDinnerApply.getCustomerName())) {
			throw new BaseException(400, "客户名称不能为空");
		}
		smsSoSalesDinnerApply.setStatus("0");
		if (StringUtils.isNotBlank(smsSoSalesDinnerApply.getId())) {
			SmsSoSalesDinnerApply apply = smsSoSalesDinnerApplyService.getById(smsSoSalesDinnerApply.getId());
			if (apply == null ) {
				throw new BaseException(400, "数据不存在");
			}
			if (!"0".equals(apply.getStatus()) && !"3".equals(apply.getStatus())) {
				throw new BaseException(400, "该状态不可保存");
			}
			smsSoSalesDinnerApply.setStatus(apply.getStatus());
			preDealUtils.preDealEntityById(smsSoSalesDinnerApply);
			smsSoSalesDinnerApplyService.updateById(smsSoSalesDinnerApply);
		}else {
			preDealUtils.preAddDealEntityById(smsSoSalesDinnerApply);
			smsSoSalesDinnerApply.setActive(ACTIVE_Y);
			String applyNo = shipNoGenerator.generateBatchApplyNo();
			smsSoSalesDinnerApply.setApplyNo(applyNo);
			smsSoSalesDinnerApplyService.save(smsSoSalesDinnerApply);
		}
		return Result.OK("保存成功！");
	}
	
/**
	 *  提交
	 *
	 * @param smsSoSalesDinnerApply
	 * @return
	 */

	@AutoLog(value = "商务宴请-提交")
	@Operation(summary="商务宴请-提交", description="商务宴请-提交")
	@PutMapping(value = "/send")
	public Result<?> send(@RequestBody SmsSoSalesDinnerApply smsSoSalesDinnerApply, HttpServletRequest request) {
		smsSoSalesDinnerApply.setStatus("1");
		if (StringUtils.isNotBlank(smsSoSalesDinnerApply.getId())) {
			SmsSoSalesDinnerApply apply = smsSoSalesDinnerApplyService.getById(smsSoSalesDinnerApply.getId());
			if (apply == null ) {
				throw new BaseException(400, "数据不存在");
			}
			if (!"0".equals(apply.getStatus()) && !"3".equals(apply.getStatus())) {
				throw new BaseException(400, "该状态不可提交");
			}
			preDealUtils.preDealEntityById(smsSoSalesDinnerApply);
			smsSoSalesDinnerApply.setAuditRemark("");
			smsSoSalesDinnerApplyService.updateById(smsSoSalesDinnerApply);
		}else {
			preDealUtils.preAddDealEntityById(smsSoSalesDinnerApply);
			smsSoSalesDinnerApply.setActive(ACTIVE_Y);
			String applyNo = shipNoGenerator.generateBatchApplyNo();
			smsSoSalesDinnerApply.setApplyNo(applyNo);
			smsSoSalesDinnerApplyService.save(smsSoSalesDinnerApply);
		}
		return Result.OK("提交成功!");
	}
	
/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */

	@AutoLog(value = "商务宴请-通过id删除")
	@Operation(summary="商务宴请-通过id删除", description="商务宴请-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		smsSoSalesDinnerApplyService.removeMain(id);
		return Result.OK("删除成功!");
	}
	
/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */

	@AutoLog(value = "商务宴请-批量删除")
	@Operation(summary="商务宴请-批量删除", description="商务宴请-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		this.smsSoSalesDinnerApplyService.removeMainByIds(Arrays.asList(ids.split(",")));
		return Result.OK("批量删除成功!");
	}
	
/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */

	@Operation(summary="商务宴请-通过id查询", description="商务宴请-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<SmsSoSalesDinnerApply> queryById(@RequestParam(name="id",required=true) String id) {
		SmsSoSalesDinnerApply smsSoSalesDinnerApply = smsSoSalesDinnerApplyService.getById(id);
		if(smsSoSalesDinnerApply==null) {
			throw new BaseException(400, "未找到对应数据");
		}
		return Result.OK(smsSoSalesDinnerApply);
	}

/**
    * 导出excel
    *
    * @param request
    * @param smsSoSalesDinnerApply
    */

	@Operation(summary="商务宴请-导出", description="商务宴请-导出")
	@GetMapping(value = "/exportXls")
    public ModelAndView exportXls(HttpServletRequest request, SmsSoSalesDinnerApply smsSoSalesDinnerApply) {
		List<SmsSoSalesDinnerApply> list = smsSoSalesDinnerApplyService.exportList(smsSoSalesDinnerApply, request.getParameterMap());
		return super.exportXls(request,SmsSoSalesDinnerApply.class, list, "商务宴请表");
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
        return super.importExcel(request, response, SmsSoSalesDinnerApply.class);
    }

/**
	 *   批量审核
	 *
	 * @param dto
	 * @return
	 */

	@AutoLog(value = "商务宴请-审核")
	@Operation(summary="商务宴请-审核", description="商务宴请-审核")
	@PostMapping(value = "/audit")
	public Result<?> audit(@RequestBody AuditDto dto) throws Exception {
		smsSoSalesDinnerApplyService.audit(dto);
		return Result.OK("成功！");
	}

}
