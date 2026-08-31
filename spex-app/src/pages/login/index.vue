<template>
  <view class="login-page">
    <view class="login-page__blob login-page__blob--lt" />
    <view class="login-page__blob login-page__blob--rt" />
    <view class="login-page__blob login-page__blob--bt" />

    <view class="login-body">
      <view class="login-nav" />

      <view class="login-brand">
        <view class="login-logo">
          <text class="login-logo__text">改</text>
        </view>
        <text class="login-brand__title">提案改善</text>
        <text class="login-brand__en">KAIZEN PROPOSAL SYSTEM</text>
        <text class="login-brand__slogan">人人参与改善 · 点滴汇聚效益</text>
      </view>

      <view class="login-action">
        <view class="login-card">
          <view class="login-field">
            <text class="login-label">工号</text>
            <wd-input
              v-model="form.username"
              prefix-icon="user"
              clearable
              placeholder="请输入工号"
              custom-class="login-input"
              @blur="touched.username = true"
            />
            <text v-if="usernameError" class="login-error">{{ usernameError }}</text>
          </view>

          <!-- #ifndef MP-WEIXIN -->
          <view v-if="h5Mode === 'password'" class="login-field login-field--gap">
            <text class="login-label">密码</text>
            <wd-input
              v-model="form.password"
              prefix-icon="lock"
              show-password
              clearable
              placeholder="请输入密码"
              custom-class="login-input"
              @blur="touched.password = true"
              @confirm="handleH5Login"
            />
            <text v-if="passwordError" class="login-error">{{ passwordError }}</text>
          </view>

          <view v-else class="login-field login-field--gap">
            <text class="login-label">手机号</text>
            <wd-input
              v-model="form.phone"
              prefix-icon="phone"
              clearable
              type="number"
              placeholder="请输入预留手机号"
              custom-class="login-input"
              @blur="touched.phone = true"
              @confirm="handleH5Login"
            />
            <text v-if="phoneError" class="login-error">{{ phoneError }}</text>
          </view>

          <wd-button
            block
            size="large"
            :loading="submitting"
            :disabled="!canSubmit"
            custom-class="login-submit"
            @click="handleH5Login"
          >
            登录
          </wd-button>

          <view class="login-switch" hover-class="login-hover" @click="toggleH5Mode">
            <text class="login-switch__text">{{ h5Mode === 'password' ? '使用工号+手机号登录' : '使用账号密码登录' }}</text>
          </view>

          <view v-if="h5Mode === 'password'" class="login-demo" hover-class="login-hover" @click="handleDemoLogin">
            <text class="login-demo__text">体验登录</text>
          </view>
          <!-- #endif -->

          <!-- #ifdef MP-WEIXIN -->
          <button
            class="login-wx-btn"
            :class="{ 'login-wx-btn--disabled': !canSubmit || submitting }"
            :disabled="!canSubmit || submitting"
            :loading="submitting"
            open-type="getPhoneNumber"
            @getphonenumber="onGetPhoneNumber"
          >
            登录
          </button>
          <!-- #endif -->
        </view>
      </view>

      <view class="login-footer">
        <text class="login-footer__line">
          登录即代表同意
          <text class="login-footer__link">《用户协议》</text>
          与
          <text class="login-footer__link">《隐私政策》</text>
        </text>
        <text class="login-footer__tip">白名单邀请制 · 请使用公司预录工号绑定</text>
      </view>
    </view>
  </view>
</template>

<script lang="ts" setup>
import type { IUserInfoRes } from '@/api/types/login'
import { isMpWeixin } from '@uni-helper/uni-env'
import { useTokenStore, useUserStore } from '@/store'
import { isPageTabbar } from '@/tabbar/store'

defineOptions({
  name: 'Login',
})

definePage({
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '登录',
    navigationBarTextStyle: 'white',
    backgroundColor: '#1890FF',
    backgroundColorTop: '#40A9FF',
    backgroundColorBottom: '#096DD9',
    disableScroll: true,
  },
  excludeLoginPath: true,
})

const tokenStore = useTokenStore()
const userStore = useUserStore()

const form = reactive({
  username: '',
  password: '',
  phone: '',
})
const touched = reactive({
  username: false,
  password: false,
  phone: false,
})
const submitting = ref(false)
const redirect = ref('')
const h5Mode = ref<'password' | 'phone'>('password')
const silentTried = ref(false)

const usernameError = computed(() => {
  if (!touched.username)
    return ''
  if (!form.username.trim())
    return '请输入工号'
  if (form.username.trim().length < 3)
    return '工号至少 3 个字符'
  return ''
})

const passwordError = computed(() => {
  if (!touched.password)
    return ''
  if (!form.password)
    return '请输入密码'
  if (form.password.length < 6)
    return '密码至少 6 位'
  return ''
})

const phoneError = computed(() => {
  if (!touched.phone)
    return ''
  const phone = form.phone.trim()
  if (!phone)
    return '请输入手机号'
  if (!/^1\d{10}$/.test(phone))
    return '请输入正确的11位手机号'
  return ''
})

const canSubmit = computed(() => {
  if (submitting.value)
    return false
  if (form.username.trim().length < 3)
    return false
  if (isMpWeixin)
    return true
  if (h5Mode.value === 'password')
    return form.password.length >= 6
  return /^1\d{10}$/.test(form.phone.trim())
})

onLoad((query) => {
  redirect.value = typeof query?.redirect === 'string' ? decodeURIComponent(query.redirect) : ''
  const lastUsername = uni.getStorageSync('login-username')
  if (lastUsername)
    form.username = lastUsername
})

onMounted(() => {
  if (isMpWeixin)
    trySilentLogin()
})

function toggleH5Mode() {
  h5Mode.value = h5Mode.value === 'password' ? 'phone' : 'password'
}

function goAfterLogin() {
  const target = redirect.value
  const tabPath = target.split('?')[0]
  if (target && isPageTabbar(tabPath)) {
    uni.switchTab({ url: tabPath })
    return
  }
  if (target.startsWith('/')) {
    uni.redirectTo({ url: target })
    return
  }
  const pages = getCurrentPages()
  if (pages.length > 1) {
    uni.navigateBack()
    return
  }
  uni.switchTab({ url: '/pages/me/me' })
}

async function trySilentLogin() {
  if (silentTried.value || submitting.value)
    return
  silentTried.value = true
  try {
    const res = await tokenStore.wxSilentLogin()
    if (res?.token)
      goAfterLogin()
  }
  catch (error) {
    console.error('静默登录失败:', error)
  }
}

async function handleH5Login() {
  touched.username = true
  if (h5Mode.value === 'password')
    touched.password = true
  else
    touched.phone = true
  if (!canSubmit.value)
    return

  submitting.value = true
  try {
    if (h5Mode.value === 'password') {
      await tokenStore.login({
        username: form.username.trim(),
        password: form.password,
        inputCode: '',
      })
    }
    else {
      await tokenStore.phoneLogin(form.username.trim(), form.phone.trim())
    }
    uni.setStorageSync('login-username', form.username.trim())
    goAfterLogin()
  }
  catch (error) {
    console.error('登录失败:', error)
  }
  finally {
    submitting.value = false
  }
}

async function onGetPhoneNumber(e: any) {
  const detail = e?.detail || {}
  const errMsg = String(detail.errMsg || '')
  if (errMsg && !errMsg.includes('ok')) {
    uni.showToast({ title: '需要授权手机号才能绑定', icon: 'none' })
    return
  }
  const phoneCode = detail.code
  if (!phoneCode) {
    uni.showToast({ title: '未获取到手机号授权', icon: 'none' })
    return
  }
  touched.username = true
  if (form.username.trim().length < 3) {
    uni.showToast({ title: '请输入工号', icon: 'none' })
    return
  }
  submitting.value = true
  try {
    await tokenStore.wxBindLogin(form.username.trim(), phoneCode)
    uni.setStorageSync('login-username', form.username.trim())
    goAfterLogin()
  }
  catch (error) {
    console.error('微信绑定失败:', error)
  }
  finally {
    submitting.value = false
  }
}

function handleDemoLogin() {
  const demoUser: IUserInfoRes = {
    userId: 10086,
    username: form.username.trim() || 'spex',
    nickname: '陈晓舟',
    avatar: '/static/logo.svg',
    role: 'user',
  }
  userStore.setUserInfo(demoUser)
  tokenStore.setTokenInfo({
    token: 'demo-token',
    expiresIn: 7 * 24 * 3600,
  })
  uni.setStorageSync('login-username', demoUser.username)
  uni.showToast({ title: '已进入体验账号', icon: 'success' })
  setTimeout(() => goAfterLogin(), 400)
}
</script>

<style lang="scss" scoped>
.login-page {
  position: relative;
  height: 100vh;
  overflow: hidden;
  background: linear-gradient(165deg, #40a9ff 0%, #1890ff 42%, #096dd9 100%);
}

.login-page__blob {
  position: absolute;
  border-radius: 9999px;
  pointer-events: none;
}

.login-page__blob--lt {
  top: -6vh;
  left: -10vw;
  width: 28vw;
  height: 28vw;
  background: rgba(255, 255, 255, 0.12);
}

.login-page__blob--rt {
  top: 28%;
  right: -12vw;
  width: 22vw;
  height: 22vw;
  background: rgba(125, 211, 252, 0.2);
}

.login-page__blob--bt {
  bottom: 12%;
  left: -10vw;
  width: 20vw;
  height: 20vw;
  background: rgba(255, 255, 255, 0.08);
}

.login-body {
  position: relative;
  z-index: 1;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  height: 100%;
  padding: env(safe-area-inset-top) 0 env(safe-area-inset-bottom);
}

.login-nav {
  flex-shrink: 0;
  height: 5.5vh;
  min-height: 40px;
  max-height: 48px;
}

.login-brand {
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 2.5vh 6vw 0;
}

.login-logo {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 11vh;
  height: 11vh;
  max-width: 88px;
  max-height: 88px;
  min-width: 64px;
  min-height: 64px;
  background: linear-gradient(135deg, #36cfc9, #13c2c2);
  border-radius: 22%;
  box-shadow: 0 12px 28px rgba(19, 194, 194, 0.35);
}

.login-logo__text {
  color: #fff;
  font-size: clamp(32px, 5.5vh, 44px);
  font-weight: 700;
  line-height: 1;
}

.login-brand__title {
  margin-top: 1.8vh;
  color: #fff;
  font-size: clamp(24px, 3.6vh, 32px);
  font-weight: 700;
  letter-spacing: 2px;
}

.login-brand__en {
  margin-top: 0.8vh;
  color: rgba(255, 255, 255, 0.88);
  font-size: clamp(11px, 1.4vh, 12px);
  font-weight: 500;
  letter-spacing: 1.5px;
}

.login-brand__slogan {
  margin-top: 1vh;
  color: rgba(255, 255, 255, 0.72);
  font-size: clamp(12px, 1.5vh, 13px);
  letter-spacing: 0.5px;
}

.login-action {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  min-height: 0;
  padding: 2vh 7vw;
}

.login-card {
  padding: 2.4vh 4.2vw;
  background: rgba(255, 255, 255, 0.96);
  border: 1px solid rgba(255, 255, 255, 0.85);
  border-radius: 18px;
  box-shadow: 0 12px 32px rgba(24, 144, 255, 0.16);
}

.login-field--gap {
  margin-top: 2vh;
}

.login-label {
  display: block;
  margin-bottom: 0.8vh;
  color: #1e2438;
  font-size: 14px;
  font-weight: 500;
}

.login-error {
  display: block;
  margin-top: 0.6vh;
  color: #ef4444;
  font-size: 12px;
}

.login-demo,
.login-switch {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 1.6vh;
}

.login-demo__text,
.login-switch__text {
  color: #1890ff;
  font-size: 14px;
}

.login-hover {
  opacity: 0.72;
}

:deep(.login-input) {
  background: #f0f8ff !important;
  border-radius: 12px !important;
}

:deep(.login-submit) {
  margin-top: 2.4vh !important;
  height: 44px !important;
  border: none !important;
  border-radius: 12px !important;
  background: linear-gradient(135deg, #69c0ff, #1890ff 50%, #13c2c2) !important;
  font-weight: 600 !important;
}

.login-wx-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 2.4vh;
  height: 44px;
  color: #fff;
  font-size: 16px;
  font-weight: 600;
  background: linear-gradient(135deg, #69c0ff, #1890ff 50%, #13c2c2);
  border: none;
  border-radius: 12px;
  line-height: 44px;
}

.login-wx-btn::after {
  border: none;
}

.login-wx-btn--disabled {
  opacity: 0.45;
}

.login-footer {
  flex-shrink: 0;
  padding: 1vh 7vw 2vh;
  text-align: center;
}

.login-footer__line {
  display: block;
  color: rgba(255, 255, 255, 0.72);
  font-size: 12px;
  line-height: 1.5;
}

.login-footer__link {
  color: rgba(255, 255, 255, 0.95);
}

.login-footer__tip {
  display: block;
  margin-top: 0.5vh;
  color: rgba(255, 255, 255, 0.55);
  font-size: 11px;
  line-height: 1.4;
}
</style>
