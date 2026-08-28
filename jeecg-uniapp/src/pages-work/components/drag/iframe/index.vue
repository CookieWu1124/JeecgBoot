<template>
  <view class="margin" style="overflow: scroll;">
    <!-- #ifdef APP-PLUS  -->
    <iframe v-if="iframeSrc" :src="iframeSrc" :style="styleObject"></iframe>
    <!-- #endif -->
    <!-- #ifdef H5  -->
    <web-view v-if="iframeSrc" :src="iframeSrc" :fullscreen="false" style="width:100%;height:300px" :webview-styles="styleObject"></web-view>
    <!-- #endif -->
  </view>
</template>

<script lang="ts" setup>
import { computed } from 'vue';
import { echartProps } from '../props';

// 定义 props
const props = defineProps(echartProps);

// 计算属性：获取 iframe 的 src
const iframeSrc = computed(() => {
  return props.config?.option?.body?.url;
});

// 计算属性：生成样式对象
const styleObject = computed(() => {
  return {
    width: '100%',
    height: '400px',
  };
});
</script>
