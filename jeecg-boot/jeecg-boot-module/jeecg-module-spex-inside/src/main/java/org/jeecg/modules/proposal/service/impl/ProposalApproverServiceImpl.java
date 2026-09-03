package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalApprover;
import org.jeecg.modules.proposal.mapper.ProposalApproverMapper;
import org.jeecg.modules.proposal.service.IProposalApproverService;
import org.springframework.stereotype.Service;

@Service
public class ProposalApproverServiceImpl extends ServiceImpl<ProposalApproverMapper, ProposalApprover>
        implements IProposalApproverService {
}
