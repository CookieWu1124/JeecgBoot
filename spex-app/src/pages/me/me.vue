<template>
  <view class="me-page">
    <view class="me-hero">
      <view class="me-hero__blob me-hero__blob--lt" />
      <view class="me-hero__blob me-hero__blob--rt" />

      <view class="relative z-1 px-4 pb-10 pt-safe">
        <view class="h-6" />

        <view class="flex flex-col items-center" hover-class="me-hover" @click="handleProfile">
          <view class="me-avatar">
            <image
              v-if="isLoggedIn && userInfo.avatar && !avatarError"
              class="me-avatar__img"
              :src="userInfo.avatar"
              mode="aspectFill"
              @error="onAvatarError"
            />
            <view v-else class="me-avatar__fallback">
              <text v-if="isLoggedIn" class="text-xl text-[#1890FF] font-semibold">{{ avatarText }}</text>
              <wd-icon v-else name="user" size="28px" color="#1890FF" />
            </view>
          </view>

          <text class="mt-2 text-lg text-white font-semibold tracking-wide">
            {{ isLoggedIn ? displayName : '点击登录' }}
          </text>
          <text class="mt-0.5 text-xs text-white/80">
            {{ displayMeta }}
          </text>

          <view v-if="isLoggedIn && roleTags.length" class="mt-2.5 flex flex-wrap items-center justify-center gap-1.5">
            <text v-for="tag in roleTags" :key="tag" class="me-tag">{{ tag }}</text>
          </view>
        </view>
      </view>
    </view>

    <view class="relative z-2 -mt-8 px-4 pb-8">
      <view class="me-card flex py-5">
        <view
          v-for="(item, index) in stats"
          :key="item.label"
          class="me-stat"
          :class="{ 'me-stat--split': index < stats.length - 1 }"
          hover-class="me-hover"
          @click="handleService"
        >
          <text class="text-xl text-slate-900 font-semibold tracking-tight">
            {{ isLoggedIn ? item.value : '--' }}
          </text>
          <text class="mt-1 text-xs text-slate-500">{{ item.label }}</text>
        </view>
      </view>

      <view class="me-card mt-3 px-2 py-4">
        <text class="mb-3 block px-2 text-sm text-slate-900 font-medium">常用服务</text>
        <view class="flex">
          <view
            v-for="item in services"
            :key="item.name"
            class="flex flex-1 flex-col items-center py-2"
            hover-class="me-hover"
            @click="handleService(item)"
          >
            <view class="me-icon" :class="item.tint">
              <wd-icon :name="item.icon" size="20px" />
            </view>
            <text class="mt-2 text-xs text-slate-600">{{ item.name }}</text>
          </view>
        </view>
      </view>

      <wd-cell-group custom-class="me-group" insert>
        <wd-cell
          v-for="item in accountMenus"
          :key="item.title"
          :title="item.title"
          :value="item.extra"
          is-link
          center
          @click="handleMenu(item)"
        >
          <template #prefix>
            <view class="me-icon me-icon--sm mr-2" :class="item.tint">
              <wd-icon :name="item.icon" size="16px" />
            </view>
          </template>
        </wd-cell>
      </wd-cell-group>

      <wd-cell-group custom-class="me-group" insert>
        <wd-cell
          v-for="item in supportMenus"
          :key="item.title"
          :title="item.title"
          :value="item.extra"
          is-link
          center
          @click="handleMenu(item)"
        >
          <template #prefix>
            <view class="me-icon me-icon--sm mr-2" :class="item.tint">
              <wd-icon :name="item.icon" size="16px" />
            </view>
          </template>
        </wd-cell>
      </wd-cell-group>

      <wd-button
        v-if="isLoggedIn"
        block
        size="large"
        custom-class="me-logout"
        @click="handleLogout"
      >
        退出登录
      </wd-button>
    </view>
  </view>
</template>

<script lang="ts" setup>
import { storeToRefs } from 'pinia'
import { useTokenStore, useUserStore } from '@/store'
import { fetchAppMeSummary, fetchAppUnreadCount } from '@/api/proposal'

defineOptions({
  name: 'Me',
})

definePage({
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '我的',
    navigationBarTextStyle: 'white',
    backgroundColor: '#EEF5FF',
    backgroundColorTop: '#1890FF',
    backgroundColorBottom: '#EEF5FF',
  },
})

interface MenuItem {
  title: string
  icon: string
  tint: string
  extra?: string
  action: 'todo' | 'about' | 'cache' | 'message'
}

interface ServiceItem {
  name: string
  icon: string
  tint: string
  action?: 'proposal' | 'score' | 'stats'
}

const userStore = useUserStore()
const tokenStore = useTokenStore()
const { userInfo } = storeToRefs(userStore)
const { hasLogin } = storeToRefs(tokenStore)

const isLoggedIn = computed(() => hasLogin.value && !!userInfo.value.username)
const displayName = computed(() => userInfo.value.nickname || userInfo.value.username || 'Spex 用户')

const positionLine = ref('')
const roleTags = ref<string[]>([])
const stats = ref([
  { label: '我的提案', value: '--' },
  { label: '采纳率', value: '0%' },
  { label: '累计奖金', value: '--' },
])

const displayMeta = computed(() => {
  if (!isLoggedIn.value)
    return '登录后查看提案与奖金数据'
  return positionLine.value || 'Spex 用户'
})

const avatarText = computed(() => displayName.value.slice(0, 1).toUpperCase())
const avatarError = ref(false)

const services: ServiceItem[] = [
  { name: '我的提案', icon: 'list', tint: 'tint-blue', action: 'proposal' },
  { name: '部门任务', icon: 'organization', tint: 'tint-cyan' },
  { name: '个人成绩', icon: 'trophy', tint: 'tint-amber', action: 'score' },
  { name: '统计看板', icon: 'dashboard', tint: 'tint-violet', action: 'stats' },
]

const accountMenus = ref<MenuItem[]>([
  { title: '账号与安全', icon: 'lock', tint: 'tint-blue', action: 'todo' },
  { title: '消息通知', icon: 'notification', tint: 'tint-violet', action: 'message' },
  { title: '通用设置', icon: 'settings', tint: 'tint-slate', action: 'todo' },
])

const supportMenus: MenuItem[] = [
  { title: '关于 Spex', icon: 'info', tint: 'tint-blue', extra: 'v1.0.0', action: 'about' },
  { title: '清除缓存', icon: 'delete', tint: 'tint-rose', action: 'cache' },
]

function formatBonus(raw: number | string | undefined | null) {
  const n = Number(raw)
  if (!Number.isFinite(n))
    return '¥0'
  return `¥${n.toLocaleString('zh-CN')}`
}

function resetMeSummary() {
  positionLine.value = ''
  roleTags.value = []
  stats.value = [
    { label: '我的提案', value: '--' },
    { label: '采纳率', value: '0%' },
    { label: '累计奖金', value: '--' },
  ]
}

async function loadMeSummary() {
  if (!isLoggedIn.value) {
    resetMeSummary()
    return
  }
  try {
    const res = await fetchAppMeSummary()
    positionLine.value = (res?.positionLine || '').trim()
    roleTags.value = (res?.roleTags || []).filter(Boolean)
    stats.value = [
      { label: '我的提案', value: String(res?.myProposalCount ?? 0) },
      { label: '采纳率', value: res?.adoptionRate || '0%' },
      { label: '累计奖金', value: formatBonus(res?.totalBonus ?? 0) },
    ]
  }
  catch {
    resetMeSummary()
  }
}

async function loadUnreadExtra() {
  const msgMenu = accountMenus.value.find(m => m.action === 'message')
  if (!msgMenu)
    return
  if (!isLoggedIn.value) {
    msgMenu.extra = undefined
    return
  }
  try {
    const count = Number(await fetchAppUnreadCount()) || 0
    msgMenu.extra = count > 0 ? `${count} 条未读` : undefined
  }
  catch {
    msgMenu.extra = undefined
  }
}

onShow(() => {
  loadMeSummary()
  loadUnreadExtra()
})

watch(() => userInfo.value.avatar, () => {
  avatarError.value = false
})

function onAvatarError() {
  avatarError.value = true
}

function handleProfile() {
  if (!isLoggedIn.value) {
    uni.navigateTo({ url: '/pages/login/index' })
    return
  }
  uni.showToast({ title: '个人资料即将上线', icon: 'none' })
}

function handleService(item?: ServiceItem) {
  if (item?.action === 'stats') {
    uni.navigateTo({ url: '/pages/stats/index' })
    return
  }
  if (item?.action === 'score') {
    uni.navigateTo({ url: '/pages/stats/index?tab=me' })
    return
  }
  if (item?.action === 'proposal') {
    uni.switchTab({ url: '/pages/proposal/index' })
    return
  }
  uni.showToast({ title: '功能即将上线', icon: 'none' })
}

function handleMenu(item: MenuItem) {
  if (item.action === 'message') {
    if (!isLoggedIn.value) {
      uni.navigateTo({ url: '/pages/login/index' })
      return
    }
    uni.navigateTo({ url: '/pages/message/index?scope=unread' })
    return
  }
  if (item.action === 'about') {
    uni.navigateTo({ url: '/pages/about/about' })
    return
  }
  if (item.action === 'cache') {
    uni.showModal({
      title: '清除缓存',
      content: '仅清理临时缓存，不会退出登录。',
      confirmColor: '#1890FF',
      success: (res) => {
        if (res.confirm)
          uni.showToast({ title: '缓存已清除', icon: 'success' })
      },
    })
    return
  }
  uni.showToast({ title: `${item.title}即将上线`, icon: 'none' })
}

function handleLogout() {
  uni.showModal({
    title: '退出登录',
    content: '确定要退出当前账号吗？',
    confirmColor: '#ef4444',
    success: async (res) => {
      if (!res.confirm)
        return
      await tokenStore.logout()
      resetMeSummary()
      uni.showToast({ title: '已退出登录', icon: 'none' })
    },
  })
}
</script>

<style lang="scss" scoped>
.me-page {
  min-height: 100vh;
  background: linear-gradient(180deg, #e6f4ff 0%, #eef5ff 40%, #f5faff 100%);
  padding-bottom: calc(90px + env(safe-area-inset-bottom));
}

.me-hero {
  position: relative;
  overflow: hidden;
  border-radius: 0 0 26px 26px;
  background: linear-gradient(135deg, #096dd9 0%, #1890ff 48%, #40a9ff 100%);
  box-shadow: 0 16px 36px rgba(24, 144, 255, 0.22);
}

.me-hero__blob {
  position: absolute;
  border-radius: 9999px;
  background: rgba(255, 255, 255, 0.12);
  pointer-events: none;
}

.me-avatar {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 60px;
  height: 60px;
  border-radius: 9999px;
  background: #fff;
  box-shadow: 0 8px 18px rgba(24, 144, 255, 0.18);

  &__img,
  &__fallback {
    width: 54px;
    height: 54px;
    border-radius: 9999px;
  }

  &__fallback {
    display: flex;
    align-items: center;
    justify-content: center;
    background: #e6f4ff;
  }
}

.me-tag {
  padding: 2px 10px;
  border: 1px solid rgba(255, 255, 255, 0.45);
  border-radius: 9999px;
  background: rgba(255, 255, 255, 0.16);
  color: #fff;
  font-size: 11px;
  line-height: 16px;
}

.me-hover {
  opacity: 0.72;
}

.me-stat {
  display: flex;
  flex: 1;
  flex-direction: column;
  align-items: center;
}

.me-stat--split {
  border-right: 1px solid #e6f4ff;
}

.me-hero__blob--lt {
  top: -48px;
  left: -36px;
  width: 160px;
  height: 160px;
}

.me-hero__blob--rt {
  right: -28px;
  bottom: 12px;
  width: 120px;
  height: 120px;
  background: rgba(125, 211, 252, 0.22);
}

.me-card {
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(15, 23, 42, 0.06);
}

.me-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border-radius: 12px;

  &--sm {
    width: 28px;
    height: 28px;
    border-radius: 8px;
  }
}

.tint-blue {
  color: #1890ff;
  background: #e6f4ff;
}

.tint-cyan {
  color: #13c2c2;
  background: #e6fffb;
}

.tint-amber {
  color: #d97706;
  background: #fffbeb;
}

.tint-violet {
  color: #7c3aed;
  background: #f5f3ff;
}

.tint-slate {
  color: #475569;
  background: #f1f5f9;
}

.tint-rose {
  color: #e11d48;
  background: #fff1f2;
}

:deep(.me-group) {
  margin-top: 12px;
  margin-right: 0;
  margin-left: 0;
  border-radius: 16px;
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.08);
  overflow: hidden;
}

:deep(.me-logout) {
  margin-top: 16px;
  height: 44px !important;
  border: none !important;
  border-radius: 12px !important;
  background: #fff !important;
  color: #ef4444 !important;
  font-weight: 500 !important;
  box-shadow: 0 8px 24px rgba(15, 23, 42, 0.06);
}
</style>
