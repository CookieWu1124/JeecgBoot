package org.jeecg.modules.proposal.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.jeecg.modules.proposal.entity.ProposalStatusLog;
import org.jeecg.modules.proposal.vo.app.StatusLogFeedRow;

import java.util.List;

public interface ProposalStatusLogMapper extends BaseMapper<ProposalStatusLog> {

    /**
     * 首页「最新动态」：与当前人相关的流转，按时间倒序只取 {@code limit} 条。
     * 相关 = 我是提案人 / 部门负责人 / 该单委员快照内 /（批准人）待核定或我做过决策。
     */
    @Select("""
            <script>
            SELECT l.id, l.proposal_id, l.action, l.remark, l.create_time
            FROM proposal_status_log l
            INNER JOIN proposal p ON p.id = l.proposal_id AND p.active = 'Y'
            WHERE l.active = 'Y'
              AND (
                    p.proposer_id = #{userId}
                 OR p.dept_leader_id = #{userId}
                 OR EXISTS (
                        SELECT 1 FROM proposal_committee_review r
                        WHERE r.reviewer_id = #{userId}
                          AND r.proposal_id = p.id
                          AND r.active = 'Y'
                    )
                 <if test='approver'>
                 OR p.status = 'PENDING_APPROVAL'
                 OR EXISTS (
                        SELECT 1 FROM proposal_approval a
                        WHERE a.approver_id = #{userId}
                          AND a.proposal_id = p.id
                          AND a.active = 'Y'
                    )
                 </if>
              )
            ORDER BY l.create_time DESC
            LIMIT #{limit}
            </script>
            """)
    List<ProposalStatusLog> selectHomeFeeds(@Param("userId") String userId,
                                            @Param("approver") boolean approver,
                                            @Param("limit") int limit);

    /**
     * 消息列表：与我相关的 status_log；未读以 unread 表有行为准。
     */
    @Select("""
            <script>
            SELECT l.id,
                   l.proposal_id AS proposalId,
                   l.action,
                   l.remark,
                   l.create_time AS createTime,
                   CASE WHEN ur.id IS NULL THEN 0 ELSE 1 END AS unread
            FROM proposal_status_log l
            INNER JOIN proposal p ON p.id = l.proposal_id AND p.active = 'Y'
            LEFT JOIN proposal_status_log_unread ur
                   ON ur.status_log_id = l.id
                  AND ur.user_id = #{userId}
                  AND ur.active = 'Y'
            WHERE l.active = 'Y'
              AND (
                    p.proposer_id = #{userId}
                 OR p.dept_leader_id = #{userId}
                 OR EXISTS (
                        SELECT 1 FROM proposal_committee_review r
                        WHERE r.reviewer_id = #{userId}
                          AND r.proposal_id = p.id
                          AND r.active = 'Y'
                    )
                 <if test='approver'>
                 OR p.status = 'PENDING_APPROVAL'
                 OR EXISTS (
                        SELECT 1 FROM proposal_approval a
                        WHERE a.approver_id = #{userId}
                          AND a.proposal_id = p.id
                          AND a.active = 'Y'
                    )
                 </if>
              )
              <if test='unreadOnly'>
              AND ur.id IS NOT NULL
              </if>
            ORDER BY l.create_time DESC
            LIMIT #{offset}, #{limit}
            </script>
            """)
    List<StatusLogFeedRow> selectUserFeeds(@Param("userId") String userId,
                                           @Param("approver") boolean approver,
                                           @Param("unreadOnly") boolean unreadOnly,
                                           @Param("offset") int offset,
                                           @Param("limit") int limit);

    @Select("""
            <script>
            SELECT COUNT(1)
            FROM proposal_status_log l
            INNER JOIN proposal p ON p.id = l.proposal_id AND p.active = 'Y'
            LEFT JOIN proposal_status_log_unread ur
                   ON ur.status_log_id = l.id
                  AND ur.user_id = #{userId}
                  AND ur.active = 'Y'
            WHERE l.active = 'Y'
              AND (
                    p.proposer_id = #{userId}
                 OR p.dept_leader_id = #{userId}
                 OR EXISTS (
                        SELECT 1 FROM proposal_committee_review r
                        WHERE r.reviewer_id = #{userId}
                          AND r.proposal_id = p.id
                          AND r.active = 'Y'
                    )
                 <if test='approver'>
                 OR p.status = 'PENDING_APPROVAL'
                 OR EXISTS (
                        SELECT 1 FROM proposal_approval a
                        WHERE a.approver_id = #{userId}
                          AND a.proposal_id = p.id
                          AND a.active = 'Y'
                    )
                 </if>
              )
              <if test='unreadOnly'>
              AND ur.id IS NOT NULL
              </if>
            </script>
            """)
    long countUserFeeds(@Param("userId") String userId,
                        @Param("approver") boolean approver,
                        @Param("unreadOnly") boolean unreadOnly);

    /** 未读数：以 unread 表为准，并校验日志/提案仍有效 */
    @Select("""
            SELECT COUNT(1)
            FROM proposal_status_log_unread ur
            INNER JOIN proposal_status_log l ON l.id = ur.status_log_id AND l.active = 'Y'
            INNER JOIN proposal p ON p.id = l.proposal_id AND p.active = 'Y'
            WHERE ur.user_id = #{userId}
              AND ur.active = 'Y'
            """)
    long countUnreadByUser(@Param("userId") String userId);
}
