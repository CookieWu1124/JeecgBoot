<template>
  <view class="rev-page" :class="{ 'rev-page--kb': !!focusField }">
    <view class="rev-nav pt-safe">
      <view class="rev-nav__bar">
        <view class="rev-back" hover-class="rev-press" @click="handleBack">
          <wd-icon name="arrow-left" size="18px" color="#5A6380" />
        </view>
        <text class="rev-nav__title">出具审核意见</text>
      </view>
    </view>

    <view class="rev-body">
      <view class="rev-card" hover-class="rev-press" @click="openDetail">
        <view class="rev-sum">
          <text class="rev-sum__title">{{ view.item.title }}</text>
          <view class="rev-sum__aside">
            <view class="stamp">
              <view class="stamp__dot" />
              <text class="stamp__txt">待审核</text>
            </view>
            <wd-icon name="arrow-right" size="14px" color="#C2C8DC" />
          </view>
        </view>
        <text class="rev-sum__sub">NO. {{ view.item.no }}</text>
        <view class="rev-who">
          <view class="rev-who__item">
            <text class="rev-who__lab">提案人</text>
            <text class="rev-who__val">{{ view.item.who }}</text>
          </view>
          <view class="rev-who__item">
            <text class="rev-who__lab">改善部门</text>
            <text class="rev-who__val">{{ apply.dept }}</text>
          </view>
          <view v-if="apply.leader" class="rev-who__item">
            <text class="rev-who__lab">负责人</text>
            <text class="rev-who__val">{{ apply.leader }}</text>
          </view>
        </view>
      </view>

      <view class="rev-card">
        <view class="rev-card__hd">
          <view class="rev-card__title">
            <view class="rev-idx">
              <text class="rev-idx__txt">A</text>
            </view>
            <text class="rev-card__name">提案内容</text>
          </view>
        </view>

        <view class="rev-block">
          <text class="rev-sec">目前状况及问题</text>
          <text class="rev-copy">{{ apply.problem }}</text>
        </view>
        <view class="rev-block">
          <text class="rev-sec">改善意见</text>
          <text class="rev-copy">{{ apply.idea }}</text>
        </view>
        <view v-if="apply.images.length" class="rev-block rev-block--last">
          <view class="rev-album__hd">
            <text class="rev-sec">现场图片</text>
            <text class="rev-album__count">{{ apply.images.length }} 张</text>
          </view>
          <view class="rev-album__grid">
            <view
              v-for="(src, index) in apply.images"
              :key="`${index}-${src}`"
              class="rev-album__slot"
              hover-class="rev-press"
              @click="previewPics(index)"
            >
              <image class="rev-album__img" :src="src" mode="aspectFill" />
            </view>
          </view>
        </view>

        <view class="rev-tags">
          <text class="nat">{{ apply.nature }}</text>
        </view>
      </view>

      <view class="rev-card rev-card--last">
        <view class="rev-card__hd">
          <view class="rev-card__title">
            <view class="rev-idx">
              <text class="rev-idx__txt">B</text>
            </view>
            <text class="rev-card__name">审核结论</text>
          </view>
          <text class="rev-req">必填</text>
        </view>

        <view
          v-for="item in VERDICT_OPTS"
          :key="item.value"
          class="opt"
          :class="{ 'opt--on': form.verdict === item.value }"
          hover-class="rev-press"
          @click="form.verdict = item.value"
        >
          <view class="rd">
            <view class="rd__dot" />
          </view>
          <text class="opt__txt">{{ item.label }}</text>
        </view>

        <view v-if="isAdopt" class="rev-extra">
          <view class="rev-field">
            <view class="rev-label-wrap">
              <text class="rev-star">*</text>
              <text class="rev-label">是否形成改善计划书</text>
            </view>
            <view class="opt-row">
              <view
                v-for="item in PLAN_OPTS"
                :key="item.value"
                class="opt opt--row"
                :class="{ 'opt--on': form.needPlan === item.value }"
                hover-class="rev-press"
                @click="form.needPlan = item.value"
              >
                <view class="rd">
                  <view class="rd__dot" />
                </view>
                <text class="opt__txt">{{ item.label }}</text>
              </view>
            </view>
          </view>

          <view class="rev-field">
            <view class="rev-label-wrap">
              <text class="rev-label">提案奖额度（元）</text>
              <text class="rev-hint">采用时建议</text>
            </view>
            <view class="rev-ipt" :class="{ 'rev-ipt--on': focusField === 'reward' }">
              <input
                v-model="form.reward"
                class="rev-ipt__inner"
                type="digit"
                maxlength="8"
                placeholder="建议额度"
                placeholder-class="rev-ph"
                :placeholder-style="PH_STYLE"
                :cursor-spacing="24"
                @focus="focusField = 'reward'"
                @blur="focusField = ''"
              >
            </view>
          </view>
        </view>

        <view class="rev-field rev-field--last">
          <view class="rev-label-row">
            <view class="rev-label-wrap rev-label-wrap--tight">
              <text v-if="!isAdopt" class="rev-star">*</text>
              <text class="rev-label">综合评价</text>
            </view>
            <text class="rev-count" :class="{ 'rev-count--max': form.comment.length >= COMMENT_MAX }">
              {{ form.comment.length }}/{{ COMMENT_MAX }}
            </text>
          </view>
          <view class="rev-ipt rev-ipt--area" :class="{ 'rev-ipt--on': focusField === 'comment' }">
            <textarea
              v-model="form.comment"
              class="rev-ipt__area"
              :maxlength="COMMENT_MAX"
              :placeholder="isAdopt ? '填写综合评价' : '请说明不采用原因'"
              placeholder-class="rev-ph"
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

    <view v-if="!focusField" class="rev-ft">
      <view
        class="rev-btn"
        :class="{ 'rev-btn--off': submitting }"
        hover-class="rev-press"
        @click="handleSubmit"
      >
        <text class="rev-btn__txt">{{ submitting ? '提交中…' : '提交意见' }}</text>
      </view>
    </view>
  </view>
</template>

<script lang="ts" setup>
import type { ImprovementDeptOption, ProposalDetailResult } from '@/api/proposal'
import { fetchImprovementDepts, fetchProposalDetail, submitCommitteeReview } from '@/api/proposal'
import {
  formatImprovementTypes,
  resolveFileUrl,
  statusLabel,
} from './helpers'

defineOptions({
  name: 'ProposalReview',
})

definePage({
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '出具审核意见',
    navigationBarTextStyle: 'black',
    backgroundColor: '#EEF5FF',
    backgroundColorTop: '#E6F4FF',
    backgroundColorBottom: '#F5FAFF',
  },
})

const PH_STYLE = 'color:#9AA3BD;font-size:14px;'
const COMMENT_MAX = 300
const VERDICT_OPTS = [
  { value: 'adopt', label: '采用' },
  { value: 'reject', label: '不采用' },
] as const
const PLAN_OPTS = [
  { value: 'yes', label: '形成计划书' },
  { value: 'no', label: '不形成' },
] as const

type Verdict = typeof VERDICT_OPTS[number]['value']
type NeedPlan = typeof PLAN_OPTS[number]['value']

const proposalId = ref('')
const loading = ref(false)
const detail = ref<ProposalDetailResult | null>(null)
const deptMeta = ref<ImprovementDeptOption | null>(null)
const focusField = ref('')
const submitting = ref(false)

const form = reactive({
  verdict: 'adopt' as Verdict,
  needPlan: 'yes' as NeedPlan,
  reward: '',
  comment: '',
})

const isAdopt = computed(() => form.verdict === 'adopt')

const view = computed(() => {
  const p = detail.value?.proposal
  return {
    item: {
      title: p?.title || '未命名提案',
      no: p?.proposalNo || '—',
      who: '提案人',
    },
  }
})

const apply = computed(() => {
  const p = detail.value?.proposal
  const app = detail.value?.application
  const images = (detail.value?.attachments || [])
    .map(a => resolveFileUrl(a.fileUrl))
    .filter(Boolean)
  return {
    nature: formatImprovementTypes(p?.improvementTypes),
    dept: deptMeta.value?.deptName || p?.deptId || '—',
    leader: deptMeta.value?.leaderName || '',
    problem: app?.currentSituation || '—',
    idea: app?.improvementSuggestion || '—',
    images,
    status: statusLabel(p?.status),
    progress: p?.reviewProgress || '',
  }
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
  }
  catch (err) {
    console.error('加载审核详情失败', err)
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

function toPreviewUrl(src: string) {
  if (/^(https?:|blob:|data:)/i.test(src))
    return src
  // #ifdef H5
  if (typeof location !== 'undefined')
    return `${location.origin}${src.startsWith('/') ? src : `/${src}`}`
  // #endif
  return src
}

function previewPics(index: number) {
  const urls = apply.value.images.map(toPreviewUrl)
  if (!urls.length)
    return
  uni.previewImage({
    current: urls[index],
    urls,
  })
}

function validate(): string {
  if (!isAdopt.value && !form.comment.trim())
    return '请填写不采用原因'
  if (isAdopt.value && !form.needPlan)
    return '请选择是否形成改善计划书'
  if (isAdopt.value && form.reward && Number.isNaN(Number(form.reward)))
    return '请输入有效的提案奖额度'
  return ''
}

async function commit() {
  if (submitting.value || !proposalId.value)
    return
  submitting.value = true
  try {
    const conclusion = isAdopt.value ? 'ADOPT' : 'REJECT'
    await submitCommitteeReview(proposalId.value, {
      conclusion,
      planRequired: isAdopt.value ? (form.needPlan === 'yes' ? 1 : 0) : undefined,
      awardSuggestion: isAdopt.value && form.reward.trim()
        ? Number(form.reward)
        : null,
      comment: form.comment.trim() || undefined,
    })
    let progHint = ''
    try {
      const latest = await fetchProposalDetail(proposalId.value)
      progHint = latest?.proposal?.reviewProgress
        ? `（进度 ${latest.proposal.reviewProgress}）`
        : ''
    }
    catch {
      // ignore
    }
    toast(`意见已提交${progHint}`)
    setTimeout(() => handleBack(), 700)
  }
  catch (err: any) {
    console.error('提交审核意见失败', err)
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
  if (!isAdopt.value) {
    uni.showModal({
      title: '确认不采用',
      content: '不采用意见将提交给批准人汇总，是否继续？',
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
.rev-page {
  box-sizing: border-box;
  min-height: 100vh;
  min-height: 100dvh;
  padding-bottom: calc(76px + env(safe-area-inset-bottom));
  background: linear-gradient(180deg, #e6f4ff 0%, #eef5ff 40%, #f5faff 100%);
}

.rev-page--kb {
  padding-bottom: 24px;
}

.rev-nav {
  position: sticky;
  top: 0;
  z-index: 20;
  background: linear-gradient(180deg, rgba(230, 244, 255, 0.96), rgba(240, 248, 255, 0.88));
}

.rev-nav__bar {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 46px;
}

.rev-back {
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

.rev-nav__title {
  color: #1e2438;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 1px;
}

.rev-body {
  padding: 12px 16px 16px;
}

.rev-card {
  margin-bottom: 14px;
  padding: 16px;
  border: 1px solid rgba(255, 255, 255, 0.7);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.82);
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.08);
}

.rev-card--last {
  margin-bottom: 0;
}

.rev-sum {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 10px;
}

.rev-sum__aside {
  display: flex;
  flex-shrink: 0;
  align-items: center;
  gap: 4px;
}

.rev-sum__title {
  flex: 1;
  min-width: 0;
  color: #1e2438;
  font-size: 16px;
  font-weight: 700;
  line-height: 1.5;
}

.rev-sum__sub {
  display: block;
  margin-top: 6px;
  color: #8a92ac;
  font-size: 12px;
  letter-spacing: 0.4px;
  line-height: 1.5;
}

.rev-who {
  display: flex;
  margin-top: 12px;
  padding-top: 12px;
  border-top: 1px dashed rgba(24, 144, 255, 0.16);
}

.rev-who__item {
  display: flex;
  flex: 1;
  flex-direction: column;
  gap: 4px;
  min-width: 0;
  padding: 0 8px;
  border-right: 1px solid #eef2f8;
}

.rev-who__item:first-child {
  padding-left: 0;
}

.rev-who__item:last-child {
  padding-right: 0;
  border-right: none;
}

.rev-who__lab {
  color: #9aa3bd;
  font-size: 11px;
  letter-spacing: 0.4px;
}

.rev-who__val {
  overflow: hidden;
  color: #1e2438;
  font-size: 14px;
  font-weight: 700;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.rev-card__hd {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
}

.rev-card__title {
  display: flex;
  align-items: center;
}

.rev-card__name {
  color: #1e2438;
  font-size: 16px;
  font-weight: 700;
  line-height: 1.3;
}

.rev-idx {
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 22px;
  margin-right: 8px;
  padding: 4px 8px;
  border-radius: 8px;
  background: #e6f4ff;
}

.rev-idx__txt {
  color: #1890ff;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 1px;
}

.rev-req {
  color: #f25555;
  font-size: 11px;
  font-weight: 500;
}

.rev-block {
  padding: 14px 0;
  border-bottom: 1px solid #eef2f8;
}

.rev-card__hd + .rev-block {
  padding-top: 2px;
}

.rev-block--last {
  padding-bottom: 0;
  border-bottom: none;
}

.rev-sec {
  display: block;
  padding-left: 8px;
  border-left: 3px solid #91d5ff;
  color: #1e2438;
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 0.3px;
  line-height: 1.3;
}

.rev-copy {
  display: block;
  margin-top: 8px;
  padding-left: 11px;
  color: #6b7390;
  font-size: 14px;
  font-weight: 400;
  line-height: 1.8;
}

.rev-album__hd {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
}

.rev-album__count {
  color: #9aa3bd;
  font-size: 12px;
}

.rev-album__grid {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  padding-left: 11px;
}

.rev-album__slot {
  width: calc((100% - 16px) / 3);
  aspect-ratio: 1;
  overflow: hidden;
  border-radius: 10px;
  background: #e6f4ff;
  touch-action: manipulation;
}

.rev-album__img {
  width: 100%;
  height: 100%;
}

.rev-tags {
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
  white-space: nowrap;
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

.rev-extra {
  margin-top: 6px;
}

.rev-field {
  margin-top: 16px;
}

.rev-field--last {
  margin-bottom: 0;
}

.opt-row {
  display: flex;
  gap: 10px;
}

.rev-label-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
}

.rev-label-wrap {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.rev-label-wrap--tight {
  margin-bottom: 0;
}

.rev-star {
  margin-right: 4px;
  color: #f25555;
  font-size: 14px;
  font-weight: 600;
  line-height: 1;
}

.rev-label {
  color: #5a6380;
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.3px;
}

.rev-count {
  color: #9aa3bd;
  font-size: 12px;
}

.rev-count--max {
  color: #f25555;
}

.rev-hint {
  margin-left: 6px;
  color: #9aa3bd;
  font-size: 11px;
  font-weight: 400;
}

.rev-ipt {
  display: flex;
  align-items: center;
  min-height: 46px;
  padding: 0 14px;
  border: 1.5px solid rgba(24, 144, 255, 0.14);
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.7);
  box-sizing: border-box;
}

.rev-ipt--area {
  align-items: stretch;
  min-height: 96px;
  padding: 12px 14px;
}

.rev-ipt--on {
  border-color: #1890ff;
  background: #fff;
  box-shadow: 0 0 0 3.5px rgba(24, 144, 255, 0.13);
}

.rev-ipt__inner,
.rev-ipt__area {
  flex: 1;
  width: 100%;
  color: #1e2438;
  font-size: 14px;
  line-height: 1.6;
}

.rev-ipt__area {
  height: 72px;
}

.rev-ph {
  color: #9aa3bd;
  font-size: 14px;
}

.stamp {
  display: inline-flex;
  flex-shrink: 0;
  align-items: center;
  gap: 5px;
  padding: 3px 9px;
  border-radius: 9999px;
  color: #1890ff;
  background: #e6f4ff;
  line-height: 1.6;
  white-space: nowrap;
}

.stamp__dot {
  width: 4px;
  height: 4px;
  border-radius: 9999px;
  background: #1890ff;
}

.stamp__txt {
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.4px;
}

.rev-ft {
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 30;
  padding: 12px 16px calc(12px + env(safe-area-inset-bottom));
  border-top: 1px solid rgba(255, 255, 255, 0.5);
  background: rgba(255, 255, 255, 0.86);
}

.rev-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 46px;
  border-radius: 14px;
  background: linear-gradient(135deg, #69c0ff, #1890ff 50%, #13c2c2);
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.35);
  touch-action: manipulation;
}

.rev-btn--off {
  opacity: 0.45;
  pointer-events: none;
}

.rev-btn__txt {
  color: #fff;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 1px;
}

.rev-press {
  opacity: 0.88;
}
</style>
