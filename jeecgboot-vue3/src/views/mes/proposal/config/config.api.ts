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
  homeBroadcast = '/proposal/admin/config/homeBroadcast',
  homeBroadcastSave = '/proposal/admin/config/homeBroadcast/save',
  userBriefs = '/proposal/meta/userBriefs',
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

export const getDeptLeaderList = async (params) => {
  return defHttp.get({ url: Api.deptLeaderList, params });
};

export const saveDeptLeader = (params) => {
  const data = { ...params };
  data.deptId = toSingleId(data.deptId) || toSingleId(data.dept?.id);
  data.leaderUserId = toSingleId(data.leaderUserId) || toSingleId(data.leader?.id);
  delete data.dept;
  delete data.leader;
  return defHttp.post({ url: Api.deptLeaderSave, params: data });
};

export const deleteDeptLeader = (params, handleSuccess) =>
  defHttp.delete({ url: Api.deptLeaderDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess());

export const getCommitteeList = async (params) => {
  return defHttp.get({ url: Api.committeeList, params });
};

/** 弹窗选人后回显姓名/工号/部门/职位（一次批量，含所属部门名） */
export async function getUserProfile(userId?: string | null): Promise<UserProfile | undefined> {
  const id = toSingleId(userId);
  if (!id) {
    return undefined;
  }
  const list = await defHttp.get({ url: Api.userBriefs, params: { userIds: id } });
  const rows = Array.isArray(list) ? list : [];
  return rows[0];
}

export const saveCommittee = (params) => {
  const data = { ...params };
  data.userId = toSingleId(data.userId);
  if (Number(data.scoreEnabled) === 0) {
    data.seatNo = null;
  }
  delete data.user;
  return defHttp.post({ url: Api.committeeSave, params: data });
};

export const deleteCommittee = (params, handleSuccess) =>
  defHttp.delete({ url: Api.committeeDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess());

/** 后端返回 List；批准人卡片与表格共用 */
export const getApproverList = async (params?) => {
  const list = await defHttp.get({ url: Api.approverList, params });
  const records = Array.isArray(list) ? list : [];
  records.forEach((r) => {
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
  delete data.user;
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

export const getHomeBroadcast = () => defHttp.get({ url: Api.homeBroadcast });

export const saveHomeBroadcast = (params: { id?: string; content?: string }) =>
  defHttp.post({ url: Api.homeBroadcastSave, params });
