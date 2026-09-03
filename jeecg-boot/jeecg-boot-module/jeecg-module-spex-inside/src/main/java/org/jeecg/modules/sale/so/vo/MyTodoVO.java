package org.jeecg.modules.sale.so.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class MyTodoVO {
    /**主键ID*/
    @TableId(type = IdType.ASSIGN_ID)
    @Schema(description = "主键ID")
    private java.lang.String id;
    /**所属客户ID，关联mom_sales_customer*/
    @Schema(description = "所属客户ID，关联mom_sales_customer")
    private java.lang.String customerId;
    @Schema(description = "所属客户名称")
    private java.lang.String customerName;
    /**项目编码*/
    @Excel(name = "项目编码", width = 15)
    @Schema(description = "项目编码")
    private java.lang.String projectNo;
    /**项目编码*/
    @Excel(name = "项目名称", width = 15)
    @Schema(description = "项目名称")
    private java.lang.String projectName;
    /**项目联系人/职务*/
    @Excel(name = "项目联系人/职务", width = 15)
    @Schema(description = "项目联系人/职务")
    private java.lang.String contactName;
    /**联系电话*/
    @Excel(name = "联系电话", width = 15)
    @Schema(description = "联系电话")
    private java.lang.String contactPhone;
    /**需求明细说明*/
    @Excel(name = "需求明细说明", width = 15)
    @Schema(description = "需求明细说明")
    private java.lang.String demandDetail;
    /**项目状态*/
    @Excel(name = "项目状态", width = 15)
    @Schema(description = "项目状态")
    private java.lang.String status;
    /**阶段转化率*/
    @Excel(name = "阶段转化率", width = 15)
    @Schema(description = "阶段转化率")
    private java.lang.String stageRate;
    /**当前销售阶段*/
    @Excel(name = "当前销售阶段", width = 15)
    @Schema(description = "当前销售阶段")
    private java.lang.String currentStage;
    /**预估成交金额*/
    @Excel(name = "预估成交金额", width = 15)
    @Schema(description = "预估成交金额")
    private java.math.BigDecimal estimateAmount;
    /**预估成交时间*/
    @Excel(name = "预估成交时间", width = 15, format = "yyyy-MM-dd")
    @JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @Schema(description = "预估成交时间")
    private java.util.Date estimateDealDate;
    /**赢单概率*/
    @Excel(name = "赢单概率", width = 15)
    @Schema(description = "赢单概率")
    private java.lang.String winProb;
    /**核心需求/痛点*/
    @Excel(name = "核心需求/痛点", width = 15)
    @Schema(description = "核心需求/痛点")
    private java.lang.String corePain;
    /**竞争对手*/
    @Excel(name = "竞争对手", width = 15)
    @Schema(description = "竞争对手")
    private java.lang.String competitor;
    /**我方优势/风险点*/
    @Excel(name = "我方优势/风险点", width = 15)
    @Schema(description = "我方优势/风险点")
    private java.lang.String advantageRisk;
    /**卡点分析*/
    @Excel(name = "卡点分析", width = 15)
    @Schema(description = "卡点分析")
    private java.lang.String blockAnalysis;
    /**需要的支持*/
    @Excel(name = "需要的支持", width = 15)
    @Schema(description = "需要的支持")
    private java.lang.String needSupport;
    /**最终结果*/
    @Excel(name = "最终结果", width = 15)
    @Schema(description = "最终结果")
    private java.lang.String finalResult;
    /**丢单原因*/
    @Excel(name = "丢单原因", width = 15)
    @Schema(description = "丢单原因")
    private java.lang.String loseReason;
    /**经验沉淀*/
    @Excel(name = "经验沉淀", width = 15)
    @Schema(description = "经验沉淀")
    private java.lang.String experienceSummary;
    /**项目金额（元）*/
    @Excel(name = "项目金额（元）", width = 15)
    @Schema(description = "项目金额（元）")
    private java.math.BigDecimal projectAmount;
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
    @Schema(description = "是否是临时客户（0否 1是）")
    private java.lang.String isTemp;
    //是否逾期 0否 1是
    @Schema(description = "是否逾期 0否 1是")
    private Integer isOverdue;
}