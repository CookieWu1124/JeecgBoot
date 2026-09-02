package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalStatusLogRead;
import org.jeecg.modules.proposal.mapper.ProposalStatusLogReadMapper;
import org.jeecg.modules.proposal.service.IProposalStatusLogReadService;
import org.springframework.stereotype.Service;

@Service
public class ProposalStatusLogReadServiceImpl
        extends ServiceImpl<ProposalStatusLogReadMapper, ProposalStatusLogRead>
        implements IProposalStatusLogReadService {
}
