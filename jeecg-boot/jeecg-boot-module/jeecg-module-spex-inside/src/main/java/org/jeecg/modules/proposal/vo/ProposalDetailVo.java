package org.jeecg.modules.proposal.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.entity.ProposalApplication;
import org.jeecg.modules.proposal.entity.ProposalAttachment;

import java.util.List;

@Data
@Schema(description = "proposal detail")
public class ProposalDetailVo {

    private Proposal proposal;
    private ProposalApplication application;
    private List<ProposalAttachment> attachments;
}
