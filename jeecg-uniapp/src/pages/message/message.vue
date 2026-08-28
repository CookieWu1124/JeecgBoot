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
  <PageLayout :navbarShow="false">
    <view
      class="wrap"
      :style="{
        '--nav-height': `${statusBarHeight + navHeight}px`,
        '--status-bar-height': `${statusBarHeight}px`,
      }"
    >
      <wd-tabs :customClass="getClass()" v-model="tabActive">
        <template v-for="(item, index) in tabList" :key="index">
          <wd-tab :title="item.title" :name="item.key">
            <chatList v-if="item.key === '1'"></chatList>
            <addressBookList v-if="item.key === '2'"></addressBookList>
          </wd-tab>
        </template>
      </wd-tabs>
    </view>
  </PageLayout>
</template>

<script lang="ts" setup>
import chatList from './components/chatList.vue'
import addressBookList from './components/addressBookList.vue'
import { platform, isMp } from '@/utils/platform'
defineOptions({
  name: 'message',
  options: {
    // apply-shared‌：当前页面样式会影响到子组件样式.(小程序)
    // shared‌：当前页面样式影响到子组件，子组件样式也会影响到当前页面.(小程序)
    styleIsolation: '‌shared‌',
  },
})
import { ref } from 'vue'
const globalData = getApp().globalData
const { systemInfo, navHeight } = globalData
const { statusBarHeight } = systemInfo
console.log('systemInfo:::', systemInfo)
const tabList = ref([
  { key: '1', title: '消息' },
  { key: '2', title: '通讯录' },
])
const tabActive = ref<string>('1')
const getClass = () => {
  return `${platform} ${isMp ? 'mp' : ''}`
}
</script>

<style lang="scss" scoped>
.wrap {
  height: 100%;
}
:deep(.wd-tabs) {
  height: 100%;
  display: flex;
  flex-direction: column;
  &.mp {
    .wd-tabs__nav-container {
      padding-right: 7%;
    }
  }
  .wd-tabs__nav {
    background: linear-gradient(45deg, #0081ff, #1cbbb4);
    height: var(--nav-height);
    padding-top: var(--status-bar-height);
    .wd-tabs__nav-item {
      color: #fff;
    }
  }
  .wd-tabs__container {
    flex: 1;
    width: 100%;
  }
  .wd-tabs__body {
    position: relative;
  }
  .wd-tabs__line {
    background-color: #fff;
  }
}
:deep(.wd-tab) {
  .wd-tab__body {
    position: absolute;
    height: 100%;
    width: 100%;
    top: 0;
    left: 0;
  }
}
</style>
