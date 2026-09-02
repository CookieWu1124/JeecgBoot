package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.proposal.entity.ProposalStatusLog;
import org.jeecg.modules.proposal.vo.app.ProposalMessageItemVo;

import java.util.List;

public interface IProposalStatusLogService extends com.baomidou.mybatisplus.extension.service.IService<ProposalStatusLog> {

    List<ProposalStatusLog> listHomeFeeds(String userId, boolean approver, int limit);

    IPage<ProposalMessageItemVo> pageUserMessages(String scope, int pageNo, int pageSize, LoginUser loginUser,
                                                  boolean approver);

    long countUnread(String userId, boolean approver);

    void markRead(String statusLogId, LoginUser loginUser, boolean approver);
}
