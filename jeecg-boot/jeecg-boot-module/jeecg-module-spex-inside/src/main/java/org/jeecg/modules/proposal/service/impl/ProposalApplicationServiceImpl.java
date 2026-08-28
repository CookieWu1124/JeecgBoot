package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalApplication;
import org.jeecg.modules.proposal.mapper.ProposalApplicationMapper;
import org.jeecg.modules.proposal.service.IProposalApplicationService;
import org.springframework.stereotype.Service;

@Service
public class ProposalApplicationServiceImpl extends ServiceImpl<ProposalApplicationMapper, ProposalApplication>
        implements IProposalApplicationService {
}
