import type {
  ILoginForm,
} from '@/api/login'
import type { IAuthLoginRes, IUserInfoRes } from '@/api/types/login'
import { defineStore } from 'pinia'
import { computed, ref } from 'vue' // 修复：导入 computed
import {
  login as _login,
  logout as _logout,
  refreshToken as _refreshToken,
  silentLogin as _silentLogin,
  bindWxMini as _bindWxMini,
  phoneLogin as _phoneLogin,
  getWxCode,
} from '@/api/login'
import { isDoubleTokenRes, isSingleTokenRes, mapJeecgLoginRes, mapJeecgUser } from '@/api/types/login'
import { useUserStore } from './user'

/**
 * 是否是双token模式
 */
export const isDoubleTokenMode = import.meta.env.VITE_AUTH_MODE === 'double'
// 初始化状态
const tokenInfoState = isDoubleTokenMode
  ? {
      accessToken: '',
      accessExpiresIn: 0,
      refreshToken: '',
      refreshExpiresIn: 0,
    }
  : {
      token: '',
      expiresIn: 0,
    }

export const useTokenStore = defineStore(
  'token',
  () => {
    // 定义用户信息
    const tokenInfo = ref<IAuthLoginRes>({ ...tokenInfoState })

    // 添加一个时间戳 ref 作为响应式依赖
    const nowTime = ref(Date.now())
    /**
     * 更新响应式数据:now
     * 确保isTokenExpired/isRefreshTokenExpired重新计算,而不是用错误过期缓存值
     * 可useTokenStore内部适时调用;也可链式调用:tokenStore.updateNowTime().hasLogin
     * @returns 最新的tokenStore实例
     */
    const updateNowTime = () => {
      nowTime.value = Date.now()
      return useTokenStore()
    }

    // 设置用户信息
    const setTokenInfo = (val: IAuthLoginRes) => {
      updateNowTime()
      tokenInfo.value = val

      // 计算并存储过期时间
      const now = Date.now()
      if (isSingleTokenRes(val)) {
        // 单token模式
        const expireTime = now + val.expiresIn * 1000
        uni.setStorageSync('accessTokenExpireTime', expireTime)
      }
      else if (isDoubleTokenRes(val)) {
        // 双token模式
        const accessExpireTime = now + val.accessExpiresIn * 1000
        const refreshExpireTime = now + val.refreshExpiresIn * 1000
        uni.setStorageSync('accessTokenExpireTime', accessExpireTime)
        uni.setStorageSync('refreshTokenExpireTime', refreshExpireTime)
      }
    }

    /**
     * 判断token是否过期
     */
    const isTokenExpired = computed(() => {
      if (!tokenInfo.value) {
        return true
      }

      const now = nowTime.value
      const expireTime = uni.getStorageSync('accessTokenExpireTime')

      if (!expireTime)
        return true
      return now >= expireTime
    })

    /**
     * 判断refreshToken是否过期
     */
    const isRefreshTokenExpired = computed(() => {
      if (!isDoubleTokenMode)
        return true

      const now = nowTime.value
      const refreshExpireTime = uni.getStorageSync('refreshTokenExpireTime')

      if (!refreshExpireTime)
        return true
      return now >= refreshExpireTime
    })

    /**
     * 登录成功后处理逻辑
     * @param tokenInfo 登录返回的token信息
     * @param user 已从登录接口拿到的用户信息，有则不再请求 /sys/user/getUserInfo
     */
    async function _postLogin(tokenInfo: IAuthLoginRes, user?: IUserInfoRes) {
      setTokenInfo(tokenInfo)
      const userStore = useUserStore()
      if (user) {
        userStore.setUserInfo(user)
        return
      }
      await userStore.fetchUserInfo()
    }

    /**
     * 用户登录（工号+密码），不再选择部门
     */
    const login = async (loginForm: ILoginForm) => {
      try {
        const res = await _login(loginForm)
        console.log('普通登录-res: ', res)
        const user = res.userInfo ? mapJeecgUser(res.userInfo) : undefined
        await _postLogin(mapJeecgLoginRes(res), user)
        uni.showToast({
          title: '登录成功',
          icon: 'success',
        })
        return res
      }
      catch (error: any) {
        console.error('登录失败:', error)
        uni.showToast({
          title: error?.message || '登录失败，请重试',
          icon: 'none',
        })
        throw error
      }
      finally {
        updateNowTime()
      }
    }

    /**
     * 小程序静默登录。未绑定返回 { bound: false }，不弹成功 toast。
     */
    const wxSilentLogin = async () => {
      try {
        const loginRes = await getWxCode()
        const jsCode = loginRes.code
        if (!jsCode)
          throw new Error('未获取到微信登录凭证')
        const res = await _silentLogin(jsCode)
        if (!res?.bound || !res.token)
          return res
        const user = res.userInfo ? mapJeecgUser(res.userInfo) : undefined
        await _postLogin(mapJeecgLoginRes({ token: res.token, userInfo: res.userInfo }), user)
        return res
      }
      catch (error: any) {
        console.error('静默登录失败:', error)
        throw error
      }
      finally {
        updateNowTime()
      }
    }

    /**
     * 小程序首次绑定：工号 + getPhoneNumber 的 phoneCode
     */
    const wxBindLogin = async (workNo: string, phoneCode: string) => {
      try {
        const loginRes = await getWxCode()
        const jsCode = loginRes.code
        if (!jsCode)
          throw new Error('未获取到微信登录凭证')
        const res = await _bindWxMini({ jsCode, workNo, phoneCode })
        const user = res.userInfo ? mapJeecgUser(res.userInfo) : undefined
        await _postLogin(mapJeecgLoginRes(res), user)
        uni.showToast({
          title: '登录成功',
          icon: 'success',
        })
        return res
      }
      catch (error: any) {
        console.error('微信绑定失败:', error)
        uni.showToast({
          title: error?.message || '绑定失败，请重试',
          icon: 'none',
        })
        throw error
      }
      finally {
        updateNowTime()
      }
    }

    /**
     * H5 工号 + 手机号登录
     */
    const phoneLogin = async (workNo: string, phone: string) => {
      try {
        const res = await _phoneLogin({ workNo, phone })
        const user = res.userInfo ? mapJeecgUser(res.userInfo) : undefined
        await _postLogin(mapJeecgLoginRes(res), user)
        uni.showToast({
          title: '登录成功',
          icon: 'success',
        })
        return res
      }
      catch (error: any) {
        console.error('工号手机号登录失败:', error)
        uni.showToast({
          title: error?.message || '登录失败，请重试',
          icon: 'none',
        })
        throw error
      }
      finally {
        updateNowTime()
      }
    }

    /**
     * 退出登录 并 删除用户信息
     */
    const logout = async () => {
      try {
        // TODO 实现自己的退出登录逻辑
        await _logout()
      }
      catch (error) {
        console.error('退出登录失败:', error)
      }
      finally {
        updateNowTime()

        // 无论成功失败，都需要清除本地token信息
        // 清除存储的过期时间
        uni.removeStorageSync('accessTokenExpireTime')
        uni.removeStorageSync('refreshTokenExpireTime')
        console.log('退出登录-清除用户信息')
        tokenInfo.value = { ...tokenInfoState }
        uni.removeStorageSync('token')
        const userStore = useUserStore()
        userStore.clearUserInfo()
      }
    }

    /**
     * 刷新token
     * @returns 刷新结果
     */
    const refreshToken = async () => {
      if (!isDoubleTokenMode) {
        console.error('单token模式不支持刷新token')
        throw new Error('单token模式不支持刷新token')
      }

      try {
        // 安全检查，确保refreshToken存在
        if (!isDoubleTokenRes(tokenInfo.value) || !tokenInfo.value.refreshToken) {
          throw new Error('无效的refreshToken')
        }

        const refreshToken = tokenInfo.value.refreshToken
        const res = await _refreshToken(refreshToken)
        console.log('刷新token-res: ', res)
        setTokenInfo(res)
        return res
      }
      catch (error) {
        console.error('刷新token失败:', error)
        throw error
      }
      finally {
        updateNowTime()
      }
    }

    /**
     * 获取有效的token
     * 注意：在computed中不直接调用异步函数，只做状态判断
     * 实际的刷新操作应由调用方处理
     * 建议这样使用 tokenStore.updateNowTime().validToken
     */
    const getValidToken = computed(() => {
      // token已过期，返回空
      if (isTokenExpired.value) {
        return ''
      }

      if (!isDoubleTokenMode) {
        return isSingleTokenRes(tokenInfo.value) ? tokenInfo.value.token : ''
      }
      else {
        return isDoubleTokenRes(tokenInfo.value) ? tokenInfo.value.accessToken : ''
      }
    })

    /**
     * 检查是否有登录信息（不考虑token是否过期）
     */
    const hasLoginInfo = computed(() => {
      if (!tokenInfo.value) {
        return false
      }
      if (isDoubleTokenMode) {
        return isDoubleTokenRes(tokenInfo.value) && !!tokenInfo.value.accessToken
      }
      else {
        return isSingleTokenRes(tokenInfo.value) && !!tokenInfo.value.token
      }
    })

    /**
     * 检查是否已登录且token有效
     * 建议这样使用tokenStore.updateNowTime().hasLogin
     */
    const hasValidLogin = computed(() => {
      console.log('hasValidLogin', hasLoginInfo.value, !isTokenExpired.value)
      return hasLoginInfo.value && !isTokenExpired.value
    })

    /**
     * 尝试获取有效的token，如果过期且可刷新，则刷新token
     * @returns 有效的token或空字符串
     */
    const tryGetValidToken = async (): Promise<string> => {
      updateNowTime()
      if (!getValidToken.value && isDoubleTokenMode && !isRefreshTokenExpired.value) {
        try {
          await refreshToken()
          return getValidToken.value
        }
        catch (error) {
          console.error('尝试刷新token失败:', error)
          return ''
        }
      }
      return getValidToken.value
    }

    return {
      // 核心API方法
      login,
      wxSilentLogin,
      wxBindLogin,
      phoneLogin,
      logout,

      // 认证状态判断（最常用的）
      hasLogin: hasValidLogin,

      // 内部系统使用的方法
      refreshToken,
      tryGetValidToken,
      validToken: getValidToken,

      // 调试或特殊场景可能需要直接访问的信息
      tokenInfo,
      setTokenInfo,
      updateNowTime,
    }
  },
  {
    // 添加持久化配置，确保刷新页面后token信息不丢失
    persist: true,
  },
)
