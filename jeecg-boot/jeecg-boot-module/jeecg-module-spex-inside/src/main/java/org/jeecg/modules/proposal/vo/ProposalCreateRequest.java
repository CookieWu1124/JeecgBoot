package org.jeecg.modules.proposal.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "create proposal request")
public class ProposalCreateRequest {

    private String title;
    private String improvementTypes;
    private String deptId;
    private String teamType;
    private String currentSituation;
    private String improvementSuggestion;
    private List<AttachmentItem> attachments;

    @Data
    public static class AttachmentItem {
        private String fileName;
        private String fileUrl;
        private Long fileSize;
    }
}
