package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalAttachment;
import org.jeecg.modules.proposal.mapper.ProposalAttachmentMapper;
import org.jeecg.modules.proposal.service.IProposalAttachmentService;
import org.springframework.stereotype.Service;

@Service
public class ProposalAttachmentServiceImpl extends ServiceImpl<ProposalAttachmentMapper, ProposalAttachment>
        implements IProposalAttachmentService {
}
