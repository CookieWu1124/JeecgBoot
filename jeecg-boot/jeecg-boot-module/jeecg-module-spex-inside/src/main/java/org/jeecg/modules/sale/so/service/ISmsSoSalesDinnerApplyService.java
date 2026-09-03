package org.jeecg.modules.sale.so.service;

import org.jeecg.modules.sale.so.dto.AuditDto;
import org.jeecg.modules.sale.so.entity.SmsSoSalesDinnerApply;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * @Description: 商务宴请
 * @Author: jeecg-boot
 * @Date:   2026-08-05
 * @Version: V1.0
 */

public interface ISmsSoSalesDinnerApplyService extends IService<SmsSoSalesDinnerApply> {

    void removeMain(String id);

    List<SmsSoSalesDinnerApply> exportList(SmsSoSalesDinnerApply smsSoSalesDinnerApply, Map<String, String[]> parameterMap);

    void audit(AuditDto dto);

    void removeMainByIds(List<String> asList);
}
