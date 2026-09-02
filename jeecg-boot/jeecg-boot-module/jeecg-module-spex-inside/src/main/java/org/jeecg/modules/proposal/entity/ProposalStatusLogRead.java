package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 提案状态日志已读：用户 × status_log
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("proposal_status_log_read")
@Schema(description = "提案状态日志已读")
public class ProposalStatusLogRead extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Schema(description = "读者 sys_user.id")
    private String userId;

    @Schema(description = "proposal_status_log.id")
    private String statusLogId;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "已读时间")
    private Date readTime;
}
