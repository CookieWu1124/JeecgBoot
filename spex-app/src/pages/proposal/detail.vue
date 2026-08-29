<template>
  <view class="detail-page">
    <view class="detail-head pt-safe">
      <view class="detail-head__blob detail-head__blob--rt" />
      <view class="detail-head__blob detail-head__blob--lt" />

      <view class="detail-nav">
        <view class="detail-back" hover-class="press" @click="handleBack">
          <wd-icon name="arrow-left" size="18px" color="#fff" />
        </view>
        <text class="detail-nav__title">提案详情</text>
        <view class="detail-nav__gap" />
      </view>

      <view class="detail-hero">
        <text class="detail-no">NO. {{ view.item.no }}</text>
        <text class="detail-title">{{ view.item.title }}</text>
        <view class="detail-meta">
          <text class="detail-pill">{{ view.status }}</text>
          <text class="detail-pill">{{ view.nature }}</text>
          <text class="detail-who">提案人 {{ view.item.who }} · {{ view.item.dept }}</text>
        </view>
      </view>
    </view>

    <view class="detail-body">
      <view class="sheet">
        <view class="sheet-hd">
          <view class="sheet-hd__left">
            <view class="sheet-bar" />
            <text class="sheet-tt">申请信息</text>
          </view>
          <view class="sheet-time">
            <wd-icon name="time-line" size="13px" color="#9AA3BD" />
            <text class="sheet-time__txt">{{ apply.time }}</text>
          </view>
        </view>

        <view class="meta-grid">
          <view class="meta-tile">
            <text class="meta-lab">改善性质</text>
            <text class="meta-tag">{{ apply.nature }}</text>
          </view>
          <view class="meta-tile">
            <text class="meta-lab">改善部门</text>
            <text class="meta-val">{{ apply.dept }}</text>
            <text v-if="apply.leader" class="meta-sub">负责人 {{ apply.leader }}</text>
          </view>
        </view>

        <view class="story">
          <view class="story-hd">
            <view class="story-ic story-ic--warn">
              <wd-icon name="info-circle" size="14px" color="#D98F0E" />
            </view>
            <text class="story-lab">目前状况</text>
          </view>
          <text class="story-body">{{ apply.problem }}</text>
        </view>

        <view class="story">
          <view class="story-hd">
            <view class="story-ic story-ic--idea">
              <wd-icon name="bulb" size="14px" color="#1890FF" />
            </view>
            <text class="story-lab">改善意见</text>
          </view>
          <text class="story-body">{{ apply.idea }}</text>
        </view>

        <view v-if="apply.images.length" class="album">
          <view class="story-hd">
            <view class="story-ic story-ic--idea">
              <wd-icon name="camera" size="14px" color="#1890FF" />
            </view>
            <text class="story-lab">现场图片</text>
            <text class="album-count">{{ apply.images.length }} 张</text>
          </view>
          <view class="album-grid">
            <view
              v-for="(src, index) in apply.images"
              :key="`${index}-${src}`"
              class="album-slot"
              hover-class="press"
              @click="previewPics(index)"
            >
              <image class="album-slot__img" :src="src" mode="aspectFill" />
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script lang="ts" setup>
import { buildDetailView } from './mock'

defineOptions({
  name: 'ProposalDetail',
})

definePage({
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '提案详情',
    navigationBarTextStyle: 'white',
    backgroundColor: '#EEF5FF',
    backgroundColorTop: '#1890FF',
    backgroundColorBottom: '#F5FAFF',
  },
})

const proposalNo = ref('')
const view = computed(() => buildDetailView(proposalNo.value))

const apply = computed(() => {
  const pick = (lab: string) => view.value.rows.find(row => row.lab === lab)?.val || ''
  const deptRaw = pick('改善部门')
  const matched = deptRaw.match(/^(.*?)（负责人：([^）]*)）$/)
  const picRow = view.value.rows.find(row => row.kind === 'pics')
  return {
    nature: pick('改善性质'),
    dept: matched?.[1] || deptRaw,
    leader: matched?.[2] || '',
    problem: pick('目前状况'),
    idea: pick('改善意见'),
    images: picRow?.images || [],
    time: pick('提交时间'),
  }
})

onLoad((query) => {
  proposalNo.value = String(query?.no || '')
})

function handleBack() {
  const pages = getCurrentPages()
  if (pages.length > 1) {
    uni.navigateBack()
    return
  }
  uni.switchTab({ url: '/pages/proposal/index' })
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
</script>

<style lang="scss" scoped>
.detail-page {
  box-sizing: border-box;
  min-height: 100vh;
  min-height: 100dvh;
  padding-bottom: 24px;
  background: linear-gradient(180deg, #e6f4ff 0%, #eef5ff 40%, #f5faff 100%);
}

.detail-head {
  position: sticky;
  top: 0;
  z-index: 20;
  overflow: hidden;
  border-radius: 0 0 22px 22px;
  background: linear-gradient(135deg, #096dd9 0%, #1890ff 48%, #40a9ff 100%);
  box-shadow: 0 12px 28px rgba(24, 144, 255, 0.28);
}

.detail-head__blob {
  position: absolute;
  border-radius: 9999px;
  pointer-events: none;
}

.detail-head__blob--rt {
  top: -40px;
  right: -36px;
  width: 140px;
  height: 140px;
  background: rgba(255, 255, 255, 0.1);
}

.detail-head__blob--lt {
  bottom: -50px;
  left: -28px;
  width: 120px;
  height: 120px;
  background: rgba(255, 255, 255, 0.07);
}

.detail-nav {
  position: relative;
  z-index: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 44px;
  padding: 0 14px;
}

.detail-back {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border-radius: 11px;
  background: rgba(255, 255, 255, 0.18);
}

.detail-nav__title {
  color: #fff;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 0.5px;
}

.detail-nav__gap {
  width: 36px;
}

.detail-hero {
  position: relative;
  z-index: 1;
  padding: 8px 16px 20px;
}

.detail-no {
  position: relative;
  z-index: 1;
  display: block;
  color: rgba(255, 255, 255, 0.85);
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 1px;
}

.detail-title {
  position: relative;
  z-index: 1;
  display: block;
  margin: 8px 0 10px;
  color: #fff;
  font-size: 20px;
  font-weight: 800;
  line-height: 1.35;
}

.detail-meta {
  position: relative;
  z-index: 1;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 6px;
}

.detail-pill {
  padding: 4px 10px;
  border: 1px solid rgba(255, 255, 255, 0.28);
  border-radius: 9999px;
  background: rgba(255, 255, 255, 0.18);
  color: #fff;
  font-size: 12px;
  font-weight: 600;
}

.detail-who {
  color: rgba(255, 255, 255, 0.9);
  font-size: 12px;
}

.detail-body {
  position: relative;
  z-index: 1;
  padding: 14px;
}

.sheet {
  padding: 18px 16px 16px;
  border: 1px solid rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.96);
  box-shadow: 0 10px 28px rgba(24, 144, 255, 0.1);
}

.sheet-hd {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
  margin-bottom: 14px;
}

.sheet-hd__left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.sheet-bar {
  width: 4px;
  height: 16px;
  border-radius: 2px;
  background: linear-gradient(180deg, #1890ff, #69c0ff);
}

.sheet-tt {
  color: #1e2438;
  font-size: 16px;
  font-weight: 700;
  letter-spacing: 0.3px;
}

.sheet-time {
  display: flex;
  flex-shrink: 0;
  align-items: center;
  gap: 4px;
}

.sheet-time__txt {
  color: #9aa3bd;
  font-size: 12px;
}

.meta-grid {
  display: flex;
  gap: 10px;
  margin-bottom: 4px;
}

.meta-tile {
  display: flex;
  flex: 1;
  flex-direction: column;
  min-width: 0;
  padding: 12px;
  border-radius: 14px;
  background: #f4f8ff;
}

.meta-lab {
  color: #8a92ac;
  font-size: 11px;
  letter-spacing: 0.4px;
}

.meta-tag {
  align-self: flex-start;
  margin-top: 8px;
  padding: 3px 10px;
  border-radius: 9999px;
  background: #fff;
  color: #096dd9;
  font-size: 13px;
  font-weight: 600;
  box-shadow: 0 2px 8px rgba(24, 144, 255, 0.08);
}

.meta-val {
  margin-top: 6px;
  color: #1e2438;
  font-size: 15px;
  font-weight: 700;
  line-height: 1.4;
}

.meta-sub {
  margin-top: 4px;
  color: #6b7390;
  font-size: 12px;
}

.story {
  padding: 14px 0;
  border-bottom: 1px solid #eef2f8;
}

.story-hd {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 8px;
}

.story-ic {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 26px;
  height: 26px;
  border-radius: 8px;
}

.story-ic--warn {
  background: #fef4de;
}

.story-ic--idea {
  background: #e6f4ff;
}

.story-lab {
  color: #3a4260;
  font-size: 13px;
  font-weight: 700;
}

.story-body {
  display: block;
  color: #3a4260;
  font-size: 14px;
  line-height: 1.75;
}

.album {
  padding-top: 14px;
}

.album-count {
  margin-left: auto;
  color: #9aa3bd;
  font-size: 12px;
}

.album-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.album-slot {
  width: calc((100% - 24px) / 4);
  aspect-ratio: 1;
  overflow: hidden;
  border-radius: 10px;
  background: #e6f4ff;
}

.album-slot__img {
  width: 100%;
  height: 100%;
}

.press {
  opacity: 0.86;
}
</style>
