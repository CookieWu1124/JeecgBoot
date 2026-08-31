import { mapJeecgUser, type ICaptcha, type IDepartItem, type IDoubleTokenRes, type IJeecgLoginRes, type IJeecgUserInfo, type IUpdateInfo, type IUpdatePassword } from './types/login'
import { http } from '@/http/http'
import { encryptAESCBC } from '@/utils/cipher'

/**
 * 登录表单
 */
export interface ILoginForm {
  username: string
  password: string
  inputCode?: string
  orgCode?: string
  departName?: string
  captcha?: string
  checkKey?: string
}

/**
 * 获取验证码
 * @returns ICaptcha 验证码
 */
export function getCode() {
  return http.get<ICaptcha>('/user/getCode')
}

/** Jeecg loginGetUserDeparts 的 result 结构 */
interface IJeecgDepartResult {
  currentOrgCode?: string
  departs?: IDepartItem[]
}

/**
 * 根据账号密码获取所属部门（免 token）
 * 对齐 Jeecg：POST /sys/loginGetUserDeparts（source=APP 跳过验证码）
 */
export async function getDepartList(loginForm: ILoginForm) {
  const res = await http.post<IJeecgDepartResult>('/sys/loginGetUserDeparts', {
    username: loginForm.username,
    password: encryptAESCBC(loginForm.password),
    loginType: 'account',
    source: 'APP',
  }, undefined, undefined, { hideErrorToast: true })
  return res?.departs ?? []
}

/**
 * 用户登录（移动端）
 * 对齐 Jeecg：POST /sys/mLogin（无图形验证码）
 * 密码与管理端一致：AES-CBC 加密后再传输
 */
export function login(loginForm: ILoginForm) {
  return http.post<IJeecgLoginRes>('/sys/mLogin', {
    username: loginForm.username,
    password: encryptAESCBC(loginForm.password),
    loginOrgCode: loginForm.orgCode,
  }, undefined, undefined, { hideErrorToast: true })
}

/**
 * 刷新token
 * @param refreshToken 刷新token
 */
export function refreshToken(refreshToken: string) {
  return http.post<IDoubleTokenRes>('/auth/refreshToken', { refreshToken })
}

/**
 * 获取用户信息
 */
export async function getUserInfo() {
  const res = await http.get<IJeecgLoginRes | IJeecgUserInfo>('/sys/user/getUserInfo')
  const user = (res as IJeecgLoginRes)?.userInfo ?? res
  return mapJeecgUser(user as IJeecgUserInfo)
}

/**
 * 退出登录
 */
export function logout() {
  return http.get<void>('/sys/logout')
}

/**
 * 修改用户信息
 */
export function updateInfo(data: IUpdateInfo) {
  return http.post('/user/updateInfo', data)
}

/**
 * 修改用户密码
 */
export function updateUserPassword(data: IUpdatePassword) {
  return http.post('/user/updatePassword', data)
}

/**
 * 获取微信登录凭证
 */
export function getWxCode() {
  return new Promise<UniApp.LoginRes>((resolve, reject) => {
    uni.login({
      provider: 'weixin',
      success: res => resolve(res),
      fail: err => reject(new Error(typeof err === 'string' ? err : err?.errMsg || '微信登录失败')),
    })
  })
}

export interface IWxMiniLoginRes {
  bound?: boolean
  token?: string
  userInfo?: IJeecgUserInfo
  [key: string]: any
}

/**
 * 小程序静默登录（jsCode 换 OpenID，已绑定则直接签发 Token）
 */
export function silentLogin(jsCode: string) {
  return http.post<IWxMiniLoginRes>('/sys/wxMini/silentLogin', { jsCode }, undefined, undefined, { hideErrorToast: true })
}

/**
 * 小程序首次绑定：工号 + 微信手机号授权 code
 */
export function bindWxMini(data: { jsCode: string, workNo: string, phoneCode: string }) {
  return http.post<IJeecgLoginRes>('/sys/wxMini/bind', data, undefined, undefined, { hideErrorToast: true })
}
