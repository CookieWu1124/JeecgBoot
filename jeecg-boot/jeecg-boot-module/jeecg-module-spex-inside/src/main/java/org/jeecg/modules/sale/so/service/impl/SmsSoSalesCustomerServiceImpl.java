package org.jeecg.modules.sale.so.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import org.jeecg.modules.sale.config.BaseException;
import org.jeecg.modules.sale.so.entity.SmsSoSalesCustomer;
import org.jeecg.modules.sale.so.entity.SmsSoSalesProject;
import org.jeecg.modules.sale.so.mapper.SmsSoSalesCustomerMapper;
import org.jeecg.modules.sale.so.service.ISmsSoSalesCustomerService;
import org.jeecg.modules.sale.so.service.ISmsSoSalesProjectService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.modules.sale.so.utils.DictUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_Y;


/**
 * @Description: 销售客户档案表
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */
@Service
public class SmsSoSalesCustomerServiceImpl extends ServiceImpl<SmsSoSalesCustomerMapper, SmsSoSalesCustomer> implements ISmsSoSalesCustomerService {

    @Autowired
    private DictUtil dictUtil;

    @Autowired
    private ISmsSoSalesProjectService smsSoSalesProjectService;

    @Override
    public void saveMain(SmsSoSalesCustomer smsSoSalesCustomer) {
        if (StringUtils.isEmpty(smsSoSalesCustomer.getCustomerNo())) {
            throw new BaseException("客户编号不能为空");
        }
        smsSoSalesCustomer.setSaleUserId(smsSoSalesCustomer.getCreateNo());
        LambdaQueryChainWrapper<SmsSoSalesCustomer> wrapper = new LambdaQueryChainWrapper<>(getBaseMapper());
        wrapper.eq(SmsSoSalesCustomer::getCustomerNo, smsSoSalesCustomer.getCustomerNo())
                .eq(SmsSoSalesCustomer::getActive, ACTIVE_Y);
        SmsSoSalesCustomer old = wrapper.one();
        if (Objects.isNull(old)) {
            this.save(smsSoSalesCustomer);
        } else {
            throw new BaseException("客户编号已存在，请重新输入！");
        }
    }

    @Override
    public void updateMain(SmsSoSalesCustomer smsSoSalesCustomer) {
        if (StringUtils.isEmpty(smsSoSalesCustomer.getCustomerNo())) {
            throw new BaseException("客户编号不能为空");
        }
        LambdaQueryChainWrapper<SmsSoSalesCustomer> wrapper = new LambdaQueryChainWrapper<>(getBaseMapper());
        wrapper.eq(SmsSoSalesCustomer::getCustomerNo, smsSoSalesCustomer.getCustomerNo())
                .eq(SmsSoSalesCustomer::getActive, ACTIVE_Y)
                .ne(SmsSoSalesCustomer::getId, smsSoSalesCustomer.getId());
        SmsSoSalesCustomer old = wrapper.one();
        if (Objects.isNull(old)) {
            this.updateById(smsSoSalesCustomer);
        } else {
            throw new BaseException("客户编号已存在，请重新输入！");
        }
    }

    @Override
    public List<SmsSoSalesCustomer> exportList(SmsSoSalesCustomer smsSoSalesCustomer, Map<String, String[]> parameterMap) {
        QueryWrapper<SmsSoSalesCustomer> queryWrapper = QueryGenerator.initQueryWrapper(smsSoSalesCustomer, parameterMap);
        queryWrapper.eq("active", ACTIVE_Y);
        queryWrapper.orderByDesc("create_time");
        List<SmsSoSalesCustomer> list = this.list(queryWrapper);
        if (CollectionUtils.isNotEmpty(list)) {
            list.forEach(ac->{
                ac.setIndustry(dictUtil.getNameByKey("sms_so_sales_industry", ac.getIndustry()));
                ac.setLevel(dictUtil.getNameByKey("sms_so_sales_level", ac.getLevel()));
                ac.setSource(dictUtil.getNameByKey("sms_so_sales_source", ac.getSource()));
            });
        }
        // 1. 获取所有表头ID
        List<String> headerIds = list.stream()
                .map(SmsSoSalesCustomer::getId)
                .collect(Collectors.toList());
        // 2. IN批量查询所有明细，只执行1次SQL
        if (CollectionUtil.isNotEmpty(headerIds)) {
            List<SmsSoSalesProject> allLines = smsSoSalesProjectService.selectByCustomerIdList(headerIds);
            Map<String, List<SmsSoSalesProject>> lineGroupMap = allLines.stream()
                    .collect(Collectors.groupingBy(SmsSoSalesProject::getCustomerId));
            if (CollectionUtils.isNotEmpty(list)) {
                list.forEach(ac->{
                    List<SmsSoSalesProject> itemList = lineGroupMap.getOrDefault(ac.getId(), Collections.emptyList());
                    ac.setTotalProjectAmount(
                            itemList.stream()
                                    .map(SmsSoSalesProject::getProjectAmount)
                                    .filter(Objects::nonNull)
                                    .reduce(BigDecimal.ZERO, BigDecimal::add));
                });
            }
        }
        return list;
    }
}
