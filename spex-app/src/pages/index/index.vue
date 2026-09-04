<script lang="ts" setup>
import type { AppHomeFeedItem, AppHomeTodoItem } from '@/api/proposal'
import { fetchAppHome } from '@/api/proposal'
import { storeToRefs } from 'pinia'
import { useTokenStore, useUserStore } from '@/store'

defineOptions({
  name: 'Home',
})

definePage({
  type: 'home',
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '首页',
    navigationBarTextStyle: 'white',
    backgroundColor: '#EEF5FF',
    backgroundColorTop: '#1890FF',
    backgroundColorBottom: '#EEF5FF',
  },
})

interface TodoItem {
  id: string
  kind: string
  char: string
  tint: string
  title: string
  sub: string
  stamp: string
  stampTint: string
}

interface FeedItem {
  id: string
  proposalId: string
  char: string
  tint: string
  title: string
  sub: string
  time: string
}

const FEED_STYLE: Record<string, { char: string, tint: string }> = {
  SUBMIT: { char: '通', tint: 'blue' },
  COMMITTEE_DONE: { char: '审', tint: 'purple' },
  APPROVE: { char: '批', tint: 'blue' },
  REJECT_FINAL: { char: '驳', tint: 'red' },
}

const userStore = useUserStore()
const tokenStore = useTokenStore()
const { userInfo } = storeToRefs(userStore)
const { hasLogin } = storeToRefs(tokenStore)

const isLoggedIn = computed(() => hasLogin.value && !!userInfo.value.username)
const displayName = computed(() => userInfo.value.nickname || userInfo.value.username || '用户')

/** 优先用后端 deptDesc（部门 · 组别）；本地 userInfo 仅兜底，不再写死「提案改善系统」 */
const deptDesc = ref('')
const displayDept = computed(() => {
  if (deptDesc.value)
    return deptDesc.value
  return userInfo.value.departName
    || userInfo.value.orgCodeTxt
    || userInfo.value.departIds_dictText
    || ''
})

/** 优先用后端 greeting（服务器时区）；本地仅作未登录/失败兜底（开发者工具 JS 时区常不准） */
function localGreeting() {
  const hour = new Date().getHours()
  if (hour < 12)
    return '早上好'
  if (hour < 18)
    return '下午好'
  return '晚上好'
}

const greeting = ref(localGreeting())
const greetText = computed(() => greeting.value || localGreeting())
const broadcastSlogan = ref('')

const kpis = ref([
  { label: '待办', value: 0, action: 'todo' },
  { label: '进行中', value: 0, action: 'proposal' },
  { label: '已批准', value: 0, action: 'proposal' },
])

const todos = ref<TodoItem[]>([])
const feeds = ref<FeedItem[]>([])
const unreadCount = ref(0)

function mapTodo(item: AppHomeTodoItem): TodoItem {
  const kind = item.kind || ''
  const no = item.proposalNo ? `NO. ${item.proposalNo}` : ''
  if (kind === 'review') {
    return {
      id: item.proposalId || '',
      kind,
      char: '审',
      tint: 'blue',
      title: item.title || '未命名提案',
      sub: [no, item.actionHint].filter(Boolean).join(' · '),
      stamp: item.statusLabel || '待审',
      stampTint: 'blue',
    }
  }
  if (kind === 'assign') {
    return {
      id: item.proposalId || '',
      kind,
      char: '派',
      tint: 'purple',
      title: item.title || '未命名提案',
      sub: [no, item.actionHint].filter(Boolean).join(' · '),
      stamp: item.statusLabel || '待派',
      stampTint: 'blue',
    }
  }
  return {
    id: item.proposalId || '',
    kind,
    char: '批',
    tint: 'amber',
    title: item.title || '未命名提案',
    sub: [no, item.actionHint].filter(Boolean).join(' · '),
    stamp: item.statusLabel || '待核',
    stampTint: 'amber',
  }
}

function mapFeed(item: AppHomeFeedItem, index: number): FeedItem {
  const style = FEED_STYLE[item.action || ''] || { char: '动', tint: 'blue' }
  const remark = [item.actionLabel, item.remark].filter(Boolean).join(' · ')
  return {
    id: `${item.proposalId || ''}-${item.action || ''}-${item.time || index}`,
    proposalId: item.proposalId || '',
    char: style.char,
    tint: style.tint,
    title: item.title ? `「${item.title}」` : '提案动态',
    sub: remark || item.proposalNo || '',
    time: item.time || '',
  }
}

async function loadHome() {
  if (!isLoggedIn.value) {
    greeting.value = localGreeting()
    deptDesc.value = ''
    broadcastSlogan.value = ''
    kpis.value = [
      { label: '待办', value: 0, action: 'todo' },
      { label: '进行中', value: 0, action: 'proposal' },
      { label: '已批准', value: 0, action: 'proposal' },
    ]
    todos.value = []
    feeds.value = []
    unreadCount.value = 0
    return
  }
  try {
    const res = await fetchAppHome()
    greeting.value = res?.greeting || localGreeting()
    deptDesc.value = res?.deptDesc || ''
    broadcastSlogan.value = (res?.broadcastSlogan || '').trim()
    kpis.value = [
      { label: '待办', value: Number(res?.todoCount) || 0, action: 'todo' },
      { label: '进行中', value: Number(res?.doingCount) || 0, action: 'proposal' },
      { label: '已批准', value: Number(res?.approvedCount) || 0, action: 'proposal' },
    ]
    todos.value = (res?.todoItems || []).map(mapTodo)
    feeds.value = (res?.feeds || []).map(mapFeed)
    unreadCount.value = Number(res?.unreadCount) || 0
  }
  catch (err) {
    console.error('加载首页失败', err)
  }
}

onShow(() => {
  loadHome()
})

function handleMsg() {
  if (!isLoggedIn.value) {
    uni.navigateTo({ url: '/pages/login/index' })
    return
  }
  uni.navigateTo({ url: '/pages/message/index?scope=all' })
}

function handleKpi(action: string) {
  if (action === 'todo') {
    uni.switchTab({ url: '/pages/todo/index' })
    return
  }
  uni.switchTab({ url: '/pages/proposal/index' })
}

function handleAllTodos() {
  uni.switchTab({ url: '/pages/todo/index' })
}

function handleTodoItem(item: TodoItem) {
  if (!item.id) {
    uni.switchTab({ url: '/pages/todo/index' })
    return
  }
  if (item.kind === 'review') {
    uni.navigateTo({ url: `/pages/proposal/review?id=${item.id}` })
    return
  }
  if (item.kind === 'approve') {
    uni.navigateTo({ url: `/pages/proposal/approve?id=${item.id}` })
    return
  }
  if (item.kind === 'assign') {
    uni.navigateTo({ url: `/pages/proposal/detail?id=${item.id}` })
    return
  }
  uni.switchTab({ url: '/pages/todo/index' })
}

function handleFeedItem(item: FeedItem) {
  if (!item.proposalId) {
    uni.switchTab({ url: '/pages/proposal/index' })
    return
  }
  uni.navigateTo({ url: `/pages/proposal/detail?id=${item.proposalId}` })
}
</script>

<template>
  <view class="home-page">
    <view class="home-hero">
      <view class="home-hero__blob home-hero__blob--rt" />
      <view class="home-hero__blob home-hero__blob--lt" />

      <view class="relative z-1 px-4 pt-safe">
        <view class="home-msg" hover-class="home-hover" @click="handleMsg">
          <wd-icon name="notification" size="18px" color="#fff" />
          <view v-if="unreadCount > 0" class="home-msg__dot" />
        </view>

        <text class="home-hi">
          {{ greetText }}，{{ isLoggedIn ? displayName : '访客' }}
        </text>
        <text class="home-sub">{{ displayDept }}</text>

        <view class="home-kpi">
          <view
            v-for="(item, index) in kpis"
            :key="item.label"
            class="home-kpi__item"
            :class="{ 'home-kpi__item--split': index < kpis.length - 1 }"
            hover-class="home-hover"
            @click="handleKpi(item.action)"
          >
            <text class="home-kpi__num">{{ isLoggedIn ? item.value : '--' }}</text>
            <text class="home-kpi__label">{{ item.label }}</text>
          </view>
        </view>
      </view>
    </view>

    <view class="home-body px-4">
      <view v-if="broadcastSlogan" class="home-broadcast">
        <view class="home-broadcast__ic">
          <wd-icon name="sound" size="16px" color="#FA8C16" />
        </view>
        <text class="home-broadcast__txt">{{ broadcastSlogan }}</text>
      </view>

      <view class="home-sec">
        <view class="home-sec__left">
          <view class="home-sec__bar" />
          <text class="home-sec__title">我的待办</text>
        </view>
        <view class="home-sec__more" hover-class="home-hover" @click="handleAllTodos">
          <text>全部</text>
          <wd-icon name="arrow-right" size="12px" color="#AAB1C9" />
        </view>
      </view>

      <view
        v-for="item in todos"
        :key="item.id"
        class="home-card"
        hover-class="home-hover"
        @click="handleTodoItem(item)"
      >
        <view class="home-card__ic" :class="`tint-${item.tint}`">
          <text>{{ item.char }}</text>
        </view>
        <view class="home-card__bd">
          <text class="home-card__title">{{ item.title }}</text>
          <text class="home-card__sub">{{ item.sub }}</text>
        </view>
        <text class="home-stamp" :class="`stamp-${item.stampTint}`">{{ item.stamp }}</text>
      </view>
      <view v-if="!todos.length" class="home-empty">
        <text class="home-empty__txt">暂无待办</text>
      </view>

      <view class="home-sec">
        <view class="home-sec__left">
          <view class="home-sec__bar" />
          <text class="home-sec__title">最新动态</text>
        </view>
      </view>

      <view
        v-for="item in feeds"
        :key="item.id"
        class="home-feed"
        hover-class="home-hover"
        @click="handleFeedItem(item)"
      >
        <view class="home-card__ic" :class="`tint-${item.tint}`">
          <text>{{ item.char }}</text>
        </view>
        <view class="home-card__bd">
          <text class="home-card__title">{{ item.title }}</text>
          <text class="home-card__sub">{{ item.sub }}</text>
          <text class="home-feed__time">{{ item.time }}</text>
        </view>
      </view>
      <view v-if="!feeds.length" class="home-empty">
        <text class="home-empty__txt">暂无动态</text>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.home-page {
  min-height: 100vh;
  padding-bottom: calc(90px + env(safe-area-inset-bottom));
  background: linear-gradient(180deg, #e6f4ff 0%, #eef5ff 40%, #f5faff 100%);
}

.home-hero {
  position: relative;
  overflow: hidden;
  padding: 4px 0 18px;
  border-radius: 0 0 26px 26px;
  background: linear-gradient(135deg, #096dd9 0%, #1890ff 48%, #40a9ff 100%);
  box-shadow: 0 16px 36px rgba(24, 144, 255, 0.22);
}

.home-hero__blob {
  position: absolute;
  border-radius: 9999px;
  pointer-events: none;
}

.home-hero__blob--rt {
  top: -46px;
  right: -46px;
  width: 170px;
  height: 170px;
  background: rgba(255, 255, 255, 0.09);
}

.home-hero__blob--lt {
  bottom: -70px;
  left: -34px;
  width: 150px;
  height: 150px;
  background: rgba(255, 255, 255, 0.06);
}

.home-msg {
  position: absolute;
  top: calc(env(safe-area-inset-top) + 8px);
  right: 16px;
  z-index: 2;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border: 1px solid rgba(255, 255, 255, 0.28);
  border-radius: 11px;
  background: rgba(255, 255, 255, 0.16);
}

.home-msg__dot {
  position: absolute;
  top: 6px;
  right: 6px;
  width: 7px;
  height: 7px;
  border-radius: 9999px;
  background: #ff4d4f;
  border: 1.5px solid rgba(255, 255, 255, 0.9);
}

.home-hi {
  display: block;
  padding-top: 22px;
  padding-right: 48px;
  color: #fff;
  font-size: 24px;
  font-weight: 700;
  letter-spacing: -0.3px;
}

.home-sub {
  display: block;
  margin-top: 4px;
  color: rgba(255, 255, 255, 0.88);
  font-size: 13.5px;
}

.home-kpi {
  display: flex;
  margin-top: 16px;
  padding: 11px 4px;
  border: 1px solid rgba(255, 255, 255, 0.22);
  border-radius: 14px;
  background: rgba(255, 255, 255, 0.14);
}

.home-kpi__item {
  display: flex;
  flex: 1;
  flex-direction: column;
  align-items: center;
}

.home-kpi__item--split {
  border-right: 1px solid rgba(255, 255, 255, 0.16);
}

.home-kpi__num {
  color: #fff;
  font-size: 24px;
  font-weight: 700;
  line-height: 1.1;
}

.home-kpi__label {
  margin-top: 2px;
  color: rgba(255, 255, 255, 0.82);
  font-size: 11.5px;
}

.home-body {
  padding-top: 4px;
}

.home-broadcast {
  display: flex;
  align-items: center;
  gap: 10px;
  margin: 8px 0 4px;
  padding: 12px 14px;
  border-radius: 14px;
  background: #fff;
  box-shadow: 0 8px 20px rgba(24, 56, 120, 0.06);
}

.home-broadcast__ic {
  display: flex;
  flex-shrink: 0;
  align-items: center;
  justify-content: center;
  width: 28px;
  height: 28px;
  border-radius: 9999px;
  background: rgba(250, 140, 22, 0.12);
}

.home-broadcast__txt {
  flex: 1;
  color: #3a4259;
  font-size: 13.5px;
  line-height: 1.45;
  font-weight: 500;
}

.home-empty {
  padding: 18px 8px 8px;
  text-align: center;
}

.home-empty__txt {
  color: #9aa3bd;
  font-size: 12px;
}

.home-sec {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 16px 2px 10px;
}

.home-sec__left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.home-sec__bar {
  width: 4px;
  height: 14px;
  border-radius: 2px;
  background: linear-gradient(180deg, #1890ff, #69c0ff);
}

.home-sec__title {
  color: #3a4260;
  font-size: 14px;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.home-sec__more {
  display: flex;
  align-items: center;
  gap: 2px;
  color: #aab1c9;
  font-size: 11.5px;
}

.home-card,
.home-feed {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 10px;
  padding: 13px 14px;
  background: rgba(255, 255, 255, 0.62);
  border: 1px solid rgba(255, 255, 255, 0.65);
  border-radius: 16px;
  box-shadow: 0 12px 28px rgba(24, 144, 255, 0.12);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  transition: transform 0.16s ease, box-shadow 0.16s ease, opacity 0.16s ease;
  overflow: hidden;
}

.home-feed {
  align-items: flex-start;
}

.home-card:active,
.home-feed:active {
  transform: translateY(1px) scale(0.99);
}

.home-card__ic {
  display: flex;
  flex-shrink: 0;
  align-items: center;
  justify-content: center;
  width: 42px;
  height: 42px;
  border-radius: 14px;
  font-size: 16px;
  font-weight: 700;
}

.home-card__bd {
  flex: 1;
  min-width: 0;
}

.home-card__title {
  display: block;
  overflow: hidden;
  color: #1e2438;
  font-size: 14px;
  font-weight: 700;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.home-feed .home-card__title {
  white-space: normal;
  line-height: 1.45;
}

.home-card__sub {
  display: block;
  margin-top: 4px;
  color: #6b7390;
  font-size: 12px;
  line-height: 1.55;
}

.home-feed__time {
  display: block;
  margin-top: 6px;
  color: #9aa3bd;
  font-size: 12px;
  letter-spacing: 0.5px;
}

.home-stamp {
  flex-shrink: 0;
  padding: 3px 9px;
  border-radius: 9999px;
  font-size: 11px;
  font-weight: 600;
  line-height: 1.6;
  white-space: nowrap;
  border: 1px solid rgba(255, 255, 255, 0.55);
}

.home-hover {
  opacity: 0.85;
}

.tint-blue {
  color: #1890ff;
  background: #e6f4ff;
}

.tint-amber {
  color: #d98f0e;
  background: #fef4de;
}

.tint-red {
  color: #f25555;
  background: #feefef;
}

.tint-purple {
  color: #2f54eb;
  background: #f0f5ff;
}

.stamp-amber {
  color: #d98f0e;
  background: #fef4de;
}

.stamp-blue {
  color: #1890ff;
  background: #e6f4ff;
}
</style>
