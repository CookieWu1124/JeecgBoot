package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalStatusLogUnread;
import org.jeecg.modules.proposal.mapper.ProposalStatusLogUnreadMapper;
import org.jeecg.modules.proposal.service.IProposalStatusLogUnreadService;
import org.springframework.stereotype.Service;

@Service
public class ProposalStatusLogUnreadServiceImpl
        extends ServiceImpl<ProposalStatusLogUnreadMapper, ProposalStatusLogUnread>
        implements IProposalStatusLogUnreadService {

    @Override
    public int physicalDelete(String userId, String statusLogId) {
        return baseMapper.physicalDelete(userId, statusLogId);
    }

    @Override
    public int physicalDeleteAllByUser(String userId) {
        return baseMapper.physicalDeleteAllByUser(userId);
    }
}
