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
          :key="item.no"
          class="sheet todo-card"
          hover-class="todo-press"
          @click="handleReview(item.no)"
        >
          <view class="todo-ic" :class="`tint-${item.tint}`">
            <text>{{ item.char }}</text>
          </view>
          <view class="todo-bd">
            <text class="todo-t">{{ item.title }}</text>
            <text class="todo-s">NO. {{ item.no }} · {{ item.dept }} · {{ item.who }}</text>
          </view>
          <view class="stamp" :class="`stamp-${item.stamp}`">
            <view class="stamp__dot" />
            <text class="stamp__txt">{{ item.status }}</text>
          </view>
        </view>

        <view
          v-for="item in sec.approves"
          :key="`${item.no}-${item.status}`"
          class="sheet prop"
          :style="{ borderLeftColor: BAND[item.band] }"
          hover-class="todo-press"
          @click="handleApprove(item)"
        >
          <view class="prop-hd">
            <text class="prop-title">{{ item.title }}</text>
            <view class="stamp" :class="`stamp-${item.stamp}`">
              <view class="stamp__dot" />
              <text class="stamp__txt">{{ item.status }}</text>
            </view>
          </view>

          <text class="todo-s">{{ item.sub }}</text>

          <view v-if="item.votes.length || item.hint" class="prop-meta">
            <view
              v-for="vote in item.votes"
              :key="vote.label"
              class="stamp"
              :class="`stamp-${vote.tone}`"
            >
              <view class="stamp__dot" />
              <text class="stamp__txt">{{ vote.label }}</text>
            </view>
            <text v-if="item.hint" class="prop-hint">{{ item.hint }}</text>
          </view>

          <text v-if="item.footer" class="prop-ft">{{ item.footer }}</text>
        </view>
      </view>

      <view v-if="!sections.length" class="todo-empty">
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
import type { ApproveTodo, ReviewTodo } from './mock'
import { APPROVE_TODOS, BAND, REVIEW_TODOS } from './mock'

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

interface TodoSection {
  key: 'review' | 'approve'
  title: string
  count: number
  reviews?: ReviewTodo[]
  approves?: ApproveTodo[]
}

const sections = computed<TodoSection[]>(() => {
  const list: TodoSection[] = []
  if (REVIEW_TODOS.length) {
    list.push({
      key: 'review',
      title: '待出具意见',
      count: REVIEW_TODOS.length,
      reviews: REVIEW_TODOS,
    })
  }
  if (APPROVE_TODOS.length) {
    list.push({
      key: 'approve',
      title: '待核定',
      count: APPROVE_TODOS.length,
      approves: APPROVE_TODOS,
    })
  }
  return list
})

function handleReview(no: string) {
  uni.navigateTo({ url: `/pages/proposal/review?no=${no}` })
}

function handleApprove(item: ApproveTodo) {
  if (item.status === '待批准') {
    uni.navigateTo({ url: `/pages/proposal/approve?no=${item.no}` })
    return
  }
  uni.navigateTo({ url: `/pages/proposal/detail?no=${item.no}` })
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
