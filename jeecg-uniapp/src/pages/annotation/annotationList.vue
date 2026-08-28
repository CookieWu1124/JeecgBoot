<route lang="json5" type="page">
{
  layout: 'default',
  style: {
    navigationBarTitleText: '我的消息',
    navigationStyle: 'custom',
  },
}
</route>

<template>
  <PageLayout navTitle="我的消息" :backRouteName="backRouteName" routeMethod="pushTab">
    <view class="wrap">
      <z-paging ref="paging" :fixed="false" v-model="dataList" @query="queryList">
        <template v-for="(item, index) in dataList">
          <wd-swipe-action>
            <view class="list bg-white" @click="showDetail(item)">
              <view class="cIcon">
                <view
                  v-if="['email'].includes(item.busType)"
                  class="u-iconfont u-icon-email"
                ></view>
                <view
                  v-else-if="['bpm_task', 'bpm'].includes(item.busType)"
                  class="u-iconfont u-icon-bpm"
                ></view>
                <view
                  v-else-if="['msgCategory'].includes(item.busType)"
                  class="u-iconfont u-icon-message"
                ></view>
                <view v-else class="u-iconfont u-icon-msg"></view>
              </view>
              <view class="content">
                <text class="title ellipsis">{{ item.titile }}</text>
                <text class="desc">{{ getDesc(item) }}</text>
              </view>
              <view class="operate">
                <view class="star-area" @click.stop="changeStarFlag(item)">
                  <view
                    v-if="item.starFlag == '1'"
                    class="u-iconfont u-icon-star-fill"
                    style="color: #f7de2d"
                  ></view>
                  <view v-else class="u-iconfont u-icon-star" style="color: #777"></view>
                </view>
                <text class="time">{{ item.sendTime?.substring(0, 10) }}</text>
              </view>
            </view>
            <template #right>
              <view class="action">
                <view class="button" @click="handleAction('del', item)">删除</view>
              </view>
            </template>
          </wd-swipe-action>
        </template>
      </z-paging>
    </view>
    <template #navRight>
      <view
        class="cuIcon-filter font-size-20px color-white"
        @click="() => (conditionFilter.show = true)"
      ></view>
    </template>
    <rightConditionFilter
      v-if="conditionFilter.show"
      @close="() => (conditionFilter.show = false)"
      :starFlag="starFlag"
      :conditionStartDate="conditionStartDate"
      :conditionEndDate="conditionEndDate"
      @change="handleFilterChange"
    ></rightConditionFilter>
  </PageLayout>
</template>

<script lang="ts" setup>
//
import { onLaunch, onShow, onHide, onLoad, onReady } from '@dcloudio/uni-app'
import { http } from '@/utils/http'
import { useToast, useMessage, useNotify, dayjs } from 'wot-design-uni'
import { useRouter } from '@/plugin/uni-mini-router'
import rightConditionFilter from './components/rightConditionFilter.vue'

defineOptions({
  name: 'annotationList',
  options: {
    // apply-shared‌：当前页面样式会影响到子组件样式.(小程序)
    // shared‌：当前页面样式影响到子组件，子组件样式也会影响到当前页面.(小程序)
    styleIsolation: '‌apply-shared‌',
  },
})
const toast = useToast()
const router = useRouter()
const paging = ref(null)
const dataList = ref([])
const starFlag = ref('')
const conditionFilter = reactive({ show: false })
const backRouteName = ref('index')
// 开始时间结束时间
const conditionStartDate = ref(null)
const conditionEndDate = ref(null)
const getParams = ({ pageNo, pageSize }) => {
  let result: any = {
    pageNo,
    pageSize,
    starFlag: starFlag.value,
    rangeDateKey: 'zdy',
  }
  if (conditionStartDate.value) {
    result.beginDate = dayjs(conditionStartDate.value).format('YYYY-MM-DD') + ' 00:00:00'
  } else {
    result.beginDate = ''
  }
  if (conditionEndDate.value) {
    result.endDate = dayjs(conditionEndDate.value).format('YYYY-MM-DD') + ' 23:59:59'
  } else {
    result.endDate = ''
  }
  return result
}
// @query所绑定的方法不要自己调用！！需要刷新列表数据时，只需要调用paging.value.reload()即可
const queryList = (pageNo, pageSize) => {
  const params = getParams({ pageNo, pageSize })
  http
    .get('/sys/annountCement/vue3List', { ...params })
    .then((res: any) => {
      if (res.success) {
        paging.value.complete(res.result)
      } else {
        paging.value.complete(false)
      }
    })
    .catch((res) => {
      paging.value.complete(false)
    })
}
const showDetail = (record) => {
  if (record.busType == 'email') {
    goEmailDetailPage(record)
  } else if (record.busType == 'bpm') {
    // goBpmList(record.busId)
    toast.warning('暂未实现~')
  } else if (record.busType == 'bpm_task') {
    // goBpmList(record.busId)
    toast.warning('暂未实现~')
  } else {
    uni.navigateTo({
      url: '/pages/annotation/annotationDetail?item=' + encodeURIComponent(JSON.stringify(record)),
    })
  }
}
const goEmailDetailPage = (item) => {
  if (item.readFlag == '0') {
    paging.value.reload()
    let readUrl = '/sys/sysAnnouncementSend/editByAnntIdAndUserId'
    http.put(readUrl, { anntId: item.anntId })
  }
  uni.navigateTo({
    url: '/pages/mail/mailDetail?id=' + item.busId,
  })
}
const goBpmList = (taskId) => {
  const url = '/act/process/extActProcessNode/getProcessNodeInfo'
  let params = { taskId: taskId, datatimes: new Date().getTime() }
  http.get(url, { params }).then((res: any) => {
    console.log('000>>', res)
    const data = res.result
    if (data.taskIsHandel == true) {
      toast.show('任务已经处理完成!')
    } else {
      let params = {
        id: taskId,
        taskId: taskId,
        isSignTask: data.isSignTask,
        taskDefKey: data.taskDefKey,
        instanceId: data.records.BPM_INST_ID,
        pageCur: 'peoplelis',
      }
      console.log('goBpmList***********params>>', params)
      // #ifdef APP-PLUS
      router.replaceAll({ name: 'index', params })
      // #endif
      // #ifndef APP-PLUS
      let url = `/pages/index/index?pageCur=peoplelis&id=${taskId}&taskId=${taskId}&isSignTask=${data.isSignTask}&taskDefKey=${data.taskDefKey}&instanceId=${data.records.BPM_INST_ID}`
      uni.reLaunch({
        url: url,
      })
      // #endif
    }
  })
}

const handleFilterChange = ([flag, startTime, endTime]) => {
  starFlag.value = flag
  startTime && (conditionStartDate.value = startTime)
  endTime && (conditionEndDate.value = endTime)
  paging.value.reload()
}
// 收藏与取消收藏
const changeStarFlag = (item) => {
  const url = '/sys/sysAnnouncementSend/edit'
  let starFlag = '1'
  if (item.starFlag == starFlag) {
    starFlag = '0'
  }
  const params = {
    starFlag,
    id: item.sendId,
  }
  http.put(url, params).then((res: any) => {
    if (res.success) {
      item.starFlag = starFlag
    } else {
      toast.warning(res.message)
    }
  })
}
// 滑动删除
const handleAction = (flag, item) => {
  http
    .delete('/sys/sysAnnouncementSend/delete', { id: item.sendId })
    .then((res: any) => {
      if (res.success) {
        paging.value.reload()
      }
    })
    .catch((e) => {
      console.log('al delUrl请求错误2', e)
    })
}
// 根据类型获取描述
const getDesc = (item) => {
  if (item.busType == 'email') {
    // 邮件提醒
    return '您收到一封新的邮件，请及时处理。'
  } else if (item.busType == 'bpm') {
    // 流程催办
    return '您收到一条流程催办，请及时处理。'
  } else if (item.busType == 'bpm_task') {
    // 流程任务
    return '您收到一条流程任务，请及时处理。'
  } else if (item.msgCategory == '2') {
    // 系统消息
    return '您收到一条系统消息，请及时处理。'
  } else if (item.msgCategory == '1') {
    // 通知公告
    return '您收到一条通知公告，请及查看。'
  }
}
onLoad((options) => {
  if (options?.backRouteName) {
    backRouteName.value = options.backRouteName
  }
})
</script>

<style lang="scss" scoped>
//
.wrap {
  height: 100%;
}
.wd-swipe-action {
  &:first-child {
    margin-top: 10px;
  }
}
.list {
  padding: 14px 14px;
  background-color: #fff;
  border-bottom: 1px solid #eee;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  .cIcon {
    flex: none;
    text-align: center;
    line-height: 33px;
    width: 33px;
    height: 33px;
    background-color: #f37b1d;
    color: #fff;
    border-radius: 4px;
    margin-right: 10px;
  }
  .content {
    flex: 1;
    display: flex;
    flex-direction: column;
    margin-right: 20px;
    overflow: hidden;
    .title {
      font-size: 15px;
      margin-bottom: 2px;
    }
    .desc {
      font-size: 13px;
      color: rgb(153, 153, 153);
    }
  }
  .operate {
    text-align: right;
    width: 70px;
    .u-iconfont {
      font-size: 20px;
      margin-bottom: 8px;
    }
    .time {
      font-size: 12px;
      color: #aaa;
    }
  }
}
.action {
  width: 70px;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  .button {
    display: flex;
    align-items: center;
    justify-content: center;
    flex: 1;
    height: 100%;
    color: #fff;
    &:first-child {
      background-color: #fa4350;
    }
  }
}
</style>
