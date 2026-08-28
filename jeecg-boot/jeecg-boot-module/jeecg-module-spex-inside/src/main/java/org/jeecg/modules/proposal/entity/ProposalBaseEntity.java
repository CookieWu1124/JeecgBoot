package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 提案模块表通用字段基类
 */
@Data
public class ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.ASSIGN_ID)
    @Schema(description = "主键")
    private String id;

    @Schema(description = "创建人工号")
    private String createNo;

    @Schema(description = "创建人名称")
    private String createBy;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "创建日期")
    private Date createTime;

    @Schema(description = "更新人工号")
    private String updateNo;

    @Schema(description = "更新人名称")
    private String updateBy;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "修改日期")
    private Date updateTime;

    @Schema(description = "所属部门编码")
    private String sysOrgCode;

    @Schema(description = "机构名称")
    private String sysOrgName;

    @Schema(description = "租户ID")
    private String tenantId;

    @Schema(description = "备注")
    private String remark;

    @TableLogic(value = "Y", delval = "N")
    @Schema(description = "是否有效 Y是 N否")
    private String active;
}
