package org.jeecg.modules.proposal.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;

@Data
@Schema(description = "部门摘要（展示用，不落库）")
public class DeptBriefVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;
    private String departName;
    private String orgCode;
}
