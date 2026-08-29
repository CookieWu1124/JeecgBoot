<script lang="ts" setup>
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
  char: string
  tint: string
  title: string
  sub: string
  stamp: string
  stampTint: string
}

interface FeedItem {
  char: string
  tint: string
  title: string
  sub: string
  time: string
}

const userStore = useUserStore()
const tokenStore = useTokenStore()
const { userInfo } = storeToRefs(userStore)
const { hasLogin } = storeToRefs(tokenStore)

const isLoggedIn = computed(() => hasLogin.value && !!userInfo.value.username)
const displayName = computed(() => userInfo.value.nickname || userInfo.value.username || '用户')
const displayDept = computed(() => {
  return userInfo.value.departName
    || userInfo.value.orgCodeTxt
    || userInfo.value.departIds_dictText
    || '提案改善系统'
})

const greetText = computed(() => {
  const hour = new Date().getHours()
  if (hour < 12)
    return '早上好'
  if (hour < 18)
    return '下午好'
  return '晚上好'
})

const kpis = ref([
  { label: '待办', value: 2, action: 'todo' },
  { label: '进行中', value: 2, action: 'proposal' },
  { label: '已结案', value: 1, action: 'proposal' },
])

const todos = ref<TodoItem[]>([
  {
    char: '审',
    tint: 'blue',
    title: '关注「产线换模时间过长改善」',
    sub: '计划书待批准人决策',
    stamp: '计划书待批',
    stampTint: 'amber',
  },
  {
    char: '池',
    tint: 'amber',
    title: '领取「包装线人效提升方案」',
    sub: '部门任务池待领取',
    stamp: '待领取',
    stampTint: 'amber',
  },
])

const feeds = ref<FeedItem[]>([
  {
    char: '通',
    tint: 'blue',
    title: '「车间物料标识标准化」已批准',
    sub: '批准人核定提案奖 ¥200，等待改善部门指派',
    time: '昨天 16:02',
  },
  {
    char: '驳',
    tint: 'red',
    title: '「产线换模时间过长改善」计划书被驳回',
    sub: '请补充效益测算依据后重新提交',
    time: '昨天 09:15',
  },
  {
    char: '评',
    tint: 'purple',
    title: '「安全通道划线规范」评分完成',
    sub: '总分 86.5 · 等级 A · 已签核归档',
    time: '08-22 15:30',
  },
])

function handleMsg() {
  uni.showToast({ title: '消息功能开发中', icon: 'none' })
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

function handleTodoItem() {
  uni.switchTab({ url: '/pages/todo/index' })
}

function handleFeedItem() {
  uni.showToast({ title: '详情开发中', icon: 'none' })
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
          <view class="home-msg__dot" />
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
        :key="item.title"
        class="home-card"
        hover-class="home-hover"
        @click="handleTodoItem"
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

      <view class="home-sec">
        <view class="home-sec__left">
          <view class="home-sec__bar" />
          <text class="home-sec__title">最新动态</text>
        </view>
      </view>

      <view
        v-for="item in feeds"
        :key="item.title"
        class="home-feed"
        hover-class="home-hover"
        @click="handleFeedItem"
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
  top: 7px;
  right: 8px;
  width: 7px;
  height: 7px;
  border: 1.5px solid #fff;
  border-radius: 9999px;
  background: #ff5a5f;
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
