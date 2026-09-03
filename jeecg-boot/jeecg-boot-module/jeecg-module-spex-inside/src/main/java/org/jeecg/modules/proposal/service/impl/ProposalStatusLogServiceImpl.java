package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalStatusLog;
import org.jeecg.modules.proposal.mapper.ProposalStatusLogMapper;
import org.jeecg.modules.proposal.service.IProposalStatusLogService;
import org.springframework.stereotype.Service;

@Service
public class ProposalStatusLogServiceImpl extends ServiceImpl<ProposalStatusLogMapper, ProposalStatusLog>
        implements IProposalStatusLogService {
}
