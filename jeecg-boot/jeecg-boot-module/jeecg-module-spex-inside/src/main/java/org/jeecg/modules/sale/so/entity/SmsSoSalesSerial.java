package org.jeecg.modules.sale.so.entity;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecg.common.aspect.annotation.Dict;
import io.swagger.v3.oas.annotations.media.Schema; 
import io.swagger.v3.oas.annotations.media.Schema; 
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @Description: 项目编号流水号表
 * @Author: jeecg-boot
 * @Date:   2026-08-17
 * @Version: V1.0
 */
@Data
@TableName("sms_so_sales_serial")
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@Schema(description="sms_so_sales_serial对象")
public class SmsSoSalesSerial implements Serializable {
    private static final long serialVersionUID = 1L;

	/**主键*/
	@TableId(type = IdType.ASSIGN_ID)
    @Schema(description = "主键")
    private java.lang.String id;
	/**编号类型：PROJ_FORMAL-正式项目 PROJ_TEMP-临时项目*/
	@Excel(name = "编号类型：PROJ_FORMAL-正式项目 PROJ_TEMP-临时项目", width = 15)
    @Schema(description = "编号类型：PROJ_FORMAL-正式项目 PROJ_TEMP-临时项目")
    private java.lang.String noType;
	/**业务年份，如2026*/
	@Excel(name = "业务年份，如2026", width = 15)
    @Schema(description = "业务年份，如2026")
    private java.lang.Integer curYear;
	/**当前最大流水号*/
	@Excel(name = "当前最大流水号", width = 15)
    @Schema(description = "当前最大流水号")
    private java.lang.Integer curSerial;
	/**createBy*/
    @Schema(description = "createBy")
    private java.lang.String createBy;
	/**createTime*/
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @Schema(description = "createTime")
    private java.util.Date createTime;
	/**updateBy*/
    @Schema(description = "updateBy")
    private java.lang.String updateBy;
	/**updateTime*/
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @Schema(description = "updateTime")
    private java.util.Date updateTime;
}
