import { BasicColumn } from '/@/components/Table';
import { h } from 'vue';
import { Tag } from 'ant-design-vue';

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

/** 对齐原型：改善部门 | 负责人姓名 | 负责人工号 | 职位 | 更新人 | 更新时间 */
export const deptLeaderColumns: BasicColumn[] = [
  {
    title: '改善部门',
    dataIndex: 'dept',
    width: 160,
    customRender: ({ record }) => record.dept?.departName || '-',
  },
  {
    title: '负责人姓名',
    dataIndex: 'leader',
    width: 120,
    customRender: ({ record }) => {
      if (!record.leaderUserId) {
        return h('span', { style: { color: '#999' } }, '未配置');
      }
      return record.leader?.realname || '-';
    },
  },
  {
    title: '负责人工号',
    dataIndex: 'leaderWorkNo',
    width: 120,
    customRender: ({ record }) => record.leader?.workNo || '-',
  },
  {
    title: '职位',
    dataIndex: 'leaderPosition',
    width: 140,
    customRender: ({ record }) => record.leader?.positionType || '-',
  },
  { title: '更新人', dataIndex: 'updateBy', width: 100 },
  { title: '更新时间', dataIndex: 'updateTime', width: 170 },
];

/** 对齐原型：成员姓名 | 工号 | 部门 | 职位 | 评分职责 | 更新人 | 更新时间 */
export const committeeColumns: BasicColumn[] = [
  {
    title: '成员姓名',
    dataIndex: 'realname',
    width: 110,
    customRender: ({ record }) => record.user?.realname || '-',
  },
  {
    title: '工号',
    dataIndex: 'workNo',
    width: 100,
    customRender: ({ record }) => record.user?.workNo || '-',
  },
  {
    title: '部门',
    dataIndex: 'userDeptName',
    width: 140,
    customRender: ({ record }) => record.user?.deptName || '-',
  },
  {
    title: '职位',
    dataIndex: 'positionType',
    width: 140,
    customRender: ({ record }) => record.user?.positionType || '-',
  },
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

/** 对齐原型：排序 | 性质编码 | 改善性质(名+说明) | 状态 | 更新人 | 更新时间 */
export const improvementTypeColumns: BasicColumn[] = [
  { title: '排序', dataIndex: 'sortNo', width: 70 },
  { title: '性质编码', dataIndex: 'typeCode', width: 120 },
  {
    title: '改善性质',
    dataIndex: 'typeName',
    align: 'left',
    customRender: ({ record }) => {
      return h('div', { style: { lineHeight: '1.4', padding: '4px 0' } }, [
        h('div', { style: { fontWeight: 600 } }, record.typeName || '-'),
        h('div', { style: { color: '#8c8c8c', fontSize: '12px' } }, record.description || ''),
      ]);
    },
  },
  {
    title: '状态',
    dataIndex: 'typeStatus',
    width: 90,
    customRender: ({ text }) =>
      text === 'active'
        ? h(Tag, { color: 'success' }, () => '启用')
        : h(Tag, { color: 'default' }, () => '禁用'),
  },
  { title: '更新人', dataIndex: 'updateBy', width: 100 },
  { title: '更新时间', dataIndex: 'updateTime', width: 170 },
];
