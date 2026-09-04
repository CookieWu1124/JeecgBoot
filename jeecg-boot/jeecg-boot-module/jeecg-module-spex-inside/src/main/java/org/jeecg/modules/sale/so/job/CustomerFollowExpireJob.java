package org.jeecg.modules.sale.so.job;

import lombok.extern.slf4j.Slf4j;
import org.jeecg.modules.sale.so.mapper.SmsSoSalesCustomerMapper;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Description: 客户拜访超30天未跟进，清空销售负责人saleUserId定时任务
 * @Author: jeecg
 */
@Slf4j
@PersistJobDataAfterExecution
@DisallowConcurrentExecution //禁止并发执行，防止任务重叠
public class CustomerFollowExpireJob implements Job {

    @Autowired
    private SmsSoSalesCustomerMapper smsSoSalesCustomerMapper;

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        log.info("【客户跟进过期定时任务】开始执行，清除超过30天未跟进客户saleUserId");
        try {
            int updateRows = smsSoSalesCustomerMapper.clearExpireCustomerSaleUserId();
            log.info("【客户跟进过期定时任务】执行完成，更新客户数量：{}", updateRows);
        } catch (Exception e) {
            log.error("【客户跟进过期定时任务】执行异常", e);
            throw new JobExecutionException(e);
        }
    }
}
