package org.jeecg.modules.proposal.enums;

import lombok.Getter;

/**
 * 状态机动作。{@link #code} 写入 {@code proposal_status_log.action}，须与历史日志字符串一致，不要随意改。
 * <p>
 * Service 只把本枚举传给 {@code ProposalStateMachine.transit}，不要自己 {@code setStatus}。
 * 绝大多数动作走四参数 transit；仅 {@link #SUBMIT_REPORT} 在 {@code plan_required=1} 时需要
 * {@code ProposalStateMachine.Context.planApproved()}。
 */
@Getter
public enum ProposalAction {

    // —— 01 申请单 ——
    SUBMIT("SUBMIT", "提交申请"),
    /** 历史日志可能仍有此动作；申请段已取消撤回，状态机不再注册。 */
    WITHDRAW("WITHDRAW", "撤回申请"),
    /** 委员全部提交后由系统触发，不是委员点的按钮。 */
    COMMITTEE_DONE("COMMITTEE_DONE", "委员审核完成"),
    APPROVE("APPROVE", "申请批准"),
    REJECT_FINAL("REJECT_FINAL", "申请不批准"),

    // —— 02 任务分配（预注册，业务未接）——
    ASSIGN("ASSIGN", "任务指派"),
    PUT_POOL("PUT_POOL", "放入任务池"),
    CLAIM("CLAIM", "领取任务"),

    // —— 03 计划书（预注册；路线带 requirePlan，plan_required 必须为 1）——
    SUBMIT_PLAN("SUBMIT_PLAN", "提交计划书"),
    PLAN_COMMITTEE_PASS("PLAN_COMMITTEE_PASS", "计划书委员审核通过"),
    PLAN_COMMITTEE_REJECT("PLAN_COMMITTEE_REJECT", "计划书委员审核不通过"),
    PLAN_APPROVE("PLAN_APPROVE", "计划书批准"),
    PLAN_REJECT("PLAN_REJECT", "计划书驳回"),
    RESUBMIT_PLAN("RESUBMIT_PLAN", "重提计划书"),

    // —— 04 报告书 / 评分 / 签核（预注册）——
    /** plan_required=1 时须带 Context.planApproved()，否则守卫会拒绝。 */
    SUBMIT_REPORT("SUBMIT_REPORT", "提交报告书"),
    SCORE_DONE("SCORE_DONE", "评分完成"),
    SIGNOFF("SIGNOFF", "签核结案");

    /** 落库值，与 status_log.action、前端动态里的 action 相同。 */
    private final String code;
    /** 给人看的短名，非法跳转提示里会用。 */
    private final String label;

    ProposalAction(String code, String label) {
        this.code = code;
        this.label = label;
    }

    public static String labelOf(String code) {
        if (code == null) {
            return null;
        }
        for (ProposalAction item : values()) {
            if (item.code.equals(code)) {
                return item.label;
            }
        }
        return code;
    }
}
