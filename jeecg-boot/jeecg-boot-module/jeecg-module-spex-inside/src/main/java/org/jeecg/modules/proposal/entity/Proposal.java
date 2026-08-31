package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.Version;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.jeecg.modules.proposal.vo.DeptBriefVo;
import org.jeecg.modules.proposal.vo.UserBriefVo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("proposal")
@Schema(description = "提案主表")
public class Proposal extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private String proposalNo;
    private String title;
    /** 当前环节，取值见 {@link org.jeecg.modules.proposal.enums.ProposalStatusEnum}。改状态须走 ProposalStateMachine。 */
    private String status;
    /** 状态中文，来自枚举，不落库。 */
    @TableField(exist = false)
    private String statusLabel;
    private String improvementTypes;
    /** 改善性质中文，配置表回显，不落库。 */
    @TableField(exist = false)
    private String improvementTypesLabel;
    private String deptId;
    private String deptLeaderId;
    private String proposerId;
    //update-begin---author:spex ---date:2026-08-31  for：【提案管理端】列表/详情嵌套回显人员部门-----------
    @TableField(exist = false)
    @Schema(description = "改善部门摘要")
    private DeptBriefVo dept;
    @TableField(exist = false)
    @Schema(description = "提案人摘要")
    private UserBriefVo proposer;
    @TableField(exist = false)
    @Schema(description = "部门负责人摘要")
    private UserBriefVo deptLeader;
    //update-end---author:spex ---date:2026-08-31  for：【提案管理端】列表/详情嵌套回显人员部门-----------
    private String implementLeaderId;
    private String teamType;
    /** 批准人核定：1 走计划书，0 任务分配后直接交报告书。委员审核里的同名字段只是建议。 */
    private Integer planRequired;
    private BigDecimal awardAmount;
    /** 计划书轮次，驳回重提时递增。 */
    private Integer planRound;
    /** 申请/计划书委员进度，如 3/7。 */
    private String reviewProgress;
    private String scoreProgress;
    private BigDecimal scoreTotal;
    private String scoreGrade;
    private Date filedDate;
    private Date closedDate;

    /** 乐观锁。状态机 updateById 影响 0 行时提示刷新后重试。 */
    @Version
    private Integer version;
}
