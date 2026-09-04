package org.jeecg.modules.sale.so.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import org.jeecg.modules.sale.config.BaseException;
import org.jeecg.modules.sale.so.entity.SmsSoSalesProject;
import org.jeecg.modules.sale.so.mapper.SmsSoSalesProjectMapper;
import org.jeecg.modules.sale.so.service.ISmsSoSalesProjectService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.modules.sale.so.utils.DictUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_Y;


/**
 * @Description: 客户销售项目跟进明细
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */

@Service
public class SmsSoSalesProjectServiceImpl extends ServiceImpl<SmsSoSalesProjectMapper, SmsSoSalesProject> implements ISmsSoSalesProjectService {

    @Autowired
    private DictUtil dictUtil;

    @Autowired
    private SmsSoSalesSerialServiceImpl smsSoSalesSerialService;

    @Override
    public void saveMain(SmsSoSalesProject smsSoSalesProject) {
        if (StringUtils.isEmpty(smsSoSalesProject.getCustomerId())) {
            throw new BaseException("客户id不能为空");
        }
        if ("1".equals(smsSoSalesProject.getIsTemp())) {
            String projectNo = smsSoSalesSerialService.nextProjectNo(true);
            smsSoSalesProject.setProjectNo(projectNo);
        } else if ("2".equals(smsSoSalesProject.getIsTemp())){
            String projectNo = smsSoSalesSerialService.nextProjectNo(false);
            smsSoSalesProject.setProjectNo(projectNo);
        } else {
            String projectNo = smsSoSalesSerialService.ywProjectNo();
            smsSoSalesProject.setProjectNo(projectNo);
        }
        LambdaQueryChainWrapper<SmsSoSalesProject> wrapper = new LambdaQueryChainWrapper<>(getBaseMapper());
        wrapper.eq(SmsSoSalesProject::getProjectNo, smsSoSalesProject.getProjectNo())
                .eq(SmsSoSalesProject::getActive, ACTIVE_Y);
        SmsSoSalesProject old = wrapper.one();
        if (Objects.isNull(old)) {
            this.save(smsSoSalesProject);
        } else {
            throw new BaseException("项目编码已存在，请重新输入！");
        }
    }

    @Override
    public void updateMain(SmsSoSalesProject smsSoSalesProject) {
        if (StringUtils.isEmpty(smsSoSalesProject.getCustomerId())) {
            throw new BaseException("客户id不能为空");
        }
        SmsSoSalesProject project = this.getById(smsSoSalesProject.getId());
        if ("1".equals(project.getIsTemp()) && "0".equals(smsSoSalesProject.getIsTemp())) {
            String projectNo = smsSoSalesSerialService.convertTempToFormal(project.getProjectNo());
            smsSoSalesProject.setProjectNo(projectNo);
        }
        LambdaQueryChainWrapper<SmsSoSalesProject> wrapper = new LambdaQueryChainWrapper<>(getBaseMapper());
        wrapper.eq(SmsSoSalesProject::getProjectNo, smsSoSalesProject.getProjectNo())
                .eq(SmsSoSalesProject::getActive, ACTIVE_Y)
                .ne(SmsSoSalesProject::getId, smsSoSalesProject.getId());
        SmsSoSalesProject old = wrapper.one();
        if (Objects.isNull(old)) {
            this.updateById(smsSoSalesProject);
        } else {
            throw new BaseException("项目编码已存在，请重新输入！");
        }
    }

    @Override
    public List<SmsSoSalesProject> exportList(SmsSoSalesProject smsSoSalesProject, Map<String, String[]> parameterMap) {
        QueryWrapper<SmsSoSalesProject> queryWrapper = QueryGenerator.initQueryWrapper(smsSoSalesProject, parameterMap);
        queryWrapper.eq("active", ACTIVE_Y);
        queryWrapper.orderByDesc("create_time");
        List<SmsSoSalesProject> list = this.list(queryWrapper);
        if (CollectionUtils.isNotEmpty(list)) {
            list.forEach(ac->{
                ac.setStatus(dictUtil.getNameByKey("sms_so_sales_project_status", ac.getStatus()));
                ac.setCurrentStage(dictUtil.getNameByKey("sms_so_sales_level", ac.getCurrentStage()));
                ac.setWinProb(dictUtil.getNameByKey("sms_so_sales_project_win", ac.getCurrentStage()));
                ac.setFinalResult(dictUtil.getNameByKey("sms_so_sales_project_result", ac.getFinalResult()));
            });
        }
        return list;
    }

    @Override
    public List<SmsSoSalesProject> selectByCustomerIdList(List<String> headerIds) {
        LambdaQueryChainWrapper<SmsSoSalesProject> wrapper = new LambdaQueryChainWrapper<>(getBaseMapper());
        wrapper.in(SmsSoSalesProject::getCustomerId, headerIds)
                .eq(SmsSoSalesProject::getFinalResult, "1")
                .eq(SmsSoSalesProject::getActive, ACTIVE_Y);
        List<SmsSoSalesProject> list = wrapper.list();
        return list;
    }
}
