/**
 * 提案前端共用：状态文案、改善性质、附件上传
 */
import { uploadFileUrl } from '@/utils/uploadFile'

export const IMPROVEMENT_TYPES = [
  { label: '安全改善', value: 'SAFETY' },
  { label: '品质改善', value: 'QUALITY' },
  { label: '效率改善', value: 'EFFICIENCY' },
  { label: '交付改善', value: 'DELIVERY' },
  { label: '成本改善', value: 'COST' },
] as const

export type ImprovementTypeCode = (typeof IMPROVEMENT_TYPES)[number]['value']

const TYPE_LABEL_MAP = Object.fromEntries(IMPROVEMENT_TYPES.map(i => [i.value, i.label])) as Record<string, string>

export type StampTone = 'amber' | 'blue' | 'teal' | 'purple' | 'green' | 'red' | 'gray'

const STATUS_META: Record<string, { label: string, stamp: StampTone }> = {
  DRAFT: { label: '草稿', stamp: 'gray' },
  PENDING_REVIEW: { label: '待审核', stamp: 'blue' },
  PENDING_APPROVAL: { label: '待批准', stamp: 'amber' },
  REJECTED_FINAL: { label: '不批准', stamp: 'gray' },
  WITHDRAWN: { label: '已撤回', stamp: 'gray' },
  PENDING_ASSIGN: { label: '待指派', stamp: 'amber' },
  PENDING_CLAIM: { label: '待领取', stamp: 'amber' },
  IN_PROGRESS: { label: '进行中', stamp: 'teal' },
  PLAN_PENDING_REVIEW: { label: '计划书待审', stamp: 'teal' },
  PLAN_PENDING_APPROVAL: { label: '计划书待批', stamp: 'amber' },
  PLAN_REJECTED: { label: '已驳回', stamp: 'red' },
  PENDING_EVALUATION: { label: '待评定', stamp: 'purple' },
  PENDING_SIGNOFF: { label: '待签核', stamp: 'purple' },
  COMPLETED: { label: '已完成', stamp: 'green' },
}

export function statusLabel(code?: string) {
  if (!code)
    return '—'
  return STATUS_META[code]?.label || code
}

export function statusStamp(code?: string): StampTone {
  if (!code)
    return 'gray'
  return STATUS_META[code]?.stamp || 'gray'
}

export function parseImprovementTypes(raw?: string | null): string[] {
  if (!raw)
    return []
  const text = String(raw).trim()
  if (!text)
    return []
  try {
    const parsed = JSON.parse(text)
    if (Array.isArray(parsed))
      return parsed.map(String)
  }
  catch {
    // 兼容逗号串
  }
  return text
    .replace(/^\[|\]$/g, '')
    .split(/[,，/|]/)
    .map(s => s.replace(/["'\s]/g, ''))
    .filter(Boolean)
}

export function formatImprovementTypes(raw?: string | null) {
  const codes = parseImprovementTypes(raw)
  if (!codes.length)
    return '—'
  return codes.map(c => TYPE_LABEL_MAP[c] || c).join(' / ')
}

export function improvementTypeLabels(raw?: string | null) {
  return parseImprovementTypes(raw).map(c => TYPE_LABEL_MAP[c] || c)
}

export function toImprovementTypesPayload(codes: string[]) {
  return JSON.stringify(codes)
}

/** 拼可访问的文件 URL（本地上传相对路径） */
export function resolveFileUrl(path?: string | null) {
  if (!path)
    return ''
  const raw = String(path).trim()
  if (!raw)
    return ''
  if (/^(https?:|blob:|data:)/i.test(raw))
    return raw
  const base = String(import.meta.env.VITE_SERVER_BASEURL || '').replace(/\/$/, '')
  const normalized = raw.replace(/\\/g, '/').replace(/^\/+/, '')
  // #ifdef H5
  if (JSON.parse(import.meta.env.VITE_APP_PROXY_ENABLE || 'false')) {
    const prefix = import.meta.env.VITE_APP_PROXY_PREFIX || ''
    return `${prefix}/sys/common/static/${normalized}`
  }
  // #endif
  return `${base}/sys/common/static/${normalized}`
}

/**
 * 上传单张现场图到 Jeecg 通用上传
 * 注意：Jeecg `/sys/common/upload` 成功时文件路径在 message 字段
 */
export function uploadProposalImage(filePath: string): Promise<{ fileUrl: string, fileName: string, fileSize?: number }> {
  return new Promise((resolve, reject) => {
    const fileName = filePath.split(/[/\\]/).pop() || `image_${Date.now()}.jpg`
    uni.uploadFile({
      url: uploadFileUrl.COMMON,
      filePath,
      name: 'file',
      formData: { biz: 'proposal' },
      success: (res) => {
        try {
          const body = typeof res.data === 'string' ? JSON.parse(res.data) : res.data
          if (!body || body.success === false) {
            reject(new Error(body?.message || '上传失败'))
            return
          }
          const fileUrl = String(body.message || body.result || body.data).replace(/\\/g, '/')
          if (!fileUrl || fileUrl === 'undefined') {
            reject(new Error('上传未返回文件地址'))
            return
          }
          resolve({ fileUrl, fileName })
        }
        catch (err) {
          reject(err instanceof Error ? err : new Error('上传响应解析失败'))
        }
      },
      fail: (err) => {
        reject(new Error(err?.errMsg || '上传失败'))
      },
    })
  })
}

export function formatDateTime(value?: string | Date | null) {
  if (!value)
    return '—'
  const d = value instanceof Date ? value : new Date(value)
  if (Number.isNaN(d.getTime()))
    return String(value)
  const pad = (n: number) => String(n).padStart(2, '0')
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`
}
