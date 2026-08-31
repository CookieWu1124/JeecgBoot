package org.jeecg.modules.proposal.enums;

import lombok.Getter;
import org.jeecg.modules.proposal.entity.Proposal;

/**
 * 提案主表 {@code proposal.status} 的合法取值。{@link #code} 落库，{@link #label} 给前端/提示。
 * <p>
 * 合法跳转见 {@code ProposalStateMachine}，不要在 Service 里拼字符串改 status。
 * 终态（不再迁出）：{@link #REJECTED_FINAL}、{@link #WITHDRAWN}、{@link #COMPLETED}。
 */
@Getter
public enum ProposalStatusEnum {

    DRAFT("DRAFT", "草稿"),
    PENDING_REVIEW("PENDING_REVIEW", "待审核"),
    PENDING_APPROVAL("PENDING_APPROVAL", "待批准"),
    REJECTED_FINAL("REJECTED_FINAL", "不批准"),
    WITHDRAWN("WITHDRAWN", "已撤回"),
    PENDING_ASSIGN("PENDING_ASSIGN", "待指派"),
    PENDING_CLAIM("PENDING_CLAIM", "待领取"),
    /** 任务已分配。下一步交计划书还是交报告书，看 plan_required，不单看本状态。 */
    IN_PROGRESS("IN_PROGRESS", "进行中"),
    PLAN_PENDING_REVIEW("PLAN_PENDING_REVIEW", "计划书待审"),
    PLAN_PENDING_APPROVAL("PLAN_PENDING_APPROVAL", "计划书待批"),
    PLAN_REJECTED("PLAN_REJECTED", "已驳回"),
    PENDING_EVALUATION("PENDING_EVALUATION", "待评定"),
    PENDING_SIGNOFF("PENDING_SIGNOFF", "待签核"),
    COMPLETED("COMPLETED", "已完成");

    /** 写入 proposal.status / status_log.from_status / to_status。 */
    private final String code;
    /** 界面显示名。 */
    private final String label;

    ProposalStatusEnum(String code, String label) {
        this.code = code;
        this.label = label;
    }

    /** 库里读出的 status 字符串转枚举；未知值返回 null，由状态机报「未知提案状态」。 */
    public static ProposalStatusEnum fromCode(String code) {
        if (code == null) {
            return null;
        }
        for (ProposalStatusEnum item : values()) {
            if (item.code.equals(code)) {
                return item;
            }
        }
        return null;
    }

    /** 给列表/详情回显；未知码原样返回，避免空白。 */
    public static String labelOf(String code) {
        ProposalStatusEnum item = fromCode(code);
        return item == null ? code : item.getLabel();
    }

    public boolean terminal() {
        return this == REJECTED_FINAL || this == WITHDRAWN || this == COMPLETED;
    }

    public static void attachLabel(Proposal proposal) {
        if (proposal != null) {
            proposal.setStatusLabel(labelOf(proposal.getStatus()));
        }
    }
}
