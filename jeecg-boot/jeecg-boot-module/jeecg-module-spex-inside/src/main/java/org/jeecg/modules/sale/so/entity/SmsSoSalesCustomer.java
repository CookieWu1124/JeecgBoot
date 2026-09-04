package org.jeecg.modules.sale.so.entity;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
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
 * @Description: 销售客户档案表
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */
@Data
@TableName("sms_so_sales_customer")
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@Schema(description="sms_so_sales_customer对象")
public class SmsSoSalesCustomer implements Serializable {
    private static final long serialVersionUID = 1L;

	/**自增主键ID*/
	@TableId(type = IdType.ASSIGN_ID)
    @Schema(description = "自增主键ID")
    private java.lang.String id;
	/**客户编号*/
	@Excel(name = "客户编号", width = 15)
    @Schema(description = "客户编号")
    private java.lang.String customerNo;
	/**客户名称*/
	@Excel(name = "客户名称", width = 15)
    @Schema(description = "客户名称")
    private java.lang.String customerName;
	/**所在地区*/
	@Excel(name = "所在地区", width = 15)
    @Schema(description = "所在地区")
    private java.lang.String area;
	/**行业*/
	@Excel(name = "行业", width = 15)
    @Schema(description = "行业")
    private java.lang.String industry;
	/**企业规模*/
	@Excel(name = "企业规模", width = 15)
    @Schema(description = "企业规模")
    private java.lang.String scale;
	/**客户等级*/
	@Excel(name = "客户等级", width = 15)
    @Schema(description = "客户等级")
    private java.lang.String level;
	/**客户来源*/
	@Excel(name = "客户来源", width = 15)
    @Schema(description = "客户来源")
    private java.lang.String source;
	/**负责销售*/
	@Excel(name = "负责销售", width = 15)
    @Schema(description = "负责销售")
    private java.lang.String saleUser;
	/**建档日期*/
	@Excel(name = "建档日期", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @Schema(description = "建档日期")
    private java.util.Date archiveDate;
	/**关键决策人*/
	@Excel(name = "关键决策人", width = 15)
    @Schema(description = "关键决策人")
    private java.lang.String authorityUser;
    /**决策人职位*/
    @Excel(name = "决策人职位", width = 15)
    @Schema(description = "决策人职位")
    private String decisionPost;

    /**决策人联系电话*/
    @Excel(name = "决策人联系电话", width = 15)
    @Schema(description = "决策人联系电话")
    private String decisionPhone;

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


    /**项目总金额（元）*/
    @TableField(exist = false)
    @Excel(name = "项目总金额（元）", width = 15)
    @Schema(description = "项目总金额（元）")
    private java.math.BigDecimal totalProjectAmount;

    /**备注*/
    @Excel(name = "备注", width = 15)
    @Schema(description = "备注")
    private java.lang.String remark;

    @Schema(description = "所属销售id")
    private java.lang.String saleUserId;
}
