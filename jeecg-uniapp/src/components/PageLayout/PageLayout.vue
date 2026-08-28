<template>
  <view class="pageLayout">
    <view
      v-if="navbarShow"
      :class="{ pageNav: true, transparent: navBgTransparent, fixed: navFixed }"
      :style="{ height: `${statusBarHeight + navHeight}px` }"
    >
      <view class="statusBar" :style="{ height: `${statusBarHeight}px` }"></view>
      <wd-navbar
        :bordered="!navBgTransparent"
        :title="navTitle"
        :leftText="navLeftText"
        :leftArrow="navLeftArrow"
        :rightText="navRightText"
        @clickLeft="handleClickLeft"
        @clickRight="handleClickRight"
        custom-class="nav"
      >
        <template v-if="$slots.navRight" #right>
          <slot name="navRight"></slot>
        </template>
      </wd-navbar>
    </view>
    <view class="pageContent">
      <slot></slot>
    </view>
    <view class="tabbar"></view>
    <wd-toast></wd-toast>
    <wd-message-box></wd-message-box>
    <wd-notify></wd-notify>
  </view>
</template>

<script setup lang="ts">
import { useSlots } from 'vue'
import { useRouter } from '@/plugin/uni-mini-router'
import { useParamsStore } from '@/store/page-params'

defineOptions({
  name: 'pageLayout',
  options: {
    // apply-shared‌：当前页面样式会影响到子组件样式.(小程序)
    // shared‌：当前页面样式影响到子组件，子组件样式也会影响到当前页面.(小程序)
    styleIsolation: 'shared',
  },
})
const paramsStore = useParamsStore()
const router = useRouter()
const props = defineProps({
  backRouteName: {
    type: String,
    default: '',
  },
  backRoutePath: {
    type: String,
    default: '',
  },
  routeParams: {
    type: Object,
    default: () => {},
  },
  routeQuery: {
    type: Object,
    default: () => {},
  },
  routeMethod: {
    type: String,
    default: 'replace',
  },
  navbarShow: {
    type: Boolean,
    default: true,
  },
  navBgTransparent: {
    type: Boolean,
    default: false,
  },
  navFixed: {
    type: Boolean,
    default: false,
  },
  type: {
    type: String,
    default: 'page', //'page','popup'
  },
  navTitle: {
    type: String,
    default: '',
  },
  navLeftText: {
    type: String,
    default: '返回',
  },
  navLeftArrow: {
    typeof: Boolean,
    default: true,
  },
  navRightText: {
    typeof: String,
    default: '',
  },
})
const slot = useSlots()
const globalData = getApp().globalData
const { systemInfo, navHeight } = globalData
const { statusBarHeight } = systemInfo
const emit = defineEmits(['navBack', 'navRight'])
const handleClickLeft = () => {
  emit('navBack')
  // 只有在页面中才默认返回，弹层中不返回
  if (props.type === 'page') {
    const pages = getCurrentPages()
    if (props.backRouteName || props.backRoutePath) {
      const prevPage = pages[pages.length - 2]
      if (prevPage) {
        const route = prevPage.route
        const name = route.split('/').pop()
        if (route === props.backRoutePath || props.backRouteName === name) {
          router.back()
          clearPageParamsCache()
          return
        }
      }
      if (props.backRouteName) {
        router[props.routeMethod]({ name: props.backRouteName, params: props.routeParams })
        clearPageParamsCache()
      } else {
        router[props.routeMethod]({ name: props.backRoutePath, query: props.routeQuery })
        clearPageParamsCache()
      }
    } else {
      router.back()
      clearPageParamsCache()
    }
  }
}
const clearPageParamsCache = () => {
  // 清除页面传参缓存
  const pages = getCurrentPages()
  const curPage = pages[pages.length - 1]
  const curRoute = curPage.route
  const name = curRoute.split('/').pop()
  paramsStore.clearPageParams(name)
}
const handleClickRight = () => {
  emit('navRight')
}
console.log('props:', props)
</script>

<style lang="scss" scoped>
.pageLayout {
  display: flex;
  flex-direction: column;
  height: 100vh;
  width: 100vw;
  .pageNav {
    background-image: linear-gradient(45deg, #0081ff, #1cbbb4);
    &.transparent {
      background-image: none;
    }
    &.fixed {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
    }
    .statusBar {
      width: 100%;
      height: 0;
    }
    :deep(.wd-navbar) {
      background-color: transparent;
      --wot-navbar-title-font-weight: 400;
      --wot-navbar-arrow-size: 18px;
      --wot-navbar-desc-font-size: 14px;
      --wot-navbar-title-font-size: 16px;
    }
  }
  .pageContent {
    flex: 1;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    background-color: #f1f1f1;
  }
  .tabbar {
    /* #ifdef H5 */
	 height: var(--window-bottom);
    /* #endif */
  }
}
</style>
