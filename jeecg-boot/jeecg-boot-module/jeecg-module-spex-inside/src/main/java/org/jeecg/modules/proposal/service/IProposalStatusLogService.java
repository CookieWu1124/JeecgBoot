package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.entity.ProposalStatusLog;
import org.jeecg.modules.proposal.vo.app.ProposalMessageItemVo;

import java.util.List;

public interface IProposalStatusLogService extends com.baomidou.mybatisplus.extension.service.IService<ProposalStatusLog> {

    List<ProposalStatusLog> listHomeFeeds(String userId, boolean approver, int limit);

    IPage<ProposalMessageItemVo> pageUserMessages(String scope, int pageNo, int pageSize, LoginUser loginUser,
                                                  boolean approver);

    long countUnread(String userId);

    void markRead(String statusLogId, LoginUser loginUser);

    /** 全部已读：清空当前用户 unread */
    int markAllRead(LoginUser loginUser);

    /**
     * 写完 status_log 后 fan-out 未读：提案人/部门负责人/委员快照/(待核定)在任批准人，排除操作人自己。
     */
    void dispatchUnread(Proposal proposal, ProposalStatusLog log, LoginUser operator);
}
