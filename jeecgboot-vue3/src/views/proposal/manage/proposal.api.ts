import { defHttp } from '/@/utils/http/axios';
import { formatAward, formatImprovementTypes, proposalStatusOptions } from './proposal.data';

enum Api {
  list = '/proposal/admin/manage/list',
  get = '/proposal/admin/manage/queryById',
  userQueryByIds = '/sys/user/queryByIds',
  departQueryByIds = '/sys/sysDepart/queryByIds',
  departByOrgCode = '/sys/sysDepart/getDepartName',
}

const statusLabelMap = Object.fromEntries(proposalStatusOptions.map((o) => [o.value, o.label]));
const statusColorMap = Object.fromEntries(proposalStatusOptions.map((o) => [o.value, o.color]));

const actionLabelMap: Record<string, string> = {
  SUBMIT: '提交申请',
  WITHDRAW: '撤回申请',
  COMMITTEE_DONE: '委员审核完成',
};

const conclusionLabelMap: Record<string, string> = {
  ADOPT: '采用',
  REJECT: '不采用',
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

type UserInfo = { name: string; workNo: string; post: string; orgCode?: string; deptName?: string };

async function fetchUserInfoMap(ids: Array<string | undefined | null>): Promise<Record<string, UserInfo>> {
  const unique = [...new Set(ids.filter((id): id is string => !!id))];
  if (!unique.length) {
    return {};
  }
  const list = await defHttp.get({ url: Api.userQueryByIds, params: { userIds: unique.join(',') } });
  const map: Record<string, UserInfo> = {};
  (Array.isArray(list) ? list : []).forEach((u) => {
    if (u?.id) {
      map[u.id] = {
        name: u.realname || u.username || u.id,
        workNo: u.workNo || u.username || '-',
        // 种子/HR 字段为 position_type，不是 post
        post: u.positionType || u.post || '-',
        orgCode: u.orgCode,
      };
    }
  });

  // 提案人「部门」取用户所属组织，不是提案改善部门
  const orgCodes = [...new Set(Object.values(map).map((u) => u.orgCode).filter(Boolean) as string[])];
  if (orgCodes.length) {
    const deptResults = await Promise.all(
      orgCodes.map(async (orgCode) => {
        try {
          const dept = await defHttp.get({ url: Api.departByOrgCode, params: { orgCode } });
          return { orgCode, name: dept?.departName || orgCode };
        } catch {
          return { orgCode, name: orgCode };
        }
      })
    );
    const orgMap = Object.fromEntries(deptResults.map((d) => [d.orgCode, d.name]));
    Object.values(map).forEach((u) => {
      if (u.orgCode) {
        u.deptName = orgMap[u.orgCode] || u.orgCode;
      }
    });
  }
  return map;
}

async function fetchUserNameMap(ids: Array<string | undefined | null>): Promise<Record<string, string>> {
  const infoMap = await fetchUserInfoMap(ids);
  const map: Record<string, string> = {};
  Object.keys(infoMap).forEach((id) => {
    map[id] = infoMap[id].name;
  });
  return map;
}

async function fetchDeptNameMap(ids: Array<string | undefined | null>): Promise<Record<string, string>> {
  const unique = [...new Set(ids.filter((id): id is string => !!id))];
  if (!unique.length) {
    return {};
  }
  try {
    const list = await defHttp.get({ url: Api.departQueryByIds, params: { deptIds: unique.join(',') } });
    const map: Record<string, string> = {};
    (Array.isArray(list) ? list : []).forEach((d) => {
      if (d?.id) {
        map[d.id] = d.departName || d.departPathName || d.id;
      }
    });
    return map;
  } catch (e) {
    console.warn('[proposal-manage] 部门名称回显失败', e);
    return {};
  }
}

function enrichRecord(record: Recordable, userMap: Record<string, string>, deptMap: Record<string, string>) {
  record.proposerName = userMap[record.proposerId] || record.proposerName || '-';
  record.deptName = deptMap[record.deptId] || record.deptName || '-';
  record.improvementTypesLabel = formatImprovementTypes(record.improvementTypes);
  record.awardAmountText = formatAward(record.awardAmount);
  return record;
}

/** 列表：回显提案人/改善部门名称 */
export const getProposalList = async (params) => {
  const query = { ...params };
  query.deptId = toSingleId(query.deptId);
  if (query.improvementTypes) {
    query.improvementTypes = `*${query.improvementTypes}*`;
  }

  const page = await defHttp.get({ url: Api.list, params: query });
  const records = page?.records || [];
  const [userMap, deptMap] = await Promise.all([
    fetchUserNameMap(records.map((r) => r.proposerId)),
    fetchDeptNameMap(records.map((r) => r.deptId)),
  ]);
  records.forEach((r) => enrichRecord(r, userMap, deptMap));
  return page;
};

/** 管理端详情：申请书 + 留痕 + 委员意见 + 名称回显 */
export const getProposalById = async (params: { id: string }) => {
  const vo = await defHttp.get({ url: Api.get, params });
  const proposal = vo?.proposal || vo || {};
  const application = vo?.application || {};
  const statusLogs = Array.isArray(vo?.statusLogs) ? vo.statusLogs : [];
  const committeeReviews = Array.isArray(vo?.committeeReviews) ? vo.committeeReviews : [];

  const [userInfoMap, deptMap] = await Promise.all([
    fetchUserInfoMap([
      proposal.proposerId,
      proposal.deptLeaderId,
      ...statusLogs.map((l) => l.operatorId),
      ...committeeReviews.map((r) => r.reviewerId),
    ]),
    fetchDeptNameMap([proposal.deptId]),
  ]);

  const proposer = userInfoMap[proposal.proposerId] || { name: '-', workNo: '-', post: '-', deptName: '-' };
  const leader = userInfoMap[proposal.deptLeaderId];

  return {
    id: proposal.id,
    proposalNo: proposal.proposalNo || '-',
    title: proposal.title || '-',
    status: proposal.status,
    statusLabel: statusLabelMap[proposal.status] || proposal.status || '-',
    statusColor: statusColorMap[proposal.status] || 'default',
    proposerId: proposal.proposerId,
    proposerName: proposer.name,
    proposerWorkNo: proposer.workNo,
    proposerPost: proposer.post || '-',
    // 提案人信息.部门 = 申请人所属部门（如 MES开发），≠ 改善部门
    proposerDeptName: proposer.deptName || '-',
    deptId: proposal.deptId,
    deptName: deptMap[proposal.deptId] || '-',
    deptLeaderId: proposal.deptLeaderId,
    deptLeaderName: leader?.name || '-',
    improvementTypesLabel: formatImprovementTypes(proposal.improvementTypes),
    awardAmountText: formatAward(proposal.awardAmount),
    reviewProgress: proposal.reviewProgress || '-',
    createTime: proposal.createTime || '-',
    submitTime: application.submitTime || proposal.createTime || '-',
    currentSituation: application.currentSituation || '-',
    improvementSuggestion: application.improvementSuggestion || '-',
    remark: proposal.remark || '',
    attachments: Array.isArray(vo?.attachments) ? vo.attachments : [],
    statusLogs: statusLogs.map((log) => ({
      ...log,
      actionLabel: actionLabelMap[log.action] || log.action || '-',
      fromStatusLabel: statusLabelMap[log.fromStatus] || log.fromStatus || '-',
      toStatusLabel: statusLabelMap[log.toStatus] || log.toStatus || '-',
      operatorName: userInfoMap[log.operatorId]?.name || '-',
    })),
    reviews: committeeReviews.map((r, idx) => {
      const done = !!r.conclusion;
      return {
        id: r.id || `${r.reviewerId}-${idx}`,
        memberName: userInfoMap[r.reviewerId]?.name || r.reviewerId || '-',
        statusLabel: done ? '已审' : '待审',
        conclusion: done ? conclusionLabelMap[r.conclusion] || r.conclusion : '-',
        planRequiredLabel: r.planRequired === 1 ? '形成' : r.planRequired === 0 ? '不形成' : '-',
        suggestAward: r.awardSuggestion != null ? `¥${r.awardSuggestion}` : '-',
        comment: r.comment || '-',
      };
    }),
  };
};
