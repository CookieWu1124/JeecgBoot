export type StampTone = 'amber' | 'blue' | 'teal' | 'purple' | 'green' | 'gray'
export type BandTone = 'amber' | 'teal' | 'purple'

export interface ReviewTodo {
  no: string
  title: string
  dept: string
  who: string
  char: string
  tint: 'blue' | 'teal'
  status: string
  stamp: StampTone
}

export interface VoteTag {
  label: string
  tone: StampTone
}

export interface ApproveTodo {
  no: string
  title: string
  sub: string
  status: string
  stamp: StampTone
  band: BandTone
  votes: VoteTag[]
  hint?: string
  footer?: string
}

export const BAND: Record<BandTone, string> = {
  amber: '#D98F0E',
  teal: '#13C2C2',
  purple: '#2F54EB',
}

export const REVIEW_TODOS: ReviewTodo[] = [
  {
    no: '202608240001',
    title: '产线换模时间过长改善',
    dept: '生产一部',
    who: '张伟',
    char: '审',
    tint: 'blue',
    status: '待审核',
    stamp: 'blue',
  },
  {
    no: '202608240004',
    title: '车间周转器具定量管理',
    dept: '生产二部',
    who: '陈晨',
    char: '审',
    tint: 'blue',
    status: '待审核',
    stamp: 'blue',
  },
]

export const APPROVE_TODOS: ApproveTodo[] = [
  {
    no: '202608230008',
    title: '车间物料标识标准化',
    sub: 'NO. 202608230008 · 品质部 · 刘洋',
    status: '待批准',
    stamp: 'amber',
    band: 'amber',
    votes: [
      { label: '采用 4', tone: 'green' },
      { label: '不采用 1', tone: 'gray' },
    ],
    footer: '委员会 5/5 · 建议形成计划书 · 奖励 ¥200',
  },
  {
    no: '202608240001',
    title: '产线换模时间过长改善',
    sub: 'NO. 202608240001 · 第 2 轮 · 张伟',
    status: '计划书待批',
    stamp: 'amber',
    band: 'teal',
    votes: [
      { label: '可行 4', tone: 'green' },
      { label: '不可行 1', tone: 'gray' },
    ],
    hint: '委员会 5/5',
  },
  {
    no: '202608180005',
    title: '仓库照明节能改造',
    sub: 'NO. 202608180005 · 仓储部 · 周敏',
    status: '待签核',
    stamp: 'purple',
    band: 'purple',
    votes: [],
    footer: '评分完成 · 86.5 · 等级 A',
  },
]
