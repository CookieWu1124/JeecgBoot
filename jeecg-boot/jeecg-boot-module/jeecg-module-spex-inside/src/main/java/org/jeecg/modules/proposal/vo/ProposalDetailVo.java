package org.jeecg.modules.proposal.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.entity.ProposalApplication;
import org.jeecg.modules.proposal.entity.ProposalAttachment;
import org.jeecg.modules.proposal.entity.ProposalCommitteeReview;
import org.jeecg.modules.proposal.entity.ProposalStatusLog;

import java.util.List;

@Data
@Schema(description = "proposal detail")
public class ProposalDetailVo {

    private Proposal proposal;
    private ProposalApplication application;
    private List<ProposalAttachment> attachments;
    /** 管理端操作留痕；小程序详情可不填 */
    private List<ProposalStatusLog> statusLogs;
    /** 委员审核意见（含未审快照行） */
    private List<ProposalCommitteeReview> committeeReviews;
}
