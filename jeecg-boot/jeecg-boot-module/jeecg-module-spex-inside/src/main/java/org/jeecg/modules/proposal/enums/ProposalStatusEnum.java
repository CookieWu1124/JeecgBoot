package org.jeecg.modules.proposal.enums;

import lombok.Getter;

@Getter
public enum ProposalStatusEnum {

    DRAFT("DRAFT", "\u8349\u7a3f"),
    PENDING_REVIEW("PENDING_REVIEW", "\u5f85\u5ba1\u6838"),
    PENDING_APPROVAL("PENDING_APPROVAL", "\u5f85\u6279\u51c6"),
    REJECTED_FINAL("REJECTED_FINAL", "\u4e0d\u6279\u51c6"),
    WITHDRAWN("WITHDRAWN", "\u5df2\u64a4\u56de"),
    PENDING_ASSIGN("PENDING_ASSIGN", "\u5f85\u6307\u6d3e"),
    PENDING_CLAIM("PENDING_CLAIM", "\u5f85\u9886\u53d6"),
    IN_PROGRESS("IN_PROGRESS", "\u8fdb\u884c\u4e2d"),
    PLAN_PENDING_REVIEW("PLAN_PENDING_REVIEW", "\u8ba1\u5212\u4e66\u5f85\u5ba1"),
    PLAN_PENDING_APPROVAL("PLAN_PENDING_APPROVAL", "\u8ba1\u5212\u4e66\u5f85\u6279"),
    PLAN_REJECTED("PLAN_REJECTED", "\u5df2\u9a73\u56de"),
    PENDING_EVALUATION("PENDING_EVALUATION", "\u5f85\u8bc4\u5b9a"),
    PENDING_SIGNOFF("PENDING_SIGNOFF", "\u5f85\u7b7e\u6838"),
    COMPLETED("COMPLETED", "\u5df2\u5b8c\u6210");

    private final String code;
    private final String label;

    ProposalStatusEnum(String code, String label) {
        this.code = code;
        this.label = label;
    }
}
