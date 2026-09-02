package org.jeecg.modules.proposal.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.jeecg.modules.proposal.entity.ProposalStatusLogUnread;

public interface ProposalStatusLogUnreadMapper extends BaseMapper<ProposalStatusLogUnread> {

    /** 标记已读：物理删除，避免未读表随已读膨胀 */
    @Delete("DELETE FROM proposal_status_log_unread WHERE user_id = #{userId} AND status_log_id = #{statusLogId}")
    int physicalDelete(@Param("userId") String userId, @Param("statusLogId") String statusLogId);

    /** 全部已读：清空该用户未读 */
    @Delete("DELETE FROM proposal_status_log_unread WHERE user_id = #{userId}")
    int physicalDeleteAllByUser(@Param("userId") String userId);
}
