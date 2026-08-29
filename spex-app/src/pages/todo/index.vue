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

        <view v-if="loading && !sec.reviews?.length" class="todo-s" style="padding: 12px 4px;">加载中…</view>
      </view>

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
import { fetchCommitteePending, fetchImprovementDepts } from '@/api/proposal'
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

interface ReviewTodoItem {
  id: string
  no: string
  title: string
  dept: string
  who: string
  char: string
  tint: 'blue' | 'teal'
  status: string
  stamp: string
  progress?: string
}

interface TodoSection {
  key: 'review' | 'approve'
  title: string
  count: number
  reviews?: ReviewTodoItem[]
}

const loading = ref(false)
const reviewTodos = ref<ReviewTodoItem[]>([])
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
  return list
})

onShow(() => {
  loadPending()
})

async function loadPending() {
  loading.value = true
  try {
    if (!Object.keys(deptNameMap.value).length) {
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
    const page = await fetchCommitteePending({ pageNo: 1, pageSize: 50 })
    const records = page?.records || []
    reviewTodos.value = records.map(mapReviewTodo)
  }
  catch (err) {
    console.error('加载委员待办失败', err)
    reviewTodos.value = []
  }
  finally {
    loading.value = false
  }
}

function mapReviewTodo(item: ProposalListItem): ReviewTodoItem {
  const title = item.title || '未命名提案'
  return {
    id: item.id,
    no: item.proposalNo || '—',
    title,
    dept: deptNameMap.value[item.deptId || ''] || item.deptId || '—',
    who: '提案人',
    char: '审',
    tint: 'blue',
    status: statusLabel(item.status),
    stamp: statusStamp(item.status),
    progress: item.reviewProgress,
  }
}

function handleReview(item: ReviewTodoItem) {
  uni.navigateTo({ url: `/pages/proposal/review?id=${item.id}` })
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

.prop {
  margin-bottom: 12px;
  padding: 14px 16px;
  border-left: 4px solid #1890ff;
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.08);
}

.prop-hd {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 10px;
}

.prop-title {
  flex: 1;
  min-width: 0;
  color: #1e2438;
  font-size: 16px;
  font-weight: 700;
  line-height: 1.5;
  letter-spacing: 0.2px;
}

.prop-meta {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 6px;
  margin-top: 10px;
}

.prop-hint,
.prop-ft {
  color: #6b7390;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.4px;
  line-height: 1.5;
}

.prop-ft {
  display: block;
  margin-top: 10px;
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
