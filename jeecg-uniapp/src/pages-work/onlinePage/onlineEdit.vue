<route lang="json5" type="page">
{
  layout: 'default',
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: 'Online表单新增',
  },
}
</route>

<template>
  <PageLayout :navTitle="navTitle" :backRouteName="backRouteName">
    <scroll-view scroll-y>
      <online-loader
        ref="online"
        :table="tableName"
        :title="navTitle"
        :dataId="dataId"
        edit
        show-footer
        @success="handleSuccess"
        @back="backRoute"
      ></online-loader>
    </scroll-view>
  </PageLayout>
</template>

<script lang="ts" setup>
import OnlineLoader from '@/components/online/online-loader.vue'
import router from '@/router'
import { onLoad } from '@dcloudio/uni-app'
// 定义响应式数据
const tableName = ref('')
const navTitle = ref('')
const dataId = ref('')
const online = ref(null)
const backRouteName = ref('onlineTable')
// 定义 initForm 方法
const initForm = (item) => {
  console.log('initForm item', item)
  // 表名
  tableName.value = item.desformCode
  // 表描述
  navTitle.value = `表单【${item.desformName}】`
  // 数据ID
  dataId.value = item.id
  // 返回上一页面
  item.backRouteName && (backRouteName.value = item.backRouteName)
  nextTick(() => {
    online.value.loadByTableName(tableName.value)
  })
}

const backRoute = () => {
  router.back()
}

// 定义 handleSuccess 方法
const handleSuccess = (id) => {
  uni.$emit('refreshList')
  backRoute()
}

// onLoad 生命周期钩子
onLoad((option) => {
  initForm(option)
})
</script>

<style lang="scss" scoped>
//
</style>
