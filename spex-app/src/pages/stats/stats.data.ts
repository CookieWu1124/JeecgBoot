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

const EMPTY_OVERVIEW: OverviewData = {
  metrics: [],
  bars: [],
  natures: [],
  depts: [],
}

/** 统计接口尚未对接，保持空数据，避免原型数字干扰联调。 */
export const OVERVIEW: Record<PeriodKey, OverviewData> = {
  year: EMPTY_OVERVIEW,
  quarter: EMPTY_OVERVIEW,
  month: EMPTY_OVERVIEW,
}

export const MY_METRICS: MetricItem[] = []

export const RANK_DATA: Record<RankKey, RankRow[]> = {
  submit: [],
  adopt: [],
  impl: [],
}
