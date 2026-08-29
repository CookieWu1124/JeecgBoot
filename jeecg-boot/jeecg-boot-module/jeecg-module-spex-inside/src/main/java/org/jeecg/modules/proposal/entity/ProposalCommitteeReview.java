package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("proposal_committee_review")
@Schema(description = "委员审核记录（申请阶段快照）")
public class ProposalCommitteeReview extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private String proposalId;
    private String reviewerId;
    /** ADOPT / REJECT；未审为空 */
    private String conclusion;
    /** 是否形成计划书建议 0/1 */
    private Integer planRequired;
    private BigDecimal awardSuggestion;
    private String comment;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date reviewTime;
}
