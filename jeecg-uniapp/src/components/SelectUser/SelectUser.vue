<template>
  <view class="SelectUser">
    <view @click.stop="handleClick">
      <wd-input
        :placeholder="getPlaceholder($attrs)"
        v-bind="$attrs"
        readonly
        v-model="showText"
      ></wd-input>
    </view>
    <SelectUserModal
      v-if="modalShow"
      :selected="modelValue"
      :modalTitle="modalTitle"
      :maxSelectCount="maxSelectCount"
      :multi="!isRadioSelection"
      @change="handleChange"
      @close="() => (modalShow = false)"
    ></SelectUserModal>
  </view>
</template>

<script setup lang="ts">
import { ref, watch, useAttrs } from 'vue'
import { useToast, useMessage, useNotify, dayjs } from 'wot-design-uni'
import { http } from '@/utils/http'
import DaTree from '@/uni_modules/da-tree/index.vue'
import { isArray, isString } from '@/utils/is'
import SelectUserModal from './components/SelectUserModal.vue'
import { getPlaceholder } from '@/common/uitls'
defineOptions({
  name: 'SelectUser',
  options: {
    styleIsolation: 'shared',
  },
})
const props = defineProps({
  modelValue: {
    type: [Array, String],
    default: '',
  },
  labelKey: {
    type: String,
    default: 'realname',
  },
  rowKey: {
    type: String,
    default: 'username',
  },
  isRadioSelection: {
    type: Boolean,
    default: false,
  },
  modalTitle: {
    type: String,
    default: '选择用户',
  },
  maxSelectCount: {
    type: Number,
  },
})
const emit = defineEmits(['update:modelValue', 'change'])
const api = {
  list: '/sys/user/list',
}
const showText = ref('')
const modalShow = ref(false)

// 翻译
const transform = () => {
  let value = props.modelValue
  let len
  if (isArray(value) || isString(value)) {
    if (isArray(value)) {
      len = value.length
      value = value.join(',')
    } else {
      len = value.split(',').length
    }
    value = value.trim()
    if (value) {
      const params = { isMultiTranslate: true, pageSize: len, [props.rowKey]: value }
      http.get(api.list, params).then((res: any) => {
        if (res.success) {
          const records = res.result?.records ?? []
          showText.value = records.map((item) => item[props.labelKey]).join(',')
        } else {
          console.log('翻译失败~')
        }
      })
    }
  } else {
    showText.value = ''
  }
}
// 打开popup
const handleClick = () => {
  modalShow.value = true
}
const handleChange = (data) => {
  const rowkey = data.map((item) => item[props.rowKey]).join(',')
  const labelKey = data.map((item) => item[props.labelKey]).join(',')
  showText.value = labelKey
  emit('update:modelValue', rowkey)
  emit('change', rowkey)
}

watch(
  () => props.modelValue,
  () => {
    transform()
  },
  { immediate: true },
)
</script>

<style scoped></style>
