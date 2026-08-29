<template>
  <view class="todo-page">
    <view class="todo-head pt-safe">
      <view class="todo-nav">
        <text class="todo-nav__title">待办</text>
      </view>
    </view>

    <view class="todo-body">
      <view
        v-for="sec in sections"
        :key="sec.key"
        class="todo-block"
      >
        <view class="todo-sec">
          <view class="todo-sec__left">
            <view class="todo-sec__bar" />
            <text class="todo-sec__title">{{ sec.title }}</text>
          </view>
          <text class="todo-sec__count">{{ sec.count }} 项</text>
        </view>

        <view
          v-for="item in sec.reviews"
          :key="item.id"
          class="sheet todo-card"
          hover-class="todo-press"
          @click="handleReview(item)"
        >
          <view class="todo-ic" :class="`tint-${item.tint}`">
            <text>{{ item.char }}</text>
          </view>
          <view class="todo-bd">
            <text class="todo-t">{{ item.title }}</text>
            <text class="todo-s">NO. {{ item.no }} · {{ item.dept }}{{ item.progress ? ` · ${item.progress}` : '' }}</text>
          </view>
          <view class="stamp" :class="`stamp-${item.stamp}`">
            <view class="stamp__dot" />
            <text class="stamp__txt">{{ item.status }}</text>
          </view>
        </view>

        <view
          v-for="item in sec.approves"
          :key="`ap-${item.id}`"
          class="sheet todo-card"
          hover-class="todo-press"
          @click="handleApprove(item)"
        >
          <view class="todo-ic tint-amber">
            <text>{{ item.char }}</text>
          </view>
          <view class="todo-bd">
            <text class="todo-t">{{ item.title }}</text>
            <text class="todo-s">NO. {{ item.no }} · {{ item.dept }}{{ item.progress ? ` · ${item.progress}` : '' }}</text>
          </view>
          <view class="stamp" :class="`stamp-${item.stamp}`">
            <view class="stamp__dot" />
            <text class="stamp__txt">{{ item.status }}</text>
          </view>
        </view>
      </view>

      <view v-if="loading && !sections.length" class="todo-s" style="padding: 12px 4px;">加载中…</view>

      <view v-if="!loading && !sections.length" class="todo-empty">
        <view class="todo-empty__ic">
          <wd-icon name="list" size="28px" color="#69C0FF" />
        </view>
        <text class="todo-empty__title">暂无待办</text>
        <text class="todo-empty__hint">委员意见和核定事项会显示在这里</text>
      </view>
    </view>
  </view>
</template>

<script lang="ts" setup>
import type { ProposalListItem } from '@/api/proposal'
import { fetchApprovalPending, fetchCommitteePending, fetchImprovementDepts } from '@/api/proposal'
import { statusLabel, statusStamp } from '@/pages/proposal/helpers'

defineOptions({
  name: 'Todo',
})

definePage({
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '待办',
    navigationBarTextStyle: 'black',
    backgroundColor: '#EEF5FF',
    backgroundColorTop: '#E6F4FF',
    backgroundColorBottom: '#F5FAFF',
  },
})

interface TodoItem {
  id: string
  no: string
  title: string
  dept: string
  who: string
  char: string
  tint: 'blue' | 'teal' | 'amber'
  status: string
  stamp: string
  progress?: string
}

interface TodoSection {
  key: 'review' | 'approve'
  title: string
  count: number
  reviews?: TodoItem[]
  approves?: TodoItem[]
}

const loading = ref(false)
const reviewTodos = ref<TodoItem[]>([])
const approveTodos = ref<TodoItem[]>([])
const deptNameMap = ref<Record<string, string>>({})

const sections = computed<TodoSection[]>(() => {
  const list: TodoSection[] = []
  if (reviewTodos.value.length) {
    list.push({
      key: 'review',
      title: '待出具意见',
      count: reviewTodos.value.length,
      reviews: reviewTodos.value,
    })
  }
  if (approveTodos.value.length) {
    list.push({
      key: 'approve',
      title: '待核定',
      count: approveTodos.value.length,
      approves: approveTodos.value,
    })
  }
  return list
})

onShow(() => {
  loadPending()
})

async function ensureDeptMap() {
  if (Object.keys(deptNameMap.value).length)
    return
  try {
    const depts = await fetchImprovementDepts()
    const map: Record<string, string> = {}
    for (const d of depts || []) {
      if (d.deptId)
        map[d.deptId] = d.deptName || d.deptId
    }
    deptNameMap.value = map
  }
  catch {
    // ignore
  }
}

async function loadPending() {
  loading.value = true
  try {
    await ensureDeptMap()
    const [reviewPage, approvePage] = await Promise.all([
      fetchCommitteePending({ pageNo: 1, pageSize: 50 }).catch(() => null),
      fetchApprovalPending({ pageNo: 1, pageSize: 50 }).catch(() => null),
    ])
    reviewTodos.value = (reviewPage?.records || []).map(item => mapTodo(item, '审', 'blue'))
    approveTodos.value = (approvePage?.records || []).map(item => mapTodo(item, '批', 'amber'))
  }
  catch (err) {
    console.error('加载待办失败', err)
    reviewTodos.value = []
    approveTodos.value = []
  }
  finally {
    loading.value = false
  }
}

function mapTodo(item: ProposalListItem, char: string, tint: TodoItem['tint']): TodoItem {
  return {
    id: item.id,
    no: item.proposalNo || '—',
    title: item.title || '未命名提案',
    dept: deptNameMap.value[item.deptId || ''] || item.deptId || '—',
    who: '提案人',
    char,
    tint,
    status: statusLabel(item.status),
    stamp: statusStamp(item.status),
    progress: item.reviewProgress,
  }
}

function handleReview(item: TodoItem) {
  uni.navigateTo({ url: `/pages/proposal/review?id=${item.id}` })
}

function handleApprove(item: TodoItem) {
  uni.navigateTo({ url: `/pages/proposal/approve?id=${item.id}` })
}
</script>

<style lang="scss" scoped>
.todo-page {
  min-height: 100vh;
  padding-bottom: calc(90px + env(safe-area-inset-bottom));
  background: linear-gradient(180deg, #e6f4ff 0%, #eef5ff 40%, #f5faff 100%);
}

.todo-head {
  position: sticky;
  top: 0;
  z-index: 20;
  padding: 0 16px 4px;
  background: linear-gradient(180deg, #e6f4ff 0%, rgba(238, 245, 255, 0.96) 70%, rgba(238, 245, 255, 0.88) 100%);
}

.todo-nav {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 46px;
}

.todo-nav__title {
  color: #1e2438;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 1px;
}

.todo-body {
  padding: 4px 16px 28px;
}

.todo-block:first-child .todo-sec {
  margin-top: 4px;
}

.todo-sec {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 18px 2px 10px;
}

.todo-sec__left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.todo-sec__bar {
  width: 4px;
  height: 14px;
  border-radius: 2px;
  background: linear-gradient(180deg, #1890ff, #69c0ff);
}

.todo-sec__title {
  color: #3a4260;
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.todo-sec__count {
  color: #aab1c9;
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.5px;
}

.sheet {
  margin-bottom: 10px;
  border: 1px solid rgba(255, 255, 255, 0.7);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.82);
  box-shadow: 0 8px 22px rgba(24, 144, 255, 0.08);
  touch-action: manipulation;
}

.todo-card {
  display: flex;
  align-items: center;
  gap: 12px;
  min-height: 68px;
  padding: 13px 14px;
  box-sizing: border-box;
}

.todo-ic {
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

.todo-bd {
  flex: 1;
  min-width: 0;
}

.todo-t {
  display: block;
  overflow: hidden;
  color: #1e2438;
  font-size: 14px;
  font-weight: 700;
  letter-spacing: 0.2px;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.todo-s {
  display: block;
  overflow: hidden;
  margin-top: 4px;
  color: #8a92ac;
  font-size: 12px;
  font-weight: 500;
  letter-spacing: 0.4px;
  line-height: 1.5;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.stamp {
  --stamp-c: #1890ff;
  --stamp-bg: #e6f4ff;
  display: inline-flex;
  flex-shrink: 0;
  align-items: center;
  gap: 5px;
  padding: 3px 9px;
  border-radius: 9999px;
  color: var(--stamp-c);
  background: var(--stamp-bg);
  line-height: 1.6;
  white-space: nowrap;
}

.stamp__dot {
  width: 4px;
  height: 4px;
  border-radius: 9999px;
  background: var(--stamp-c);
}

.stamp__txt {
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.4px;
}

.stamp-amber { --stamp-c: #d98f0e; --stamp-bg: #fef4de; }
.stamp-blue { --stamp-c: #1890ff; --stamp-bg: #e6f4ff; }
.stamp-teal { --stamp-c: #13c2c2; --stamp-bg: #e6fffb; }
.stamp-purple { --stamp-c: #2f54eb; --stamp-bg: #f0f5ff; }
.stamp-green { --stamp-c: #10b981; --stamp-bg: #e8f8ee; }
.stamp-gray { --stamp-c: #8a92ac; --stamp-bg: #eff2f9; }

.tint-blue {
  color: #1890ff;
  background: #e6f4ff;
}

.tint-teal {
  color: #13c2c2;
  background: #e6fffb;
}

.tint-amber {
  color: #d98f0e;
  background: #fef4de;
}

.todo-press {
  opacity: 0.94;
  transform: scale(0.99);
}

.todo-empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 56px 24px 32px;
}

.todo-empty__ic {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 56px;
  height: 56px;
  margin-bottom: 12px;
  border-radius: 18px;
  background: #e6f4ff;
}

.todo-empty__title {
  color: #5a6380;
  font-size: 14px;
  font-weight: 600;
}

.todo-empty__hint {
  margin-top: 6px;
  color: #9aa3bd;
  font-size: 12px;
}
</style>
