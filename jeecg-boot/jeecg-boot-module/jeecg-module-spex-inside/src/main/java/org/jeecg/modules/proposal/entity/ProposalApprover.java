package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.jeecg.modules.proposal.vo.UserBriefVo;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("proposal_approver")
@Schema(description = "提案批准人配置")
public class ProposalApprover extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private String userId;
    private String approverStatus;

    //update-begin---author:spex ---date:2026-08-31  for：【提案管理端】列表嵌套回显批准人-----------
    @TableField(exist = false)
    @Schema(description = "批准人摘要")
    private UserBriefVo user;
    //update-end---author:spex ---date:2026-08-31  for：【提案管理端】列表嵌套回显批准人-----------
}
