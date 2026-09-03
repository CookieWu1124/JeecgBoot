package org.jeecg.modules.sale.so.service;

import org.jeecg.modules.sale.so.entity.SmsSoSalesCustomer;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * @Description: 销售客户档案表
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */
public interface ISmsSoSalesCustomerService extends IService<SmsSoSalesCustomer> {

    void saveMain(SmsSoSalesCustomer smsSoSalesCustomer);

    void updateMain(SmsSoSalesCustomer smsSoSalesCustomer);

    List<SmsSoSalesCustomer> exportList(SmsSoSalesCustomer smsSoSalesCustomer, Map<String, String[]> parameterMap);
}
