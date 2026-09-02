/**
 * 提案业务 API
 * 路径对齐后端 ProposalController / ProposalMetaController
 */
import { http } from '@/http/http'

/** 发起提案请求（对齐 ProposalCreateRequest） */
export interface ProposalCreatePayload {
  title: string
  /** 改善性质：JSON 数组字符串，如 ["SAFETY","QUALITY"] */
  improvementTypes: string
  deptId: string
  teamType?: string
  currentSituation: string
  improvementSuggestion: string
  attachments?: ProposalAttachmentPayload[]
}

export interface ProposalAttachmentPayload {
  fileName: string
  fileUrl: string
  fileSize?: number
}

export interface ImprovementDeptOption {
  deptId: string
  deptName: string
  leaderUserId?: string
  leaderName?: string
  leaderConfigured?: boolean
}

export interface StatusOption {
  code: string
  label: string
  terminal?: boolean
}

export interface ProposalListQuery {
  /** all | mine | doing | done */
  tab?: string
  title?: string
  pageNo?: number
  pageSize?: number
}

export interface ProposalUserBrief {
  id?: string
  realname?: string
  workNo?: string
  username?: string
  deptName?: string
}

export interface ProposalDeptBrief {
  id?: string
  departName?: string
  orgCode?: string
}

export interface ProposalListItem {
  id: string
  proposalNo?: string
  title?: string
  status?: string
  statusLabel?: string
  improvementTypes?: string
  improvementTypesLabel?: string
  deptId?: string
  deptLeaderId?: string
  proposerId?: string
  dept?: ProposalDeptBrief
  proposer?: ProposalUserBrief
  reviewProgress?: string
  /** 委员采用人数（列表汇总，不落库） */
  adoptCount?: number
  /** 委员不采用人数 */
  rejectCount?: number
  /** 委员采用票多数建议是否形成计划书 0/1 */
  planRequiredSuggest?: number
  /** 委员采用票奖励建议众数 */
  awardSuggestAmount?: number
  scoreProgress?: string
  scoreTotal?: number
  scoreGrade?: string
  planRequired?: number
  awardAmount?: number
  createTime?: string
  updateTime?: string
  [key: string]: any
}

export interface ProposalPageResult {
  records: ProposalListItem[]
  total: number
  current?: number
  size?: number
  pages?: number
}

export interface ProposalApplication {
  id?: string
  proposalId?: string
  currentSituation?: string
  improvementSuggestion?: string
  submitTime?: string
  [key: string]: any
}

export interface ProposalAttachment {
  id?: string
  proposalId?: string
  fileName?: string
  fileUrl?: string
  fileSize?: number
  sortNo?: number
  [key: string]: any
}

export interface ProposalDetailResult {
  proposal: ProposalListItem
  application?: ProposalApplication
  attachments?: ProposalAttachment[]
  committeeReviews?: CommitteeReviewItem[]
  applicationApproval?: ApplicationApprovalResult
}

export interface CommitteeReviewItem {
  id?: string
  proposalId?: string
  reviewerId?: string
  conclusion?: string | null
  planRequired?: number | null
  awardSuggestion?: number | null
  comment?: string | null
  reviewTime?: string | null
  [key: string]: any
}

export interface ApplicationApprovalResult {
  id?: string
  proposalId?: string
  approverId?: string
  stage?: string
  decision?: string
  planRequired?: number | null
  awardAmount?: number | null
  comment?: string | null
  approveTime?: string | null
  [key: string]: any
}

/** ---------- 元数据 ---------- */

export interface ImprovementTypeOption {
  code: string
  label: string
  typeStatus?: string
  sortNo?: number
  description?: string
}

export function fetchImprovementDepts() {
  return http.get<ImprovementDeptOption[]>('/proposal/meta/improvementDepts')
}

export function fetchProposalStatuses() {
  return http.get<StatusOption[]>('/proposal/meta/statuses')
}

export function fetchImprovementTypes(enabledOnly = true) {
  return http.get<ImprovementTypeOption[]>('/proposal/meta/improvementTypes', {
    enabledOnly: enabledOnly ? 'true' : 'false',
  })
}

/** ---------- 申请段：已实现 ---------- */

/** 发起提案（一次提交，进入审核中；无暂存） */
export function createProposal(data: ProposalCreatePayload) {
  return http.post<string>('/proposal/create', data)
}

export function fetchProposalList(query: ProposalListQuery = {}) {
  return http.get<ProposalPageResult>('/proposal/list', {
    tab: query.tab ?? 'mine',
    title: query.title,
    pageNo: query.pageNo ?? 1,
    pageSize: query.pageSize ?? 20,
  })
}

export function fetchProposalDetail(id: string) {
  return http.get<ProposalDetailResult>(`/proposal/${id}`)
}

/** ---------- Phase 2：委员审核 ---------- */

export interface CommitteeReviewPayload {
  conclusion: 'ADOPT' | 'REJECT'
  planRequired?: number
  awardSuggestion?: number | null
  comment?: string
}

export function fetchCommitteePending(query?: { pageNo?: number, pageSize?: number }) {
  return http.get<ProposalPageResult>('/proposal/review/committee/pending', {
    pageNo: query?.pageNo ?? 1,
    pageSize: query?.pageSize ?? 20,
  })
}

export function submitCommitteeReview(proposalId: string, data: CommitteeReviewPayload) {
  return http.post<string>(`/proposal/review/committee/${proposalId}`, data)
}

/** ---------- Phase 2：批准人申请决策 ---------- */

export interface ApplicationApprovalPayload {
  decision: 'APPROVE' | 'REJECT'
  planRequired?: number
  awardAmount?: number | null
  comment?: string
}

export function fetchApprovalPending(query?: { pageNo?: number, pageSize?: number }) {
  return http.get<ProposalPageResult>('/proposal/approval/pending', {
    pageNo: query?.pageNo ?? 1,
    pageSize: query?.pageSize ?? 20,
  })
}

export function submitApplicationApproval(proposalId: string, data: ApplicationApprovalPayload) {
  return http.post<string>(`/proposal/approval/application/${proposalId}`, data)
}

/** 小程序首页聚合 GET /proposal/app/home */
export interface AppHomeTodoItem {
  proposalId?: string
  proposalNo?: string
  title?: string
  status?: string
  statusLabel?: string
  actionHint?: string
  /** review=委员待审，approve=批准人待核定，assign=部门负责人待指派 */
  kind?: 'review' | 'approve' | 'assign' | string
}

export interface AppHomeFeedItem {
  proposalId?: string
  proposalNo?: string
  title?: string
  action?: string
  actionLabel?: string
  remark?: string
  time?: string
}

export interface AppHomeResult {
  greeting?: string
  userName?: string
  deptDesc?: string
  todoCount?: number
  doingCount?: number
  doneCount?: number
  todoItems?: AppHomeTodoItem[]
  feeds?: AppHomeFeedItem[]
  /** 未读动态数，铃铛角标 */
  unreadCount?: number
}

export function fetchAppHome() {
  return http.get<AppHomeResult>('/proposal/app/home')
}

/** 消息动态列表 GET /proposal/app/message/list */
export interface AppMessageItem {
  id?: string
  proposalId?: string
  proposalNo?: string
  title?: string
  action?: string
  actionLabel?: string
  remark?: string
  time?: string
  unread?: boolean
}

export interface AppMessagePage {
  records?: AppMessageItem[]
  total?: number
  current?: number
  size?: number
}

export function fetchAppMessages(params: {
  scope?: 'all' | 'unread'
  pageNo?: number
  pageSize?: number
}) {
  return http.get<AppMessagePage>('/proposal/app/message/list', params)
}

export function fetchAppUnreadCount() {
  return http.get<number>('/proposal/app/message/unreadCount')
}

export function markAppMessageRead(id: string) {
  return http.put<string>(`/proposal/app/message/${id}/read`)
}

export function markAppMessagesReadAll() {
  return http.put<number>('/proposal/app/message/readAll')
}
