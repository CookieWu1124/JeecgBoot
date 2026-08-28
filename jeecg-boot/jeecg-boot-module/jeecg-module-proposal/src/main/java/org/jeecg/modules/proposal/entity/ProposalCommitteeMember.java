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
@TableName("proposal_committee_member")
@Schema(description = "提案委员会成员配置")
public class ProposalCommitteeMember extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private String userId;
    private Integer scoreEnabled;
    private Integer seatNo;
    private String memberStatus;
    private Integer sortNo;
}
