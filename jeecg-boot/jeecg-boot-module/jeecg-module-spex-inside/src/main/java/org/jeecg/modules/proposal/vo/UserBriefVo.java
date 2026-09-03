package org.jeecg.modules.proposal.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;

@Data
@Schema(description = "用户摘要（展示用，不落库）")
public class UserBriefVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;
    private String realname;
    private String workNo;
    private String username;
    private String positionType;
    private String orgCode;
    /** 所属部门名称，由 orgCode 批量换出 */
    private String deptName;
}
