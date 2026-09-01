package org.jeecg.modules.proposal.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.jeecg.modules.proposal.entity.ProposalDeptLeader;

public interface ProposalDeptLeaderMapper extends BaseMapper<ProposalDeptLeader> {

    //update-begin---author:spex ---date:2026-09-01  for：【提案配置】重配已移除部门负责人时查询/恢复含逻辑删除行-----------
    /** 含逻辑删除行；用于按部门命中唯一键占用 */
    @Select("SELECT * FROM proposal_dept_leader WHERE dept_id = #{deptId} ORDER BY update_time DESC LIMIT 1")
    ProposalDeptLeader selectAnyByDeptId(@Param("deptId") String deptId);

    /** 绕过 TableLogic，把已移除行恢复为有效（亦可更新仍有效的同一部门行） */
    @Update("UPDATE proposal_dept_leader SET dept_id = #{deptId}, leader_user_id = #{leaderUserId}, "
            + "update_no = #{updateNo}, update_by = #{updateBy}, remark = #{remark}, active = 'Y' "
            + "WHERE id = #{id}")
    int restoreById(ProposalDeptLeader entity);
    //update-end---author:spex ---date:2026-09-01  for：【提案配置】重配已移除部门负责人时查询/恢复含逻辑删除行-----------
}
