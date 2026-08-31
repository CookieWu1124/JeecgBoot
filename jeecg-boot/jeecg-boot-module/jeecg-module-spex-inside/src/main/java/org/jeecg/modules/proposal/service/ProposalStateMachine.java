package org.jeecg.modules.proposal.service;

import org.jeecg.common.exception.JeecgBootBizTipException;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.entity.ProposalStatusLog;
import org.jeecg.modules.proposal.enums.ProposalAction;
import org.jeecg.modules.proposal.enums.ProposalStatusEnum;
import org.jeecg.modules.proposal.mapper.ProposalMapper;
import org.jeecg.modules.proposal.util.ProposalAuditHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.EnumMap;
import java.util.Map;

/**
 * 提案状态守门人：只负责「当前状态 + 动作 → 下一状态」及写 {@code proposal_status_log}。
 * <p>
 * 不管：是不是委员/批准人/部门负责人、意见填没填、奖励金额、任务成员名单 —— 那些仍在各 Service。
 * <p>
 * 调用约定（02/03/04 实现业务时同样遵守）：
 * <ul>
 *   <li>日常用四参数 {@link #transit(Proposal, ProposalAction, LoginUser, String)}，内部把 {@code context} 填成 null。</li>
 *   <li>仅「plan_required=1 且提交报告书」时用五参数，传入 {@link Context#planApproved()}。</li>
 *   <li>不要自己实现 Guard：路线和守卫在本类 static 块里注册死，Service 只选 {@link ProposalAction}。</li>
 *   <li>未注册的跳转会直接拒绝。发起直接写入审核中，用 {@link #recordEnter} 记一条 from 为空的提交留痕。</li>
 *   <li>申请段批准后停在 {@code APPROVED}，不要接到 {@code PENDING_ASSIGN}（阶段 2 待定）。</li>
 * </ul>
 */
@Component
public class ProposalStateMachine {

    @Autowired
    private ProposalMapper proposalMapper;
    @Autowired
    private IProposalStatusLogService statusLogService;

    /** from → (action → Route)。Route 里的 Guard 为 null 表示「状态对了就能跳」。 */
    private static final Map<ProposalStatusEnum, Map<ProposalAction, Route>> ROUTES = new EnumMap<>(ProposalStatusEnum.class);

    static {
        // 01 申请段：发起即审核中（无草稿跳板）。对外只有审核中/待批准/已批准/不批准。
        add(ProposalStatusEnum.PENDING_REVIEW, ProposalAction.COMMITTEE_DONE, ProposalStatusEnum.PENDING_APPROVAL);
        add(ProposalStatusEnum.PENDING_APPROVAL, ProposalAction.APPROVE, ProposalStatusEnum.APPROVED);
        add(ProposalStatusEnum.PENDING_APPROVAL, ProposalAction.REJECT_FINAL, ProposalStatusEnum.REJECTED_FINAL);

        // 02 任务分配（预注册，业务未接）。入口不再是批准动作；阶段 2 若做，应从 APPROVED 另挂路线，不要和已批准合并。
        add(ProposalStatusEnum.PENDING_ASSIGN, ProposalAction.ASSIGN, ProposalStatusEnum.IN_PROGRESS);
        add(ProposalStatusEnum.PENDING_ASSIGN, ProposalAction.PUT_POOL, ProposalStatusEnum.PENDING_CLAIM);
        add(ProposalStatusEnum.PENDING_CLAIM, ProposalAction.CLAIM, ProposalStatusEnum.IN_PROGRESS);

        // 03 计划书（预注册）：进行中之后按 plan_required 分叉，必须靠 Guard，不能只看 status。
        // requirePlan：plan_required 必须为 1，否则不能进 PLAN_*。
        add(ProposalStatusEnum.IN_PROGRESS, ProposalAction.SUBMIT_PLAN, ProposalStatusEnum.PLAN_PENDING_REVIEW,
                ProposalStateMachine::requirePlan);
        add(ProposalStatusEnum.PLAN_PENDING_REVIEW, ProposalAction.PLAN_COMMITTEE_PASS,
                ProposalStatusEnum.PLAN_PENDING_APPROVAL, ProposalStateMachine::requirePlan);
        add(ProposalStatusEnum.PLAN_PENDING_REVIEW, ProposalAction.PLAN_COMMITTEE_REJECT,
                ProposalStatusEnum.PLAN_REJECTED, ProposalStateMachine::requirePlan);
        add(ProposalStatusEnum.PLAN_PENDING_APPROVAL, ProposalAction.PLAN_APPROVE, ProposalStatusEnum.IN_PROGRESS,
                ProposalStateMachine::requirePlan);
        add(ProposalStatusEnum.PLAN_PENDING_APPROVAL, ProposalAction.PLAN_REJECT, ProposalStatusEnum.PLAN_REJECTED,
                ProposalStateMachine::requirePlan);
        add(ProposalStatusEnum.PLAN_REJECTED, ProposalAction.RESUBMIT_PLAN, ProposalStatusEnum.PLAN_PENDING_REVIEW,
                ProposalStateMachine::requirePlan);

        // 04 报告书 / 评分 / 签核（预注册）。
        // IN_PROGRESS 同时挂了 SUBMIT_PLAN 和 SUBMIT_REPORT：同一状态两条路，靠 Guard 分开。
        // requireCanSubmitReport：=0 可直接交报告；=1 必须 Context.planApproved()（计划书批准后会回到进行中，单靠 status 分不出）。
        add(ProposalStatusEnum.IN_PROGRESS, ProposalAction.SUBMIT_REPORT, ProposalStatusEnum.PENDING_EVALUATION,
                ProposalStateMachine::requireCanSubmitReport);
        add(ProposalStatusEnum.PENDING_EVALUATION, ProposalAction.SCORE_DONE, ProposalStatusEnum.PENDING_SIGNOFF);
        add(ProposalStatusEnum.PENDING_SIGNOFF, ProposalAction.SIGNOFF, ProposalStatusEnum.COMPLETED);
    }

    /**
     * 日常入口。内部调用五参数并把 {@code context} 置为 null。
     * 申请提交/批准、任务指派/入池/领取、交计划书等都不需要 Context。
     */
    public void transit(Proposal proposal, ProposalAction action, LoginUser loginUser, String remark) {
        transit(proposal, action, loginUser, remark, null);
    }

    /**
     * 完整入口：查 ROUTES →（若有 Guard）check → 改 status → updateById → 写 status_log。
     * 调用方须先写好业务字段（如 planRequired、reviewProgress），本方法一次落库。
     *
     * @param context 绝大多数传 null（或走四参数重载）。仅 SUBMIT_REPORT 且 plan_required=1 时传 {@link Context#planApproved()}。
     */
    public void transit(Proposal proposal, ProposalAction action, LoginUser loginUser, String remark, Context context) {
        if (proposal == null || oConvertUtils.isEmpty(proposal.getId())) {
            throw new JeecgBootBizTipException("提案不存在");
        }
        if (action == null) {
            throw new JeecgBootBizTipException("状态动作不能为空");
        }
        if (loginUser == null) {
            throw new JeecgBootBizTipException("操作人不能为空");
        }

        ProposalStatusEnum from = ProposalStatusEnum.fromCode(proposal.getStatus());
        if (from == null) {
            throw new JeecgBootBizTipException("未知提案状态：" + proposal.getStatus());
        }
        Map<ProposalAction, Route> allowed = ROUTES.get(from);
        Route route = allowed == null ? null : allowed.get(action);
        if (route == null) {
            throw new JeecgBootBizTipException(
                    "当前状态「" + from.getLabel() + "」不允许执行「" + action.getLabel() + "」");
        }
        // Guard=null：没有额外条件，不调用 check，此时 context 即使为 null 也无影响。
        if (route.guard != null) {
            route.guard.check(proposal, context);
        }

        String fromCode = from.getCode();
        String toCode = route.to.getCode();
        proposal.setStatus(toCode);
        ProposalAuditHelper.fillOnUpdate(loginUser, proposal);
        int rows = proposalMapper.updateById(proposal);
        if (rows == 0) {
            throw new JeecgBootBizTipException("提案状态更新失败，请刷新后重试");
        }
        appendStatusLog(proposal.getId(), fromCode, toCode, action.getCode(), loginUser, remark);
    }

    /**
     * 新建即进入当前状态：不改 status（调用方已写好），只写一条 from 为空的留痕。
     * 申请段发起用 {@link ProposalAction#SUBMIT}，to 为审核中。
     */
    public void recordEnter(Proposal proposal, ProposalAction action, LoginUser loginUser, String remark) {
        if (proposal == null || oConvertUtils.isEmpty(proposal.getId())) {
            throw new JeecgBootBizTipException("提案不存在");
        }
        if (action == null) {
            throw new JeecgBootBizTipException("状态动作不能为空");
        }
        if (loginUser == null) {
            throw new JeecgBootBizTipException("操作人不能为空");
        }
        if (oConvertUtils.isEmpty(proposal.getStatus())) {
            throw new JeecgBootBizTipException("提案状态不能为空");
        }
        appendStatusLog(proposal.getId(), null, proposal.getStatus(), action.getCode(), loginUser, remark);
    }

    /**
     * 不改状态，只拦「当前必须是某状态」。
     * 用于委员逐条提交意见等：动作发生在同一状态内，没有 from→to，不能走 transit。
     */
    public void assertStatus(Proposal proposal, ProposalStatusEnum expected, String message) {
        if (proposal == null) {
            throw new JeecgBootBizTipException("提案不存在");
        }
        if (expected == null || !expected.getCode().equals(proposal.getStatus())) {
            throw new JeecgBootBizTipException(message);
        }
    }

    private void appendStatusLog(String proposalId, String fromStatus, String toStatus,
                                 String action, LoginUser loginUser, String remark) {
        ProposalStatusLog log = new ProposalStatusLog();
        log.setProposalId(proposalId);
        log.setFromStatus(fromStatus);
        log.setToStatus(toStatus);
        log.setAction(action);
        log.setOperatorId(loginUser.getId());
        log.setRemark(remark);
        ProposalAuditHelper.fillOnCreate(loginUser, log);
        statusLogService.save(log);
    }

    /** 无额外条件的路线。内部把 Guard 填成 null。 */
    private static void add(ProposalStatusEnum from, ProposalAction action, ProposalStatusEnum to) {
        add(from, action, to, null);
    }

    /** 带守卫的路线。guard 用本类已有方法引用（requirePlan 等），不要在 Service 里实现 Guard。 */
    private static void add(ProposalStatusEnum from, ProposalAction action, ProposalStatusEnum to, Guard guard) {
        ROUTES.computeIfAbsent(from, k -> new EnumMap<>(ProposalAction.class))
                .put(action, new Route(to, guard));
    }

    /**
     * 计划书链路守卫：只读 proposal.planRequired，不读 Context（故参数名 ignored）。
     * plan_required=0 的单走这条会失败，从而跳过整个 PLAN_*。
     */
    private static void requirePlan(Proposal proposal, Context ignored) {
        if (proposal.getPlanRequired() == null || proposal.getPlanRequired() != 1) {
            throw new JeecgBootBizTipException("未核定形成计划书，不能进入计划书流程");
        }
    }

    /**
     * 提交报告书守卫。plan_required=0：放行（四参数、context=null 即可）。
     * plan_required=1：必须带 Context.planApproved()，否则视为计划书尚未批准。
     */
    private static void requireCanSubmitReport(Proposal proposal, Context context) {
        Integer flag = proposal.getPlanRequired();
        if (flag != null && flag == 0) {
            return;
        }
        if (flag != null && flag == 1) {
            if (context == null || !context.planApproved) {
                throw new JeecgBootBizTipException("计划书尚未批准，不能提交报告书");
            }
            return;
        }
        throw new JeecgBootBizTipException("未核定是否形成计划书，不能提交报告书");
    }

    /**
     * 路线上的额外条件，仅本类内部使用（private）。
     * 已有实现：requirePlan、requireCanSubmitReport。
     * Service 不要实现本接口，也不要把 Guard 当 transit 的入参。
     */
    @FunctionalInterface
    private interface Guard {
        /**
         * @param context 四参数 transit 传来为 null；仅 requireCanSubmitReport 会读它
         */
        void check(Proposal proposal, Context context);
    }

    /** 一条合法跳转：目标状态 + 可选守卫。 */
    private static final class Route {
        /** 动作成功后的目标状态。 */
        private final ProposalStatusEnum to;
        /** null = 无额外条件，transit 跳过 check。 */
        private final Guard guard;

        private Route(ProposalStatusEnum to, Guard guard) {
            this.to = to;
            this.guard = guard;
        }
    }

    /**
     * transit 的可选附加证明，不是 Guard 的实现。
     * 目前只有 planApproved：plan_required=1 交报告书时，Service 先确认计划书已批准再传入。
     * 其它动作不要造 Context。
     */
    public static final class Context {
        /** true 表示 Service 已确认计划书已批准。false/null 时 requireCanSubmitReport 会拒绝。 */
        private final boolean planApproved;

        private Context(boolean planApproved) {
            this.planApproved = planApproved;
        }

        public static Context planApproved() {
            return new Context(true);
        }
    }
}
