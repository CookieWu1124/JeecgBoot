package org.jeecg.modules.sale.so.mapper;

import org.jeecg.modules.sale.so.entity.SmsSoSalesCustomer;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * @Description: 销售客户档案表
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */
public interface SmsSoSalesCustomerMapper extends BaseMapper<SmsSoSalesCustomer> {

    int clearExpireCustomerSaleUserId();
}
