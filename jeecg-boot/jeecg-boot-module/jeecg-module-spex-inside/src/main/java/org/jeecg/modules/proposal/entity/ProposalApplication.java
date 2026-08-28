package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("proposal_application")
@Schema(description = "proposal application")
public class ProposalApplication extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private String proposalId;
    private String currentSituation;
    private String improvementSuggestion;
    private String email;
    private Date submitTime;
}
