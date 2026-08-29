<template>
  <view class="apply-page" :class="{ 'apply-page--kb': !!focusField }">
    <view class="apply-nav pt-safe">
      <view class="apply-nav__bar">
        <view class="apply-back" hover-class="apply-press" @click="handleBack">
          <wd-icon name="arrow-left" size="18px" color="#5A6380" />
        </view>
        <text class="apply-nav__title">发起提案</text>
      </view>
    </view>

    <view class="apply-body">
      <view class="apply-steps">
        <view
          v-for="(item, index) in STEPS"
          :key="item"
          class="apply-step"
          :class="{
            'apply-step--on': step === index + 1,
            'apply-step--fin': step > index + 1,
          }"
        >
          <view class="apply-step__n">
            <text class="apply-step__n-txt">{{ step > index + 1 ? '✓' : index + 1 }}</text>
          </view>
          <text class="apply-step__s">{{ item }}</text>
          <view v-if="index < STEPS.length - 1" class="apply-step__line" />
        </view>
      </view>

      <template v-if="step === 1">
        <view class="apply-card">
          <view class="apply-card__hd">
            <view class="apply-card__title">
              <view class="apply-idx"><text class="apply-idx__txt">A</text></view>
              <text class="apply-card__name">提案内容</text>
            </view>
          </view>
          <view class="apply-field">
            <view class="apply-label-row">
              <view class="apply-label-wrap">
                <text class="apply-req">*</text>
                <text class="apply-label">提案名称</text>
              </view>
              <text class="apply-count" :class="{ 'apply-count--max': form.title.length >= 50 }">
                {{ form.title.length }}/50
              </text>
            </view>
            <view class="apply-ipt" :class="{ 'apply-ipt--on': focusField === 'title' }">
              <input
                v-model="form.title"
                class="apply-ipt__inner"
                type="text"
                :maxlength="50"
                placeholder="请简要概括改善主题"
                placeholder-class="apply-ph"
                :placeholder-style="PH_STYLE"
                confirm-type="next"
                :cursor-spacing="24"
                @focus="focusField = 'title'"
                @blur="focusField = ''"
              >
            </view>
          </view>
          <view class="apply-field">
            <view class="apply-label-row">
              <view class="apply-label-wrap">
                <text class="apply-req">*</text>
                <text class="apply-label">目前状况及问题</text>
              </view>
              <text class="apply-count">{{ form.problem.length }}/500</text>
            </view>
            <view class="apply-ipt apply-ipt--area" :class="{ 'apply-ipt--on': focusField === 'problem' }">
              <textarea
                v-model="form.problem"
                class="apply-ipt__area"
                :maxlength="500"
                placeholder="请描述当前问题、影响范围与数据"
                placeholder-class="apply-ph"
                :placeholder-style="PH_STYLE"
                :show-confirm-bar="false"
                :disable-default-padding="true"
                :cursor-spacing="24"
                @focus="focusField = 'problem'"
                @blur="focusField = ''"
              />
            </view>
          </view>
          <view class="apply-field">
            <view class="apply-label-row">
              <view class="apply-label-wrap">
                <text class="apply-req">*</text>
                <text class="apply-label">改善意见（含具体实施设想）</text>
              </view>
              <text class="apply-count">{{ form.idea.length }}/500</text>
            </view>
            <view class="apply-ipt apply-ipt--area" :class="{ 'apply-ipt--on': focusField === 'idea' }">
              <textarea
                v-model="form.idea"
                class="apply-ipt__area"
                :maxlength="500"
                placeholder="请描述改善思路与实施设想"
                placeholder-class="apply-ph"
                :placeholder-style="PH_STYLE"
                :show-confirm-bar="false"
                :disable-default-padding="true"
                :cursor-spacing="24"
                @focus="focusField = 'idea'"
                @blur="focusField = ''"
              />
            </view>
          </view>
          <view class="apply-field apply-field--last">
            <view class="apply-label-row">
              <view class="apply-label-wrap">
                <text class="apply-req">*</text>
                <text class="apply-label">改善性质（多选）</text>
              </view>
              <text class="apply-count">已选 {{ form.natures.length }} 项</text>
            </view>
            <view class="nature-grid">
              <view
                v-for="item in NATURES"
                :key="item"
                class="nature-tag"
                :class="{ 'nature-tag--on': form.natures.includes(item) }"
                hover-class="apply-press"
                @click="toggleNature(item)"
              >
                <text :class="form.natures.includes(item) ? 'nature-tag__on' : 'nature-tag__off'">
                  {{ item }}
                </text>
              </view>
            </view>
          </view>
        </view>

        <view class="apply-card">
          <view class="apply-card__hd">
            <view class="apply-card__title">
              <view class="apply-idx"><text class="apply-idx__txt">B</text></view>
              <text class="apply-card__name">改善部门</text>
            </view>
          </view>
          <view class="apply-field apply-field--compact">
            <view class="apply-label-row">
              <view class="apply-label-wrap">
                <text class="apply-req">*</text>
                <text class="apply-label">改善部门</text>
              </view>
            </view>
            <view class="apply-ipt apply-ipt--select" hover-class="apply-press" @click="openDeptPicker">
              <text class="apply-ipt__val">{{ form.dept }}</text>
              <wd-icon name="arrow-down" size="14px" color="#9AA3BD" />
            </view>
          </view>
          <view class="apply-cell apply-cell--last">
            <text class="apply-cell__lab">部门负责人</text>
            <text class="apply-cell__val apply-cell__val--ro">{{ leaderText }}</text>
          </view>
          <view v-if="!currentLeader" class="apply-banner apply-banner--err">
            <text class="apply-banner__ic">!</text>
            <text class="apply-banner__txt">该部门未配置负责人，请联系管理员</text>
          </view>
        </view>

        <view class="apply-card apply-card--last">
          <view class="apply-card__hd">
            <view class="apply-card__title">
              <view class="apply-idx"><text class="apply-idx__txt">C</text></view>
              <text class="apply-card__name">现场图片</text>
            </view>
            <text class="apply-hint">可选，最多 4 张</text>
          </view>
          <view class="img-grid">
            <view
              v-for="(src, index) in form.images"
              :key="`${index}-${src}`"
              class="img-slot img-slot--has"
              @click="previewImage(index)"
            >
              <image class="img-slot__img" :src="src" mode="aspectFill" />
              <view class="img-slot__rm" hover-class="apply-press" @click.stop="removeImage(index)">
                <text class="img-slot__rm-txt">×</text>
              </view>
            </view>
            <view
              v-if="form.images.length < 4"
              class="img-slot img-slot--add"
              hover-class="apply-press"
              @click="addImage"
            >
              <text class="img-slot__plus">＋</text>
              <text class="img-slot__add">添加</text>
            </view>
          </view>
        </view>
      </template>

      <template v-else>
        <view class="apply-card">
          <view class="apply-cell">
            <text class="apply-cell__lab">提案名称</text>
            <text class="apply-cell__val">{{ form.title }}</text>
          </view>
          <view class="apply-cell apply-cell--block">
            <text class="apply-cell__lab">改善性质</text>
            <view class="confirm-tags">
              <text v-for="item in form.natures" :key="item" class="confirm-tag">{{ item }}</text>
            </view>
          </view>
          <view class="apply-cell">
            <text class="apply-cell__lab">改善部门</text>
            <text class="apply-cell__val">{{ confirmDeptText }}</text>
          </view>
          <view class="apply-cell apply-cell--last apply-cell--block">
            <text class="apply-cell__lab">现场图片</text>
            <view v-if="form.images.length" class="confirm-imgs">
              <image
                v-for="(src, index) in form.images"
                :key="`${index}-${src}`"
                class="confirm-imgs__item"
                :src="src"
                mode="aspectFill"
                @click="previewImage(index)"
              />
            </view>
            <text v-else class="apply-cell__val">未上传</text>
          </view>
        </view>

        <view class="apply-card">
          <text class="confirm-sec">目前状况及问题</text>
          <text class="confirm-body">{{ form.problem }}</text>
          <text class="confirm-sec confirm-sec--gap">改善意见</text>
          <text class="confirm-body">{{ form.idea }}</text>
        </view>

        <view class="apply-banner apply-banner--warn">
          <text class="apply-banner__ic apply-banner__ic--warn">!</text>
          <text class="apply-banner__txt apply-banner__txt--warn">提交后进入委员会并行审核；待审核中可撤回</text>
        </view>
      </template>
    </view>

    <view v-if="!focusField" class="apply-ft">
      <view v-if="step === 1" class="apply-btn apply-btn--pri" hover-class="apply-press" @click="goNext">
        <text class="apply-btn__light">下一步</text>
      </view>
      <template v-else>
        <view class="apply-btn apply-btn--plain" hover-class="apply-press" @click="goPrev">
          <text class="apply-btn__plain">上一步</text>
        </view>
        <view
          class="apply-btn apply-btn--acc"
          :class="{ 'apply-btn--off': submitting }"
          hover-class="apply-press"
          @click="submitApply"
        >
          <text class="apply-btn__light">{{ submitting ? '提交中…' : '提交申请' }}</text>
        </view>
      </template>
    </view>

    <view v-if="showDeptPicker" class="apply-mask" @click="showDeptPicker = false" @touchmove.stop.prevent>
      <view class="apply-sheet" @click.stop>
        <view class="apply-sheet__handle" />
        <text class="apply-sheet__title">选择改善部门</text>
        <view
          v-for="item in deptOptions"
          :key="item.name"
          class="apply-sheet__item"
          :class="{
            'apply-sheet__item--on': form.dept === item.name,
            'apply-sheet__item--off': !item.leader,
          }"
          hover-class="apply-press"
          @click="selectDept(item)"
        >
          <view class="apply-sheet__meta">
            <text :class="item.leader ? 'apply-sheet__name' : 'apply-sheet__name--off'">
              {{ item.name }}
            </text>
            <text v-if="item.leader" class="apply-sheet__sub">{{ item.leader }}</text>
            <text v-else class="apply-sheet__name--off">（未配置负责人）</text>
          </view>
          <wd-icon v-if="form.dept === item.name && item.leader" name="check" size="16px" color="#1890FF" />
        </view>
        <view class="apply-sheet__cancel" hover-class="apply-press" @click="showDeptPicker = false">
          <text class="apply-sheet__cancel-txt">取消</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script lang="ts" setup>
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/store'

defineOptions({
  name: 'ProposalApply',
})

definePage({
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '发起提案',
    navigationBarTextStyle: 'black',
    backgroundColor: '#EEF5FF',
    backgroundColorTop: '#E6F4FF',
    backgroundColorBottom: '#F5FAFF',
  },
})

const STEPS = ['内容填写', '确认提交'] as const
const NATURES = ['安全改善', '品质改善', '效率改善', '交付改善', '成本改善'] as const
const DEPT_LEADERS: Record<string, string> = {
  生产一部: '赵强',
  生产二部: '赵强',
  品质部: '赵强',
  仓储部: '周敏',
  设备部: '郑浩',
  综合部: '',
}
const PH_STYLE = 'color:#9AA3BD;font-size:14px;'
const MAX_IMAGES = 4

type DeptOption = { name: string, leader: string }

const userStore = useUserStore()
const { userInfo } = storeToRefs(userStore)

const step = ref(1)
const focusField = ref('')
const showDeptPicker = ref(false)
const submitting = ref(false)

function readDefaultDept() {
  const name = String(userInfo.value.departName || '')
  if (name && DEPT_LEADERS[name])
    return name
  return '生产一部'
}

const form = reactive({
  title: '',
  problem: '',
  idea: '',
  natures: [] as string[],
  dept: readDefaultDept(),
  images: [] as string[],
})

const deptOptions = computed<DeptOption[]>(() =>
  Object.entries(DEPT_LEADERS).map(([name, leader]) => ({ name, leader })),
)

const currentLeader = computed(() => DEPT_LEADERS[form.dept] || '')
const leaderText = computed(() => currentLeader.value || '未配置负责人')
const confirmDeptText = computed(() => `${form.dept}（负责人：${currentLeader.value || '—'}）`)

const step1Errors = computed(() => {
  if (!form.title.trim())
    return '请填写提案名称'
  if (!form.problem.trim())
    return '请填写目前状况及问题'
  if (!form.idea.trim())
    return '请填写改善意见'
  if (!form.natures.length)
    return '请至少选择一项改善性质'
  if (!currentLeader.value)
    return '请选择已配置负责人的改善部门'
  return ''
})

onLoad(() => {
  if (!DEPT_LEADERS[form.dept])
    form.dept = readDefaultDept()
})

function toast(title: string) {
  uni.showToast({ title, icon: 'none' })
}

function leavePage() {
  const pages = getCurrentPages()
  if (pages.length > 1) {
    uni.navigateBack()
    return
  }
  uni.switchTab({ url: '/pages/index/index' })
}

function handleBack() {
  if (step.value === 2) {
    goPrev()
    return
  }
  leavePage()
}

function toggleNature(name: string) {
  const idx = form.natures.indexOf(name)
  if (idx >= 0)
    form.natures.splice(idx, 1)
  else
    form.natures.push(name)
}

function openDeptPicker() {
  focusField.value = ''
  showDeptPicker.value = true
}

function selectDept(item: DeptOption) {
  if (!item.leader) {
    toast('请选择已配置负责人的改善部门')
    return
  }
  form.dept = item.name
  showDeptPicker.value = false
}

function addImage() {
  const remain = MAX_IMAGES - form.images.length
  if (remain <= 0) {
    toast('最多上传 4 张图片')
    return
  }
  uni.chooseImage({
    count: remain,
    sizeType: ['compressed'],
    sourceType: ['album', 'camera'],
    success: (res) => {
      form.images.push(...(res.tempFilePaths || []).slice(0, remain))
    },
  })
}

function removeImage(index: number) {
  form.images.splice(index, 1)
}

function previewImage(index: number) {
  uni.previewImage({
    current: form.images[index],
    urls: form.images,
  })
}

function goNext() {
  if (step1Errors.value) {
    toast(step1Errors.value)
    return
  }
  form.title = form.title.trim()
  form.problem = form.problem.trim()
  form.idea = form.idea.trim()
  step.value = 2
  uni.pageScrollTo({ scrollTop: 0, duration: 200 })
}

function goPrev() {
  step.value = 1
  uni.pageScrollTo({ scrollTop: 0, duration: 200 })
}

function buildProposalNo() {
  const now = new Date()
  const y = now.getFullYear()
  const m = String(now.getMonth() + 1).padStart(2, '0')
  const d = String(now.getDate()).padStart(2, '0')
  const seq = String(now.getHours() * 60 + now.getMinutes()).padStart(4, '0')
  return `${y}${m}${d}${seq}`
}

function submitApply() {
  if (submitting.value)
    return
  if (step1Errors.value) {
    toast(step1Errors.value)
    step.value = 1
    return
  }

  uni.showModal({
    title: '确认提交',
    content: `提交后将进入委员会并行审核，待审核中可撤回。确定提交「${form.title}」吗？`,
    cancelText: '再看看',
    confirmText: '确认提交',
    confirmColor: '#13C2C2',
    success: (res) => {
      if (!res.confirm)
        return
      setTimeout(() => {
        doSubmit()
      }, 80)
    },
  })
}

function doSubmit() {
  submitting.value = true
  const no = buildProposalNo()
  uni.showModal({
    title: '提交成功',
    content: `编号 ${no} 已生成，已进入委员会审核`,
    showCancel: false,
    confirmText: '知道了',
    confirmColor: '#13C2C2',
    success: (res) => {
      submitting.value = false
      if (res.confirm)
        leavePage()
    },
    fail: () => {
      submitting.value = false
    },
  })
}
</script>

<style lang="scss" scoped>
.apply-page {
  min-height: 100vh;
  padding-bottom: calc(88px + env(safe-area-inset-bottom));
  background:
    radial-gradient(320px 220px at 10% 0%, rgba(105, 192, 255, 0.28), transparent 60%),
    radial-gradient(280px 240px at 100% 18%, rgba(54, 207, 201, 0.16), transparent 55%),
    linear-gradient(180deg, #e6f4ff 0%, #f0f8ff 40%, #eef5ff 70%, #f5faff 100%);
}

.apply-page--kb {
  padding-bottom: 24px;
}

.apply-nav {
  position: sticky;
  top: 0;
  z-index: 20;
  background: linear-gradient(180deg, rgba(230, 244, 255, 0.96), rgba(240, 248, 255, 0.88));
}

.apply-nav__bar {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 46px;
}

.apply-back {
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

.apply-nav__title {
  color: #1e2438;
  font-size: 17px;
  font-weight: 600;
  letter-spacing: 1px;
}

.apply-body {
  padding: 12px 16px 16px;
}

.apply-steps {
  display: flex;
  margin-bottom: 14px;
  padding: 16px 8px 13px;
  border: 1px solid rgba(255, 255, 255, 0.65);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.62);
  box-shadow: 0 8px 22px rgba(24, 144, 255, 0.08);
}

.apply-step {
  position: relative;
  flex: 1;
  text-align: center;
}

.apply-step__n {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 26px;
  height: 26px;
  margin: 0 auto 6px;
  border: 2px solid #e0e6f4;
  border-radius: 50%;
  background: #fff;
}

.apply-step__n-txt {
  color: #aab1c9;
  font-size: 12px;
  font-weight: 700;
  line-height: 1;
}

.apply-step--on .apply-step__n {
  border-color: transparent;
  background: linear-gradient(135deg, #40a9ff, #1890ff);
  box-shadow: 0 5px 12px rgba(24, 144, 255, 0.35);
}

.apply-step--on .apply-step__n-txt,
.apply-step--fin .apply-step__n-txt {
  color: #fff;
}

.apply-step--fin .apply-step__n {
  border-color: transparent;
  background: #d9e3fd;
}

.apply-step--fin .apply-step__n-txt {
  color: #1890ff;
}

.apply-step__s {
  color: #9aa3bd;
  font-size: 12px;
  letter-spacing: 0.5px;
}

.apply-step--on .apply-step__s {
  color: #1890ff;
  font-weight: 600;
}

.apply-step__line {
  position: absolute;
  top: 13px;
  left: calc(50% + 19px);
  width: calc(100% - 38px);
  height: 2px;
  border-radius: 1px;
  background: #e7ebf6;
}

.apply-step--fin .apply-step__line {
  background: #91d5ff;
}

.apply-card {
  margin-bottom: 14px;
  padding: 16px 16px 18px;
  border: 1px solid rgba(255, 255, 255, 0.7);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.78);
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.08);
}

.apply-card--last {
  margin-bottom: 0;
}

.apply-card__hd {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 14px;
}

.apply-card__title {
  display: flex;
  align-items: center;
}

.apply-card__name {
  color: #1e2438;
  font-size: 16px;
  font-weight: 700;
  line-height: 1.3;
}

.apply-idx {
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 22px;
  margin-right: 8px;
  padding: 4px 8px;
  border-radius: 8px;
  background: #e6f4ff;
}

.apply-idx__txt {
  color: #1890ff;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 1px;
}

.apply-hint {
  color: #9aa3bd;
  font-size: 12px;
}

.apply-cell {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  padding: 12px 0;
  border-bottom: 1px solid #eff2f9;
}

.apply-cell--last {
  padding-bottom: 0;
  border-bottom: none;
}

.apply-cell--block {
  flex-direction: column;
  align-items: flex-start;
  gap: 8px;
}

.apply-cell__lab {
  flex-shrink: 0;
  color: #6b7390;
  font-size: 14px;
  line-height: 1.4;
}

.apply-cell__val {
  flex: 1;
  color: #1e2438;
  font-size: 14px;
  line-height: 1.5;
  text-align: right;
  word-break: break-all;
}

.apply-cell--block .apply-cell__val {
  text-align: left;
}

.apply-cell__val--ro {
  color: #8a92ac;
}

.apply-field {
  margin-bottom: 18px;
}

.apply-field--last {
  margin-bottom: 0;
}

.apply-field--compact {
  margin-bottom: 8px;
}

.apply-label-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
}

.apply-label-wrap {
  display: flex;
  align-items: center;
}

.apply-req {
  margin-right: 4px;
  color: #f25555;
  font-size: 15px;
  font-weight: 600;
  line-height: 1;
}

.apply-label {
  color: #5a6380;
  font-size: 13px;
  font-weight: 600;
  line-height: 1.4;
  letter-spacing: 0.3px;
}

.apply-count {
  color: #9aa3bd;
  font-size: 12px;
}

.apply-count--max {
  color: #f25555;
}

.apply-ipt {
  display: flex;
  align-items: center;
  min-height: 46px;
  padding: 0 14px;
  border: 1.5px solid rgba(24, 144, 255, 0.14);
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.7);
  box-sizing: border-box;
}

.apply-ipt--area {
  align-items: stretch;
  min-height: 108px;
  padding: 12px 14px;
}

.apply-ipt--select {
  justify-content: space-between;
}

.apply-ipt--on {
  border-color: #1890ff;
  background: #fff;
  box-shadow: 0 0 0 3.5px rgba(24, 144, 255, 0.13);
}

.apply-ipt__inner,
.apply-ipt__area {
  width: 100%;
  height: 22px;
  border: none;
  background: transparent;
  color: #1e2438;
  font-size: 14px;
  line-height: 1.4;
}

.apply-ipt__area {
  height: 84px;
  line-height: 1.7;
}

.apply-ipt__val {
  color: #1e2438;
  font-size: 14px;
  line-height: 1.4;
}

.apply-ph {
  color: #9aa3bd;
  font-size: 14px;
}

:deep(.uni-input-input),
:deep(.uni-textarea-textarea) {
  color: #1e2438;
  font-size: 14px;
  background: transparent !important;
}

.nature-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.nature-tag {
  display: flex;
  align-items: center;
  justify-content: center;
  width: calc((100% - 16px) / 3);
  padding: 11px 4px;
  border: 1.5px solid rgba(24, 144, 255, 0.14);
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.55);
  box-sizing: border-box;
}

.nature-tag--on {
  border-color: rgba(24, 144, 255, 0.45);
  background: #e6f4ff;
  box-shadow: 0 4px 12px rgba(24, 144, 255, 0.15);
}

.nature-tag__off {
  color: #5a6380;
  font-size: 13px;
  font-weight: 500;
}

.nature-tag__on {
  color: #1890ff;
  font-size: 13px;
  font-weight: 700;
}

.img-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.img-slot {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: calc((100% - 30px) / 4);
  aspect-ratio: 1;
  overflow: hidden;
  border: 1.5px dashed rgba(24, 144, 255, 0.35);
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.55);
  box-sizing: border-box;
}

.img-slot--add {
  gap: 2px;
}

.img-slot__plus {
  color: #1890ff;
  font-size: 22px;
  font-weight: 700;
  line-height: 1;
}

.img-slot__add {
  color: #6b7390;
  font-size: 12px;
}

.img-slot--has {
  border-style: solid;
  border-color: rgba(24, 144, 255, 0.2);
}

.img-slot__img {
  width: 100%;
  height: 100%;
}

.img-slot__rm {
  position: absolute;
  top: 4px;
  right: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 18px;
  height: 18px;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.45);
}

.img-slot__rm-txt {
  color: #fff;
  font-size: 11px;
  line-height: 1;
}

.confirm-tags,
.confirm-imgs {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.confirm-tag {
  padding: 5px 10px;
  border-radius: 999px;
  background: #e6f4ff;
  color: #1890ff;
  font-size: 12px;
  font-weight: 600;
}

.confirm-imgs__item {
  width: 56px;
  height: 56px;
  border-radius: 10px;
  background: #e6f4ff;
}

.confirm-sec {
  display: block;
  color: #5a6380;
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.3px;
}

.confirm-sec--gap {
  margin-top: 18px;
}

.confirm-body {
  display: block;
  margin-top: 10px;
  color: #1e2438;
  font-size: 15px;
  line-height: 1.7;
  white-space: pre-wrap;
  word-break: break-all;
}

.apply-banner {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  margin-top: 8px;
  padding: 11px 13px;
  border-radius: 14px;
}

.apply-banner--err {
  background: #feefef;
}

.apply-banner--warn {
  margin-top: 0;
  background: #fef4de;
}

.apply-banner__ic {
  flex-shrink: 0;
  width: 18px;
  height: 18px;
  margin-top: 2px;
  border-radius: 50%;
  background: linear-gradient(135deg, #ff7070, #f25555);
  color: #fff;
  font-size: 10.5px;
  font-weight: 700;
  line-height: 18px;
  text-align: center;
}

.apply-banner__ic--warn {
  background: linear-gradient(135deg, #ffc53d, #f0a020);
}

.apply-banner__txt {
  flex: 1;
  color: #c44545;
  font-size: 13px;
  line-height: 1.7;
}

.apply-banner__txt--warn {
  color: #a76b0a;
}

.apply-ft {
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 30;
  display: flex;
  gap: 10px;
  padding: 12px 16px calc(12px + env(safe-area-inset-bottom));
  border-top: 1px solid rgba(255, 255, 255, 0.5);
  background: rgba(255, 255, 255, 0.86);
}

.apply-btn {
  display: flex;
  flex: 1;
  align-items: center;
  justify-content: center;
  height: 46px;
  border-radius: 14px;
}

.apply-btn--pri {
  background: linear-gradient(135deg, #69c0ff, #1890ff 50%, #13c2c2);
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.35);
}

.apply-btn--acc {
  background: linear-gradient(135deg, #36cfc9, #13c2c2);
  box-shadow: 0 10px 24px rgba(19, 194, 194, 0.35);
}

.apply-btn--plain {
  background: #edf0f9;
}

.apply-btn--off {
  opacity: 0.45;
}

.apply-btn__light,
.apply-btn__plain {
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 1px;
}

.apply-btn__light {
  color: #fff;
}

.apply-btn__plain {
  color: #5a6380;
}

.apply-press {
  opacity: 0.88;
}

.apply-mask {
  position: fixed;
  inset: 0;
  z-index: 40;
  display: flex;
  align-items: flex-end;
  background: rgba(15, 23, 42, 0.45);
}

.apply-sheet {
  width: 100%;
  padding: 10px 16px calc(16px + env(safe-area-inset-bottom));
  border-radius: 20px 20px 0 0;
  background: #fff;
}

.apply-sheet__handle {
  width: 36px;
  height: 4px;
  margin: 0 auto 12px;
  border-radius: 999px;
  background: #e2e8f0;
}

.apply-sheet__title {
  display: block;
  margin-bottom: 4px;
  color: #0f172a;
  font-size: 16px;
  font-weight: 600;
  text-align: center;
}

.apply-sheet__item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  min-height: 36px;
  padding: 6px 4px;
  border-bottom: 1px solid #f1f5f9;
}

.apply-sheet__meta {
  display: flex;
  flex: 1;
  align-items: baseline;
  gap: 8px;
}

.apply-sheet__name {
  color: #0f172a;
  font-size: 15px;
}

.apply-sheet__name--off {
  color: #94a3b8;
  font-size: 15px;
}

.apply-sheet__item--on .apply-sheet__name {
  color: #1890ff;
  font-weight: 600;
}

.apply-sheet__sub {
  color: #9aa3bd;
  font-size: 12px;
}

.apply-sheet__cancel {
  margin-top: 8px;
  padding: 14px 0;
  text-align: center;
}

.apply-sheet__cancel-txt {
  color: #64748b;
  font-size: 15px;
}
</style>
