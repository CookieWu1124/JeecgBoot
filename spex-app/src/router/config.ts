/**
 * 登录策略配置
 * @see ./README.md
 */

/** 默认无需登录（黑名单）：仅列表中的页面需要登录 */
export const DEFAULT_NO_NEED_LOGIN = 0
/** 默认需要登录（白名单）：仅列表中的页面可不登录 */
export const DEFAULT_NEED_LOGIN = 1

/**
 * 登录策略：本项目为 2B 提案改善系统，进入应用需先登录
 */
export const LOGIN_STRATEGY = DEFAULT_NEED_LOGIN

/** 登录页路径 */
export const LOGIN_PAGE = '/pages/login/index'

/**
 * 排除列表：
 * - DEFAULT_NEED_LOGIN 下为白名单（可不登录）
 * - DEFAULT_NO_NEED_LOGIN 下为黑名单（需登录）
 */
export const EXCLUDE_LOGIN_PATH_LIST: string[] = [
  LOGIN_PAGE,
]

/** 小程序端是否启用登录页拦截逻辑 */
export const LOGIN_PAGE_ENABLE_IN_MP = true
