package org.jeecg.modules.proposal.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Schema(description = "批准人申请批准决策")
public class ApplicationApprovalRequest {

    @Schema(description = "决策 APPROVE / REJECT", requiredMode = Schema.RequiredMode.REQUIRED)
    private String decision;

    @Schema(description = "核定是否形成计划书 0/1（批准时必填）")
    private Integer planRequired;

    @Schema(description = "核定提案奖金额（批准时建议填写）")
    private BigDecimal awardAmount;

    @Schema(description = "不批准原因（不批准时必填）")
    private String comment;
}
