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
@TableName("proposal_approval")
@Schema(description = "批准人决策记录")
public class ProposalApproval extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private String proposalId;
    private String approverId;
    /** APPLICATION / PLAN / SIGNOFF */
    private String stage;
    /** APPROVE / REJECT */
    private String decision;
    private Integer planRequired;
    private BigDecimal awardAmount;
    private String comment;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date approveTime;
}
