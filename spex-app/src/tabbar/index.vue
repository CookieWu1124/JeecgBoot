<script setup lang="ts">
// i-carbon-code
// i-carbon-add
import { customTabbarEnable, needHideNativeTabbar, tabbarCacheEnable } from './config'
import { setTabbarItem } from './i18n'
import { tabbarList, tabbarStore } from './store'
import TabbarItem from './TabbarItem.vue'

// #ifdef MP-WEIXIN
defineOptions({
  virtualHost: true,
})
// #endif

/** 中间鼓包：发起提案 */
function handleClickBulge() {
  uni.navigateTo({ url: '/pages/proposal/apply' })
}

function handleClick(index: number) {
  const list = tabbarList.value
  if (!list[index]) {
    return
  }
  if (list[index].isBulge) {
    handleClickBulge()
    return
  }
  if (index === tabbarStore.curIdx) {
    return
  }
  const url = list[index].pagePath
  tabbarStore.setCurIdx(index)
  if (tabbarCacheEnable) {
    uni.switchTab({ url })
  }
  else {
    uni.navigateTo({ url })
  }
}

// #ifndef MP-WEIXIN || MP-ALIPAY
onLoad(() => {
  needHideNativeTabbar
  && uni.hideTabBar({
    fail(err) {
      console.log('hideTabBar fail: ', err)
    },
  })
})
// #endif

// #ifdef MP-ALIPAY
onMounted(() => {
  customTabbarEnable
  && uni.hideTabBar({
    fail(err) {
      console.log('hideTabBar fail: ', err)
    },
  })
})
// #endif

const activeColor = '#1890FF'
const inactiveColor = '#9AA2BC'

function getColorByIndex(index: number) {
  return tabbarStore.curIdx === index ? activeColor : inactiveColor
}

function isActive(index: number) {
  return !tabbarList.value[index]?.isBulge && tabbarStore.curIdx === index
}

onShow(() => {
  setTabbarItem()
})
</script>

<template>
  <view v-if="customTabbarEnable" class="tabbar-root">
    <!-- 挡住浮动菜单四周/底部的页面内容透出 -->
    <view class="tabbar-mask" />
    <view class="tabbar-shell" @touchmove.stop.prevent>
      <view class="tabbar-inner">
        <view
          v-for="(item, index) in tabbarList"
          :key="index"
          class="tab-slot"
          :class="{ 'tab-slot--active': isActive(index), 'tab-slot--bulge': item.isBulge }"
          :style="{ color: item.isBulge ? '#fff' : getColorByIndex(index) }"
          @click="handleClick(index)"
        >
          <view v-if="item.isBulge" class="bulge">
            <TabbarItem :item="item" :index="index" is-bulge />
          </view>
          <TabbarItem v-else :item="item" :index="index" class="relative px-2 text-center" />
        </view>
      </view>
    </view>
  </view>
</template>

<style scoped lang="scss">
/* 仅固定悬浮，不占文档流，避免底部多出一条白底 */
.tabbar-root {
  pointer-events: none;
}

.tabbar-mask {
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 99;
  height: calc(88px + env(safe-area-inset-bottom));
  pointer-events: none;
  background: linear-gradient(
    180deg,
    rgba(238, 245, 255, 0) 0%,
    rgba(238, 245, 255, 0.72) 32%,
    #eef5ff 58%
  );
}

.tabbar-shell {
  position: fixed;
  right: 10px;
  bottom: calc(10px + env(safe-area-inset-bottom));
  left: 10px;
  z-index: 100;
  height: 62px;
  pointer-events: auto;
  background: #fff;
  border: 1px solid rgba(255, 255, 255, 0.9);
  border-radius: 26px;
  box-shadow:
    0 12px 40px rgba(24, 144, 255, 0.12),
    inset 0 1px 0 rgba(255, 255, 255, 0.8);
  box-sizing: border-box;
}

.tabbar-inner {
  display: flex;
  align-items: flex-start;
  height: 100%;
  padding-top: 8px;
}

.tab-slot {
  position: relative;
  display: flex;
  flex: 1;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  padding-top: 2px;
}

.tab-slot--active::before {
  position: absolute;
  top: -8px;
  width: 20px;
  height: 3.5px;
  content: '';
  background: linear-gradient(90deg, #1890ff, #69c0ff);
  border-radius: 0 0 4px 4px;
}

.tab-slot--bulge {
  padding-top: 0;
}

.bulge {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 54px;
  height: 54px;
  margin-top: -24px;
  background: linear-gradient(135deg, #69c0ff, #1890ff 55%, #13c2c2);
  border-radius: 50%;
  box-shadow:
    0 12px 28px rgba(24, 144, 255, 0.45),
    0 0 0 5px rgba(255, 255, 255, 0.55);

  &:active {
    transform: scale(0.92);
  }
}
</style>
