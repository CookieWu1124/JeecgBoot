<template>
  <view class="ProgressMap">
    <view class="title">{{ title }}</view>
    <view
      :class="{
        stepBox: true,
        active: item.activeStep,
        'u-iconfont': true,
        'u-icon-clock': !item.activeStep,
        'u-icon-success': item.activeStep,
      }"
      v-for="(item, index) in dataSource"
      :key="index"
    >
      <view :class="{ stepContent: true, active: item.activeStep }">
        <view class="item" v-for="(inItem, inIndex) in item.data" :key="inIndex">
          {{ inItem.label }}
        </view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref } from 'vue'

defineProps({
  title: {
    type: String,
    default: '',
  },
  dataSource: {
    type: Array,
    default: () => [],
  },
})
</script>

<style lang="scss" scoped>
.title {
  padding: 20upx;
  font-weight: bold;
}
.stepBox {
  position: relative;
  padding: 32upx 32upx 32upx 120upx;
  color: #aaaaaa;
  &.active {
    color: #39b54a;
  }
  &::before {
    position: absolute;
    left: 40upx;
    background-color: #fff;
    z-index: 9;
    top: 40upx;
    border-radius: 50%;
    margin: 8upx;
  }
  &::after {
    content: '';
    display: block;
    position: absolute;
    width: 0.5px;
    background-color: #ddd;
    left: 60upx;
    height: 100%;
    top: 0;
    z-index: 8;
  }
  .stepContent {
    padding: 10upx 50upx 10upx 30upx;
    border-radius: 8upx;
    background-color: #f0f0f0;
    color: #333333;
    font-size: 24upx;
    &.active {
      background-color: #39b54a;
      color: #fff;
      box-shadow: 0 0 5px #39b54a;
    }
  }
}
</style>
