import { BasicColumn, FormSchema } from '/@/components/Table';
import { h } from 'vue';
import { Tag } from 'ant-design-vue';
import { defHttp } from '/@/utils/http/axios';

export const memberStatusOptions = [
  { label: '在任', value: 'active' },
  { label: '离任', value: 'inactive' },
];

export const approverStatusOptions = [
  { label: '启用', value: 'active' },
  { label: '停用', value: 'inactive' },
];

export const dimStatusOptions = [
  { label: '启用', value: 'active' },
  { label: '禁用', value: 'disabled' },
];

/** 按改善部门过滤可选负责人（仅本部门及下级成员） */
function createDeptScopedUserSelectProps(formModel: Recordable) {
  return {
    rowKey: 'id',
    labelKey: 'realname',
    showButton: true,
    modalTitle: '选择本部门负责人',
    isRadioSelection: true,
    params: { departId: formModel.deptId || '' },
    customListApi: (params) => {
      const departId = formModel.deptId;
      if (!departId) {
        return Promise.resolve({ records: [], total: 0 });
      }
      return defHttp.get({
        url: '/sys/user/queryUserComponentData',
        params: { ...params, departId },
      });
    },
  };
}

/** 对齐原型：改善部门 | 负责人姓名 | 负责人工号 | 职位 | 更新人 | 更新时间 */
export const deptLeaderColumns: BasicColumn[] = [
  { title: '改善部门', dataIndex: 'deptName', width: 160 },
  {
    title: '负责人姓名',
    dataIndex: 'leaderRealname',
    width: 120,
    customRender: ({ text, record }) => {
      if (!record.leaderUserId) {
        return h('span', { style: { color: '#999' } }, '未配置');
      }
      return text || '-';
    },
  },
  { title: '负责人工号', dataIndex: 'leaderWorkNo', width: 120 },
  { title: '职位', dataIndex: 'leaderPosition', width: 140 },
  { title: '更新人', dataIndex: 'updateBy', width: 100 },
  { title: '更新时间', dataIndex: 'updateTime', width: 170 },
];

export const deptLeaderFormSchema: FormSchema[] = [
  { field: 'id', component: 'Input', show: false },
  {
    field: 'deptId',
    label: '改善部门',
    component: 'JSelectDept',
    required: true,
    dynamicDisabled: ({ values }) => !!values.id,
    componentProps: ({ formModel }) => ({
      multiple: false,
      sync: false,
      checkStrictly: true,
      showButton: true,
      modalTitle: '选择改善部门',
      onChange: () => {
        formModel.leaderUserId = undefined;
      },
    }),
  },
  {
    field: 'leaderUserId',
    label: '部门负责人',
    component: 'JSelectUser',
    required: true,
    dynamicDisabled: ({ values }) => !values.deptId,
    componentProps: ({ formModel }) => createDeptScopedUserSelectProps(formModel),
    dynamicRules: ({ values }) => [
      {
        required: true,
        message: values.deptId ? '请选择本部门负责人' : '请先选择改善部门',
      },
    ],
  },
  { field: 'remark', label: '备注', component: 'InputTextArea', componentProps: { rows: 2 } },
];

/** 对齐原型：成员姓名 | 工号 | 部门 | 职位 | 评分职责 | 更新人 | 更新时间 */
export const committeeColumns: BasicColumn[] = [
  { title: '成员姓名', dataIndex: 'realname', width: 110 },
  { title: '工号', dataIndex: 'workNo', width: 100 },
  { title: '部门', dataIndex: 'userDeptName', width: 140 },
  { title: '职位', dataIndex: 'positionType', width: 140 },
  {
    title: '评分职责',
    dataIndex: 'scoreDutyLabel',
    width: 140,
    customRender: ({ record }) => {
      if (Number(record.scoreEnabled) === 1 && record.seatNo != null && record.seatNo !== '') {
        return h(Tag, { color: 'purple' }, () => `评分席位 ${record.seatNo}`);
      }
      return h('span', { style: { color: '#666' } }, '不参与评分');
    },
  },
  { title: '更新人', dataIndex: 'updateBy', width: 100 },
  { title: '更新时间', dataIndex: 'updateTime', width: 170 },
];

export const approverFormSchema: FormSchema[] = [
  { field: 'id', component: 'Input', show: false },
  {
    field: 'userId',
    label: '批准人',
    component: 'JSelectUser',
    required: true,
    componentProps: {
      rowKey: 'id',
      labelKey: 'realname',
      showButton: true,
      modalTitle: '选择批准人',
      isRadioSelection: true,
    },
  },
  {
    field: 'approverStatus',
    label: '状态',
    component: 'Select',
    defaultValue: 'active',
    show: false,
    componentProps: { options: approverStatusOptions },
  },
  { field: 'remark', label: '备注', component: 'InputTextArea', componentProps: { rows: 2 } },
];

/** 对齐原型：排序 | 维度编码 | 评分维度(名+说明) | 权重 | 状态 | 更新人 | 更新时间 */
export const scoreDimensionColumns: BasicColumn[] = [
  { title: '排序', dataIndex: 'sortNo', width: 70 },
  { title: '维度编码', dataIndex: 'dimCode', width: 120 },
  {
    title: '评分维度',
    dataIndex: 'dimName',
    align: 'left',
    customRender: ({ record }) => {
      return h('div', { style: { lineHeight: '1.4', padding: '4px 0' } }, [
        h('div', { style: { fontWeight: 600 } }, record.dimName || '-'),
        h('div', { style: { color: '#8c8c8c', fontSize: '12px' } }, record.description || ''),
      ]);
    },
  },
  { title: '权重(%)', dataIndex: 'weightPct', width: 90 },
  {
    title: '状态',
    dataIndex: 'dimStatus',
    width: 90,
    customRender: ({ text }) =>
      text === 'active'
        ? h(Tag, { color: 'success' }, () => '启用')
        : h(Tag, { color: 'default' }, () => '禁用'),
  },
  { title: '更新人', dataIndex: 'updateBy', width: 100 },
  { title: '更新时间', dataIndex: 'updateTime', width: 170 },
];
