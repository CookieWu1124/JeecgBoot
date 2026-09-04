<template>
  <view class="stats-page">
    <view class="stats-nav pt-safe">
      <view class="stats-nav__bar">
        <view class="stats-back" hover-class="stats-press" @click="handleBack">
          <wd-icon name="arrow-left" size="18px" color="#5A6380" />
        </view>
        <text class="stats-nav__title">统计看板</text>
      </view>
      <view class="stats-nav__tabs">
        <stats-chips :items="STATS_TABS" :active="tab" @change="switchTab" />
      </view>
    </view>

    <view class="stats-body">
      <template v-if="tab === 'overview'">
        <view class="stats-period">
          <stats-chips :items="PERIODS" :active="period" @change="onPeriodChange" />
        </view>

        <view v-if="!overview.metrics.length" class="stats-empty">
          <text class="stats-empty__title">暂无统计数据</text>
          <text class="stats-empty__hint">统计接口尚未对接</text>
        </view>

        <view v-else class="metric-grid">
          <view v-for="item in overview.metrics" :key="item.key" class="metric">
            <text class="metric__k">{{ item.label }}</text>
            <view class="metric__num">
              <text class="metric__v" :class="{ 'metric__v--acc': item.accent }">{{ item.value }}</text>
              <text v-if="item.unit" class="metric__u">{{ item.unit }}</text>
            </view>
            <text v-if="item.hint" class="metric__d" :class="item.hintTone === 'ok' ? 'metric__d--ok' : 'metric__d--sub'">
              {{ item.hint }}
            </text>
          </view>
        </view>

        <template v-if="overview.metrics.length">
        <view class="stats-card">
          <view class="stats-card__hd">
            <view class="stats-idx"><text class="stats-idx__txt">T</text></view>
            <text class="stats-card__name">月度提案量</text>
          </view>
          <view class="bar-chart">
            <view
              v-for="item in overview.bars"
              :key="item.label"
              class="bar-col"
              :class="{ 'bar-col--hot': item.hot }"
            >
              <view class="bar-col__track">
                <view class="bar-col__fill" :style="{ height: `${item.height}%` }" />
              </view>
              <text class="bar-col__lab">{{ item.label }}</text>
            </view>
          </view>
        </view>

        <view class="stats-card">
          <view class="stats-card__hd">
            <view class="stats-idx"><text class="stats-idx__txt">N</text></view>
            <text class="stats-card__name">改善性质分布</text>
          </view>
          <view class="donut-wrap">
            <view class="donut" :style="{ background: donutBg }">
              <view class="donut__hole">
                <text class="donut__num">{{ natureTotal }}件</text>
              </view>
            </view>
            <view class="leg">
              <view v-for="item in overview.natures" :key="item.name" class="leg-row">
                <view class="leg-row__dot" :style="{ background: item.color }" />
                <text class="leg-row__name">{{ item.name }}</text>
                <text class="leg-row__val">{{ item.value }}</text>
              </view>
            </view>
          </view>
        </view>

        <view class="stats-card">
          <view class="stats-card__hd">
            <view class="stats-idx"><text class="stats-idx__txt">D</text></view>
            <text class="stats-card__name">部门提案排行</text>
          </view>
          <view
            v-for="(item, index) in deptRows"
            :key="item.name"
            class="hbar"
            :class="{ 'hbar--last': index === deptRows.length - 1 }"
          >
            <text class="hbar__nm">{{ item.name }}</text>
            <view class="hbar__tk">
              <view
                class="hbar__fill"
                :class="{ 'hbar__fill--top': index === 0 }"
                :style="{ width: `${item.width}%` }"
              />
            </view>
            <text class="hbar__vl">{{ item.value }}</text>
          </view>
        </view>
        </template>
      </template>

      <template v-else-if="tab === 'me'">
        <view class="score-hero">
          <text class="score-hero__who">{{ scoreName }} · 个人成绩单</text>
          <text class="score-hero__title">暂无个人成绩</text>
          <text class="score-hero__sub">统计接口尚未对接</text>
        </view>

        <view v-if="MY_METRICS.length" class="metric-grid">
          <view v-for="item in MY_METRICS" :key="item.key" class="metric">
            <text class="metric__k">{{ item.label }}</text>
            <view class="metric__num">
              <text class="metric__v" :class="{ 'metric__v--acc': item.accent }">{{ item.value }}</text>
              <text v-if="item.unit" class="metric__u">{{ item.unit }}</text>
            </view>
          </view>
        </view>

        <view class="stats-banner">
          <text class="stats-banner__ic">i</text>
          <text class="stats-banner__txt">金额仅本人可见；排行榜不展示他人奖金</text>
        </view>
      </template>

      <template v-else>
        <view class="stats-period">
          <stats-chips :items="RANK_TABS" :active="rankKey" @change="onRankChange" />
        </view>

        <view v-if="!rankRows.length" class="stats-empty">
          <text class="stats-empty__title">暂无排行数据</text>
          <text class="stats-empty__hint">统计接口尚未对接</text>
        </view>

        <view v-else class="stats-card">
          <view
            v-for="(item, index) in rankRows"
            :key="`${rankKey}-${item.no}-${item.name}`"
            class="rank-row"
            :class="{
              'rank-row--me': item.name === scoreName,
              'rank-row--last': index === rankRows.length - 1,
            }"
          >
            <text class="rank-no" :class="`rank-no--${item.no}`">{{ item.no }}</text>
            <view class="rank-info">
              <text class="rank-name">{{ item.name }}</text>
              <text class="rank-meta">{{ item.dept }}</text>
            </view>
            <text class="rank-val">{{ item.value }}</text>
          </view>
        </view>
      </template>
    </view>
  </view>
</template>

<script lang="ts" setup>
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/store'
import {
  MY_METRICS,
  OVERVIEW,
  PERIODS,
  RANK_DATA,
  RANK_TABS,
  STATS_TABS,
  type PeriodKey,
  type RankKey,
  type StatsTab,
} from './stats.data'
import StatsChips from './stats-chips.vue'

defineOptions({
  name: 'ProposalStats',
})

definePage({
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '统计看板',
    navigationBarTextStyle: 'black',
    backgroundColor: '#EEF5FF',
    backgroundColorTop: '#E6F4FF',
    backgroundColorBottom: '#F5FAFF',
  },
})

const userStore = useUserStore()
const { userInfo } = storeToRefs(userStore)

const tab = ref<StatsTab>('overview')
const period = ref<PeriodKey>('year')
const rankKey = ref<RankKey>('submit')

const overview = computed(() => OVERVIEW[period.value])
const natureTotal = computed(() =>
  overview.value.natures.reduce((sum, item) => sum + item.value, 0),
)
const donutBg = computed(() => {
  const items = overview.value.natures
  if (!items.length)
    return '#eef2f8'
  const total = natureTotal.value || 1
  let acc = 0
  const stops = items.map((item) => {
    const start = (acc / total) * 100
    acc += item.value
    return `${item.color} ${start}% ${(acc / total) * 100}%`
  })
  return `conic-gradient(${stops.join(',')})`
})
const deptRows = computed(() => {
  const list = overview.value.depts
  const max = Math.max(...list.map(item => item.value), 1)
  return list.map(item => ({
    ...item,
    width: Math.round((item.value / max) * 100),
  }))
})
const scoreName = computed(() =>
  userInfo.value.nickname || userInfo.value.username || '我',
)
const rankRows = computed(() => RANK_DATA[rankKey.value])

function switchTab(key: string) {
  tab.value = key as StatsTab
  uni.pageScrollTo({ scrollTop: 0, duration: 180 })
}

function onPeriodChange(key: string) {
  period.value = key as PeriodKey
}

function onRankChange(key: string) {
  rankKey.value = key as RankKey
}

function handleBack() {
  const pages = getCurrentPages()
  if (pages.length > 1) {
    uni.navigateBack()
    return
  }
  uni.switchTab({ url: '/pages/me/me' })
}

onLoad((query) => {
  const next = String(query?.tab || '')
  if (next === 'me' || next === 'rank' || next === 'overview')
    tab.value = next
})
</script>

<style lang="scss" scoped>
.stats-page {
  min-height: 100vh;
  padding-bottom: calc(24px + env(safe-area-inset-bottom));
  background:
    radial-gradient(320px 220px at 10% 0%, rgba(105, 192, 255, 0.28), transparent 60%),
    radial-gradient(280px 240px at 100% 18%, rgba(54, 207, 201, 0.16), transparent 55%),
    linear-gradient(180deg, #e6f4ff 0%, #f0f8ff 40%, #eef5ff 70%, #f5faff 100%);
}

.stats-nav {
  position: sticky;
  top: 0;
  z-index: 20;
  background: linear-gradient(180deg, rgba(230, 244, 255, 0.96) 0%, rgba(240, 248, 255, 0.94) 100%);
}

.stats-nav__bar {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 46px;
}

.stats-back {
  position: absolute;
  left: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border: 1px solid rgba(255, 255, 255, 0.65);
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.55);
}

.stats-nav__title {
  color: #1e2438;
  font-size: 17px;
  font-weight: 600;
  letter-spacing: 1px;
}

.stats-nav__tabs {
  padding: 0 16px 10px;
}

.stats-body {
  padding: 4px 16px 8px;
}

.stats-empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 48px 16px 24px;
}

.stats-empty__title {
  color: #5a6380;
  font-size: 14px;
  font-weight: 600;
}

.stats-empty__hint {
  margin-top: 6px;
  color: #9aa3bd;
  font-size: 12px;
}

.stats-period {
  margin-bottom: 13px;
}

.metric-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-bottom: 14px;
}

.metric {
  width: calc(50% - 5px);
  padding: 14px 15px 13px;
  border: 1px solid rgba(255, 255, 255, 0.7);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.78);
  box-shadow: 0 8px 22px rgba(24, 144, 255, 0.08);
  box-sizing: border-box;
}

.metric__k {
  color: #8a92ac;
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 1.5px;
}

.metric__num {
  display: flex;
  align-items: baseline;
  margin-top: 5px;
}

.metric__v {
  color: #1e2438;
  font-size: 28px;
  font-weight: 700;
  letter-spacing: 0.5px;
  line-height: 1.15;
}

.metric__v--acc {
  color: #13c2c2;
}

.metric__u {
  margin-left: 3px;
  color: #9aa3bd;
  font-size: 12px;
  font-weight: 500;
  letter-spacing: 1px;
}

.metric__d {
  display: block;
  margin-top: 5px;
  font-size: 10.5px;
  letter-spacing: 0.5px;
}

.metric__d--ok {
  color: #10b981;
}

.metric__d--sub {
  color: #6b7390;
}

.stats-card {
  margin-bottom: 14px;
  padding: 16px;
  border: 1px solid rgba(255, 255, 255, 0.7);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.78);
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.08);
}

.stats-card__hd {
  display: flex;
  align-items: center;
  margin-bottom: 12px;
}

.stats-idx {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 22px;
  height: 18px;
  margin-right: 8px;
  border-radius: 8px;
  background: #e6f4ff;
}

.stats-idx__txt {
  color: #1890ff;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 1px;
  line-height: 1;
}

.stats-card__name {
  color: #1e2438;
  font-size: 14.5px;
  font-weight: 700;
  letter-spacing: 0.3px;
}

.bar-chart {
  display: flex;
  align-items: stretch;
  height: 132px;
}

.bar-col {
  display: flex;
  flex: 1;
  flex-direction: column;
  align-items: center;
  height: 100%;
  padding: 0 5px;
  box-sizing: border-box;
}

.bar-col:first-child {
  padding-left: 0;
}

.bar-col:last-child {
  padding-right: 0;
}

.bar-col__track {
  display: flex;
  flex: 1;
  flex-direction: column;
  justify-content: flex-end;
  width: 100%;
}

.bar-col__fill {
  width: 100%;
  min-height: 4px;
  border-radius: 6px 6px 3px 3px;
  background: linear-gradient(180deg, #69c0ff, #40a9ff);
  transition: height 0.22s ease;
}

.bar-col--hot .bar-col__fill {
  background: linear-gradient(180deg, #5cdbd3, #13c2c2);
  box-shadow: 0 4px 12px rgba(19, 194, 194, 0.35);
}

.bar-col__lab {
  flex-shrink: 0;
  margin-top: 6px;
  color: #9aa3bd;
  font-size: 9.5px;
  font-weight: 600;
  letter-spacing: 1px;
  line-height: 1;
}

.donut-wrap {
  display: flex;
  align-items: center;
}

.donut {
  position: relative;
  flex-shrink: 0;
  width: 118px;
  height: 118px;
  border-radius: 50%;
  background: #1890ff;
  box-shadow: 0 8px 22px rgba(24, 144, 255, 0.15);
}

.donut__hole {
  position: absolute;
  top: 27px;
  right: 27px;
  bottom: 27px;
  left: 27px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: #fff;
  box-shadow: inset 0 2px 8px rgba(24, 144, 255, 0.08);
}

.donut__num {
  color: #1e2438;
  font-size: 15px;
  font-weight: 700;
  letter-spacing: 1px;
}

.leg {
  flex: 1;
  min-width: 0;
  margin-left: 22px;
}

.leg-row {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.leg-row:last-child {
  margin-bottom: 0;
}

.leg-row__dot {
  flex-shrink: 0;
  width: 9px;
  height: 9px;
  border-radius: 3px;
}

.leg-row__name {
  flex: 1;
  margin-left: 9px;
  overflow: hidden;
  color: #5a6380;
  font-size: 12px;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.leg-row__val {
  color: #1e2438;
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.hbar {
  display: flex;
  align-items: center;
  margin-bottom: 13px;
}

.hbar--last {
  margin-bottom: 2px;
}

.hbar__nm {
  flex-shrink: 0;
  width: 62px;
  color: #5a6380;
  font-size: 12px;
  text-align: right;
}

.hbar__tk {
  flex: 1;
  height: 14px;
  margin: 0 10px;
  overflow: hidden;
  border-radius: 999px;
  background: #eaeef9;
}

.hbar__fill {
  height: 100%;
  border-radius: 999px;
  background: linear-gradient(90deg, #69c0ff, #1890ff);
  transition: width 0.22s ease;
}

.hbar__fill--top {
  background: linear-gradient(90deg, #5cdbd3, #13c2c2);
}

.hbar__vl {
  flex-shrink: 0;
  min-width: 26px;
  color: #1e2438;
  font-size: 14px;
  font-weight: 700;
  letter-spacing: 0.5px;
  text-align: right;
}

.score-hero {
  margin-bottom: 14px;
  padding: 18px 16px 16px;
  border-radius: 18px;
  background: linear-gradient(135deg, #096dd9, #1890ff 55%, #40a9ff);
  box-shadow: 0 12px 28px rgba(24, 144, 255, 0.3);
}

.score-hero__who {
  color: rgba(255, 255, 255, 0.85);
  font-size: 13px;
}

.score-hero__title {
  display: block;
  margin-top: 6px;
  color: #fff;
  font-size: 22px;
  font-weight: 700;
  line-height: 1.4;
}

.score-hero__sub {
  display: block;
  margin-top: 4px;
  color: rgba(255, 255, 255, 0.7);
  font-size: 11px;
}

.stats-banner {
  display: flex;
  align-items: flex-start;
  margin-bottom: 8px;
  padding: 11px 13px;
  border-radius: 14px;
  background: #e6f4ff;
}

.stats-banner__ic {
  flex-shrink: 0;
  width: 18px;
  height: 18px;
  margin-top: 2px;
  border-radius: 50%;
  background: linear-gradient(135deg, #40a9ff, #1890ff);
  color: #fff;
  font-size: 10.5px;
  font-weight: 700;
  line-height: 18px;
  text-align: center;
}

.stats-banner__txt {
  flex: 1;
  margin-left: 10px;
  color: #096dd9;
  font-size: 12px;
  line-height: 1.75;
}

.rank-row {
  display: flex;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px solid #eff2f9;
}

.rank-row--last {
  border-bottom: none;
}

.rank-row--me {
  margin: 0 -8px;
  padding: 10px 8px;
  border-bottom: none;
  border-radius: 10px;
  background: rgba(24, 144, 255, 0.06);
}

.rank-no {
  width: 22px;
  color: #9aa3bd;
  font-size: 14px;
  font-weight: 700;
  text-align: center;
}

.rank-no--1 {
  color: #d4a017;
}

.rank-no--2 {
  color: #8a92ac;
}

.rank-no--3 {
  color: #c47b4a;
}

.rank-info {
  flex: 1;
  margin: 0 10px;
}

.rank-name {
  display: block;
  color: #1e2438;
  font-size: 13px;
  font-weight: 600;
}

.rank-meta {
  display: block;
  color: #9aa3bd;
  font-size: 11px;
}

.rank-val {
  color: #1e2438;
  font-size: 14px;
  font-weight: 700;
}

.stats-press {
  opacity: 0.86;
}
</style>
