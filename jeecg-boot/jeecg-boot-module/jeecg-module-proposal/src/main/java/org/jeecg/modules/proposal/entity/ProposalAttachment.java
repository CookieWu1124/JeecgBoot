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
@TableName("proposal_attachment")
@Schema(description = "提案附件")
public class ProposalAttachment extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private String proposalId;
    private String bizType;
    private String fileName;
    private String fileUrl;
    private Long fileSize;
    private Integer sortNo;
}
