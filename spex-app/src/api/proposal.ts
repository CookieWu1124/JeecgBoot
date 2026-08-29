/**
 * 提案业务 API（骨架）
 *
 * 当前页面仍使用 mock；待确认迁入无误后，再替换各页 mock 调用。
 * 路径对齐后端：`ProposalController` / Phase 2 规划接口。
 */
import { http } from '@/http/http'

/** 创建/更新草稿请求（对齐 ProposalCreateRequest） */
export interface ProposalCreatePayload {
  title: string
  /** 改善性质，多选用逗号拼接或后端约定格式 */
  improvementTypes: string
  deptId: string
  teamType?: string
  currentSituation: string
  improvementSuggestion: string
  email?: string
  attachments?: ProposalAttachmentPayload[]
}

export interface ProposalAttachmentPayload {
  fileName: string
  fileUrl: string
  fileSize?: number
}

export interface ProposalListQuery {
  /** mine | all | ... 以后端为准 */
  tab?: string
  title?: string
  pageNo?: number
  pageSize?: number
}

/** 列表项（字段以后端 Proposal 实体为准，前端可再映射） */
export interface ProposalListItem {
  id: string
  proposalNo?: string
  title?: string
  status?: string
  improvementTypes?: string
  deptId?: string
  proposerId?: string
  reviewProgress?: string
  scoreProgress?: string
  scoreTotal?: number
  scoreGrade?: string
  planRequired?: number
  awardAmount?: number
  createTime?: string
  [key: string]: any
}

export interface ProposalPageResult {
  records: ProposalListItem[]
  total: number
  current?: number
  size?: number
  pages?: number
}

export interface ProposalDetailResult {
  proposal: ProposalListItem
  application?: Record<string, any>
  attachments?: Array<Record<string, any>>
}

/** ---------- Phase 1：已实现 ---------- */

export function createProposal(data: ProposalCreatePayload) {
  return http.post<string>('/proposal/create', data)
}

export function updateProposalDraft(id: string, data: ProposalCreatePayload) {
  return http.put<string>(`/proposal/${id}/draft`, data)
}

export function submitProposal(id: string) {
  return http.put<string>(`/proposal/${id}/submit`)
}

export function withdrawProposal(id: string) {
  return http.post<string>(`/proposal/${id}/withdraw`)
}

export function fetchProposalList(query: ProposalListQuery = {}) {
  return http.get<ProposalPageResult>('/proposal/list', {
    tab: query.tab ?? 'mine',
    title: query.title,
    pageNo: query.pageNo ?? 1,
    pageSize: query.pageSize ?? 10,
  })
}

export function fetchProposalDetail(id: string) {
  return http.get<ProposalDetailResult>(`/proposal/${id}`)
}

/** ---------- Phase 2：待后端实现 ---------- */

export function fetchCommitteePending(query?: { pageNo?: number, pageSize?: number }) {
  return http.get<ProposalPageResult>('/proposal/review/committee/pending', query)
}

export function submitCommitteeReview(proposalId: string, data: Record<string, any>) {
  return http.post<string>(`/proposal/review/committee/${proposalId}`, data)
}

export function fetchApprovalPending(query?: { pageNo?: number, pageSize?: number }) {
  return http.get<ProposalPageResult>('/proposal/approval/pending', query)
}

export function submitApplicationApproval(proposalId: string, data: Record<string, any>) {
  return http.post<string>(`/proposal/approval/application/${proposalId}`, data)
}

/** 小程序首页聚合（若已部署） */
export function fetchAppHome() {
  return http.get<Record<string, any>>('/proposal/app/home')
}
