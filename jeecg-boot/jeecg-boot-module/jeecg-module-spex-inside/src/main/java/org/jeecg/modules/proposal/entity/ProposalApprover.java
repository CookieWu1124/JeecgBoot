package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

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
}
