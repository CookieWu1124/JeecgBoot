package org.jeecg.modules.sale.so.service;

import org.jeecg.modules.sale.so.entity.SmsSoSalesSerial;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Description: 项目编号流水号表
 * @Author: jeecg-boot
 * @Date:   2026-08-17
 * @Version: V1.0
 */
public interface ISmsSoSalesSerialService extends IService<SmsSoSalesSerial> {
    /**
     * 获取下一个项目编号
     * @param isTemp true临时项目；false正式项目
     * @return 编号 FC2026001 / 2026001
     */
    String nextProjectNo(boolean isTemp);

    @Transactional(rollbackFor = Exception.class)
    String ywProjectNo();

    /**
     * 临时项目转正
     * @param tempNo 旧临时编号 FC2026001
     * @return 返回全新正式项目编号（调用正式流水生成，不会重复）
     */
    String convertTempToFormal(String tempNo);
}
