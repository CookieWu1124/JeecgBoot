import { LOGIN_PAGE } from '@/router/config'
import { isPageNeedLogin } from '@/router/interceptor'
import { useTokenStore } from '@/store'
import { tabbarStore } from '@/tabbar/store'

export const permission = {
  install(router) {
    router.beforeEach((to, from, next) => {
      const path = to.path === '/' ? '/pages/index/index' : to.path
      tabbarStore.setAutoCurIdx(path)

      if (path === LOGIN_PAGE || !isPageNeedLogin(path)) {
        next()
        return
      }

      const tokenStore = useTokenStore()
      if (tokenStore.updateNowTime().hasLogin) {
        next()
        return
      }

      next({
        path: LOGIN_PAGE,
        query: {
          redirect: to.fullPath || path,
        },
        replace: true,
      })
    })
  },
}
