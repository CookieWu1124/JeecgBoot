<template>
  <view class="proposal-page">
    <view class="proposal-head pt-safe">
      <view class="proposal-nav">
        <text class="proposal-nav__title">提案列表</text>
      </view>

      <view class="proposal-search" :class="{ 'proposal-search--on': searchFocused }">
        <wd-icon name="search" size="16px" color="#9AA3BD" />
        <input
          v-model="keyword"
          class="proposal-search__input"
          type="text"
          confirm-type="search"
          placeholder="搜索提案名称 / 编号"
          placeholder-class="proposal-ph"
          placeholder-style="color:#9AA3BD;font-size:13px"
          @focus="searchFocused = true"
          @blur="searchFocused = false"
        >
        <view
          v-if="keyword"
          class="proposal-search__clear"
          hover-class="press"
          @click.stop="keyword = ''"
        >
          <wd-icon name="close-circle-fill" size="14px" color="#C2C8DC" />
        </view>
      </view>

      <scroll-view class="proposal-chips" scroll-x :show-scrollbar="false">
        <view class="proposal-chips__row">
          <view
            v-for="tab in FILTER_TABS"
            :key="tab.key"
            class="chip"
            :class="{ 'chip--on': activeTab === tab.key }"
            hover-class="press"
            @click="handleTab(tab.key)"
          >
            <text class="chip__txt">{{ tab.label }}</text>
          </view>
        </view>
      </scroll-view>
    </view>

    <view class="proposal-body">
      <view
        v-for="item in displayList"
        :key="item.no"
        class="prop"
        :style="{ borderLeftColor: item.band }"
        hover-class="prop-press"
        @click="handleOpen(item)"
      >
        <view class="prop-hd">
          <text class="prop-title">{{ item.title }}</text>
          <view class="stamp" :class="`stamp-${item.stamp}`">
            <view class="stamp__dot" />
            <text class="stamp__txt">{{ item.status }}</text>
          </view>
        </view>

        <text class="prop-no">NO. {{ item.no }} · {{ item.dept }} · {{ item.who }}</text>

        <view class="prop-meta">
          <text v-for="tag in item.nature" :key="tag" class="nat">{{ tag }}</text>
          <view v-if="item.score" class="stamp stamp-purple">
            <view class="stamp__dot" />
            <text class="stamp__txt">评分 {{ item.score }}</text>
          </view>
        </view>

        <view v-if="item.progress" class="prog">
          <view class="prog-bar">
            <view class="prog-bar__fill" :style="{ width: `${item.progress.width}%` }" />
          </view>
          <text class="prog-t">{{ item.progress.label }}</text>
        </view>
      </view>

      <view v-if="!displayList.length" class="proposal-empty">
        <view class="proposal-empty__ic">
          <wd-icon name="list" size="28px" color="#69C0FF" />
        </view>
        <text class="proposal-empty__title">暂无相关提案</text>
        <text class="proposal-empty__hint">{{ emptyHint }}</text>
        <view
          v-if="hasFilter"
          class="proposal-empty__reset"
          hover-class="press"
          @click="resetFilter"
        >
          <text>重置筛选</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script lang="ts" setup>
import type { FilterTab, ProposalItem, StampTone } from './mock'
import { MOCK_LIST } from './mock'

defineOptions({
  name: 'Proposal',
})

definePage({
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '提案列表',
    navigationBarTextStyle: 'black',
    backgroundColor: '#EEF5FF',
    backgroundColorTop: '#E6F4FF',
    backgroundColorBottom: '#F5FAFF',
  },
})

interface ProgressInfo {
  label: string
  width: number
}

const BAND: Record<StampTone, string> = {
  amber: '#D98F0E',
  blue: '#1890FF',
  teal: '#13C2C2',
  purple: '#2F54EB',
  green: '#10B981',
  red: '#F25555',
  gray: '#9AA2BC',
}

const FILTER_TABS: { key: FilterTab, label: string }[] = [
  { key: 'all', label: '全部' },
  { key: 'submit', label: '我提交的' },
  { key: 'join', label: '我参与的' },
  { key: 'improve', label: '我改善的' },
]

const keyword = ref('')
const activeTab = ref<FilterTab>('all')
const searchFocused = ref(false)

const hasFilter = computed(() => activeTab.value !== 'all' || !!keyword.value.trim())

const emptyHint = computed(() => {
  if (keyword.value.trim())
    return '换个关键词，或清空后再看看'
  if (activeTab.value !== 'all')
    return '这个分类暂时还没有提案'
  return '发起提案后会显示在这里'
})

const displayList = computed(() => {
  const q = keyword.value.trim().toLowerCase()
  return MOCK_LIST
    .filter((item) => {
      if (activeTab.value !== 'all' && !item.tabs.includes(activeTab.value))
        return false
      if (!q)
        return true
      return item.title.toLowerCase().includes(q) || item.no.includes(q)
    })
    .map(item => ({
      ...item,
      band: BAND[item.stamp],
      progress: toProgress(item.prog),
    }))
})

function toProgress(prog?: string): ProgressInfo | null {
  if (!prog)
    return null
  const matched = /^(\d+)\/(\d+)$/.exec(prog)
  if (!matched)
    return { label: prog, width: 60 }
  const current = Number(matched[1])
  const total = Number(matched[2])
  return {
    label: `审核进度 ${prog}`,
    width: total ? Math.round((current / total) * 100) : 0,
  }
}

function handleTab(key: FilterTab) {
  if (activeTab.value === key)
    return
  activeTab.value = key
  uni.pageScrollTo({ scrollTop: 0, duration: 180 })
}

function resetFilter() {
  keyword.value = ''
  activeTab.value = 'all'
}

function handleOpen(item: ProposalItem) {
  uni.navigateTo({ url: `/pages/proposal/detail?no=${item.no}` })
}
</script>

<style lang="scss" scoped>
.proposal-page {
  min-height: 100vh;
  padding-bottom: calc(90px + env(safe-area-inset-bottom));
  background: linear-gradient(180deg, #e6f4ff 0%, #eef5ff 40%, #f5faff 100%);
}

.proposal-head {
  position: sticky;
  top: 0;
  z-index: 20;
  padding: 0 16px 4px;
  background: linear-gradient(180deg, #e6f4ff 0%, rgba(238, 245, 255, 0.96) 70%, rgba(238, 245, 255, 0.88) 100%);
}

.proposal-nav {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 46px;
}

.proposal-nav__title {
  color: #1e2438;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 1px;
}

.proposal-search {
  display: flex;
  align-items: center;
  gap: 6px;
  height: 38px;
  margin-bottom: 12px;
  padding: 0 14px;
  border: 1px solid rgba(255, 255, 255, 0.72);
  border-radius: 9999px;
  background: rgba(255, 255, 255, 0.78);
  box-shadow: 0 6px 16px rgba(24, 144, 255, 0.06);
  box-sizing: border-box;
}

.proposal-search--on {
  border-color: rgba(24, 144, 255, 0.35);
  background: #fff;
  box-shadow: 0 0 0 3px rgba(24, 144, 255, 0.12);
}

.proposal-search__input {
  flex: 1;
  height: 22px;
  color: #1e2438;
  font-size: 13px;
  line-height: 22px;
}

.proposal-search__clear {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 22px;
  height: 22px;
}

.proposal-ph {
  color: #9aa3bd;
  font-size: 13px;
}

.proposal-chips {
  width: 100%;
  margin-bottom: 2px;
}

.proposal-chips::-webkit-scrollbar {
  display: none;
  height: 0;
}

.proposal-chips__row {
  display: inline-flex;
  flex-wrap: nowrap;
  gap: 6px;
  padding: 0 1px 6px;
}

.chip {
  display: flex;
  flex-shrink: 0;
  align-items: center;
  justify-content: center;
  height: 32px;
  padding: 0 16px;
  border: 1px solid rgba(255, 255, 255, 0.7);
  border-radius: 9999px;
  background: rgba(255, 255, 255, 0.62);
  box-sizing: border-box;
  touch-action: manipulation;
}

.chip__txt {
  color: #5a6380;
  font-size: 12px;
  letter-spacing: 0.3px;
  line-height: 1;
  white-space: nowrap;
}

.chip--on {
  border-color: transparent;
  background: linear-gradient(135deg, #40a9ff, #1890ff);
  box-shadow: 0 3px 8px rgba(24, 144, 255, 0.28);
}

.chip--on .chip__txt {
  color: #fff;
  font-weight: 500;
}

.proposal-body {
  padding: 4px 16px 28px;
}

.prop {
  margin-bottom: 12px;
  padding: 14px 16px;
  border: 1px solid rgba(255, 255, 255, 0.7);
  border-left: 4px solid #1890ff;
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.82);
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.08);
  touch-action: manipulation;
  transition: transform 0.16s ease, box-shadow 0.16s ease, opacity 0.16s ease;
}

.prop-press {
  opacity: 0.94;
  transform: scale(0.99);
}

.press {
  opacity: 0.86;
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

.prop-no {
  display: block;
  margin-top: 6px;
  color: #8a92ac;
  font-size: 12px;
  line-height: 1.5;
  letter-spacing: 0.4px;
}

.prop-meta {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 6px;
  margin-top: 10px;
}

.nat {
  padding: 3px 10px;
  border-radius: 9999px;
  background: #e6f4ff;
  color: #096dd9;
  font-size: 12px;
  font-weight: 500;
  letter-spacing: 0.5px;
  line-height: 1.6;
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
.stamp-red { --stamp-c: #f25555; --stamp-bg: #feefef; }
.stamp-gray { --stamp-c: #8a92ac; --stamp-bg: #eff2f9; }

.prog {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-top: 12px;
}

.prog-bar {
  flex: 1;
  height: 5px;
  overflow: hidden;
  border-radius: 9999px;
  background: #eaeef9;
}

.prog-bar__fill {
  height: 100%;
  border-radius: 9999px;
  background: linear-gradient(90deg, #69c0ff, #1890ff);
  transition: width 0.28s ease;
}

.prog-t {
  flex-shrink: 0;
  color: #6b7390;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.4px;
  white-space: nowrap;
}

.proposal-empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 56px 24px 32px;
}

.proposal-empty__ic {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 56px;
  height: 56px;
  margin-bottom: 12px;
  border-radius: 18px;
  background: #e6f4ff;
}

.proposal-empty__title {
  color: #5a6380;
  font-size: 14px;
  font-weight: 600;
}

.proposal-empty__hint {
  margin-top: 6px;
  color: #9aa3bd;
  font-size: 12px;
}

.proposal-empty__reset {
  margin-top: 16px;
  padding: 8px 18px;
  border-radius: 9999px;
  background: #1890ff;
  color: #fff;
  font-size: 13px;
  font-weight: 500;
  box-shadow: 0 6px 16px rgba(24, 144, 255, 0.28);
}
</style>
