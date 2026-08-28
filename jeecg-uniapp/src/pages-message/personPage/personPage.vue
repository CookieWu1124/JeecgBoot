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
  <PageLayout
    :backRouteName="backRouteName"
    navLeftText=""
    :navBgTransparent="true"
    :navFixed="true"
  >
    <view class="wrap">
      <view class="topArea"></view>
      <view class="middleArea bg-white">
        <wd-img
          custom-class="avatar"
          width="75px"
          height="75px"
          radius="50%"
          :src="data.avatar"
        ></wd-img>
        <wd-text custom-class="realname center" :text="data.realname"></wd-text>
        <wd-button custom-class="" @click="handleGo">发消息</wd-button>
      </view>
      <view class="bottomArea bg-white">
        <view class="list">
          <view class="iconBox">
            <view class="cuIcon-mobile text-gray-4"></view>
          </view>
          <view class="content">
            <view class="label text-gray-4">手机</view>
            <view class="value text-blue-5">{{ data.phone || '未填写' }}</view>
          </view>
        </view>
        <view class="list">
          <view class="iconBox">
            <view class="cuIcon-mail text-gray-4"></view>
          </view>
          <view class="content">
            <view class="label text-gray-4">手机</view>
            <view class="value text-blue-5">{{ data.email || '未填写' }}</view>
          </view>
        </view>
      </view>
    </view>
  </PageLayout>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { useUserStore } from '@/store/user'
import { useParamsStore } from '@/store/page-params'
import { useRouter } from '@/plugin/uni-mini-router'
//
const userStore = useUserStore()
const paramsStore = useParamsStore()
const router = useRouter()
const params = paramsStore.getPageParams('personPage')
const backRouteName = ref(params.backRouteName) ?? {}
let data = params.data ?? {}


const handleGo = () => {
  var parmas = {
    fromAvatar: data.avatar,
    fromUserName: data.realname || data.username,
    msgFrom: userStore.userInfo.userid,
    msgTo: data.id,
    type: 'friend',
  }
  paramsStore.setPageParams('chat', { back: 'personPage', data: parmas })
  router.push({ name: 'chat' })
}
</script>

<style lang="scss" scoped>
//
.topArea {
  background: linear-gradient(45deg, #0081ff, #1cbbb4);
  min-height: 170px;
}
.middleArea {
  position: relative;
  display: flex;
  flex-direction: column;
  padding-bottom: 30px;
  .avatar {
    position: absolute;
    top: 0;
    left: 50%;
    transform: translate(-50%, -50%);
  }
  .realname {
    padding-top: 50px;
    font-size: 18px;
    font-weight: 700;
    color: #333;
    margin-bottom: 20px;
  }
}
.bottomArea {
  .list {
    border-top: 1px solid #f1f1f1;
    display: flex;
    align-items: center;
    padding: 10px;
    .iconBox {
      font-size: 28px;
      margin-right: 10px;
    }
    .label {
      font-size: 15px;
      margin-bottom: 4px;
    }
  }
  .value {
    color: #3665cb;
  }
}
</style>
