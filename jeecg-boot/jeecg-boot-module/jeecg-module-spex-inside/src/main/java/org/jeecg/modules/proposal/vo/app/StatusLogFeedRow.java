package org.jeecg.modules.proposal.vo.app;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

/**
 * 与我相关的 status_log 查询行（含已读标记）
 */
@Data
@Schema(description = "消息动态原始行")
public class StatusLogFeedRow {

    private String id;
    private String proposalId;
    private String action;
    private String remark;
    private Date createTime;
    /** 1=未读，0=已读 */
    private Integer unread;
}
