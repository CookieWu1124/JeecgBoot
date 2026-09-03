package org.jeecg.modules.sale.so.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.jeecgframework.poi.excel.annotation.Excel;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @Description: 商务宴请
 * @Author: jeecg-boot
 * @Date:   2026-08-05
 * @Version: V1.0
 */
@Data
@TableName("sms_so_sales_dinner_apply")
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@Schema(description="sms_so_sales_dinner_apply对象")
public class SmsSoSalesDinnerApply implements Serializable {
    private static final long serialVersionUID = 1L;

	/**主键ID*/
	@TableId(type = IdType.ASSIGN_ID)
    @Schema(description = "主键ID")
    private java.lang.String id;
	/**申请单号*/
	@Excel(name = "申请单号", width = 15)
    @Schema(description = "申请单号")
    private java.lang.String applyNo;
	/**客户名称*/
	@Excel(name = "客户名称", width = 15)
    @Schema(description = "客户名称")
    private java.lang.String customerName;
	/**项目编码*/
	@Excel(name = "项目编码", width = 15)
    @Schema(description = "项目编码")
    private java.lang.String projectCode;
	/**拜访记录*/
	@Excel(name = "拜访记录", width = 15)
    @Schema(description = "拜访记录")
    private java.lang.String visitRecord;
	/**宴请日期*/
	@Excel(name = "宴请日期", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @Schema(description = "宴请日期")
    private java.util.Date dinnerDate;
	/**宴请时间*/
	@Excel(name = "宴请时间", width = 15)
    @Schema(description = "宴请时间")
    private java.lang.String dinnerTime;
	/**宴请地点*/
	@Excel(name = "宴请地点", width = 15)
    @Schema(description = "宴请地点")
    private java.lang.String dinnerAddress;
	/**宴请事由*/
	@Excel(name = "宴请事由", width = 15)
    @Schema(description = "宴请事由")
    private java.lang.String dinnerReason;
    /**宴请对象*/
    @Excel(name = "宴请对象", width = 15)
    @Schema(description = "宴请对象")
    private java.lang.String inviteName;
    /**客户部门*/
    @Excel(name = "客户部门", width = 15)
    @Schema(description = "客户部门")
    private java.lang.String custDept;
    /**客户职务*/
    @Excel(name = "客户职务", width = 15)
    @Schema(description = "客户职务")
    private java.lang.String custPost;
	/**参加人数*/
	@Excel(name = "参加人数", width = 15)
    @Schema(description = "参加人数")
    private java.lang.Integer attendNum;
	/**预算金额(元)*/
	@Excel(name = "预算金额(元)", width = 15)
    @Schema(description = "预算金额(元)")
    private java.math.BigDecimal budgetAmount;
	/**申请人*/
	@Excel(name = "申请人", width = 15)
    @Schema(description = "申请人")
    private java.lang.String applicant;
	/**申请人用户ID*/
    @Schema(description = "申请人用户ID")
    private java.lang.String applicantId;
	/**审核状态*/
	@Excel(name = "审核状态", width = 15)
    @Schema(description = "审核状态")
    private java.lang.String status;
	/**审核意见*/
	@Excel(name = "审核意见", width = 15)
    @Schema(description = "审核意见")
    private java.lang.String auditRemark;
	/**审核人ID*/
    @Schema(description = "审核人ID")
    private java.lang.String auditUserId;
	/**审核时间*/
	@Excel(name = "审核时间", width = 15, format = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @Schema(description = "审核时间")
    private java.util.Date auditTime;
	/**创建人工号*/
	@Excel(name = "创建人工号", width = 15)
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
	@Excel(name = "状态", width = 15)
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
	@Excel(name = "备注", width = 15)
    @Schema(description = "备注")
    private java.lang.String remark;
	/**客户id*/
    @Schema(description = "客户id")
    private java.lang.String customerId;
	/**项目id*/
    @Schema(description = "项目id")
    private java.lang.String projectId;
	/**拜访记录id*/
    @Schema(description = "拜访记录id")
    private java.lang.String visitId;

    @Schema(description = "附件")
    private String attachFile;

}
