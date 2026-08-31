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
@TableName("proposal_improvement_type")
@Schema(description = "改善性质配置")
public class ProposalImprovementType extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private String typeCode;
    private String typeName;
    private String description;
    private Integer sortNo;
    private String typeStatus;
}
