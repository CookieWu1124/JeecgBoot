// @ts-nocheck
import { randomString } from './uitls'
import { useUserStore } from '@/store/user'

const baseUrl = import.meta.env.VITE_SERVER_BASEURL

class socket {
  constructor() {
    this.socketUrl = baseUrl
    this.socketStart = false
    this.socketType = ''
    this.monitorSocketError()
    this.monitorSocketClose()
    this.socketReceive()
  }
  init(socket_type, callback?) {
		const userStore = useUserStore()
    const _this = this
    if (baseUrl) {
      if (this.socketStart) {
        console.log('webSocket已经启动了')
      } else {
        _this.socketType = socket_type
        let url =
          this.socketUrl.replace('https://', 'wss://').replace('http://', 'ws://') +
          '/' +
          socket_type +
          '/' +
          userStore.userInfo.userid +
          '_app'
        if (socket_type == 'eoaNewChatSocket') {
          let randomMessageId = randomString(6)
          url =
            this.socketUrl.replace('https://', 'wss://').replace('http://', 'ws://') +
            '/eoaNewChatSocket/' +
            userStore.userInfo.userid +
            '/' +
            randomMessageId
        }
        console.log('启动this.socketUrl连接地址：', url)
        // update-begin-author:taoyan date:20220422 for:v2.4.6 的 websocket 服务端，存在性能和安全问题。 #3278

        let token = userStore.userInfo.token
        uni.connectSocket({
          url: url,
          method: 'GET',
          protocols: [token],
        })
        // update-end-author:taoyan date:20220422 for: v2.4.6 的 websocket 服务端，存在性能和安全问题。 #3278
        uni.onSocketOpen((res) => {
          this.socketStart = true
          callback && callback()
          console.log('WebSocket连接已打开！')
        })
        /* setTimeout(() => {
				   _this.getHeartbeat();
				}, 5000); */
      }
    } else {
      console.log('config/baseUrl socketUrl为空')
    }
  }
  // Socket给服务器发送消息
  send(data, callback) {
		const userStore = useUserStore()
    const _this = this
    if (userStore.userInfo.userid) {
      data.userUid = userStore.userInfo.userid
    }
    console.log(data)
    uni.sendSocketMessage({
      data: JSON.stringify(data),
      success: () => {
        callback && callback(true)
      },
      fail: () => {
        callback && callback(false)
      },
    })
  }
  // Socket接收服务器发送过来的消息
  socketReceive() {
    const _this = this
    uni.onSocketMessage(function (res) {
      console.log('APP:--》收到服务器内容：')
      let data = JSON.parse(res.data)
      // console.log('收到服务器内容：', data);
      _this.acceptMessage && _this.acceptMessage(data)
    })
  }
  // 关闭Socket
  closeSocket() {
    const _this = this
    uni.closeSocket()
    _this.socketStart = false
  }
  // 监听Socket关闭
  monitorSocketClose() {
    const _this = this
    uni.onSocketClose(function (res) {
      console.log('WebSocket 已关闭！')
      _this.socketStart = false
      setTimeout(function () {
        _this.init(_this.socketType)
      }, 3000)
    })
  }
  // 监听Socket错误
  monitorSocketError() {
    const _this = this
    uni.onSocketError(function (res) {
      _this.socketStart = false
      console.log('WebSocket连接打开失败，请检查！')
    })
  }
  // 心跳
  getHeartbeat() {
		const userStore = useUserStore()
    const _this = this
    this.send(
      {
        type: '心跳',
        userUid: userStore.userInfo.userid,
      },
      (val) => {
        setTimeout(() => {
          if (val) {
            // _this.getHeartbeat();
          } else {
            if (!_this.socketStart) {
              // _this.init();
            }
          }
        }, 10000)
      },
    )
  }
}
const mySocket = new socket()
export default mySocket
