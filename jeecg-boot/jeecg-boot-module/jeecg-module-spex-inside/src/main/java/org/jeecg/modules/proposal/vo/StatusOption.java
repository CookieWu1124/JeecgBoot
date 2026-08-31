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
    /** 是否终态（不批准 / 已撤回 / 已完成） */
    private Boolean terminal;
}
