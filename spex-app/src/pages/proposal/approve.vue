<template>
  <view class="ap-page" :class="{ 'ap-page--kb': !!focusField }">
    <view class="ap-nav pt-safe">
      <view class="ap-nav__bar">
        <view class="ap-back" hover-class="ap-press" @click="handleBack">
          <wd-icon name="arrow-left" size="18px" color="#5A6380" />
        </view>
        <text class="ap-nav__title">批准决策</text>
      </view>
    </view>

    <view class="ap-body">
      <view class="ap-card" hover-class="ap-press" @click="openDetail">
        <view class="ap-sum">
          <text class="ap-sum__title">{{ view.item.title }}</text>
          <view class="ap-sum__aside">
            <view class="stamp" :class="`stamp-${view.item.stamp}`">
              <view class="stamp__dot" />
              <text class="stamp__txt">{{ view.status }}</text>
            </view>
            <wd-icon name="arrow-right" size="14px" color="#C2C8DC" />
          </view>
        </view>
        <text class="ap-sum__sub"><text class="ap-sum__no">NO.</text> {{ view.item.no }} · {{ view.item.dept }} · {{ view.item.who }}</text>
        <view class="ap-tags">
          <text class="nat">{{ view.nature }}</text>
        </view>
      </view>

      <view class="ap-sec">
        <view class="ap-sec__left">
          <view class="ap-sec__bar" />
          <text class="ap-sec__title">委员意见汇总</text>
        </view>
        <view class="ap-sec__right">
          <view v-if="tally.total" class="stamp stamp-green">
            <view class="stamp__dot" />
            <text class="stamp__txt">采用 {{ tally.adopt }}</text>
          </view>
          <view v-if="tally.total" class="stamp stamp-gray">
            <view class="stamp__dot" />
            <text class="stamp__txt">不采用 {{ tally.reject }}</text>
          </view>
          <text class="ap-sec__count">{{ progressText }}</text>
        </view>
      </view>

      <view class="ap-ops">
        <view
          v-for="(item, index) in opinions"
          :key="`${item.name}-${index}`"
          class="op"
          :class="item.adopt ? 'op--yes' : 'op--no'"
        >
          <view class="op-hd">
            <text class="op-nm">{{ item.name }}</text>
            <view class="stamp" :class="item.adopt ? 'stamp-green' : 'stamp-gray'">
              <view class="stamp__dot" />
              <text class="stamp__txt">{{ item.adopt ? '采用' : '不采用' }}</text>
            </view>
            <view v-if="item.plan" class="stamp stamp-blue">
              <view class="stamp__dot" />
              <text class="stamp__txt">形成计划书</text>
            </view>
          </view>
          <text class="op-bd">{{ item.comment }}</text>
          <text v-if="item.reward" class="op-ft">建议奖励 ¥{{ item.reward }}</text>
        </view>

        <view v-if="!opinions.length" class="op op--empty">
          <text class="op-bd">暂无委员意见</text>
        </view>
      </view>

      <view class="ap-card ap-card--last">
        <view class="ap-card__hd">
          <text class="ap-card__name">批准决策</text>
          <text class="ap-req">必填</text>
        </view>

        <view
          v-for="item in DECISION_OPTS"
          :key="item.value"
          class="opt"
          :class="{ 'opt--on': form.decision === item.value }"
          hover-class="ap-press"
          @click="setDecision(item.value)"
        >
          <view class="rd">
            <view class="rd__dot" />
          </view>
          <text class="opt__txt">{{ item.label }}</text>
        </view>

        <view v-if="isApprove" class="ap-extra">
          <view class="ap-field">
            <view class="ap-label-wrap">
              <text class="ap-label">核定是否形成改善计划书</text>
              <text v-if="planHint" class="ap-hint">{{ planHint }}</text>
            </view>
            <view class="opt-row">
              <view
                v-for="item in PLAN_OPTS"
                :key="item.value"
                class="opt opt--row"
                :class="{ 'opt--on': form.needPlan === item.value }"
                hover-class="ap-press"
                @click="form.needPlan = item.value"
              >
                <view class="rd">
                  <view class="rd__dot" />
                </view>
                <text class="opt__txt">{{ item.label }}</text>
              </view>
            </view>
          </view>

          <view class="ap-field ap-field--last">
            <view class="ap-label-wrap">
              <text class="ap-label">核定提案奖金额</text>
              <text class="ap-hint">委员会建议 ¥{{ suggestedReward }}</text>
            </view>
            <view class="ap-ipt" :class="{ 'ap-ipt--on': focusField === 'reward' }">
              <text class="ap-ipt__unit">¥</text>
              <input
                v-model="form.reward"
                class="ap-ipt__inner"
                type="digit"
                :maxlength="8"
                placeholder="请输入金额"
                placeholder-class="ap-ph"
                :placeholder-style="PH_STYLE"
                :cursor-spacing="24"
                :adjust-position="true"
                @focus="focusField = 'reward'"
                @blur="focusField = ''"
              >
            </view>
          </view>
        </view>

        <view v-else class="ap-extra">
          <view class="ap-warn">不批准为终态，提案将终止且不可退回</view>
          <view class="ap-field ap-field--last">
            <view class="ap-label-row">
              <view class="ap-label-wrap ap-label-wrap--tight">
                <text class="ap-star">*</text>
                <text class="ap-label">不批准原因</text>
              </view>
              <text class="ap-count" :class="{ 'ap-count--max': form.comment.length >= COMMENT_MAX }">
                {{ form.comment.length }}/{{ COMMENT_MAX }}
              </text>
            </view>
            <view class="ap-ipt ap-ipt--area" :class="{ 'ap-ipt--on': focusField === 'comment' }">
              <textarea
                v-model="form.comment"
                class="ap-ipt__area"
                :maxlength="COMMENT_MAX"
                placeholder="请说明不批准原因"
                placeholder-class="ap-ph"
                :placeholder-style="PH_STYLE"
                :show-confirm-bar="false"
                :disable-default-padding="true"
                :cursor-spacing="24"
                :adjust-position="true"
                @focus="focusField = 'comment'"
                @blur="focusField = ''"
              />
            </view>
          </view>
        </view>
      </view>
    </view>

    <view v-if="!focusField" class="ap-ft">
      <view
        class="ap-btn"
        :class="{ 'ap-btn--off': submitting }"
        hover-class="ap-press"
        @click="handleSubmit"
      >
        <text class="ap-btn__txt">{{ submitting ? '提交中…' : submitLabel }}</text>
      </view>
    </view>
  </view>
</template>

<script lang="ts" setup>
import type { CommitteeReviewItem, ImprovementDeptOption, ProposalDetailResult } from '@/api/proposal'
import {
  fetchImprovementDepts,
  fetchProposalDetail,
  submitApplicationApproval,
} from '@/api/proposal'
import { formatImprovementTypes, statusLabel, statusStamp } from './helpers'

defineOptions({
  name: 'ProposalApprove',
})

definePage({
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '批准决策',
    navigationBarTextStyle: 'black',
    backgroundColor: '#EEF5FF',
    backgroundColorTop: '#E6F4FF',
    backgroundColorBottom: '#F5FAFF',
  },
})

const PH_STYLE = 'color:#9AA3BD;font-size:14px;'
const COMMENT_MAX = 300
const DEFAULT_REWARD = 200
const DECISION_OPTS = [
  { value: 'approve', label: '批准' },
  { value: 'reject', label: '不批准' },
] as const
const PLAN_OPTS = [
  { value: 'yes', label: '形成' },
  { value: 'no', label: '不形成' },
] as const

type Decision = typeof DECISION_OPTS[number]['value']
type NeedPlan = typeof PLAN_OPTS[number]['value']

interface OpinionView {
  name: string
  adopt: boolean
  plan: boolean
  comment: string
  reward?: number
}

const proposalId = ref('')
const loading = ref(false)
const detail = ref<ProposalDetailResult | null>(null)
const deptMeta = ref<ImprovementDeptOption | null>(null)
const reviewerNameMap = ref<Record<string, string>>({})
const focusField = ref('')
const submitting = ref(false)

const form = reactive({
  decision: 'approve' as Decision,
  needPlan: 'yes' as NeedPlan,
  reward: String(DEFAULT_REWARD),
  comment: '',
})

const isApprove = computed(() => form.decision === 'approve')
const submitLabel = computed(() => (isApprove.value ? '确认批准' : '确认不批准'))

const view = computed(() => {
  const p = detail.value?.proposal
  return {
    item: {
      title: p?.title || '未命名提案',
      no: p?.proposalNo || '—',
      dept: deptMeta.value?.deptName || p?.deptId || '—',
      who: '提案人',
      stamp: statusStamp(p?.status),
      prog: p?.reviewProgress || '',
    },
    status: statusLabel(p?.status),
    nature: formatImprovementTypes(p?.improvementTypes),
  }
})

const opinions = computed<OpinionView[]>(() => {
  const rows = (detail.value?.committeeReviews || []).filter(r => !!r.conclusion)
  return rows.map((r: CommitteeReviewItem) => ({
    name: reviewerNameMap.value[r.reviewerId || ''] || r.reviewerId || '委员',
    adopt: String(r.conclusion).toUpperCase() === 'ADOPT',
    plan: r.planRequired === 1,
    comment: r.comment || '—',
    reward: r.awardSuggestion != null ? Number(r.awardSuggestion) : undefined,
  }))
})

const tally = computed(() => {
  const adopt = opinions.value.filter(item => item.adopt).length
  return { adopt, reject: opinions.value.length - adopt, total: opinions.value.length }
})

const progressText = computed(() => {
  const prog = view.value.item.prog
  if (prog)
    return `${prog} 已完成`
  const n = opinions.value.length
  return n ? `${n}/${n} 已完成` : '暂无意见'
})

const suggestedReward = computed(() => {
  const nums = opinions.value
    .map(item => item.reward)
    .filter((n): n is number => typeof n === 'number' && !Number.isNaN(n))
  if (!nums.length)
    return DEFAULT_REWARD
  const counts = new Map<number, number>()
  for (const n of nums)
    counts.set(n, (counts.get(n) || 0) + 1)
  return [...counts.entries()].sort((a, b) => b[1] - a[1])[0][0]
})

const suggestedPlan = computed<NeedPlan>(() => {
  const adopted = opinions.value.filter(item => item.adopt)
  if (!adopted.length)
    return 'yes'
  return adopted.filter(item => item.plan).length >= adopted.length / 2 ? 'yes' : 'no'
})

const planHint = computed(() => {
  const n = opinions.value.filter(item => item.adopt && item.plan).length
  return n ? `${n} 位委员建议形成` : ''
})

onLoad(async (query) => {
  proposalId.value = String(query?.id || '')
  if (!proposalId.value) {
    uni.showToast({ title: '缺少提案 ID', icon: 'none' })
    return
  }
  await loadDetail()
})

async function loadDetail() {
  loading.value = true
  try {
    const res = await fetchProposalDetail(proposalId.value)
    detail.value = res
    const deptId = res?.proposal?.deptId
    if (deptId) {
      try {
        const depts = await fetchImprovementDepts()
        deptMeta.value = (depts || []).find(d => d.deptId === deptId) || null
      }
      catch {
        deptMeta.value = null
      }
    }
    // 委员姓名：详情暂无批量用户接口时先用工号/ID；管理端另有回显
    const map: Record<string, string> = {}
    for (const r of res?.committeeReviews || []) {
      if (r.reviewerId)
        map[r.reviewerId] = r.updateBy || r.createBy || r.reviewerId
    }
    reviewerNameMap.value = map

    form.reward = String(suggestedReward.value)
    form.needPlan = suggestedPlan.value
  }
  catch (err) {
    console.error('加载批准详情失败', err)
    uni.showToast({ title: '加载失败', icon: 'none' })
  }
  finally {
    loading.value = false
  }
}

function toast(title: string) {
  uni.showToast({ title, icon: 'none' })
}

function handleBack() {
  const pages = getCurrentPages()
  if (pages.length > 1) {
    uni.navigateBack()
    return
  }
  uni.switchTab({ url: '/pages/todo/index' })
}

function openDetail() {
  if (!proposalId.value)
    return
  uni.navigateTo({ url: `/pages/proposal/detail?id=${proposalId.value}` })
}

function setDecision(value: Decision) {
  form.decision = value
  focusField.value = ''
}

function validate(): string {
  if (!isApprove.value) {
    if (!form.comment.trim())
      return '请填写不批准原因'
    return ''
  }
  const reward = String(form.reward ?? '').trim()
  if (!reward)
    return '请核定提案奖金额'
  if (!/^\d+(\.\d{1,2})?$/.test(reward))
    return '请输入有效的提案奖额度'
  return ''
}

async function commit() {
  if (submitting.value || !proposalId.value)
    return
  submitting.value = true
  try {
    if (isApprove.value) {
      await submitApplicationApproval(proposalId.value, {
        decision: 'APPROVE',
        planRequired: form.needPlan === 'yes' ? 1 : 0,
        awardAmount: Number(form.reward),
        comment: form.comment.trim() || undefined,
      })
      toast('已批准，转入任务分配')
    }
    else {
      await submitApplicationApproval(proposalId.value, {
        decision: 'REJECT',
        comment: form.comment.trim(),
      })
      toast('已不批准')
    }
    setTimeout(() => handleBack(), 700)
  }
  catch (err: any) {
    console.error('提交批准决策失败', err)
    toast(err?.message || err?.data?.message || '提交失败')
  }
  finally {
    submitting.value = false
  }
}

function handleSubmit() {
  if (submitting.value)
    return
  const error = validate()
  if (error) {
    toast(error)
    return
  }
  if (!isApprove.value) {
    uni.showModal({
      title: '确认不批准',
      content: '不批准为终态，不可退回。是否继续？',
      confirmColor: '#1890FF',
      success: (res) => {
        if (res.confirm)
          commit()
      },
    })
    return
  }
  commit()
}
</script>

<style lang="scss" scoped>
.ap-page {
  box-sizing: border-box;
  min-height: 100vh;
  min-height: 100dvh;
  padding-bottom: calc(76px + env(safe-area-inset-bottom));
  background: linear-gradient(180deg, #e6f4ff 0%, #eef5ff 40%, #f5faff 100%);
}

.ap-page--kb {
  padding-bottom: 24px;
}

.ap-nav {
  position: sticky;
  top: 0;
  z-index: 20;
  background: linear-gradient(180deg, rgba(230, 244, 255, 0.96), rgba(240, 248, 255, 0.88));
}

.ap-nav__bar {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 46px;
}

.ap-back {
  position: absolute;
  left: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border: 1px solid rgba(255, 255, 255, 0.65);
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.55);
  touch-action: manipulation;
}

.ap-nav__title {
  color: #1e2438;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 1px;
}

.ap-body {
  padding: 12px 16px 16px;
}

.ap-card {
  margin-bottom: 14px;
  padding: 16px;
  border: 1px solid rgba(255, 255, 255, 0.7);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.82);
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.08);
}

.ap-card--last {
  margin-top: 14px;
  margin-bottom: 0;
}

.ap-sum {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 10px;
}

.ap-sum__aside {
  display: flex;
  flex-shrink: 0;
  align-items: center;
  gap: 4px;
}

.ap-sum__title {
  flex: 1;
  min-width: 0;
  color: #1e2438;
  font-size: 16px;
  font-weight: 700;
  line-height: 1.5;
}

.ap-sum__sub {
  display: block;
  margin-top: 8px;
  color: #8a92ac;
  font-size: 12px;
  letter-spacing: 0.4px;
  line-height: 1.5;
}

.ap-sum__no {
  color: #5a6380;
  font-weight: 700;
}

.ap-tags {
  margin-top: 12px;
}

.nat {
  padding: 3px 10px;
  border-radius: 9999px;
  background: #e6f4ff;
  color: #096dd9;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.5px;
  line-height: 1.6;
}

.ap-sec {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
  margin: 4px 2px 12px;
}

.ap-sec__left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.ap-sec__right {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: flex-end;
  gap: 6px;
  margin-left: auto;
}

.ap-sec__bar {
  width: 4px;
  height: 14px;
  border-radius: 2px;
  background: linear-gradient(180deg, #1890ff, #69c0ff);
}

.ap-sec__title {
  color: #3a4260;
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.ap-sec__count {
  color: #aab1c9;
  font-size: 12px;
  font-weight: 500;
  letter-spacing: 0.5px;
}

.ap-ops {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.op {
  padding: 14px 14px 14px 16px;
  border: 1px solid rgba(24, 144, 255, 0.1);
  border-left: 3px solid #d8def0;
  border-radius: 14px;
  background: rgba(255, 255, 255, 0.72);
  box-shadow: 0 6px 16px rgba(24, 144, 255, 0.05);
  box-sizing: border-box;
}

.op--yes {
  border-left-color: #10b981;
}

.op--no {
  border-left-color: #c9d2e8;
}

.op--empty {
  border-left-color: #d8def0;
}

.op-hd {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 8px;
  margin-bottom: 12px;
}

.op-nm {
  flex-shrink: 0;
  color: #1e2438;
  font-size: 14px;
  font-weight: 700;
  letter-spacing: 0.3px;
  line-height: 1.4;
}

.op-bd {
  display: block;
  color: #6b7390;
  font-size: 14px;
  font-weight: 400;
  line-height: 1.75;
}

.op-ft {
  display: block;
  margin-top: 10px;
  color: #9aa3bd;
  font-size: 12px;
  font-weight: 500;
  letter-spacing: 0.4px;
}

.ap-card__hd {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
}

.ap-card__name {
  color: #1e2438;
  font-size: 16px;
  font-weight: 700;
  line-height: 1.3;
}

.ap-req {
  color: #f25555;
  font-size: 11px;
  font-weight: 500;
}

.opt {
  display: flex;
  align-items: center;
  gap: 12px;
  min-height: 48px;
  margin-bottom: 10px;
  padding: 12px 15px;
  border: 1.5px solid rgba(24, 144, 255, 0.14);
  border-radius: 14px;
  background: rgba(255, 255, 255, 0.7);
  box-sizing: border-box;
  touch-action: manipulation;
}

.opt--row {
  flex: 1;
  min-width: 0;
  margin-bottom: 0;
}

.opt--on {
  border-color: #1890ff;
  background: #f0f8ff;
  box-shadow: 0 4px 14px rgba(24, 144, 255, 0.12);
}

.opt__txt {
  color: #1e2438;
  font-size: 14px;
  font-weight: 500;
  line-height: 1.4;
}

.rd {
  display: flex;
  flex-shrink: 0;
  align-items: center;
  justify-content: center;
  width: 19px;
  height: 19px;
  border: 2px solid #c9d2e8;
  border-radius: 9999px;
  box-sizing: border-box;
}

.rd__dot {
  width: 9px;
  height: 9px;
  border-radius: 9999px;
  background: linear-gradient(135deg, #40a9ff, #1890ff);
  opacity: 0;
}

.opt--on .rd {
  border-color: #1890ff;
}

.opt--on .rd__dot {
  opacity: 1;
}

.ap-card .opt:last-child {
  margin-bottom: 0;
}

.ap-extra {
  margin-top: 6px;
}

.ap-warn {
  margin-top: 4px;
  padding: 10px 12px;
  border-radius: 12px;
  background: #fef4de;
  color: #d98f0e;
  font-size: 12px;
  line-height: 1.6;
}

.ap-field {
  margin-top: 16px;
}

.ap-field--last {
  margin-bottom: 0;
}

.opt-row {
  display: flex;
  gap: 10px;
}

.ap-label-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
}

.ap-label-wrap {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  margin-bottom: 10px;
}

.ap-label-wrap--tight {
  margin-bottom: 0;
}

.ap-star {
  margin-right: 4px;
  color: #f25555;
  font-size: 14px;
  font-weight: 600;
  line-height: 1;
}

.ap-label {
  color: #5a6380;
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.3px;
}

.ap-hint {
  margin-left: 6px;
  color: #9aa3bd;
  font-size: 11px;
  font-weight: 400;
}

.ap-count {
  color: #9aa3bd;
  font-size: 12px;
}

.ap-count--max {
  color: #f25555;
}

.ap-ipt {
  display: flex;
  align-items: center;
  gap: 6px;
  min-height: 46px;
  padding: 0 14px;
  border: 1.5px solid rgba(24, 144, 255, 0.14);
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.7);
  box-sizing: border-box;
}

.ap-ipt--area {
  align-items: stretch;
  min-height: 96px;
  padding: 12px 14px;
}

.ap-ipt--on {
  border-color: #1890ff;
  background: #fff;
  box-shadow: 0 0 0 3.5px rgba(24, 144, 255, 0.13);
}

.ap-ipt__unit {
  flex-shrink: 0;
  color: #5a6380;
  font-size: 14px;
  font-weight: 600;
}

.ap-ipt__inner,
.ap-ipt__area {
  flex: 1;
  width: 100%;
  color: #1e2438;
  font-size: 14px;
  line-height: 1.6;
}

.ap-ipt__area {
  height: 72px;
}

.ap-ph {
  color: #9aa3bd;
  font-size: 14px;
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
.stamp-red { --stamp-c: #f25555; --stamp-bg: #fff1f0; }
.stamp-gray { --stamp-c: #8a92ac; --stamp-bg: #eff2f9; }

.ap-ft {
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 30;
  padding: 12px 16px calc(12px + env(safe-area-inset-bottom));
  border-top: 1px solid rgba(255, 255, 255, 0.5);
  background: rgba(255, 255, 255, 0.86);
}

.ap-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 46px;
  border-radius: 14px;
  background: linear-gradient(135deg, #69c0ff, #1890ff 50%, #13c2c2);
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.35);
  touch-action: manipulation;
}

.ap-btn--off {
  opacity: 0.45;
  pointer-events: none;
}

.ap-btn__txt {
  color: #fff;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 1px;
}

.ap-press {
  opacity: 0.88;
}
</style>
