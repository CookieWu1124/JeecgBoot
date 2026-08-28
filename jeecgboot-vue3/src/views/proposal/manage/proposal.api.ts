import { defHttp } from '/@/utils/http/axios';
import { formatAward, formatImprovementTypes } from './proposal.data';

enum Api {
  list = '/proposal/admin/manage/list',
  get = '/proposal/admin/manage/queryById',
  userQueryByIds = '/sys/user/queryByIds',
  departQueryByIds = '/sys/sysDepart/queryByIds',
}

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

async function fetchUserNameMap(ids: Array<string | undefined | null>): Promise<Record<string, string>> {
  const unique = [...new Set(ids.filter((id): id is string => !!id))];
  if (!unique.length) {
    return {};
  }
  const list = await defHttp.get({ url: Api.userQueryByIds, params: { userIds: unique.join(',') } });
  const map: Record<string, string> = {};
  (Array.isArray(list) ? list : []).forEach((u) => {
    if (u?.id) {
      map[u.id] = u.realname || u.username || u.id;
    }
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
  // 改善性质按包含匹配（JSON 数组字符串）
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

export const getProposalById = async (params) => {
  const record = await defHttp.get({ url: Api.get, params });
  if (!record) {
    return record;
  }
  const [userMap, deptMap] = await Promise.all([
    fetchUserNameMap([record.proposerId]),
    fetchDeptNameMap([record.deptId]),
  ]);
  return enrichRecord(record, userMap, deptMap);
};
