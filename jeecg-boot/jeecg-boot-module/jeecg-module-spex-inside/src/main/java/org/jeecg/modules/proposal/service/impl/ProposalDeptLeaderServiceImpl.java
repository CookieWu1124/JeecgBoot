package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalDeptLeader;
import org.jeecg.modules.proposal.mapper.ProposalDeptLeaderMapper;
import org.jeecg.modules.proposal.service.IProposalDeptLeaderService;
import org.springframework.stereotype.Service;

@Service
public class ProposalDeptLeaderServiceImpl extends ServiceImpl<ProposalDeptLeaderMapper, ProposalDeptLeader>
        implements IProposalDeptLeaderService {
}
