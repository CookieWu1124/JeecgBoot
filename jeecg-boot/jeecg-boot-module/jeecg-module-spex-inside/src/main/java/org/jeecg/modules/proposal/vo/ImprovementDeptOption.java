package org.jeecg.modules.proposal.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;

@Data
@Schema(description = "改善部门选项（含负责人）")
public class ImprovementDeptOption implements Serializable {

    private static final long serialVersionUID = 1L;

    private String deptId;
    private String deptName;
    private String leaderUserId;
    private String leaderName;
    /** 是否已配置负责人 */
    private Boolean leaderConfigured;
}
