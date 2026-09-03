package org.jeecg.modules.sale.so.service;

import org.jeecg.modules.sale.so.entity.SmsSoSalesProject;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * @Description: 客户销售项目跟进明细
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */
public interface ISmsSoSalesProjectService extends IService<SmsSoSalesProject> {

    void saveMain(SmsSoSalesProject smsSoSalesProject);

    void updateMain(SmsSoSalesProject smsSoSalesProject);

    List<SmsSoSalesProject> exportList(SmsSoSalesProject smsSoSalesProject, Map<String, String[]> parameterMap);

    List<SmsSoSalesProject> selectByCustomerIdList(List<String> headerIds);
}
