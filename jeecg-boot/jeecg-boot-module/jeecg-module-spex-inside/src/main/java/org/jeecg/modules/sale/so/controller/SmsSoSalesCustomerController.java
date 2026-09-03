package org.jeecg.modules.sale.so.controller;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import cn.hutool.core.collection.CollectionUtil;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.sale.config.BaseException;
import org.jeecg.modules.sale.so.entity.SmsSoSalesProject;
import org.jeecg.modules.sale.so.service.ISmsSoSalesProjectService;
import org.apache.commons.collections.CollectionUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.modules.sale.so.entity.SmsSoSalesCustomer;
import org.jeecg.modules.sale.so.service.ISmsSoSalesCustomerService;

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

import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_Y;

/**
 * @Description: 销售客户档案表
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */
@Tag(name="4-3销售客户档案表")
@RestController
@RequestMapping("/sms/smsSoSalesCustomer")
@Slf4j
public class SmsSoSalesCustomerController extends JeecgController<SmsSoSalesCustomer, ISmsSoSalesCustomerService> {
	@Autowired
	private ISmsSoSalesCustomerService smsSoSalesCustomerService;

	@Autowired
	private ISmsSoSalesProjectService smsSoSalesProjectService;

    @Autowired
    private PreDealUtils preDealUtils;

	/**
	 * 分页列表查询
	 *
	 * @param smsSoSalesCustomer
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */
	@Operation(summary="销售客户档案表-分页列表查询", description="销售客户档案表-分页列表查询")
	@GetMapping(value = "/list")
	public Result<IPage<SmsSoSalesCustomer>> queryPageList(SmsSoSalesCustomer smsSoSalesCustomer,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<SmsSoSalesCustomer> queryWrapper = QueryGenerator.initQueryWrapper(smsSoSalesCustomer, req.getParameterMap());
        //=======新增联合模糊查询逻辑=======
        String keyword = req.getParameter("keyword");
        if(oConvertUtils.isNotEmpty(keyword)){
            queryWrapper.and(wrapper -> wrapper.like("customer_name", keyword).or().like("customer_no", keyword));
        }
        LoginUser user = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        String roleCode = user.getRoleCode();
        if (!roleCode.contains("saleManager")) {
            queryWrapper.eq("sale_user_id", user.getUsername());
        }
        queryWrapper.eq("active", ACTIVE_Y);
		queryWrapper.orderByDesc("create_time");
		Page<SmsSoSalesCustomer> page = new Page<SmsSoSalesCustomer>(pageNo, pageSize);
		IPage<SmsSoSalesCustomer> pageList = smsSoSalesCustomerService.page(page, queryWrapper);
		List<SmsSoSalesCustomer> records = pageList.getRecords();
		// 1. 获取所有表头ID
		List<String> headerIds = records.stream()
				.map(SmsSoSalesCustomer::getId)
				.collect(Collectors.toList());
		// 2. IN批量查询所有明细，只执行1次SQL
		if (CollectionUtil.isNotEmpty(headerIds)) {
			List<SmsSoSalesProject> allLines = smsSoSalesProjectService.selectByCustomerIdList(headerIds);
			// 3. 按退货单ID分组
			Map<String, List<SmsSoSalesProject>> lineGroupMap = allLines.stream()
					.collect(Collectors.groupingBy(SmsSoSalesProject::getCustomerId));
			records.stream().forEach(o->{
				List<SmsSoSalesProject> itemList = lineGroupMap.getOrDefault(o.getId(), Collections.emptyList());
				o.setTotalProjectAmount(
						itemList.stream()
								.map(SmsSoSalesProject::getProjectAmount)
								.filter(Objects::nonNull)
								.reduce(BigDecimal.ZERO, BigDecimal::add));
			});
		}
		return Result.OK(pageList);
	}

    /**
     * 分页列表查询（公海池）
     *
     * @param smsSoSalesCustomer
     * @param pageNo
     * @param pageSize
     * @param req
     * @return
     */
    @Operation(summary="销售客户档案表-分页列表查询（公海池）", description="销售客户档案表-分页列表查询（公海池）")
    @GetMapping(value = "/listNoUser")
    public Result<IPage<SmsSoSalesCustomer>> listNoUser(SmsSoSalesCustomer smsSoSalesCustomer,
                                                           @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
                                                           @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
                                                           HttpServletRequest req) {
        QueryWrapper<SmsSoSalesCustomer> queryWrapper = QueryGenerator.initQueryWrapper(smsSoSalesCustomer, req.getParameterMap());
        //=======新增联合模糊查询逻辑=======
        String keyword = req.getParameter("keyword");
        if(oConvertUtils.isNotEmpty(keyword)){
            queryWrapper.and(wrapper -> wrapper.like("customer_name", keyword).or().like("customer_no", keyword));
        }
        queryWrapper.eq("sale_user_id", "");
        queryWrapper.eq("active", ACTIVE_Y);
        queryWrapper.orderByDesc("create_time");
        Page<SmsSoSalesCustomer> page = new Page<SmsSoSalesCustomer>(pageNo, pageSize);
        IPage<SmsSoSalesCustomer> pageList = smsSoSalesCustomerService.page(page, queryWrapper);
        List<SmsSoSalesCustomer> records = pageList.getRecords();
        // 1. 获取所有表头ID
        List<String> headerIds = records.stream()
                .map(SmsSoSalesCustomer::getId)
                .collect(Collectors.toList());
        // 2. IN批量查询所有明细，只执行1次SQL
        if (CollectionUtil.isNotEmpty(headerIds)) {
            List<SmsSoSalesProject> allLines = smsSoSalesProjectService.selectByCustomerIdList(headerIds);
            // 3. 按退货单ID分组
            Map<String, List<SmsSoSalesProject>> lineGroupMap = allLines.stream()
                    .collect(Collectors.groupingBy(SmsSoSalesProject::getCustomerId));
            records.stream().forEach(o->{
                List<SmsSoSalesProject> itemList = lineGroupMap.getOrDefault(o.getId(), Collections.emptyList());
                o.setTotalProjectAmount(
                        itemList.stream()
                                .map(SmsSoSalesProject::getProjectAmount)
                                .filter(Objects::nonNull)
                                .reduce(BigDecimal.ZERO, BigDecimal::add));
            });
        }
        return Result.OK(pageList);
    }

	/**
	 * 列表查询
	 *
	 * @param smsSoSalesCustomer
	 * @param req
	 * @return
	 */
	@Operation(summary="销售客户档案表-列表查询", description="销售客户档案表-列表查询")
	@GetMapping(value = "/queryList")
	public Result<List<SmsSoSalesCustomer>> queryList(SmsSoSalesCustomer smsSoSalesCustomer,
														   HttpServletRequest req) {
		QueryWrapper<SmsSoSalesCustomer> queryWrapper = QueryGenerator.initQueryWrapper(smsSoSalesCustomer, req.getParameterMap());
        //=======新增联合模糊查询逻辑=======
        String keyword = req.getParameter("keyword");
        if(oConvertUtils.isNotEmpty(keyword)){
            queryWrapper.and(wrapper -> wrapper.like("customer_name", keyword).or().like("customer_no", keyword));
        }
        LoginUser user = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        String roleCode = user.getRoleCode();
        if (!roleCode.contains("saleManager")) {
            queryWrapper.eq("sale_user_id", user.getUsername());
        }
        queryWrapper.eq("active", ACTIVE_Y);
		queryWrapper.orderByDesc("create_time");
		List<SmsSoSalesCustomer> list = smsSoSalesCustomerService.list(queryWrapper);
		return Result.OK(list);
	}

	/**
	 *   添加
	 *
	 * @param smsSoSalesCustomer
	 * @return
	 */
	@AutoLog(value = "销售客户档案表-添加")
	@Operation(summary="销售客户档案表-添加", description="销售客户档案表-添加")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody SmsSoSalesCustomer smsSoSalesCustomer) {
		preDealUtils.preAddDealEntityById(smsSoSalesCustomer);
		smsSoSalesCustomer.setActive(ACTIVE_Y);
		smsSoSalesCustomerService.saveMain(smsSoSalesCustomer);
		return Result.OK("添加成功！");
	}
	
	/**
	 *  编辑
	 *
	 * @param smsSoSalesCustomer
	 * @return
	 */
	@AutoLog(value = "销售客户档案表-编辑")
	@Operation(summary="销售客户档案表-编辑", description="销售客户档案表-编辑")
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody SmsSoSalesCustomer smsSoSalesCustomer) {
		preDealUtils.preDealEntityById(smsSoSalesCustomer);
		smsSoSalesCustomerService.updateMain(smsSoSalesCustomer);
		return Result.OK("编辑成功!");
	}
	
	/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "销售客户档案表-通过id删除")
	@Operation(summary="销售客户档案表-通过id删除", description="销售客户档案表-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		SmsSoSalesCustomer qmsPlanCustomer = smsSoSalesCustomerService.getById(id);
		if (Objects.isNull(qmsPlanCustomer)) return Result.error("未找到有效数据");

		//逻辑删除
		qmsPlanCustomer.setActive("Y");
		preDealUtils.preDealEntityById(qmsPlanCustomer);
		smsSoSalesCustomerService.updateById(qmsPlanCustomer);
		return Result.OK("删除成功!");
	}
	
	/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */
	@AutoLog(value = "销售客户档案表-批量删除")
	@Operation(summary="销售客户档案表-批量删除", description="销售客户档案表-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		List<SmsSoSalesCustomer> oldList = smsSoSalesCustomerService.listByIds(Arrays.asList(ids.split(",")));
		if (CollectionUtils.isEmpty(oldList)) return Result.error("未找到有效数据");
		oldList.forEach(old -> {
			preDealUtils.preDealEntityById(old);
			old.setActive("Y");
		});
		smsSoSalesCustomerService.updateBatchById(oldList);
		return Result.OK("批量删除成功!");
	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@Operation(summary="销售客户档案表-通过id查询", description="销售客户档案表-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<SmsSoSalesCustomer> queryById(@RequestParam(name="id",required=true) String id) {
		SmsSoSalesCustomer rdmMdmItemBrand = smsSoSalesCustomerService.getById(id);
		if(rdmMdmItemBrand==null) {
			throw new BaseException(400, "未找到对应数据");
		}
		return Result.OK(rdmMdmItemBrand);
	}

    /**
    * 导出excel
    *
    * @param request
    * @param smsSoSalesCustomer
    */
	@Operation(summary="销售客户档案表-导出", description="销售客户档案表-导出")
	@GetMapping(value = "/exportXls")
    public ModelAndView exportXls(HttpServletRequest request, SmsSoSalesCustomer smsSoSalesCustomer) {
		List<SmsSoSalesCustomer> list = smsSoSalesCustomerService.exportList(smsSoSalesCustomer, request.getParameterMap());
		return super.exportXls(request,SmsSoSalesCustomer.class, list, "销售客户档案表");
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
        return super.importExcel(request, response, SmsSoSalesCustomer.class);
    }

    /**
     * 领取客户
     * @param id 客户主键id
     * @return
     */
    @AutoLog(value = "销售客户档案表-领取客户")
    @Operation(summary = "销售客户档案表-领取客户", description = "领取客户，把当前登录用户id存入sale_user_id")
    @PostMapping(value = "/receiveCustomer")
    public Result<?> receiveCustomer(@RequestParam(name = "id",required = true) String id) {
        //1. 根据id查询客户
        SmsSoSalesCustomer customer = smsSoSalesCustomerService.getById(id);
        if (Objects.isNull(customer)) {
            return Result.error("未找到该客户数据");
        }

        //2. 判断：已经被别人领取（sale_user_id不为空且不为null），不允许重复领取
        if (oConvertUtils.isNotEmpty(customer.getSaleUserId())) {
            return Result.error("该客户已经被其他人领取，不可重复领取");
        }

        //3. 设置当前登录用户id到sale_user_id
        LoginUser user = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        customer.setSaleUserId(user.getUsername());

        //4. 公共预处理（同删除接口写法）
        preDealUtils.preDealEntityById(customer);
        boolean ok = smsSoSalesCustomerService.updateById(customer);
        if(!ok){
            return Result.error("领取失败");
        }
        return Result.OK("领取成功！");
    }

}
