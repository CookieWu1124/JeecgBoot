<script lang="ts" setup>
import type { AppMessageItem } from '@/api/proposal'
import {
  fetchAppMessages,
  fetchAppUnreadCount,
  markAppMessageRead,
  markAppMessagesReadAll,
} from '@/api/proposal'

defineOptions({
  name: 'Message',
})

definePage({
  style: {
    navigationBarTitleText: '消息通知',
    navigationBarBackgroundColor: '#EEF5FF',
    backgroundColor: '#EEF5FF',
  },
})

const FEED_STYLE: Record<string, { char: string, tint: string }> = {
  SUBMIT: { char: '通', tint: 'blue' },
  COMMITTEE_DONE: { char: '审', tint: 'purple' },
  APPROVE: { char: '批', tint: 'blue' },
  REJECT_FINAL: { char: '驳', tint: 'red' },
}

interface ViewItem {
  id: string
  proposalId: string
  char: string
  tint: string
  title: string
  sub: string
  time: string
  unread: boolean
}

const scope = ref<'all' | 'unread'>('all')
const items = ref<ViewItem[]>([])
const loading = ref(false)
const markingAll = ref(false)
const finished = ref(false)
const pageNo = ref(1)
const pageSize = 20
const unreadCount = ref(0)

const pageTitle = computed(() => scope.value === 'unread' ? '未读消息' : '全部动态')
const showReadAll = computed(() => unreadCount.value > 0)

onLoad((query) => {
  const raw = String(query?.scope || 'all').toLowerCase()
  scope.value = raw === 'unread' ? 'unread' : 'all'
  uni.setNavigationBarTitle({ title: pageTitle.value })
})

onShow(() => {
  resetAndLoad()
})

function mapItem(row: AppMessageItem): ViewItem {
  const style = FEED_STYLE[row.action || ''] || { char: '动', tint: 'blue' }
  const remark = [row.actionLabel, row.remark].filter(Boolean).join(' · ')
  return {
    id: row.id || '',
    proposalId: row.proposalId || '',
    char: style.char,
    tint: style.tint,
    title: row.title ? `「${row.title}」` : '提案动态',
    sub: remark || row.proposalNo || '',
    time: row.time || '',
    unread: !!row.unread,
  }
}

async function refreshUnreadCount() {
  try {
    unreadCount.value = Number(await fetchAppUnreadCount()) || 0
  }
  catch {
    unreadCount.value = 0
  }
}

async function resetAndLoad() {
  pageNo.value = 1
  finished.value = false
  items.value = []
  await Promise.all([loadMore(), refreshUnreadCount()])
}

async function loadMore() {
  if (loading.value || finished.value)
    return
  loading.value = true
  try {
    const res = await fetchAppMessages({
      scope: scope.value,
      pageNo: pageNo.value,
      pageSize,
    })
    const records = (res?.records || []).map(mapItem)
    items.value = pageNo.value === 1 ? records : items.value.concat(records)
    const total = Number(res?.total) || 0
    if (items.value.length >= total || records.length < pageSize)
      finished.value = true
    else
      pageNo.value += 1
  }
  catch (err) {
    console.error('加载消息失败', err)
    uni.showToast({ title: '加载失败', icon: 'none' })
  }
  finally {
    loading.value = false
  }
}

async function handleOpen(item: ViewItem) {
  if (item.unread && item.id) {
    try {
      await markAppMessageRead(item.id)
      if (scope.value === 'unread') {
        items.value = items.value.filter(x => x.id !== item.id)
      }
      else {
        item.unread = false
      }
      if (unreadCount.value > 0)
        unreadCount.value -= 1
    }
    catch (err) {
      console.error('标记已读失败', err)
    }
  }
  if (!item.proposalId) {
    uni.showToast({ title: '提案不存在', icon: 'none' })
    return
  }
  uni.navigateTo({ url: `/pages/proposal/detail?id=${item.proposalId}` })
}

function handleReadAll() {
  if (!showReadAll.value || markingAll.value)
    return
  uni.showModal({
    title: '全部已读',
    content: `确定将 ${unreadCount.value} 条未读标为已读？`,
    confirmColor: '#1890FF',
    success: async (res) => {
      if (!res.confirm)
        return
      markingAll.value = true
      try {
        await markAppMessagesReadAll()
        unreadCount.value = 0
        if (scope.value === 'unread') {
          items.value = []
          finished.value = true
        }
        else {
          items.value.forEach((item) => {
            item.unread = false
          })
        }
        uni.showToast({ title: '已全部已读', icon: 'success' })
      }
      catch (err) {
        console.error('全部已读失败', err)
        uni.showToast({ title: '操作失败', icon: 'none' })
      }
      finally {
        markingAll.value = false
      }
    },
  })
}

onReachBottom(() => {
  loadMore()
})
</script>

<template>
  <view class="msg-page">
    <view v-if="showReadAll" class="msg-toolbar">
      <text class="msg-toolbar__hint">{{ unreadCount }} 条未读</text>
      <text class="msg-toolbar__btn" @click="handleReadAll">
        {{ markingAll ? '处理中…' : '全部已读' }}
      </text>
    </view>

    <view
      v-for="item in items"
      :key="item.id"
      class="msg-card"
      hover-class="msg-hover"
      @click="handleOpen(item)"
    >
      <view v-if="item.unread" class="msg-dot" />
      <view class="msg-card__ic" :class="`tint-${item.tint}`">
        <text>{{ item.char }}</text>
      </view>
      <view class="msg-card__bd">
        <text class="msg-card__title">{{ item.title }}</text>
        <text class="msg-card__sub">{{ item.sub }}</text>
        <text class="msg-card__time">{{ item.time }}</text>
      </view>
    </view>

    <view v-if="loading && !items.length" class="msg-empty">
      <text class="msg-empty__txt">加载中…</text>
    </view>
    <view v-else-if="!items.length" class="msg-empty">
      <text class="msg-empty__txt">{{ scope === 'unread' ? '暂无未读消息' : '暂无动态' }}</text>
    </view>
    <view v-else-if="finished" class="msg-end">
      <text class="msg-empty__txt">没有更多了</text>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.msg-page {
  min-height: 100vh;
  padding: 12px 16px calc(24px + env(safe-area-inset-bottom));
  background: linear-gradient(180deg, #e6f4ff 0%, #eef5ff 40%, #f5faff 100%);
}

.msg-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
  padding: 10px 14px;
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.72);
  border: 1px solid rgba(255, 255, 255, 0.7);
}

.msg-toolbar__hint {
  color: #6b7390;
  font-size: 12px;
}

.msg-toolbar__btn {
  color: #1890ff;
  font-size: 13px;
  font-weight: 600;
}

.msg-card {
  position: relative;
  display: flex;
  align-items: flex-start;
  gap: 12px;
  margin-bottom: 10px;
  padding: 13px 14px;
  background: rgba(255, 255, 255, 0.62);
  border: 1px solid rgba(255, 255, 255, 0.65);
  border-radius: 16px;
  box-shadow: 0 12px 28px rgba(24, 144, 255, 0.12);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
}

.msg-hover {
  opacity: 0.85;
}

.msg-card__ic {
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

.msg-dot {
  position: absolute;
  top: 10px;
  right: 12px;
  width: 8px;
  height: 8px;
  border-radius: 9999px;
  background: #f5222d;
}

.msg-card__bd {
  flex: 1;
  min-width: 0;
}

.msg-card__title {
  display: block;
  color: #1e2438;
  font-size: 14px;
  font-weight: 700;
  line-height: 1.45;
}

.msg-card__sub {
  display: block;
  margin-top: 4px;
  color: #6b7390;
  font-size: 12px;
  line-height: 1.55;
}

.msg-card__time {
  display: block;
  margin-top: 6px;
  color: #9aa3bd;
  font-size: 12px;
  letter-spacing: 0.5px;
}

.msg-empty,
.msg-end {
  padding: 28px 8px;
  text-align: center;
}

.msg-empty__txt {
  color: #9aa3bd;
  font-size: 12px;
}

.tint-blue {
  color: #1890ff;
  background: #e6f4ff;
}

.tint-red {
  color: #f25555;
  background: #feefef;
}

.tint-purple {
  color: #2f54eb;
  background: #f0f5ff;
}
</style>
