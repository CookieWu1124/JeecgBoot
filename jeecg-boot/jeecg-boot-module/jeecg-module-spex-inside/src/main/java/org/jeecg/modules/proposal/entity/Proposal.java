package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.Version;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

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
    private String status;
    private String improvementTypes;
    private String deptId;
    private String deptLeaderId;
    private String proposerId;
    private String implementLeaderId;
    private String teamType;
    private Integer planRequired;
    private BigDecimal awardAmount;
    private Integer planRound;
    private String reviewProgress;
    private String scoreProgress;
    private BigDecimal scoreTotal;
    private String scoreGrade;
    private Date filedDate;
    private Date closedDate;

    @Version
    private Integer version;
}
