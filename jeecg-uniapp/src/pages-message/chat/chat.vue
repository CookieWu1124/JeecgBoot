<route lang="json5" type="page">
{
  layout: 'default',
  style: {
    navigationBarTitleText: '聊天',
    navigationStyle: 'custom',
  },
}
</route>

<template>
  <PageLayout :navTitle="navTitle" backRouteName="message" routeMethod="pushTab">
    <view class="wrap">
      <!-- prettier-ignore -->
      <z-paging ref="paging" v-model="dataList" :fixed="false" use-chat-record-mode use-virtual-list cell-height-mode="dynamic" safe-area-inset-bottom bottom-bg-color="#e5e5e5" @query="queryList" @keyboardHeightChange="keyboardHeightChange" @hidedKeyboard="hidedKeyboard">
        <template #cell="{item,index}">
          <view style="transform: scaleY(-1)">
            <chat-item :item="item" :playMsgid="playMsgid" @playVoice="handlePlayVoice"></chat-item>
          </view>
        </template>
        <template #bottom>
          <chat-input-bar ref="inputBar" @send="doSend" @image="handleImage" />
        </template>
      </z-paging>
    </view>
  </PageLayout>
</template>

<script lang="ts" setup>
//
import { onLaunch, onShow, onHide, onLoad, onReady } from '@dcloudio/uni-app'
import { nextTick, onMounted, ref } from 'vue'
import { useUserStore } from '@/store/user'
import { http } from '@/utils/http'
import { useToast, useMessage, useNotify, dayjs } from 'wot-design-uni'
import { useRouter } from '@/plugin/uni-mini-router'
import { cache, getFileAccessHttpUrl, hasRoute, formatDate } from '@/common/uitls'
import { TENANT_LIST } from '@/common/constants'
import socket from '@/common/socket'
import { textReplaceEmoji, getEmojiImageUrl } from './emojis'
import chatInputBar from './components/chat-input-bar.vue'
import chatItem from './components/chat-item.vue'
import { getEnvBaseUrl } from '@/utils/index'
import { useParamsStore } from '@/store/page-params'

defineOptions({
  name: 'chat',
  options: {
    // apply-shared‌：当前页面样式会影响到子组件样式.(小程序)
    // shared‌：当前页面样式影响到子组件，子组件样式也会影响到当前页面.(小程序)
    styleIsolation: '‌apply-shared‌',
  },
})

const api = {
  chatlog_old: '/eoa/im/api/queryChatLogList',
  chatlog: '/eoa/im/newApi/records',
  sendMsg: '/eoa/im/newApi/sendMessage',
  sendFile: '/eoa/im/newApi/sendFile',
  creatFriendSession: '/eoa/im/newApi/creatFriendSession',
  uploadUrl: `${getEnvBaseUrl()}/eoa/im/newApi/sendImage`,
}

const toast = useToast()
const userStore = useUserStore()
const paging = ref(null)

// 聊天对方用户信息
const chatObj = ref(null)
const navTitle = ref('')
// 对方userid
const chatto = ref()
const myuid = ref(userStore.userInfo.userid)
const msgList = ref([])
// const pageNo = ref(1)
// const pageSize = ref(10)
const loadingShow = ref(false)
const hasRecord = ref(false)
const dataList = ref([])
const inputBar = ref(null)
const AUDIO = uni.createInnerAudioContext()
const playMsgid = ref('')
let stopWatch: any = null
const paramsStore = useParamsStore()

// 页面初始化
const init = () => {
  const localData = paramsStore.getPageParams('chat')
  const params = localData.data
  if (!params) {
    return
  }
  chatObj.value = { ...params }
  navTitle.value = params.fromUserName
  chatto.value = chatObj.value.msgTo
  creatFriendSession(chatObj.value.msgTo)
  onSocketOpen()
  onSocketReceive()
  getMsgList()
}
// 创建会话数据
const creatFriendSession = (userId) => {
  http.post(api.creatFriendSession, {
    type: 'friend',
    userId,
  })
}
const onSocketOpen = () => {
  console.log('启动webSocket')
  socket.init('eoaNewChatSocket')
}
const onSocketReceive = () => {
  var _this = this
  socket.acceptMessage = function (res) {
    console.log('页面收到的消息=====》', res)
    if (res.event == 'event_talk_revoke') {
      // 撤回了消息
      removeMsg(res)
    } else {
      if (res.type == 'friend') {
        //聊天消息
        screenMsg(res)
        unreadClear()
      }
    }
  }
}
const removeMsg = (data) => {
  let arr = msgList.value.filter((item) => item.id != data.id)
  msgList.value = arr
}
const screenMsg = (msg) => {
  //消息处理
  if (msg.msgFrom == chatto.value && msg.msgTo == myuid.value) {
    console.log('用户消息')
    let time = formatDate(msg.sendTime, 'yyyy-MM-dd hh:mm:ss')
    let id = time.replace(/\:/g, '').replace(/\-/g, '').replace(' ', '')
    let content = msg.msgData
    if (msg.msgType == 'text') {
      content = replaceEmoji(content)
    }
    if (msg.msgType == 'voice') {
      content = JSON.parse(content)
    }
    msgList.value.push({
      fromUserName: msg.fromUserName,
      msgTo: msg.msgTo,
      msgFrom: msg.msgFrom,
      msgData: content,
      fromAvatar: msg.fromAvatar,
      sendTime: time,
      msgType: msg.msgType,
      sendTimeId: id,
      fileName: msg.fileName,
      id: msg.id,
    })
    //非自己的消息震动
    if (msg.msgFrom != myuid.value) {
      console.log('振动')
      uni.vibrateLong()
    }
    // this.$nextTick(function () {
    //   // 滚动到底
    //   this.scrollToView = 'msg' + id
    // })
  }
}
//替换表情符号为图片
const replaceEmoji = (str) => {
  let temp = textReplaceEmoji(str)
  return '<div style="display:inline-block">' + temp + '</div>'
}

const queryList = (pageNo, pageSize) => {
  //数据库查询消息列表
  let params = {
    type: 'friend',
    pageNo: pageNo,
    pageSize: pageSize,
    msgTo: chatto.value,
    id: myuid.value,
    sort: 'DESC',
  }
  console.log('params', params)
  http
    .get(api.chatlog, params)
    .then((res: any) => {
      if (res.success && res.result?.records) {
        const records = analysis(res.result.records)
        paging.value.complete(records)
      } else {
        paging.value.complete(false)
      }
    })
    .catch((res) => {
      paging.value.complete(false)
    })
}
const analysis = (data) => {
  let arr = data
  if (arr.length > 0) {
    let list = arr.map((item) => {
      let id = item.sendTime.replace(/\:/g, '').replace(/\-/g, '').replace(' ', '')
      item.sendTimeId = id
      let content = item.msgData
      if (item.msgType == 'text') {
        content = replaceEmoji(content)
      }
      if (item.msgType == 'voice') {
        content = JSON.parse(content)
      }
      item.msgData = content
      return item
    })
    for (let i = 0; i < list.length; i++) {
      if (list[i].msgType == 'revoke') {
        continue
      }
      if (list[i].referenceMsgId) {
        list[i] = handleReplyMsg(list[i], list)
      }
    }
  }
  return data
}

// 加载初始页面消息
const getMsgList = () => {}
const handleReplyMsg = (item, list) => {
  let tempId = item.referenceMsgId
  item.reply = true
  let replyContent = ''
  for (let i = 0; i < list.length; i++) {
    if (list[i].id == tempId) {
      replyContent = '"' + list[i].fromUserName + ':' + list[i].msgData + '"'
      break
    }
  }
  item.replyContent = replyContent
  return item
}
const unreadClear = () => {
  http
    .post('/eoa/im/newApi/unreadClear', {
      type: chatObj.value.type,
      msgTo: chatObj.value.msgTo,
      msgFrom: chatObj.value.msgFrom,
    })
    .then((res: any) => {
      if (res.success) {
        // _this.eventChannel.emit('toPrePageData', { data: 'data from chat page' })
      }
    })
}
// 播放语音
const handlePlayVoice = (item) => {
  if (item.id == playMsgid.value) {
    AUDIO.stop()
    playMsgid.value = ''
  } else {
    playMsgid.value = item.id
    AUDIO.src = item.msgData.url
    nextTick(function () {
      AUDIO.play()
    })
  }
}
// 播放语音结束
AUDIO.onEnded((res) => {
  playMsgid.value = ''
})

// 监听键盘高度改变，请不要直接通过uni.onKeyboardHeightChange监听，否则可能导致z-paging内置的键盘高度改变监听失效（如果不需要切换表情面板则不用写）
const keyboardHeightChange = (res) => {
  inputBar.value.updateKeyboardHeightChange(res)
}
// 用户尝试隐藏键盘，此时如果表情面板在展示中，应当通知chatInputBar隐藏表情面板（如果不需要切换表情面板则不用写）
const hidedKeyboard = () => {
  inputBar.value.hidedKeyboard()
}
const doSend = (textMsg) => {
  // paging.value.addChatRecordData([
  //   {
  //     time: '',
  //     icon: '/static/daxiong.jpg',
  //     name: '大雄',
  //     content: msg,
  //     isMe: true,
  //   },
  // ])

  let content = replaceEmoji(textMsg)
  //let msg = {'text':content}
  //content = (content||'').replace(/&(?!#?[a-zA-Z0-9]+;)/g, '&amp;')
  console.log('content', content)
  let msg = textMsg
  let time = formatDate(new Date().getTime(), 'yyyy-MM-dd hh:mm:ss')
  let id = time.replace(/\:/g, '').replace(/\-/g, '').replace(' ', '')
  //发送
  sendMsg(msg, 'text')
  paging.value.addChatRecordData(
    analysis([
      {
        fromUserName: userStore.userInfo.realname,
        msgTo: chatto.value,
        msgFrom: myuid.value,
        msgData: content,
        fromAvatar: userStore.userInfo.avatar,
        sendTime: time,
        sendTimeId: id,
        msgType: 'text',
      },
    ]),
  )
}

const sendMsg = (content, type) => {
  //实际应用中，此处应该提交长连接，模板仅做本地处理。
  var nowDate = new Date()
  // 发送消息
  var obj = {
    mine: {
      avatar: userStore.userInfo.avatar,
      content: content,
      id: myuid.value,
      mine: true,
      username: userStore.userInfo.username,
    },
    to: {
      avatar: chatObj.value.avatar,
      id: chatObj.value.msgTo,
      type: 'friend',
      username: chatObj.value.username,
    },
  }

  let sendData = {
    type: 'chatMessage',
    data: obj,
  }
  console.log('sendData======>', sendData)
  let params = {
    type: 'friend',
    msgTo: chatObj.value.msgTo,
    text: content,
    msgType: 'text',
  }
  http.post(api.sendMsg, params).then((res: any) => {
    console.log('消息发送结果：', res)
    if (!res.success) {
      toast.error(res.message)
    }
  })
}

const handleImage = (type) => {
  let time = formatDate(new Date().getTime(), 'yyyy-MM-dd hh:mm:ss')
  let id = time.replace(/\:/g, '').replace(/\-/g, '').replace(' ', '')
  let formData = {
    type: 'friend',
    msgTo: chatto.value,
    fileId: id,
    msgType: 'images',
    fileName: '',
  }
  const { loading, data, error, run } = useUpload(
    { ...formData, name: 'image' },
    { url: api.uploadUrl, sourceType: [type] },
  )
  if (stopWatch) stopWatch()
  run()
  stopWatch = watch(
    () => [loading.value, error.value, data.value],
    ([loading, err, data], oldValue) => {
      if (loading == false) {
        if (err) {
          toast.warning('修改失败')
          uni.hideLoading()
        } else {
          if (data) {
            console.log('data::', data)
          }
        }
      }
    },
  )
}
init()
</script>

<style lang="scss" scoped>
//
.wrap {
  height: 100%;
}
</style>
