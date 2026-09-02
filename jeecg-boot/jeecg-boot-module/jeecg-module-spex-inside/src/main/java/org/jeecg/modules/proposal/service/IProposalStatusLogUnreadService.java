package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.modules.proposal.entity.ProposalStatusLogUnread;

public interface IProposalStatusLogUnreadService extends IService<ProposalStatusLogUnread> {

    int physicalDelete(String userId, String statusLogId);

    int physicalDeleteAllByUser(String userId);
}
