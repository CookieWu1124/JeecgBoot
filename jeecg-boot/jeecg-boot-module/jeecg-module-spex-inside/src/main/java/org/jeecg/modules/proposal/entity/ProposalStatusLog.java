package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("proposal_status_log")
@Schema(description = "提案状态变更日志")
public class ProposalStatusLog extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Schema(description = "提案ID")
    private String proposalId;
    /** 跳转前状态，对应 {@link org.jeecg.modules.proposal.enums.ProposalStatusEnum#getCode()}。 */
    @Schema(description = "变更前状态")
    private String fromStatus;
    /** 跳转后状态。 */
    @Schema(description = "变更后状态")
    private String toStatus;
    /** 动作码，对应 {@link org.jeecg.modules.proposal.enums.ProposalAction#getCode()}。 */
    @Schema(description = "动作")
    private String action;
    @Schema(description = "操作人用户ID")
    private String operatorId;
}
