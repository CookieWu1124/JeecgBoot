export type FilterTab = 'all' | 'submit' | 'join' | 'improve'
export type StampTone = 'amber' | 'blue' | 'teal' | 'purple' | 'green' | 'red' | 'gray'

export interface ProposalItem {
  no: string
  title: string
  dept: string
  who: string
  nature: string[]
  status: string
  stamp: StampTone
  prog?: string
  score?: string
  tabs: FilterTab[]
  stage: number
  pdate: string
}

export interface DetailRow {
  lab: string
  val: string
  kind?: 'text' | 'pics'
  images?: string[]
}

export interface DetailView {
  item: ProposalItem
  status: string
  nature: string
  rows: DetailRow[]
}

const DEPT_LEADER: Record<string, string> = {
  生产一部: '赵强',
  生产二部: '赵强',
  品质部: '赵强',
  仓储部: '周敏',
  设备部: '郑浩',
  综合部: '—',
}

const SITE_PICS = [
  '/static/proposal/site-1.jpg',
  '/static/proposal/site-2.jpg',
  '/static/proposal/site-3.jpg',
  '/static/proposal/site-4.jpg',
]

function sitePics(count: number, offset = 0) {
  return Array.from({ length: count }, (_, i) => SITE_PICS[(i + offset) % SITE_PICS.length])
}

const APPLY_DETAIL: Record<string, DetailRow[]> = {
  '202608230008': [
    { lab: '提案名称', val: '车间物料标识标准化' },
    { lab: '改善性质', val: '品质改善' },
    { lab: '改善部门', val: '品质部（负责人：赵强）' },
    { lab: '目前状况', val: '车间物料标识不统一，错料、混料风险高，新员工辨识成本大。' },
    { lab: '改善意见', val: '统一色标与编码规则，同步修订检验指导书，旧标识设过渡期。' },
    { lab: '现场图片', val: '现状照片 ×2', kind: 'pics', images: sitePics(2, 3) },
    { lab: '提交时间', val: '2026-08-23 09:40' },
  ],
  '202608240001': [
    { lab: '提案名称', val: '产线换模时间过长改善' },
    { lab: '改善性质', val: '效率改善' },
    { lab: '改善部门', val: '生产一部（负责人：赵强）' },
    { lab: '目前状况', val: '目前注塑车间换模平均耗时 45 分钟，超出行业标准约 40%，月均换模 60 次，占用有效产能约 45 小时。' },
    { lab: '改善意见', val: '推行 SMED 快速换模法，将内部作业转换为外部作业，预置标准化模具小车与快换夹具。' },
    { lab: '现场图片', val: '现状照片 ×2', kind: 'pics', images: sitePics(2) },
    { lab: '提交时间', val: '2026-08-24 09:15' },
  ],
  '202608240004': [
    { lab: '提案名称', val: '车间周转器具定量管理' },
    { lab: '改善性质', val: '交付改善' },
    { lab: '改善部门', val: '生产二部（负责人：赵强）' },
    { lab: '目前状况', val: '周转箱混放、数量不清，换线时常找箱耽误节拍，在制品堆放占用通道。' },
    { lab: '改善意见', val: '按产线定量、定置、定容，色标分区并建立台账，减少找箱与混料。' },
    { lab: '现场图片', val: '现状照片 ×2', kind: 'pics', images: sitePics(2, 1) },
    { lab: '提交时间', val: '2026-08-24 10:20' },
  ],
  '202608180005': [
    { lab: '提案名称', val: '仓库照明节能改造' },
    { lab: '改善性质', val: '成本改善' },
    { lab: '改善部门', val: '仓储部（负责人：周敏）' },
    { lab: '目前状况', val: '仓库传统金卤灯 288 盏，单盏 400W，日均照明 14 小时，电费高且照度不足。' },
    { lab: '改善意见', val: '分两批更换 LED 灯 288 盏，总投入约 ¥86,400，预期年节电约 10.2 万度。' },
    { lab: '现场图片', val: '现状照片 ×2', kind: 'pics', images: sitePics(2, 2) },
    { lab: '提交时间', val: '2026-08-18 09:12' },
  ],
  '202608120003': [
    { lab: '提案名称', val: '安全通道划线规范' },
    { lab: '改善性质', val: '安全改善' },
    { lab: '改善部门', val: '设备部（负责人：郑浩）' },
    { lab: '目前状况', val: '通道划线磨损严重，叉车与行人混行存在安全隐患。' },
    { lab: '改善意见', val: '统一黄色警示线 + 地面箭头，并在交叉口增设反光标识。' },
    { lab: '现场图片', val: '现场照片 ×3', kind: 'pics', images: sitePics(3, 1) },
    { lab: '提交时间', val: '2026-08-12 10:20' },
  ],
}

export const MOCK_LIST: ProposalItem[] = [
  { no: '202608240001', title: '产线换模时间过长改善', dept: '生产一部', who: '张伟', nature: ['效率改善'], status: '计划书待批', stamp: 'amber', prog: '5/5', tabs: ['submit', 'join'], stage: 5, pdate: '08-24' },
  { no: '202608240004', title: '车间周转器具定量管理', dept: '生产二部', who: '陈晨', nature: ['交付改善'], status: '待审核', stamp: 'blue', prog: '1/5', tabs: ['join'], stage: 1, pdate: '08-24' },
  { no: '202608230008', title: '车间物料标识标准化', dept: '品质部', who: '刘洋', nature: ['品质改善'], status: '待批准', stamp: 'amber', prog: '5/5', tabs: ['join'], stage: 2, pdate: '08-23' },
  { no: '202608220012', title: '包装线人效提升方案', dept: '生产二部', who: '王鑫', nature: ['效率改善'], status: '待领取', stamp: 'amber', tabs: ['improve'], stage: 3, pdate: '08-22' },
  { no: '202608210009', title: '注塑机模温机点检标准化', dept: '生产一部', who: '马超', nature: ['安全改善'], status: '计划书待审', stamp: 'teal', prog: '2/5', tabs: ['join'], stage: 5, pdate: '08-21' },
  { no: '202608180005', title: '仓库照明节能改造', dept: '仓储部', who: '周敏', nature: ['成本改善'], status: '待评定', stamp: 'purple', prog: '3/4', tabs: ['join', 'improve'], stage: 8, pdate: '08-18' },
  { no: '202608120003', title: '安全通道划线规范', dept: '设备部', who: '郑浩', nature: ['安全改善'], status: '已完成', stamp: 'green', prog: '4/4', score: '86.5 · A', tabs: ['improve'], stage: 9, pdate: '08-12' },
  { no: '202608100002', title: '办公耗材领用流程优化', dept: '综合部', who: '孙悦', nature: ['成本改善'], status: '已驳回', stamp: 'red', prog: '第1轮', tabs: ['submit'], stage: 4, pdate: '08-10' },
  { no: '202608060001', title: '产线噪声超标治理', dept: '设备部', who: '李强', nature: ['安全改善'], status: '不批准', stamp: 'gray', tabs: ['submit'], stage: 2, pdate: '08-06' },
]

export function findProposal(no?: string) {
  return MOCK_LIST.find(item => item.no === no) || MOCK_LIST[0]
}

export interface CommitteeOpinion {
  name: string
  adopt: boolean
  plan?: boolean
  comment: string
  reward?: number
}

export const COMMITTEE_OPINIONS: Record<string, CommitteeOpinion[]> = {
  '202608230008': [
    { name: '李静', adopt: true, plan: true, comment: '标识标准化可显著降低错料风险，建议同步修订检验指导书。', reward: 200 },
    { name: '孙磊', adopt: true, plan: true, comment: '投入小见效快，同意。', reward: 200 },
    { name: '吴芳', adopt: false, comment: '现有标识体系已运行两年，建议先评估再推广。' },
    { name: '郑军', adopt: true, plan: true, comment: '同意，注意旧标识的过渡期管理。', reward: 200 },
    { name: '何丽', adopt: true, plan: true, comment: '可行。', reward: 200 },
  ],
}

export function getCommitteeOpinions(no?: string) {
  return COMMITTEE_OPINIONS[no || ''] || []
}

export function buildDetailView(no?: string): DetailView {
  const item = findProposal(no)
  const nature = item.nature[0] || '改善'
  return {
    item,
    status: item.status,
    nature,
    rows: APPLY_DETAIL[item.no] || [
      { lab: '提案名称', val: item.title },
      { lab: '改善性质', val: nature },
      { lab: '改善部门', val: `${item.dept}（负责人：${DEPT_LEADER[item.dept] || '赵强'}）` },
      { lab: '目前状况', val: '现场存在可改善点，影响效率 / 成本 / 品质，详见申请表描述。' },
      { lab: '改善意见', val: '通过标准化 / 工装 / 流程优化等手段降低浪费，预期可量化收益。' },
      { lab: '现场图片', val: '现状照片 ×2', kind: 'pics', images: sitePics(2) },
      { lab: '提交时间', val: `2026-${item.pdate} 09:15` },
    ],
  }
}
