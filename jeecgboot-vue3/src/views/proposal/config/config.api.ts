import { defHttp } from '/@/utils/http/axios';

enum Api {
  deptLeaderList = '/proposal/admin/config/deptLeader/list',
  deptLeaderSave = '/proposal/admin/config/deptLeader/save',
  deptLeaderDelete = '/proposal/admin/config/deptLeader/delete',
  committeeList = '/proposal/admin/config/committee/list',
  committeeSave = '/proposal/admin/config/committee/save',
  committeeDelete = '/proposal/admin/config/committee/delete',
  approverList = '/proposal/admin/config/approver/list',
  approverSave = '/proposal/admin/config/approver/save',
  approverDelete = '/proposal/admin/config/approver/delete',
  improvementTypeList = '/proposal/admin/config/improvementType/list',
  improvementTypeSave = '/proposal/admin/config/improvementType/save',
  improvementTypeDelete = '/proposal/admin/config/improvementType/delete',
  scoreDimensionList = '/proposal/admin/config/scoreDimension/list',
  scoreDimensionSave = '/proposal/admin/config/scoreDimension/save',
  scoreDimensionDelete = '/proposal/admin/config/scoreDimension/delete',
  userQueryByIds = '/sys/user/queryByIds',
  departQueryByIds = '/sys/sysDepart/queryByIds',
  departByOrgCode = '/sys/sysDepart/getDepartName',
}

export type UserProfile = {
  id: string;
  realname?: string;
  workNo?: string;
  positionType?: string;
  orgCode?: string;
  deptName?: string;
};

/** 取单个 ID（兼容组件偶发返回数组或逗号串） */
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

async function fetchUserProfileMap(ids: Array<string | undefined | null>): Promise<Record<string, UserProfile>> {
  const unique = [...new Set(ids.filter((id): id is string => !!id))];
  if (!unique.length) {
    return {};
  }
  const list = await defHttp.get({ url: Api.userQueryByIds, params: { userIds: unique.join(',') } });
  const map: Record<string, UserProfile> = {};
  (Array.isArray(list) ? list : []).forEach((u) => {
    if (!u?.id) {
      return;
    }
    map[u.id] = {
      id: u.id,
      realname: u.realname || u.username || u.id,
      workNo: u.workNo || u.username || '-',
      positionType: u.positionType || '-',
      orgCode: u.orgCode,
    };
  });

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
        // 优先用部门名称；路径名依赖合法 org_code，异常时可能为空
        map[d.id] = d.departName || d.departPathName || d.id;
      }
    });
    return map;
  } catch (e) {
    // org_code 不合 Jeecg 优编码规则时 queryByIds 会抛「编码长度必须能被固定位数整除」
    console.warn('[proposal-config] 部门名称回显失败，请检查 sys_depart.org_code', e);
    return {};
  }
}

function applyUserFields(target: Recordable, user?: UserProfile, asLeader = false) {
  if (asLeader) {
    if (!user) {
      target.leaderRealname = '未配置';
      target.leaderWorkNo = '-';
      target.leaderPosition = '-';
      return;
    }
    target.leaderRealname = user.realname || '-';
    target.leaderWorkNo = user.workNo || '-';
    target.leaderPosition = user.positionType || '-';
    return;
  }
  target.realname = user?.realname || '-';
  target.workNo = user?.workNo || '-';
  target.positionType = user?.positionType || '-';
  target.userDeptName = user?.deptName || '-';
}

export const getDeptLeaderList = async (params) => {
  const page = await defHttp.get({ url: Api.deptLeaderList, params });
  const records = page?.records || [];
  const [userMap, deptMap] = await Promise.all([
    fetchUserProfileMap(records.map((r) => r.leaderUserId)),
    fetchDeptNameMap(records.map((r) => r.deptId)),
  ]);
  records.forEach((r) => {
    r.deptName = deptMap[r.deptId] || r.deptId || '-';
    const user = r.leaderUserId ? userMap[r.leaderUserId] : undefined;
    applyUserFields(r, user, true);
  });
  return page;
};

export const saveDeptLeader = (params) => {
  const data = { ...params };
  data.deptId = toSingleId(data.deptId);
  data.leaderUserId = toSingleId(data.leaderUserId);
  return defHttp.post({ url: Api.deptLeaderSave, params: data });
};

export const deleteDeptLeader = (params, handleSuccess) =>
  defHttp.delete({ url: Api.deptLeaderDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess());

export const getCommitteeList = async (params) => {
  const page = await defHttp.get({ url: Api.committeeList, params });
  const records = page?.records || [];
  const userMap = await fetchUserProfileMap(records.map((r) => r.userId));
  records.forEach((r) => {
    applyUserFields(r, userMap[r.userId]);
    r.scoreDutyLabel =
      Number(r.scoreEnabled) === 1 && r.seatNo != null && r.seatNo !== ''
        ? `评分席位 ${r.seatNo}`
        : '不参与评分';
  });
  return page;
};

/** 弹窗选人后回显姓名/工号/部门/职位 */
export async function getUserProfile(userId?: string | null): Promise<UserProfile | undefined> {
  const id = toSingleId(userId);
  if (!id) {
    return undefined;
  }
  const map = await fetchUserProfileMap([id]);
  return map[id];
}

export const saveCommittee = (params) => {
  const data = { ...params };
  data.userId = toSingleId(data.userId);
  if (Number(data.scoreEnabled) === 0) {
    data.seatNo = null;
  }
  return defHttp.post({ url: Api.committeeSave, params: data });
};

export const deleteCommittee = (params, handleSuccess) =>
  defHttp.delete({ url: Api.committeeDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess());

/** 后端返回 List；批准人卡片与表格共用 */
export const getApproverList = async (params?) => {
  const list = await defHttp.get({ url: Api.approverList, params });
  const records = Array.isArray(list) ? list : [];
  const userMap = await fetchUserProfileMap(records.map((r) => r.userId));
  records.forEach((r) => {
    applyUserFields(r, userMap[r.userId]);
    r.signoffScopes = ['申请单终审', '计划书终审', '报告书终审'];
  });
  return { records, total: records.length };
};

export const saveApprover = (params) => {
  const data = { ...params };
  data.userId = toSingleId(data.userId);
  if (!data.approverStatus) {
    data.approverStatus = 'active';
  }
  return defHttp.post({ url: Api.approverSave, params: data });
};

export const deleteApprover = (params, handleSuccess?) =>
  defHttp.delete({ url: Api.approverDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess && handleSuccess());

export const getImprovementTypeList = async (params?) => {
  const list = await defHttp.get({ url: Api.improvementTypeList, params });
  const records = Array.isArray(list) ? list : [];
  return { records, total: records.length };
};

export const saveImprovementType = (params) => defHttp.post({ url: Api.improvementTypeSave, params });

export const deleteImprovementType = (params, handleSuccess) =>
  defHttp.delete({ url: Api.improvementTypeDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess());

export const getScoreDimensionList = async (params?) => {
  const list = await defHttp.get({ url: Api.scoreDimensionList, params });
  const records = Array.isArray(list) ? list : [];
  const weightTotal = records
    .filter((r) => r.dimStatus === 'active')
    .reduce((sum, r) => sum + (Number(r.weightPct) || 0), 0);
  return { records, total: records.length, weightTotal };
};

export const saveScoreDimension = (params) => defHttp.post({ url: Api.scoreDimensionSave, params });

export const deleteScoreDimension = (params, handleSuccess) =>
  defHttp.delete({ url: Api.scoreDimensionDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess());
