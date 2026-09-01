package org.jeecg.modules.proposal.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.jeecg.modules.proposal.entity.ProposalCommitteeMember;

public interface ProposalCommitteeMemberMapper extends BaseMapper<ProposalCommitteeMember> {

    //update-begin---author:spex ---date:2026-09-01  for：【提案配置】重加委员时查询/恢复含逻辑删除行-----------
    /** 含逻辑删除行；用于重加委员时命中唯一键占用 */
    @Select("SELECT * FROM proposal_committee_member WHERE user_id = #{userId} ORDER BY update_time DESC LIMIT 1")
    ProposalCommitteeMember selectAnyByUserId(@Param("userId") String userId);

    /** 绕过 TableLogic，把已移除行恢复为有效 */
    @Update("UPDATE proposal_committee_member SET user_id = #{userId}, score_enabled = #{scoreEnabled}, "
            + "seat_no = #{seatNo}, member_status = #{memberStatus}, sort_no = #{sortNo}, "
            + "update_no = #{updateNo}, update_by = #{updateBy}, remark = #{remark}, active = 'Y' "
            + "WHERE id = #{id}")
    int restoreById(ProposalCommitteeMember entity);
    //update-end---author:spex ---date:2026-09-01  for：【提案配置】重加委员时查询/恢复含逻辑删除行-----------
}
