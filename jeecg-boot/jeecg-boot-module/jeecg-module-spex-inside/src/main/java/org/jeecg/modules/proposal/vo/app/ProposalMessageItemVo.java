package org.jeecg.modules.proposal.vo.app;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "消息动态条目")
public class ProposalMessageItemVo {

    @Schema(description = "status_log.id，标记已读用")
    private String id;
    private String proposalId;
    private String proposalNo;
    private String title;
    private String action;
    private String actionLabel;
    private String remark;
    private String time;
    @Schema(description = "是否未读")
    private Boolean unread;
}
