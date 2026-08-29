import { mapJeecgUser, type IAuthLoginRes, type ICaptcha, type IDepartItem, type IDoubleTokenRes, type IJeecgLoginRes, type IJeecgUserInfo, type IUpdateInfo, type IUpdatePassword } from './types/login'
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
 * @returns Promise 包含微信登录凭证(code)
 */
export function getWxCode() {
  return new Promise<UniApp.LoginRes>((resolve, reject) => {
    uni.login({
      provider: 'weixin',
      success: res => resolve(res),
      fail: err => reject(new Error(err)),
    })
  })
}

/**
 * 微信登录
 * @param params 微信登录参数，包含code
 * @returns Promise 包含登录结果
 */
export function wxLogin(data: { code: string }) {
  return http.post<IAuthLoginRes>('/auth/wxLogin', data)
}
