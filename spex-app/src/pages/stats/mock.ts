export type StatsTab = 'overview' | 'me' | 'rank'
export type PeriodKey = 'year' | 'quarter' | 'month'
export type RankKey = 'submit' | 'adopt' | 'impl'

export interface MetricItem {
  key: string
  label: string
  value: string
  unit?: string
  accent?: boolean
  hint?: string
  hintTone?: 'ok' | 'sub'
}

export interface BarItem {
  label: string
  height: number
  hot?: boolean
}

export interface NatureItem {
  name: string
  value: number
  color: string
}

export interface DeptRankItem {
  name: string
  value: number
}

export interface RankRow {
  no: string
  name: string
  dept: string
  value: string
}

export interface OverviewData {
  metrics: MetricItem[]
  bars: BarItem[]
  natures: NatureItem[]
  depts: DeptRankItem[]
}

export const STATS_TABS: { key: StatsTab, label: string }[] = [
  { key: 'overview', label: '总览' },
  { key: 'me', label: '个人成绩' },
  { key: 'rank', label: '排行' },
]

export const PERIODS: { key: PeriodKey, label: string }[] = [
  { key: 'year', label: '本年' },
  { key: 'quarter', label: '本季' },
  { key: 'month', label: '本月' },
]

export const RANK_TABS: { key: RankKey, label: string }[] = [
  { key: 'submit', label: '提交排行' },
  { key: 'adopt', label: '被采用' },
  { key: 'impl', label: '改善实施' },
]

export const OVERVIEW: Record<PeriodKey, OverviewData> = {
  year: {
    metrics: [
      { key: 'total', label: '提案总数', value: '128', unit: '件', hint: '↑ 12% 同比', hintTone: 'ok' },
      { key: 'rate', label: '采用率', value: '76', unit: '%', accent: true, hint: '↑ 3.2pt', hintTone: 'ok' },
      { key: 'doing', label: '进行中', value: '18', unit: '件', hint: '待我处理 2', hintTone: 'sub' },
      { key: 'award', label: '累计提案奖', value: '3.2', unit: '万', hint: '节约 86 万', hintTone: 'sub' },
    ],
    bars: [
      { label: '1月', height: 38 },
      { label: '2月', height: 30 },
      { label: '3月', height: 52 },
      { label: '4月', height: 46 },
      { label: '5月', height: 64 },
      { label: '6月', height: 58 },
      { label: '7月', height: 72 },
      { label: '8月', height: 86, hot: true },
    ],
    natures: [
      { name: '效率改善', value: 55, color: '#1890FF' },
      { name: '品质改善', value: 32, color: '#36CFC9' },
      { name: '成本改善', value: 21, color: '#FFC53D' },
      { name: '安全 / 交付', value: 20, color: '#13C2C2' },
    ],
    depts: [
      { name: '生产一部', value: 36 },
      { name: '品质部', value: 27 },
      { name: '生产二部', value: 22 },
      { name: '仓储部', value: 17 },
      { name: '设备部', value: 14 },
    ],
  },
  quarter: {
    metrics: [
      { key: 'total', label: '提案总数', value: '42', unit: '件', hint: '↑ 8% 环比', hintTone: 'ok' },
      { key: 'rate', label: '采用率', value: '74', unit: '%', accent: true, hint: '↑ 1.1pt', hintTone: 'ok' },
      { key: 'doing', label: '进行中', value: '11', unit: '件', hint: '待我处理 2', hintTone: 'sub' },
      { key: 'award', label: '累计提案奖', value: '1.1', unit: '万', hint: '节约 24 万', hintTone: 'sub' },
    ],
    bars: [
      { label: '1月', height: 22 },
      { label: '2月', height: 18 },
      { label: '3月', height: 28 },
      { label: '4月', height: 26 },
      { label: '5月', height: 34 },
      { label: '6月', height: 40 },
      { label: '7月', height: 58 },
      { label: '8月', height: 76, hot: true },
    ],
    natures: [
      { name: '效率改善', value: 18, color: '#1890FF' },
      { name: '品质改善', value: 11, color: '#36CFC9' },
      { name: '成本改善', value: 7, color: '#FFC53D' },
      { name: '安全 / 交付', value: 6, color: '#13C2C2' },
    ],
    depts: [
      { name: '生产一部', value: 12 },
      { name: '品质部', value: 9 },
      { name: '生产二部', value: 8 },
      { name: '仓储部', value: 7 },
      { name: '设备部', value: 6 },
    ],
  },
  month: {
    metrics: [
      { key: 'total', label: '提案总数', value: '18', unit: '件', hint: '↑ 5% 环比', hintTone: 'ok' },
      { key: 'rate', label: '采用率', value: '72', unit: '%', accent: true, hint: '↑ 0.6pt', hintTone: 'ok' },
      { key: 'doing', label: '进行中', value: '6', unit: '件', hint: '待我处理 2', hintTone: 'sub' },
      { key: 'award', label: '累计提案奖', value: '0.4', unit: '万', hint: '节约 8 万', hintTone: 'sub' },
    ],
    bars: [
      { label: '1月', height: 16 },
      { label: '2月', height: 14 },
      { label: '3月', height: 20 },
      { label: '4月', height: 18 },
      { label: '5月', height: 24 },
      { label: '6月', height: 22 },
      { label: '7月', height: 30 },
      { label: '8月', height: 68, hot: true },
    ],
    natures: [
      { name: '效率改善', value: 8, color: '#1890FF' },
      { name: '品质改善', value: 4, color: '#36CFC9' },
      { name: '成本改善', value: 3, color: '#FFC53D' },
      { name: '安全 / 交付', value: 3, color: '#13C2C2' },
    ],
    depts: [
      { name: '生产一部', value: 6 },
      { name: '品质部', value: 4 },
      { name: '生产二部', value: 3 },
      { name: '仓储部', value: 3 },
      { name: '设备部', value: 2 },
    ],
  },
}

export const MY_METRICS: MetricItem[] = [
  { key: 'submit', label: '提交数', value: '6' },
  { key: 'adopt', label: '采用数', value: '4', accent: true },
  { key: 'rate', label: '采用率', value: '67', unit: '%' },
  { key: 'impl', label: '参与实施', value: '3' },
  { key: 'score', label: '累计得分', value: '86.5' },
  { key: 'award', label: '提案奖', value: '¥900' },
]

export const RANK_DATA: Record<RankKey, RankRow[]> = {
  submit: [
    { no: '1', name: '李静', dept: '品质部', value: '12' },
    { no: '2', name: '张伟', dept: '生产一部', value: '6' },
    { no: '3', name: '陈晨', dept: '生产二部', value: '5' },
    { no: '4', name: '刘洋', dept: '品质部', value: '5' },
    { no: '5', name: '周敏', dept: '仓储部', value: '4' },
  ],
  adopt: [
    { no: '1', name: '李静', dept: '品质部', value: '9' },
    { no: '2', name: '张伟', dept: '生产一部', value: '4' },
    { no: '3', name: '周敏', dept: '仓储部', value: '3' },
    { no: '4', name: '陈晨', dept: '生产二部', value: '3' },
    { no: '5', name: '郑浩', dept: '设备部', value: '2' },
  ],
  impl: [
    { no: '1', name: '张伟', dept: '生产一部', value: '3' },
    { no: '2', name: '马超', dept: '生产一部', value: '3' },
    { no: '3', name: '吴刚', dept: '仓储部', value: '2' },
    { no: '4', name: '陈晨', dept: '生产二部', value: '2' },
    { no: '5', name: '刘洋', dept: '品质部', value: '1' },
  ],
}
