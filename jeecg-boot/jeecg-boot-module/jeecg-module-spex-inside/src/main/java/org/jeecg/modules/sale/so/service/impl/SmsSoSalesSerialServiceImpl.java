package org.jeecg.modules.sale.so.service.impl;

import org.jeecg.modules.sale.so.entity.SmsSoSalesSerial;
import org.jeecg.modules.sale.so.enums.NoTypeEnum;
import org.jeecg.modules.sale.so.mapper.SmsSoSalesSerialMapper;
import org.jeecg.modules.sale.so.service.ISmsSoSalesSerialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

/**
 * @Description: 项目编号流水号表
 * @Author: jeecg-boot
 * @Date:   2026-08-17
 * @Version: V1.0
 */

@Service
public class SmsSoSalesSerialServiceImpl extends ServiceImpl<SmsSoSalesSerialMapper, SmsSoSalesSerial> implements ISmsSoSalesSerialService {

    @Autowired
    private SmsSoSalesSerialMapper smsSoSalesSerialMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String nextProjectNo(boolean isTemp) {
        NoTypeEnum type = isTemp ? NoTypeEnum.PROJ_TEMP : NoTypeEnum.PROJ_FORMAL;
        int year = LocalDate.now().getYear();

        //行锁锁住计数器
        SmsSoSalesSerial counter = smsSoSalesSerialMapper.selectForUpdate(type.getCode(), year);
        if (counter == null) {
            counter = new SmsSoSalesSerial();
            counter.setNoType(type.getCode());
            counter.setCurYear(year);
            counter.setCurSerial(1);
            smsSoSalesSerialMapper.insert(counter);
        } else {
            //流水号+1
            smsSoSalesSerialMapper.incrementSerial(counter.getId());
            counter.setCurSerial(counter.getCurSerial() + 1);
        }
        //拼接编号：前缀+年份+3位补零流水
        return type.getPrefix() + year + String.format("%0" + type.getSerialLength() + "d", counter.getCurSerial());
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public String ywProjectNo() {
        NoTypeEnum type = NoTypeEnum.PROJ_YW;
        int year = LocalDate.now().getYear();

        //行锁锁住计数器
        SmsSoSalesSerial counter = smsSoSalesSerialMapper.selectForUpdate(type.getCode(), year);
        if (counter == null) {
            counter = new SmsSoSalesSerial();
            counter.setNoType(type.getCode());
            counter.setCurYear(year);
            counter.setCurSerial(1);
            smsSoSalesSerialMapper.insert(counter);
        } else {
            //流水号+1
            smsSoSalesSerialMapper.incrementSerial(counter.getId());
            counter.setCurSerial(counter.getCurSerial() + 1);
        }
        //拼接编号：前缀+年份+3位补零流水
        return type.getPrefix() + year + String.format("%0" + type.getSerialLength() + "d", counter.getCurSerial());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String convertTempToFormal(String tempNo) {
        //仅做格式校验，不再写入作废数据
        if(tempNo == null || !tempNo.startsWith(NoTypeEnum.PROJ_TEMP.getPrefix())){
            throw new IllegalArgumentException("临时编号格式错误：" + tempNo);
        }
        //直接拿【全新正式流水号】，彻底避免编号冲突，不复用临时号内部数字
        return nextProjectNo(false);
    }
}
