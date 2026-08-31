/**
 * 提案前端共用：状态文案、改善性质、附件上传
 */
import { fetchImprovementTypes, fetchProposalStatuses, type ImprovementTypeOption } from '@/api/proposal'
import { uploadFileUrl } from '@/utils/uploadFile'

export type ImprovementTypeCode = string

let typeOptionsCache: ImprovementTypeOption[] = []
let typeLabelMap: Record<string, string> = {}
let typeLabelsLoading: Promise<ImprovementTypeOption[]> | null = null

export function loadImprovementTypes() {
  if (typeOptionsCache.length) {
    return Promise.resolve(typeOptionsCache.filter(i => i.typeStatus !== 'disabled'))
  }
  if (typeLabelsLoading) {
    return typeLabelsLoading
  }
  typeLabelsLoading = fetchImprovementTypes(false)
    .then((list) => {
      const rows = Array.isArray(list) ? list : []
      typeOptionsCache = rows
      typeLabelMap = Object.fromEntries(rows.map(i => [i.code, i.label]))
      return rows.filter(i => i.typeStatus !== 'disabled')
    })
    .catch(() => {
      return [] as ImprovementTypeOption[]
    })
    .finally(() => {
      typeLabelsLoading = null
    })
  return typeLabelsLoading
}

export type StampTone = 'amber' | 'blue' | 'teal' | 'purple' | 'green' | 'red' | 'gray'

/** 印章颜色只属于展示，不参与文案真相。文案优先用接口 statusLabel / meta/statuses。 */
const STATUS_STAMP: Record<string, StampTone> = {
  PENDING_REVIEW: 'blue',
  PENDING_APPROVAL: 'amber',
  APPROVED: 'green',
  REJECTED_FINAL: 'gray',
  PENDING_ASSIGN: 'amber',
  PENDING_CLAIM: 'amber',
  IN_PROGRESS: 'teal',
  PLAN_PENDING_REVIEW: 'teal',
  PLAN_PENDING_APPROVAL: 'amber',
  PLAN_REJECTED: 'red',
  PENDING_EVALUATION: 'purple',
  PENDING_SIGNOFF: 'purple',
  COMPLETED: 'green',
}

let statusLabelCache: Record<string, string> = {}
let statusLabelsLoading: Promise<void> | null = null

export function loadStatusLabels() {
  if (Object.keys(statusLabelCache).length) {
    return Promise.resolve()
  }
  if (statusLabelsLoading) {
    return statusLabelsLoading
  }
  statusLabelsLoading = fetchProposalStatuses()
    .then((list) => {
      const rows = Array.isArray(list) ? list : []
      statusLabelCache = Object.fromEntries(rows.map(i => [i.code, i.label]))
    })
    .catch(() => {
      // 列表行上通常已有 statusLabel；下拉失败时退回 code
    })
    .finally(() => {
      statusLabelsLoading = null
    })
  return statusLabelsLoading
}

export function statusLabel(code?: string, serverLabel?: string) {
  if (serverLabel)
    return serverLabel
  if (!code)
    return '—'
  return statusLabelCache[code] || code
}

export function statusStamp(code?: string): StampTone {
  if (!code)
    return 'gray'
  return STATUS_STAMP[code] || 'gray'
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

export function formatImprovementTypes(raw?: string | null, serverLabel?: string | null) {
  if (serverLabel)
    return serverLabel
  const codes = parseImprovementTypes(raw)
  if (!codes.length)
    return '—'
  return codes.map(c => typeLabelMap[c] || c).join(' / ')
}

export function improvementTypeLabels(raw?: string | null, serverLabel?: string | null) {
  if (serverLabel)
    return String(serverLabel).split(/\s*\/\s*/).filter(Boolean)
  return parseImprovementTypes(raw).map(c => typeLabelMap[c] || c)
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
