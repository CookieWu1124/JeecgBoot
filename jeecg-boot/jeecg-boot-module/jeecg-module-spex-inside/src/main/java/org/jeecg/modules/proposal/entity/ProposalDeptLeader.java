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
@TableName("proposal_dept_leader")
@Schema(description = "改善部门负责人配置")
public class ProposalDeptLeader extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private String deptId;
    private String leaderUserId;
}
