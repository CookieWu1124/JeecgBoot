package org.jeecg.modules.sale.so.mapper;

import org.jeecg.modules.sale.so.entity.SmsSoSalesDinnerApply;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * @Description: 商务宴请
 * @Author: jeecg-boot
 * @Date:   2026-08-05
 * @Version: V1.0
 */
public interface SmsSoSalesDinnerApplyMapper extends BaseMapper<SmsSoSalesDinnerApply> {

    String selectMaxShipNoByPrefix(String prefix);
}
