import { BasicColumn, FormSchema } from '/@/components/Table';

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

const ynOptions = [
  { label: '否', value: 0 },
  { label: '是', value: 1 },
];

export const deptLeaderColumns: BasicColumn[] = [
  { title: '改善部门ID', dataIndex: 'deptId', width: 200 },
  { title: '负责人用户ID', dataIndex: 'leaderUserId', width: 200 },
  { title: '备注', dataIndex: 'remark' },
  { title: '更新时间', dataIndex: 'updateTime', width: 170 },
];

export const deptLeaderFormSchema: FormSchema[] = [
  { field: 'id', component: 'Input', show: false },
  {
    field: 'deptId',
    label: '改善部门',
    component: 'JSelectDept',
    required: true,
    componentProps: {
      sync: false,
      checkStrictly: true,
      showButton: true,
      modalTitle: '选择改善部门',
    },
  },
  {
    field: 'leaderUserId',
    label: '部门负责人',
    component: 'JSelectUser',
    componentProps: {
      rowKey: 'id',
      labelKey: 'realname',
      showButton: true,
      modalTitle: '选择部门负责人',
      isRadioSelection: true,
    },
  },
  { field: 'remark', label: '备注', component: 'InputTextArea', componentProps: { rows: 2 } },
];

export const committeeColumns: BasicColumn[] = [
  { title: '委员用户ID', dataIndex: 'userId', width: 200 },
  {
    title: '参与评分',
    dataIndex: 'scoreEnabled',
    width: 100,
    customRender: ({ text }) => (text === 1 ? '是' : '否'),
  },
  { title: '评分席位', dataIndex: 'seatNo', width: 90 },
  {
    title: '在任状态',
    dataIndex: 'memberStatus',
    width: 100,
    customRender: ({ text }) => (text === 'active' ? '在任' : '离任'),
  },
  { title: '排序', dataIndex: 'sortNo', width: 80 },
  { title: '备注', dataIndex: 'remark' },
];

export const committeeFormSchema: FormSchema[] = [
  { field: 'id', component: 'Input', show: false },
  {
    field: 'userId',
    label: '委员',
    component: 'JSelectUser',
    required: true,
    componentProps: {
      rowKey: 'id',
      labelKey: 'realname',
      showButton: true,
      modalTitle: '选择委员',
      isRadioSelection: true,
    },
  },
  {
    field: 'scoreEnabled',
    label: '参与评分',
    component: 'RadioButtonGroup',
    defaultValue: 1,
    componentProps: { options: ynOptions },
  },
  {
    field: 'seatNo',
    label: '评分席位号',
    component: 'InputNumber',
    componentProps: { min: 1, max: 99 },
  },
  {
    field: 'memberStatus',
    label: '在任状态',
    component: 'Select',
    defaultValue: 'active',
    componentProps: { options: memberStatusOptions },
  },
  {
    field: 'sortNo',
    label: '排序',
    component: 'InputNumber',
    defaultValue: 0,
    componentProps: { min: 0 },
  },
  { field: 'remark', label: '备注', component: 'InputTextArea', componentProps: { rows: 2 } },
];

export const approverColumns: BasicColumn[] = [
  { title: '批准人用户ID', dataIndex: 'userId', width: 200 },
  {
    title: '状态',
    dataIndex: 'approverStatus',
    width: 100,
    customRender: ({ text }) => (text === 'active' ? '启用' : '停用'),
  },
  { title: '备注', dataIndex: 'remark' },
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
    componentProps: { options: approverStatusOptions },
  },
  { field: 'remark', label: '备注', component: 'InputTextArea', componentProps: { rows: 2 } },
];

export const scoreDimensionColumns: BasicColumn[] = [
  { title: '维度编码', dataIndex: 'dimCode', width: 120 },
  { title: '维度名称', dataIndex: 'dimName', width: 120 },
  { title: '说明', dataIndex: 'description', align: 'left' },
  { title: '权重(%)', dataIndex: 'weightPct', width: 90 },
  { title: '排序', dataIndex: 'sortNo', width: 80 },
  {
    title: '状态',
    dataIndex: 'dimStatus',
    width: 90,
    customRender: ({ text }) => (text === 'active' ? '启用' : '禁用'),
  },
];

export const scoreDimensionFormSchema: FormSchema[] = [
  { field: 'id', component: 'Input', show: false },
  {
    field: 'dimCode',
    label: '维度编码',
    component: 'Input',
    required: true,
    dynamicDisabled: ({ values }) => !!values.id,
  },
  { field: 'dimName', label: '维度名称', component: 'Input', required: true },
  { field: 'description', label: '说明', component: 'InputTextArea', componentProps: { rows: 2 } },
  {
    field: 'weightPct',
    label: '权重(%)',
    component: 'InputNumber',
    required: true,
    componentProps: { min: 0, max: 100 },
  },
  {
    field: 'sortNo',
    label: '排序',
    component: 'InputNumber',
    defaultValue: 0,
    componentProps: { min: 0 },
  },
  {
    field: 'dimStatus',
    label: '状态',
    component: 'Select',
    defaultValue: 'active',
    componentProps: { options: dimStatusOptions },
  },
  { field: 'remark', label: '备注', component: 'InputTextArea', componentProps: { rows: 2 } },
];
