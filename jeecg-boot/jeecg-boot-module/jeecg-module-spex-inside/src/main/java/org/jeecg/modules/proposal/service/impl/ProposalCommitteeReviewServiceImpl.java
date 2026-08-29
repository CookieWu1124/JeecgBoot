package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalCommitteeReview;
import org.jeecg.modules.proposal.mapper.ProposalCommitteeReviewMapper;
import org.jeecg.modules.proposal.service.IProposalCommitteeReviewService;
import org.springframework.stereotype.Service;

@Service
public class ProposalCommitteeReviewServiceImpl
        extends ServiceImpl<ProposalCommitteeReviewMapper, ProposalCommitteeReview>
        implements IProposalCommitteeReviewService {
}
