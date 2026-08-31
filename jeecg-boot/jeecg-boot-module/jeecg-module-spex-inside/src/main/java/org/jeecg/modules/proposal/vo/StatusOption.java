package org.jeecg.modules.proposal.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;

@Data
@Schema(description = "提案状态选项（来自 ProposalStatusEnum，非字典）")
public class StatusOption implements Serializable {

    private static final long serialVersionUID = 1L;

    private String code;
    private String label;
    /** 申请段接口默认：已批准 / 不批准为闭环；全量时为不批准 / 已撤回 / 已完成 */
    private Boolean terminal;
}
