import { defineStore } from 'pinia'
import { ref } from 'vue'

const initState = {
  token: '',
  userid: '',
  username: '',
  realname: '',
  welcome: '',
  avatar: '',
  tenantId: 0,
  phone: '',
  email: '',
  sex: 1,
  // 本地存储时间
  localStorageTime: 0,
}

export const useUserStore = defineStore(
  'user',
  () => {
    const userInfo = ref<IUserInfo>({ ...initState })
    const setUserInfo = (val: IUserInfo) => {
      userInfo.value = val
    }
    const clearUserInfo = () => {
      userInfo.value = { ...initState }
    }
    const editUserInfo = (options) => {
      userInfo.value = { ...userInfo.value, ...options }
    }
    // 一般没有reset需求，不需要的可以删除
    const reset = () => {
      userInfo.value = { ...initState }
    }
    const isLogined = computed(() => !!userInfo.value.token)
    return {
      userInfo,
      setUserInfo,
      clearUserInfo,
      isLogined,
      editUserInfo,
      reset,
    }
  },
  {
    // 如果需要持久化就写 true, 不需要持久化就写 false（或者去掉这个配置项）
    persist: true,
  },
)
