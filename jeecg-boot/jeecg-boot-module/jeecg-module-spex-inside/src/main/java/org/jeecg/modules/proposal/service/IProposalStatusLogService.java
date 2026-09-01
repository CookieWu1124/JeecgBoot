package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.modules.proposal.entity.ProposalStatusLog;

import java.util.List;

public interface IProposalStatusLogService extends IService<ProposalStatusLog> {

    /** 首页动态：与当前人相关的流转，最多 {@code limit} 条。 */
    List<ProposalStatusLog> listHomeFeeds(String userId, boolean approver, int limit);
}
