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
 * @Description: 项目拜访跟进记录
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */
@Data
@TableName("sms_so_sales_visit")
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@Schema(description="sms_so_sales_visit对象")
public class SmsSoSalesVisit implements Serializable {
    private static final long serialVersionUID = 1L;

	/**主键ID*/
	@TableId(type = IdType.ASSIGN_ID)
    @Schema(description = "主键ID")
    private java.lang.String id;
	/**关联项目ID*/
    @Schema(description = "关联项目ID")
    private java.lang.String projectId;
	/**跟进日期*/
	@Excel(name = "跟进日期", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @Schema(description = "跟进日期")
    private java.util.Date visitDate;
	/**跟进方式*/
	@Excel(name = "跟进方式", width = 15)
    @Schema(description = "跟进方式")
    private java.lang.String visitType;
	/**沟通对象*/
	@Excel(name = "沟通对象", width = 15)
    @Schema(description = "沟通对象")
    private java.lang.String talkObject;
	/**沟通要点*/
	@Excel(name = "沟通要点", width = 15)
    @Schema(description = "沟通要点")
    private java.lang.String talkPoint;
	/**客户反馈/异议*/
	@Excel(name = "客户反馈/异议", width = 15)
    @Schema(description = "客户反馈/异议")
    private java.lang.String customerFeedback;
	/**我方应对策略*/
	@Excel(name = "我方应对策略", width = 15)
    @Schema(description = "我方应对策略")
    private java.lang.String ourStrategy;
	/**下一步行动*/
	@Excel(name = "下一步行动", width = 15)
    @Schema(description = "下一步行动")
    private java.lang.String nextAction;
	/**下次跟进时间*/
	@Excel(name = "下次跟进时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @Schema(description = "下次跟进时间")
    private java.util.Date nextVisitTime;
	/**最新跟进摘要*/
	@Excel(name = "最新跟进摘要", width = 15)
    @Schema(description = "最新跟进摘要")
    private java.lang.String latestSummary;
	/**创建人工号*/
    @Schema(description = "创建人工号")
    private java.lang.String createNo;
	/**创建人*/
    @Schema(description = "创建人")
    private java.lang.String createBy;
	/**创建日期*/
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @Schema(description = "创建日期")
    private java.util.Date createTime;
	/**更新人工号*/
    @Schema(description = "更新人工号")
    private java.lang.String updateNo;
	/**更新人*/
    @Schema(description = "更新人")
    private java.lang.String updateBy;
	/**更新日期*/
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @Schema(description = "更新日期")
    private java.util.Date updateTime;
	/**状态*/
    @Schema(description = "状态")
    private java.lang.String active;
	/**租户ID*/
    @Schema(description = "租户ID")
    private java.lang.String tenantId;
	/**所属部门*/
    @Schema(description = "所属部门")
    private java.lang.String sysOrgCode;
	/**机构名称*/
    @Schema(description = "机构名称")
    private java.lang.String sysOrgName;
	/**备注*/
    @Schema(description = "备注")
    private java.lang.String remark;
}
