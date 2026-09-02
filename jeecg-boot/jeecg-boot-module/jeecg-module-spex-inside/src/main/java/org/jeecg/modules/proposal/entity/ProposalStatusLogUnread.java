package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * 提案状态日志未读：用户 × status_log；已读后物理删除
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("proposal_status_log_unread")
@Schema(description = "提案状态日志未读")
public class ProposalStatusLogUnread extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Schema(description = "收件人 sys_user.id")
    private String userId;

    @Schema(description = "proposal_status_log.id")
    private String statusLogId;
}
