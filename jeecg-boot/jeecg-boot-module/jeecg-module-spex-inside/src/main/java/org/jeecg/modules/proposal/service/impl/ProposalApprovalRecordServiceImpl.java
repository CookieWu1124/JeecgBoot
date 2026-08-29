package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalApproval;
import org.jeecg.modules.proposal.mapper.ProposalApprovalMapper;
import org.jeecg.modules.proposal.service.IProposalApprovalRecordService;
import org.springframework.stereotype.Service;

@Service
public class ProposalApprovalRecordServiceImpl
        extends ServiceImpl<ProposalApprovalMapper, ProposalApproval>
        implements IProposalApprovalRecordService {
}
