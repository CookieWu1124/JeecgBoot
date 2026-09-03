package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalCommitteeMember;
import org.jeecg.modules.proposal.mapper.ProposalCommitteeMemberMapper;
import org.jeecg.modules.proposal.service.IProposalCommitteeMemberService;
import org.springframework.stereotype.Service;

@Service
public class ProposalCommitteeMemberServiceImpl extends ServiceImpl<ProposalCommitteeMemberMapper, ProposalCommitteeMember>
        implements IProposalCommitteeMemberService {
}
