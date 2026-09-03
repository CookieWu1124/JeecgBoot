package org.jeecg.modules.sale.so.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.sale.so.dto.AuditDto;
import org.jeecg.modules.sale.so.entity.SmsSoSalesDinnerApply;
import org.jeecg.modules.sale.so.mapper.SmsSoSalesDinnerApplyMapper;
import org.jeecg.modules.sale.so.service.ISmsSoSalesDinnerApplyService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.jeecg.common.system.api.ISysBaseAPI;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.modules.sale.so.utils.DictUtil;
import org.jeecg.modules.sale.so.utils.PreDealUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_N;
import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_Y;


/**
 * @Description: 商务宴请
 * @Author: jeecg-boot
 * @Date:   2026-08-05
 * @Version: V1.0
 */

@Service
@Slf4j
public class SmsSoSalesDinnerApplyServiceImpl extends ServiceImpl<SmsSoSalesDinnerApplyMapper, SmsSoSalesDinnerApply> implements ISmsSoSalesDinnerApplyService {

    @Autowired
    private DictUtil dictUtil;

    @Autowired
    private PreDealUtils preDealUtils;

    @Override
    public void removeMain(String id) {
        SmsSoSalesDinnerApply dinnerApply = this.getById(id);
        if (dinnerApply == null) {
            throw new RuntimeException("申请单不存在");
        }
        if (!"0".equals(dinnerApply.getStatus())) {
            throw new RuntimeException("申请单不可删除");
        }
        dinnerApply.setActive(ACTIVE_N);
        this.updateById(dinnerApply);
    }

    @Override
    public List<SmsSoSalesDinnerApply> exportList(SmsSoSalesDinnerApply smsSoSalesDinnerApply, Map<String, String[]> parameterMap) {
        QueryWrapper<SmsSoSalesDinnerApply> queryWrapper = QueryGenerator.initQueryWrapper(smsSoSalesDinnerApply, parameterMap);
        queryWrapper.eq("active", ACTIVE_Y);
        queryWrapper.orderByDesc("create_time");
        List<SmsSoSalesDinnerApply> list = this.list(queryWrapper);
        if (CollectionUtils.isNotEmpty(list)) {
            list.forEach(ac->{
                ac.setStatus(dictUtil.getNameByKey("sms_so_apply_status", ac.getStatus()));
            });
        }
        return list;
    }

    @Override
    public void audit(AuditDto dto) {
        SmsSoSalesDinnerApply apply = this.getById(dto.getId());
        if (apply == null) {
            throw new RuntimeException("申请单不存在");
        }
        if (!"1".equals(apply.getStatus())) {
            throw new RuntimeException("申请单不可审核");
        }
        if (dto.getStatus().equals("1")) {
            //通过
            apply.setStatus("2");

        } else {
            //驳回
            apply.setStatus("3");
            apply.setAuditRemark(dto.getReason());
        }
        apply.setAuditTime(new Date());
        apply.setAuditUserId(preDealUtils.getLoginUser().getId());
        preDealUtils.preDealEntityById(apply);
        this.updateById(apply);
    }

    @Override
    public void removeMainByIds(List<String> asList) {
        for (String id : asList) {
            SmsSoSalesDinnerApply dinnerApply = this.getById(id);
            if (dinnerApply == null) {
                throw new RuntimeException("申请单不存在");
            }
            if (!"0".equals(dinnerApply.getStatus())) {
                throw new RuntimeException("申请单不可删除");
            }
            dinnerApply.setActive(ACTIVE_N);
            this.updateById(dinnerApply);
        }
    }
}
