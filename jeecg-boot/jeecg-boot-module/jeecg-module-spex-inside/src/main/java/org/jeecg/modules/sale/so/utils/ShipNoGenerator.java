package org.jeecg.modules.sale.so.utils;


import org.jeecg.modules.sale.so.mapper.SmsSoSalesDinnerApplyMapper;
import org.springframework.stereotype.Component;
import jakarta.annotation.Resource;
import java.time.Year;

@Component
public class ShipNoGenerator {

    @Resource
    private SmsSoSalesDinnerApplyMapper smsSoSalesDinnerApplyMapper;



    /**
     * 生成宴请申请单号 SH26P00001
     */
    public String generateBatchApplyNo() {
        // 使用4位完整年份，和历史数据对齐
        int yearFull = Year.now().getValue();
        String prefix = "DQ" + yearFull;

        String maxNo = smsSoSalesDinnerApplyMapper.selectMaxShipNoByPrefix(prefix);
        int serial = 1;

        if (maxNo != null && maxNo.startsWith(prefix)) {
            try {
                // 截取前缀后面的流水部分
                String numStr = maxNo.substring(prefix.length());
                serial = Integer.parseInt(numStr) + 1;
            } catch (NumberFormatException | IndexOutOfBoundsException e) {
                // 格式异常，直接从1开始
                serial = 1;
            }
        }
        // 5位数字，不足补0
        String serialStr = String.format("%05d", serial);
        return prefix + serialStr;
    }
}