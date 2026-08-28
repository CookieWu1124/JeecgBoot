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
  scoreDimensionList = '/proposal/admin/config/scoreDimension/list',
  scoreDimensionSave = '/proposal/admin/config/scoreDimension/save',
  scoreDimensionDelete = '/proposal/admin/config/scoreDimension/delete',
}

export const getDeptLeaderList = (params) => defHttp.get({ url: Api.deptLeaderList, params });

export const saveDeptLeader = (params) => defHttp.post({ url: Api.deptLeaderSave, params });

export const deleteDeptLeader = (params, handleSuccess) =>
  defHttp.delete({ url: Api.deptLeaderDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess());

export const getCommitteeList = (params) => defHttp.get({ url: Api.committeeList, params });

export const saveCommittee = (params) => defHttp.post({ url: Api.committeeSave, params });

export const deleteCommittee = (params, handleSuccess) =>
  defHttp.delete({ url: Api.committeeDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess());

/** 后端返回 List，适配 BasicTable 分页格式 */
export const getApproverList = async (params) => {
  const list = await defHttp.get({ url: Api.approverList, params });
  const records = Array.isArray(list) ? list : [];
  return { records, total: records.length };
};

export const saveApprover = (params) => defHttp.post({ url: Api.approverSave, params });

export const deleteApprover = (params, handleSuccess) =>
  defHttp.delete({ url: Api.approverDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess());

export const getScoreDimensionList = async (params) => {
  const list = await defHttp.get({ url: Api.scoreDimensionList, params });
  const records = Array.isArray(list) ? list : [];
  return { records, total: records.length };
};

export const saveScoreDimension = (params) => defHttp.post({ url: Api.scoreDimensionSave, params });

export const deleteScoreDimension = (params, handleSuccess) =>
  defHttp.delete({ url: Api.scoreDimensionDelete, data: params }, { joinParamsToUrl: true }).then(() => handleSuccess());
