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
@TableName("proposal_score_dimension")
@Schema(description = "提案评分维度配置")
public class ProposalScoreDimension extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private String dimCode;
    private String dimName;
    private String description;
    private Integer weightPct;
    private Integer sortNo;
    private String dimStatus;
}
