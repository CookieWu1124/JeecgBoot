import { createRouter } from '@/plugin/uni-mini-router'
// 导入pages.json
import pagesJson from '../pages.json'
console.log("pagesJson::",pagesJson);
// 引入uni-parse-pages
import pagesJsonToRoutes from 'uni-parse-pages'
import { useUserStore } from '@/store/user'
// 生成路由表
const routes = pagesJsonToRoutes(pagesJson)
setRouteName(routes)
const router = createRouter({
  routes: [...routes], // 路由表信息
})
export const whiteList = ['/pages/login/login']
export const loginPage = '/pages/login/login'

export const beforEach = (to, from, next) => {
  const userStore = useUserStore()
  if (userStore.isLogined) {
    // 有登录态
    next(true)
  } else {
    // 无登录态
    if (whiteList.includes(to.path)) {
      next()
    } else {
      next({ path: loginPage })
    }
  }
}
// 全局前置守卫
router.beforeEach(beforEach)

// 路由的最后一级为路由名字不可重复
function setRouteName(routes) {
  routes.forEach((item) => {
    if (item.path) {
      const name = item.path.split('/').pop()
      item.name = name
    }
  })
}
export default router
