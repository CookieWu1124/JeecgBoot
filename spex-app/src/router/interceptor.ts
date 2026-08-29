/**
 * by 菲鸽 on 2025-08-19
 * 路由拦截，通常也是登录拦截
 * 黑、白名单的配置，请看 config.ts 文件， EXCLUDE_LOGIN_PATH_LIST
 */
import {
  DEFAULT_NEED_LOGIN,
  EXCLUDE_LOGIN_PATH_LIST,
  LOGIN_PAGE,
  LOGIN_PAGE_ENABLE_IN_MP,
  LOGIN_STRATEGY,
} from '@/router/config'
import { useTokenStore } from '@/store'
import { tabbarStore } from '@/tabbar/store'
import { getAllPages, getLastPage, parseUrlToObj } from '@/utils/index'
import { toLoginPage } from '@/utils/toLoginPage'

export const FG_LOG_ENABLE = false

function buildFullUrl(path: string, query: Record<string, string>) {
  const queryStr = Object.keys(query)
    .filter(key => query[key] !== undefined && query[key] !== null && query[key] !== '')
    .map(key => `${key}=${encodeURIComponent(query[key])}`)
    .join('&')
  return queryStr ? `${path}?${queryStr}` : path
}

/**
 * 判断目标路由是否需要登录
 */
export function isPageNeedLogin(path: string) {
  // #ifdef MP
  if (!LOGIN_PAGE_ENABLE_IN_MP)
    return false
  // #endif

  const excludePaths = new Set([
    ...EXCLUDE_LOGIN_PATH_LIST,
    ...getAllPages('excludeLoginPath').map(page => page.path),
  ])

  const isExcluded = excludePaths.has(path)
  if (LOGIN_STRATEGY === DEFAULT_NEED_LOGIN)
    return !isExcluded
  return isExcluded
}

export const navigateToInterceptor = {
  // 注意，这里的url是 '/' 开头的，如 '/pages/index/index'，跟 'pages.json' 里面的 path 不同
  // 增加对相对路径的处理，BY 网友 @ideal
  invoke({ url, query }: { url: string, query?: Record<string, string> }) {
    if (url === undefined) {
      return
    }
    let { path, query: _query } = parseUrlToObj(url)

    FG_LOG_ENABLE && console.log('\n\n路由拦截器:-------------------------------------')
    FG_LOG_ENABLE && console.log('路由拦截器 1: url->', url, ', query ->', query)
    const myQuery = { ..._query, ...query }
    // /pages/route-interceptor/index?name=feige&age=30
    FG_LOG_ENABLE && console.log('路由拦截器 2: path->', path, ', _query ->', _query)
    FG_LOG_ENABLE && console.log('路由拦截器 3: myQuery ->', myQuery)

    // 处理相对路径
    if (!path.startsWith('/')) {
      const currentPath = getLastPage()?.route || ''
      const normalizedCurrentPath = currentPath.startsWith('/') ? currentPath : `/${currentPath}`
      const baseDir = normalizedCurrentPath.substring(0, normalizedCurrentPath.lastIndexOf('/'))
      path = `${baseDir}/${path}`
    }

    // 首页简写
    if (path === '/')
      path = '/pages/index/index'

    // 处理直接进入路由非首页时，tabbarIndex 不正确的问题
    tabbarStore.setAutoCurIdx(path)

    // 登录页本身不拦截
    if (path === LOGIN_PAGE)
      return true

    if (!isPageNeedLogin(path))
      return true

    const tokenStore = useTokenStore()
    const hasLogin = tokenStore.updateNowTime().hasLogin
    if (hasLogin)
      return true

    const redirect = encodeURIComponent(buildFullUrl(path, myQuery))
    toLoginPage({
      mode: 'reLaunch',
      queryString: `?redirect=${redirect}`,
    })
    toLoginPage.flush()
    return false
  },
}

export const routeInterceptor = {
  install() {
    uni.addInterceptor('navigateTo', navigateToInterceptor)
    uni.addInterceptor('reLaunch', navigateToInterceptor)
    uni.addInterceptor('redirectTo', navigateToInterceptor)
    uni.addInterceptor('switchTab', navigateToInterceptor)
  },
}
