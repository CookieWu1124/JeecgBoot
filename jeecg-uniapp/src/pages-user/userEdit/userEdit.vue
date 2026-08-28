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
  <PageLayout navTitle="编辑资料" backRouteName="people" routeMethod="pushTab">
    <wd-form custom-class="pt3" ref="form" :model="model">
      <wd-cell-group border>
        <wd-input
          label="用户名"
          prop="username"
          clearable
          label-width="70px"
          v-model="model.username"
          :readonly="true"
          placeholder="请输入用户名"
        />
        <wd-input
          label="名称"
          prop="realname"
          clearable
          label-width="70px"
          v-model="model.realname"
          placeholder="请输入用户名"
          :rules="[{ validator: rules.realname }]"
        />
        <wd-cell title="头像">
          <avatar v-model="model.avatar"></avatar>
        </wd-cell>
        <wd-select-picker
          label="性别"
          type="radio"
          v-model="model.sex"
          :columns="columns"
          title="请选择性别"
          :safe-area-inset-bottom="false"
        ></wd-select-picker>
        <wd-input
          label="手机号"
          prop="phone"
          clearable
          label-width="70px"
          v-model="model.phone"
          :readonly="true"
          placeholder="请输入手机号"
          :rules="[{ validator: rules.phone }]"
        />
        <wd-input
          label="邮箱"
          prop="email"
          clearable
          label-width="70px"
          v-model="model.email"
          :readonly="true"
          placeholder="请输入邮箱"
          :rules="[{ validator: rules.email }]"
        />
      </wd-cell-group>
      <view class="footer p5">
        <wd-button type="primary" size="large" @click="handleSubmit" block>提交</wd-button>
      </view>
    </wd-form>
  </PageLayout>
</template>

<script lang="ts" setup>
import { http } from '@/utils/http'
import { useToast, useMessage, useNotify, dayjs } from 'wot-design-uni'
import { useRouter } from '@/plugin/uni-mini-router'
import { useUserStore } from '@/store/user'
import avatar from './components/avatar.vue'

defineOptions({
  name: 'chatList',
  options: {
    styleIsolation: 'shared',
  },
})
const toast = useToast()
const router = useRouter()
const userStore = useUserStore()
const columns = [
  { label: '男', value: 1 },
  { label: '女', value: 2 },
]
const model = reactive({
  username: userStore.userInfo.username,
  realname: userStore.userInfo.realname,
  avatar: userStore.userInfo.avatar,
  sex: userStore.userInfo.sex ?? 1,
  phone: userStore.userInfo.phone,
  email: userStore.userInfo.email,
})
const rules = {
  realname: (value) => {
    if (value?.trim()?.length) {
      return true
    } else {
      toast.warning('请输入名称')
      return false
    }
  },
  phone: (value) => {
    if (value?.trim()?.length) {
      if (/^1[3-9]\d{9}$/.test(value)) {
        return true
      } else {
        toast.warning('请输入正确的手机号')
        return false
      }
    } else {
      toast.warning('请输入手机号')
      return false
    }
  },
  email: (value) => {
    if (value?.trim()?.length) {
      if (/^[a-zA-Z0-9_%+-]+(\.[a-zA-Z0-9_%+-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$/.test(value)) {
        return true
      } else {
        toast.warning('请输入正确的邮箱')
        return false
      }
    } else {
      toast.warning('请输入邮箱')
      return false
    }
  },
}
const form = ref()

function handleSubmit() {
  form.value
    .validate()
    .then(({ valid, errors }) => {
      if (valid) {
        if (!model.avatar) {
          toast.warning('上传头像')
          return
        }
        // toast.success('校验通过')
        const data = { ...model, id: userStore.userInfo.userid }
        delete data.username
        uni.showLoading()
        http
          .post('/sys/user/login/setting/userEdit', { ...data })
          .then((res: any) => {
            uni.hideLoading()
            if (res.success) {
              toast.success('修改成功~')
              setTimeout(() => {
                userStore.editUserInfo({ ...data })
                router.replaceAll({ name: 'people' })
              }, 1e3)
            } else {
              toast.warning(res.message)
            }
          })
          .catch(() => {
            toast.error('提交失败')
            uni.hideLoading()
          })
      }
    })
    .catch((error) => {
      console.log(error, 'error')
    })
}
</script>

<style lang="scss" scoped>
//
:deep(.wd-cell) {
  .wd-cell__left {
    width: 70px;
    flex: none;
  }
  .wd-cell__value {
    text-align: left;
  }
}
</style>
