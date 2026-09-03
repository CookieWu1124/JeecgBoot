package org.jeecg.modules.sale.so.mapper;

import org.apache.ibatis.annotations.Param;
import org.jeecg.modules.sale.so.entity.SmsSoSalesSerial;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * @Description: 项目编号流水号表
 * @Author: jeecg-boot
 * @Date:   2026-08-17
 * @Version: V1.0
 */
public interface SmsSoSalesSerialMapper extends BaseMapper<SmsSoSalesSerial> {

    @Select("SELECT * FROM sms_so_sales_serial WHERE no_type = #{noType} AND cur_year = #{curYear} FOR UPDATE")
    SmsSoSalesSerial selectForUpdate(@Param("noType") String noType, @Param("curYear") Integer curYear);

    @Update("UPDATE sms_so_sales_serial SET cur_serial = cur_serial + 1 WHERE id = #{id}")
    int incrementSerial(@Param("id") String id);
}
