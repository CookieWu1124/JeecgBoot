package org.jeecg.modules.proposal.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;

@Data
@Schema(description = "改善性质选项（来自 proposal_improvement_type，非字典）")
public class ImprovementTypeOption implements Serializable {

    private static final long serialVersionUID = 1L;

    private String code;
    private String label;
    /** 启用状态 active/disabled */
    private String typeStatus;
    private Integer sortNo;
    private String description;
}
