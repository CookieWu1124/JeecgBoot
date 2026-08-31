import { defHttp } from '/@/utils/http/axios';
import { formatAward, formatImprovementTypes, STATUS_TAG_COLOR } from './proposal.data';

enum Api {
  list = '/proposal/admin/manage/list',
  get = '/proposal/admin/manage/queryById',
}

const actionLabelMap: Record<string, string> = {
  SUBMIT: '提交申请',
  COMMITTEE_DONE: '委员审核完成',
  APPROVE: '申请批准',
  REJECT_FINAL: '申请不批准',
};

const conclusionLabelMap: Record<string, string> = {
  ADOPT: '采用',
  REJECT: '不采用',
};

const decisionLabelMap: Record<string, string> = {
  APPROVE: '批准',
  REJECT: '不批准',
};

function toSingleId(value: unknown): string | undefined {
  if (value == null || value === '') {
    return undefined;
  }
  if (Array.isArray(value)) {
    return value.length ? String(value[0]) : undefined;
  }
  const text = String(value).trim();
  if (!text) {
    return undefined;
  }
  return text.includes(',') ? text.split(',')[0].trim() : text;
}

function userName(user?: Recordable) {
  return user?.realname || user?.username || '-';
}

/** 列表：人员/部门已由后端嵌套返回 */
export const getProposalList = async (params) => {
  const query = { ...params };
  query.deptId = toSingleId(query.deptId);
  if (query.improvementTypes) {
    query.improvementTypes = `*${query.improvementTypes}*`;
  }
  return defHttp.get({ url: Api.list, params: query });
};

/** 管理端详情：申请书 + 留痕 + 委员意见；姓名部门走嵌套字段 */
export const getProposalById = async (params: { id: string }) => {
  const vo = await defHttp.get({ url: Api.get, params });
  const proposal = vo?.proposal || vo || {};
  const application = vo?.application || {};
  const statusLogs = Array.isArray(vo?.statusLogs) ? vo.statusLogs : [];
  const committeeReviews = Array.isArray(vo?.committeeReviews) ? vo.committeeReviews : [];
  const applicationApproval = vo?.applicationApproval || null;
  const proposer = proposal.proposer || {};
  const leader = proposal.deptLeader;

  return {
    id: proposal.id,
    proposalNo: proposal.proposalNo || '-',
    title: proposal.title || '-',
    status: proposal.status,
    statusLabel: proposal.statusLabel || proposal.status || '-',
    statusColor: STATUS_TAG_COLOR[proposal.status] || 'default',
    proposerId: proposal.proposerId,
    proposerName: userName(proposer),
    proposerWorkNo: proposer.workNo || '-',
    proposerPost: proposer.positionType || '-',
    proposerDeptName: proposer.deptName || '-',
    deptId: proposal.deptId,
    deptName: proposal.dept?.departName || '-',
    deptLeaderId: proposal.deptLeaderId,
    deptLeaderName: userName(leader),
    improvementTypesLabel: proposal.improvementTypesLabel || formatImprovementTypes(proposal.improvementTypes),
    awardAmountText: formatAward(proposal.awardAmount),
    planRequiredLabel:
      proposal.planRequired === 1 ? '形成' : proposal.planRequired === 0 ? '不形成' : '-',
    reviewProgress: proposal.reviewProgress || '-',
    createTime: proposal.createTime || '-',
    submitTime: application.submitTime || proposal.createTime || '-',
    currentSituation: application.currentSituation || '-',
    improvementSuggestion: application.improvementSuggestion || '-',
    remark: proposal.remark || '',
    attachments: Array.isArray(vo?.attachments) ? vo.attachments : [],
    applicationApproval: applicationApproval
      ? {
          decision: applicationApproval.decision,
          decisionLabel: decisionLabelMap[applicationApproval.decision] || applicationApproval.decision || '-',
          planRequiredLabel:
            applicationApproval.planRequired === 1
              ? '形成'
              : applicationApproval.planRequired === 0
                ? '不形成'
                : '-',
          awardAmountText: formatAward(applicationApproval.awardAmount),
          comment: applicationApproval.comment || '-',
          approverName: userName(applicationApproval.approver),
          approveTime: applicationApproval.approveTime || '-',
        }
      : null,
    statusLogs: statusLogs.map((log) => ({
      ...log,
      actionLabel: log.actionLabel || actionLabelMap[log.action] || log.action || '-',
      fromStatusLabel: log.fromStatusLabel || log.fromStatus || '-',
      toStatusLabel: log.toStatusLabel || log.toStatus || '-',
      operatorName: userName(log.operator),
    })),
    reviews: committeeReviews.map((r, idx) => {
      const done = !!r.conclusion;
      return {
        id: r.id || `${r.reviewerId}-${idx}`,
        memberName: r.reviewer?.realname || r.reviewerId || '-',
        statusLabel: done ? '已审' : '待审',
        conclusion: done ? conclusionLabelMap[r.conclusion] || r.conclusion : '-',
        planRequiredLabel: r.planRequired === 1 ? '形成' : r.planRequired === 0 ? '不形成' : '-',
        suggestAward: r.awardSuggestion != null ? `¥${r.awardSuggestion}` : '-',
        comment: r.comment || '-',
      };
    }),
  };
};
