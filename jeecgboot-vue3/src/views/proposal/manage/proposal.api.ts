import { defHttp } from '/@/utils/http/axios';

enum Api {
  list = '/proposal/admin/manage/list',
  save = '/proposal/admin/manage/add',
  edit = '/proposal/admin/manage/edit',
  get = '/proposal/admin/manage/queryById',
  delete = '/proposal/admin/manage/delete',
}

export const getProposalList = (params) => {
  return defHttp.get({ url: Api.list, params });
};

export const saveOrUpdateProposal = (params, isUpdate) => {
  const url = isUpdate ? Api.edit : Api.save;
  return isUpdate ? defHttp.put({ url, params }) : defHttp.post({ url, params });
};

export const getProposalById = (params) => {
  return defHttp.get({ url: Api.get, params });
};

export const deleteProposal = (params, handleSuccess) => {
  return defHttp.delete({ url: Api.delete, data: params }, { joinParamsToUrl: true }).then(() => {
    handleSuccess();
  });
};
