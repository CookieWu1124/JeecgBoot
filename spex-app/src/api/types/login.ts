// 认证模式类型
export type AuthMode = 'single' | 'double'

// 单Token响应类型
export interface ISingleTokenRes {
  token: string
  expiresIn: number // 有效期(秒)
}

// 双Token响应类型
export interface IDoubleTokenRes {
  accessToken: string
  refreshToken: string
  accessExpiresIn: number // 访问令牌有效期(秒)
  refreshExpiresIn: number // 刷新令牌有效期(秒)
}

/**
 * 登录返回的信息，其实就是 token 信息
 */
export type IAuthLoginRes = ISingleTokenRes | IDoubleTokenRes

/**
 * 用户信息
 */
export type UserRole = string

export interface IUserInfoRes {
  userId: string | number
  username: string
  nickname: string
  avatar?: string
  /** 同时支持单角色和多角色，你自行选择一种就行 */
  role?: UserRole
  roles?: UserRole[]
  orgCode?: string
  loginTenantId?: string | number
  [key: string]: any // 允许其他扩展字段
}

/** Jeecg 登录部门 */
export interface IDepartItem {
  orgCode: string
  departName: string
  [key: string]: any
}

/** Jeecg 用户信息 */
export interface IJeecgUserInfo {
  id?: string | number
  username?: string
  realname?: string
  avatar?: string
  orgCode?: string
  loginTenantId?: string | number
  [key: string]: any
}

/** Jeecg /sys/login 返回的 result */
export interface IJeecgLoginRes {
  token: string
  userInfo?: IJeecgUserInfo
  sysAllDictItems?: Record<string, any>
  [key: string]: any
}

const DEFAULT_TOKEN_EXPIRES_IN = 7 * 24 * 3600

/**
 * 将 Jeecg 用户信息映射为 App 内使用的结构
 */
export function mapJeecgUser(user: IJeecgUserInfo = {}): IUserInfoRes {
  return {
    ...user,
    userId: user.id ?? user.userId ?? -1,
    username: user.username ?? '',
    nickname: user.realname || user.nickname || user.username || '',
    avatar: user.avatar,
  }
}

/**
 * 将 Jeecg 登录结果映射为单 Token 结构
 */
export function mapJeecgLoginRes(res: IJeecgLoginRes): ISingleTokenRes {
  return {
    token: res.token,
    expiresIn: DEFAULT_TOKEN_EXPIRES_IN,
  }
}

// 认证存储数据结构
export interface AuthStorage {
  mode: AuthMode
  tokens: ISingleTokenRes | IDoubleTokenRes
  userInfo?: IUserInfoRes
  loginTime: number // 登录时间戳
}

/**
 * 获取验证码
 */
export interface ICaptcha {
  captchaEnabled: boolean
  uuid: string
  image: string
}
/**
 * 上传成功的信息
 */
export interface IUploadSuccessInfo {
  fileId: number
  originalName: string
  fileName: string
  storagePath: string
  fileHash: string
  fileType: string
  fileBusinessType: string
  fileSize: number
}
/**
 * 更新用户信息
 */
export interface IUpdateInfo {
  id: number
  name: string
  sex: string
}
/**
 * 更新用户信息
 */
export interface IUpdatePassword {
  id: number
  oldPassword: string
  newPassword: string
  confirmPassword: string
}

/**
 * 判断是否为单Token响应
 * @param tokenRes 登录响应数据
 * @returns 是否为单Token响应
 */
export function isSingleTokenRes(tokenRes: IAuthLoginRes): tokenRes is ISingleTokenRes {
  return 'token' in tokenRes && !('refreshToken' in tokenRes)
}

/**
 * 判断是否为双Token响应
 * @param tokenRes 登录响应数据
 * @returns 是否为双Token响应
 */
export function isDoubleTokenRes(tokenRes: IAuthLoginRes): tokenRes is IDoubleTokenRes {
  return 'accessToken' in tokenRes && 'refreshToken' in tokenRes
}
