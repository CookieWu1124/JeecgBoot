<template>
  <z-paging
    ref="paging"
    :fixed="false"
    v-model="dataList"
    @query="queryList"
    :default-page-size="100"
  >
    <uni-list>
      <template v-for="(item, index) in dataList" :key="index">
        <view
          :class="{ list: true, isTop: item.izTop == 1 }"
          @longpress.prevent="handleLongPress(item)"
          @click="handleGo(item)"
        >
          <template v-if="['systemNotice'].includes(item.type)">
            <view class="avatar">
              <text class="cuIcon-notice text-white"></text>
            </view>
          </template>
          <template v-if="['group'].includes(item.type) && !item.fromAvatar">
            <view class="group avatar">
              <text class="text-white">{{ getFirstStr(item.fromUserName) }}</text>
            </view>
          </template>
          <uni-list-chat
            avatarCircle
            clickable
            :title="item.fromUserName"
            :avatar="getAvatar(item)"
            :note="getChatType(item)"
            :time="beautifyTime(item.sendTime)"
            badge-positon="left"
            :badge-text="item.unreadNum"
            @click="handleGo(item)"
          ></uni-list-chat>
        </view>
      </template>
    </uni-list>
  </z-paging>
  <BottomOperate
    v-if="bottomOperatePopup.show"
    v-bind="bottomOperatePopup"
    @close="() => (bottomOperatePopup.show = false)"
    @change="handleChange"
  ></BottomOperate>
  <wd-toast />
</template>

<script setup lang="ts">
import { onLaunch, onShow, onHide, onLoad, onReady } from '@dcloudio/uni-app'
import { http } from '@/utils/http'
import { useToast, useMessage, useNotify, dayjs } from 'wot-design-uni'
import { useRouter } from '@/plugin/uni-mini-router'
import { beautifyTime } from '@/common/uitls'
import { useParamsStore } from '@/store/page-params'

defineOptions({
  name: 'chatList',
  options: {
    styleIsolation: 'shared',
  },
})
const toast = useToast()
const router = useRouter()
const paramsStore = useParamsStore()
const paging = ref(null)
const avatarList = ref()
const dataList = ref([])

const options = [
  { key: 'backtop', icon: 'backtop', label: '置顶' },
  { key: 'cancelbacktop', icon: 'translate-bold', label: '取消置顶' },
  { key: 'delete', icon: 'delete', label: '删除', color: 'red' },
]
const bottomOperatePopup = reactive({
  show: false,
  title: '',
  data: {},
  options: [],
})

const queryList = () => {
  http
    .get('/eoa/im/newApi/getChatList')
    .then((res: any) => {
      if (res.success) {
        paging.value.complete(res.result.logVoList)
        nextTick(() => {
          setTimeout(() => {
            sortByIzTop(dataList.value)
            dataList.value = [...dataList.value]
          }, 10)
        })
      } else {
        paging.value.complete(false)
      }
    })
    .catch((res) => {
      paging.value.complete(false)
    })
}
const sortByIzTop = (arr) => {
  return arr.sort((a, b) => {
    if (a.izTop && !b.izTop) {
      return -1 // a 排在 b 前面
    } else if (!a.izTop && b.izTop) {
      return 1 // b 排在 a 前面
    } else {
      return 0 // 保持原有顺序
    }
  })
}
const getFirstStr = (val) => {
  return val ? val.substr(0, 1) : val
}
const getAvatar = (item) => {
  if (['systemNotice'].includes(item.type)) {
  } else if (['group'].includes(item.type)) {
  }
  return item.fromAvatar ?? ''
}
const getChatType = (item) => {
  switch (item.type) {
    case 'discussion':
      return '[组消息]'
    case 'systemNotice':
      return '[系统消息]'
    case 'friend':
      return item.status == 'offline' ? '[离线]' : '[在线]'
    case 'group':
      return '[群消息]'
    default:
      return ''
  }
}
const handleLongPress = (item) => {
  bottomOperatePopup.show = true
  bottomOperatePopup.title = item.fromUserName
  bottomOperatePopup.data = item
  bottomOperatePopup.options = options.filter((o) => {
    if (o.key == 'backtop' && item.izTop == 1) {
      return false
    } else if (o.key == 'cancelbacktop' && item.izTop == 0) {
      return false
    }
    return true
  })
}
const handleChange = ({ option, data }) => {
  if (['cancelbacktop', 'backtop'].includes(option.key)) {
    let izTop = 1
    if (option.key === 'cancelbacktop') {
      izTop = 0
    }
    http
      .post('/eoa/im/newApi/chatToTop', {
        id: data.id,
        izTop,
      })
      .then((res: any) => {
        if (res.success) {
          paging.value.reload()
        }
      })
  } else if (option.key === 'delete') {
    http
      .post('/eoa/im/newApi/removeChat', {
        id: data.id,
      })
      .then((res: any) => {
        if (res.success) {
          paging.value.reload()
        }
      })
  }
}
// 跳转
const handleGo = (item) => {
  if (['systemNotice'].includes(item.type)) {
    //1.系统消息
    router.push({ name: 'annotationList', params: { backRouteName: 'message' } })
  } else if (['friend'].includes(item.type)) {
    //2.聊天
    paramsStore.setPageParams('chat', { data: item })
    router.push({ name: 'chat' })
  } else {
    ///3.群组和讨论组
    // TODO
    toast.warning('暂不支持')
  }
}
</script>

<style lang="scss" scoped>
.z-paging-content {
  background-color: #f1f1f1;
}
.list {
  &.isTop {
    :deep(.uni-list-chat) {
      background-color: #eee;
    }
  }
  position: relative;
  .avatar {
    &.group {
      background-color: #f37b1d;
      font-size: 18px;
    }
    position: absolute;
    top: 10px;
    left: 15px;
    background-color: #0081ff;
    font-size: 24px;
    width: 45px;
    height: 45px;
    z-index: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
  }
}
:deep(.uni-list-chat) {
  .uni-list-chat__badge {
    z-index: 2;
  }
  .uni-list-chat__content-title {
    color: #9ca3af;
  }
  .uni-list-chat__content-title {
    font-size: 15px;
  }
  .uni-list-chat__header {
    background-color: #eee;
  }
}
:deep(.wd-popup) {
  &.wd-popup--bottom {
    bottom: 50px;
  }
}
</style>
