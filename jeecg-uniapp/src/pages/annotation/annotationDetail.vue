<route lang="json5" type="page">
{
  layout: 'default',
  style: {
    navigationBarTitleText: '',
    navigationStyle: 'custom',
  },
}
</route>

<template>
  <PageLayout navTitle="详情" backRouteName="annotationList">
    <view class="p-10px">
      <view class="mb-8px">
        <wd-text custom-class="title font-size-20px" :text="annotation.titile"></wd-text>
      </view>
      <view class="flex mb-16px">
        <wd-text custom-class="sender mr-8px" :text="annotation.sender"></wd-text>
        <wd-text class="sendTime" :text="annotation.sendTime"></wd-text>
      </view>
      <view class="content mb-16px">
        <view class="text-content" v-html="annotation.msgContent"></view>
      </view>
      <view class="flex">
        <wd-text
          custom-class="cIcon cuIcon-attentionfill mr-10px"
          text="10"
          @click="numberPlus"
        ></wd-text>
        <wd-text class="cIcon cuIcon-appreciatefill" text="20" @click="numberPlus"></wd-text>
      </view>
    </view>
  </PageLayout>
</template>

<script lang="ts" setup>
import { reactive } from 'vue'
import { onLaunch, onShow, onHide, onLoad, onReady } from '@dcloudio/uni-app'
import { http } from '@/utils/http'
//
const annotation = reactive({
  id: '',
  titile: '',
  startTime: '',
  sender: '',
  msgContent: '',
  anntId: '',
  sendTime: '',
})
const goodNumber = ref(null)
const flg = ref(true)
const init = (option) => {
  const annItem = JSON.parse(decodeURIComponent(option.item))
  console.log('ann', annItem)
  Object.assign(annotation, annItem)
  readOk()
}
const readOk = () => {
  let param = { anntId: annotation.anntId }
  http.put('/sys/sysAnnouncementSend/editByAnntIdAndUserId', param)
}

const numberPlus = () => {
  if (flg.value) {
    goodNumber.value++
    flg.value = false
  } else {
    goodNumber.value--
    if (goodNumber.value == 0) {
      goodNumber.value = null
    }
    flg.value = true
  }
}
onLoad((option) => {
  init(option)
})
</script>

<style lang="scss" scoped>
//
:deep(.wd-text) {
   --wot-text-info-color: var(--color-grey);
  &.cIcon {
    &::before {
      margin-right: 4px;
    }
  }
}
.title {
  --wot-text-info-color: #333;
  margin-bottom: 10px;
}
</style>
