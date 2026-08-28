import { BasicColumn, FormSchema } from '/@/components/Table';

/** 提案状态（与 proposal_init.sql 注释一致） */
export const proposalStatusOptions = [
  { label: '草稿', value: 'DRAFT' },
  { label: '待委员审核', value: 'PENDING_REVIEW' },
  { label: '待批准', value: 'PENDING_APPROVAL' },
  { label: '终审驳回', value: 'REJECTED_FINAL' },
  { label: '已撤回', value: 'WITHDRAWN' },
  { label: '待指派', value: 'PENDING_ASSIGN' },
  { label: '待认领', value: 'PENDING_CLAIM' },
  { label: '实施中', value: 'IN_PROGRESS' },
  { label: '计划书待审核', value: 'PLAN_PENDING_REVIEW' },
  { label: '计划书待批准', value: 'PLAN_PENDING_APPROVAL' },
  { label: '计划书驳回', value: 'PLAN_REJECTED' },
  { label: '待评分', value: 'PENDING_EVALUATION' },
  { label: '待签核', value: 'PENDING_SIGNOFF' },
  { label: '已结案', value: 'COMPLETED' },
];

const statusMap = Object.fromEntries(proposalStatusOptions.map((o) => [o.value, o.label]));

export const columns: BasicColumn[] = [
  {
    title: '提案编号',
    dataIndex: 'proposalNo',
    width: 140,
  },
  {
    title: '提案名称',
    dataIndex: 'title',
    align: 'left',
  },
  {
    title: '状态',
    dataIndex: 'status',
    width: 120,
    customRender: ({ text }) => statusMap[text] || text,
  },
  {
    title: '改善部门ID',
    dataIndex: 'deptId',
    width: 120,
  },
  {
    title: '提案人ID',
    dataIndex: 'proposerId',
    width: 120,
  },
  {
    title: '创建时间',
    dataIndex: 'createTime',
    width: 170,
  },
];

export const searchFormSchema: FormSchema[] = [
  {
    field: 'proposalNo',
    label: '提案编号',
    component: 'Input',
    colProps: { span: 6 },
  },
  {
    field: 'title',
    label: '提案名称',
    component: 'Input',
    colProps: { span: 6 },
  },
  {
    field: 'status',
    label: '状态',
    component: 'Select',
    componentProps: {
      options: proposalStatusOptions,
      allowClear: true,
    },
    colProps: { span: 6 },
  },
];

export const formSchema: FormSchema[] = [
  {
    field: 'id',
    label: '主键',
    component: 'Input',
    show: false,
  },
  {
    field: 'title',
    label: '提案名称',
    component: 'Input',
    required: true,
    componentProps: { maxlength: 100 },
  },
  {
    field: 'status',
    label: '状态',
    component: 'Select',
    defaultValue: 'DRAFT',
    componentProps: {
      options: proposalStatusOptions,
    },
  },
  {
    field: 'deptId',
    label: '改善部门',
    component: 'JSelectDept',
    componentProps: {
      sync: false,
      checkStrictly: true,
      showButton: true,
      modalTitle: '选择改善部门',
    },
  },
  {
    field: 'proposerId',
    label: '提案人',
    component: 'JSelectUser',
    required: true,
    componentProps: {
      rowKey: 'id',
      labelKey: 'realname',
      showButton: true,
      modalTitle: '选择提案人',
      isRadioSelection: true,
    },
  },
  {
    field: 'deptLeaderId',
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
  {
    field: 'implementLeaderId',
    label: '实施负责人',
    component: 'JSelectUser',
    componentProps: {
      rowKey: 'id',
      labelKey: 'realname',
      showButton: true,
      modalTitle: '选择实施负责人',
      isRadioSelection: true,
    },
  },
  {
    field: 'teamType',
    label: '团队类型',
    component: 'Select',
    componentProps: {
      options: [
        { label: '个人', value: 'PERSONAL' },
        { label: '团队', value: 'TEAM' },
      ],
      allowClear: true,
    },
  },
  {
    field: 'planRequired',
    label: '需计划书',
    component: 'RadioButtonGroup',
    defaultValue: 0,
    componentProps: {
      options: [
        { label: '否', value: 0 },
        { label: '是', value: 1 },
      ],
    },
  },
  {
    field: 'improvementTypes',
    label: '改善性质',
    component: 'InputTextArea',
    componentProps: {
      rows: 2,
      placeholder: 'JSON 数组，如 ["SAFETY","QUALITY"]',
    },
  },
  {
    field: 'remark',
    label: '备注',
    component: 'InputTextArea',
    componentProps: { rows: 2 },
  },
];
