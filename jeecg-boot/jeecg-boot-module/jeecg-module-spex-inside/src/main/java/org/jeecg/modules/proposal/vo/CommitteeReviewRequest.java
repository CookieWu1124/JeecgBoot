package org.jeecg.modules.proposal.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Schema(description = "委员提交审核意见")
public class CommitteeReviewRequest {

    @Schema(description = "审核结论 ADOPT / REJECT", requiredMode = Schema.RequiredMode.REQUIRED)
    private String conclusion;

    @Schema(description = "是否形成计划书建议 0否 1是（采用时必填）")
    private Integer planRequired;

    @Schema(description = "建议奖励金额（采用时可选）")
    private BigDecimal awardSuggestion;

    @Schema(description = "综合评价（不采用时必填）")
    private String comment;
}
