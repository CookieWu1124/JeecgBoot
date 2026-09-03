package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.jeecg.modules.proposal.vo.DeptBriefVo;
import org.jeecg.modules.proposal.vo.UserBriefVo;

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

    //update-begin---author:spex ---date:2026-08-31  for：【提案管理端】列表嵌套回显部门/负责人-----------
    @TableField(exist = false)
    @Schema(description = "改善部门摘要")
    private DeptBriefVo dept;

    @TableField(exist = false)
    @Schema(description = "负责人摘要")
    private UserBriefVo leader;
    //update-end---author:spex ---date:2026-08-31  for：【提案管理端】列表嵌套回显部门/负责人-----------
}
