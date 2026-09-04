import { BasicColumn, FormSchema } from '/@/components/Table';
import { h } from 'vue';
import { Progress, Tag } from 'ant-design-vue';
import { defHttp } from '/@/utils/http/axios';

/** 状态色仅前端展示用；文案以接口 /proposal/meta/statuses 及行内 statusLabel 为准 */
const STATUS_TAG_COLOR: Record<string, string> = {
  PENDING_REVIEW: 'gold',
  PENDING_APPROVAL: 'blue',
  APPROVED: 'success',
  REJECTED_FINAL: 'error',
  PENDING_ASSIGN: 'processing',
  PENDING_CLAIM: 'processing',
  IN_PROGRESS: 'processing',
  PLAN_PENDING_REVIEW: 'orange',
  PLAN_PENDING_APPROVAL: 'orange',
  PLAN_REJECTED: 'error',
  PENDING_EVALUATION: 'cyan',
  PENDING_SIGNOFF: 'cyan',
  COMPLETED: 'success',
};

export function fetchProposalStatusOptions() {
  return defHttp.get({ url: '/proposal/meta/statuses' });
}

export function fetchProposalImprovementTypeOptions() {
  return defHttp.get({ url: '/proposal/meta/improvementTypes' }).then((list) => {
    const rows = Array.isArray(list) ? list : [];
    rows.forEach((o) => {
      if (o?.code) {
        improvementTypeMap[o.code] = o.label || o.code;
      }
    });
    return rows;
  });
}

let improvementTypeMap: Record<string, string> = {};

function parseImprovementTypes(raw: unknown): string[] {
  if (raw == null || raw === '') {
    return [];
  }
  if (Array.isArray(raw)) {
    return raw.map(String);
  }
  const text = String(raw).trim();
  if (!text) {
    return [];
  }
  try {
    const parsed = JSON.parse(text);
    if (Array.isArray(parsed)) {
      return parsed.map(String);
    }
  } catch {
    // 兼容逗号串
  }
  return text
    .replace(/^\[|\]$/g, '')
    .split(/[,，/|]/)
    .map((s) => s.replace(/["'\s]/g, ''))
    .filter(Boolean);
}

function formatImprovementTypes(raw: unknown): string {
  const codes = parseImprovementTypes(raw);
  if (!codes.length) {
    return '-';
  }
  return codes.map((c) => improvementTypeMap[c] || c).join(' / ');
}

function formatAward(amount: unknown): string {
  if (amount == null || amount === '') {
    return '-';
  }
  const num = Number(amount);
  if (Number.isNaN(num)) {
    return String(amount);
  }
  return `¥${num}`;
}

function renderReviewProgress(text: unknown) {
  const raw = text == null || text === '' ? '' : String(text).trim();
  if (!raw || raw === '-') {
    return '-';
  }
  const match = raw.match(/^(\d+)\s*\/\s*(\d+)$/);
  if (!match) {
    return raw;
  }
  const done = Number(match[1]);
  const total = Number(match[2]);
  const percent = total > 0 ? Math.min(100, Math.round((done / total) * 100)) : 0;
  const strokeColor = percent >= 100 ? '#52c41a' : '#1677ff';
  return h('div', { class: 'proposal-review-progress' }, [
    h(Progress, {
      percent,
      size: 'small',
      showInfo: false,
      strokeColor,
      style: { width: '72px', margin: 0 },
    }),
    h('span', { class: 'proposal-review-progress__text' }, raw),
  ]);
}

function renderStatusTag(status: unknown, statusLabel?: unknown) {
  const code = String(status || '');
  const label = statusLabel ? String(statusLabel) : code || '-';
  if (!code) {
    return '-';
  }
  return h(Tag, { color: STATUS_TAG_COLOR[code] || 'default' }, () => label);
}

/** 对齐原型：序号 | 提案编号 | 提案名称 | 提案人 | 改善部门 | 改善性质 | 当前环节 | 审核进度 | 核定提案奖 | 提交时间 | 操作 */
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
    minWidth: 160,
  },
  {
    title: '提案人',
    dataIndex: 'proposer',
    width: 100,
    customRender: ({ record }) => record.proposer?.realname || '-',
  },
  {
    title: '改善部门',
    dataIndex: 'dept',
    width: 120,
    customRender: ({ record }) => record.dept?.departName || '-',
  },
  {
    title: '改善性质',
    dataIndex: 'improvementTypes',
    width: 160,
    align: 'left',
    customRender: ({ text, record }) => record?.improvementTypesLabel || formatImprovementTypes(text),
  },
  {
    title: '当前环节',
    dataIndex: 'status',
    width: 110,
    customRender: ({ text, record }) => renderStatusTag(text, record?.statusLabel),
  },
  {
    title: '审核进度',
    dataIndex: 'reviewProgress',
    width: 140,
    customRender: ({ text }) => renderReviewProgress(text),
  },
  {
    title: '核定提案奖',
    dataIndex: 'awardAmount',
    width: 110,
    customRender: ({ text }) => formatAward(text),
  },
  {
    title: '提交时间',
    dataIndex: 'createTime',
    width: 170,
  },
];

/** 对齐原型筛选：提案编号 / 名称 / 当前环节 / 改善部门 / 改善性质 / 提案人 / 提交日期 */
export const searchFormSchema: FormSchema[] = [
  {
    field: 'proposalNo',
    label: '提案编号',
    component: 'Input',
    componentProps: { placeholder: '请输入' },
    colProps: { span: 4 },
  },
  {
    field: 'title',
    label: '提案名称',
    component: 'Input',
    componentProps: { placeholder: '请输入' },
    colProps: { span: 4 },
  },
  {
    field: 'status',
    label: '当前环节',
    component: 'ApiSelect',
    componentProps: {
      api: fetchProposalStatusOptions,
      labelField: 'label',
      valueField: 'code',
      placeholder: '请选择',
      allowClear: true,
    },
    colProps: { span: 4 },
  },
  {
    field: 'deptName',
    label: '改善部门',
    component: 'Input',
    componentProps: { placeholder: '请输入' },
    colProps: { span: 4 },
  },
  {
    field: 'improvementTypes',
    label: '改善性质',
    component: 'ApiSelect',
    componentProps: {
      api: fetchProposalImprovementTypeOptions,
      labelField: 'label',
      valueField: 'code',
      placeholder: '请选择',
      allowClear: true,
    },
    colProps: { span: 4 },
  },
  {
    field: 'proposerName',
    label: '提案人',
    component: 'Input',
    componentProps: { placeholder: '请输入' },
    colProps: { span: 4 },
  },
  {
    field: 'createTime',
    label: '提交日期',
    component: 'RangePicker',
    componentProps: {
      valueType: 'Date',
      placeholder: ['开始日期', '结束日期'],
      style: { width: '100%' },
    },
    // 占两列，与上方「提案编号 + 提案名称」左边缘对齐
    colProps: { span: 8 },
  },
];

export { formatImprovementTypes, formatAward, STATUS_TAG_COLOR };
