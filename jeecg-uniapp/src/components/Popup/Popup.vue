<template>
  <view class="Popup">
    <view @click="handleClick">
      <wd-input
        :placeholder="`请选择${$attrs.label}`"
        type="text"
        readonly
        v-model="showText"
        clearable
        v-bind="$attrs"
      />
    </view>
    <popupReportModal
      v-if="reportModal.show"
      :code="code"
      :showFiled="reportModal.showFiled"
      :multi="multi"
      @close="handleClose"
      @change="handleChange"
    ></popupReportModal>
  </view>
</template>

<script setup lang="ts">
import { ref, watch, useAttrs } from 'vue'
import { useToast, useMessage, useNotify, dayjs } from 'wot-design-uni'
import { http } from '@/utils/http'
import popupReportModal from './components/popupReportModal.vue'
defineOptions({
  name: 'Popup',
  options: {
    styleIsolation: 'shared'
  }
})
const props = defineProps({
  code: {
    type: String,
    required: true,
    default: '',
  },
  fieldConfig: {
    type: Array,
    required: true,
    default: () => [],
  },
  setFieldsValue: {
    type: Function,
    required: true,
    default: () => {},
  },
  modelValue: {
    type: String,
    default: '',
  },
  multi: {
    type: Boolean,
    default: false,
  },
  spliter: {
    type: String,
    default: ',',
  },
})
const emit = defineEmits(['change', 'update:modelValue'])

const toast = useToast()
const showText = ref('')
const attrs: any = useAttrs()
const reportModal = reactive({
  show: false,
  showFiled: props.fieldConfig.map((item) => item['target']).join(','),
})
if (!props.code || props.fieldConfig.length == 0) {
  toast.error('popup参数未正确配置!')
}

/**
 * 监听value数值
 */
watch(
  () => props.modelValue,
  (val) => {
    showText.value = val && val.length > 0 ? val.split(props.spliter).join(',') : ''
  },
  { immediate: true },
)
function callBack(rows) {
  let fieldConfig: any = props.fieldConfig
  //匹配popup设置的回调值
  let values = {}
  let labels = []
  for (let item of fieldConfig) {
    let val = rows.map((row) => row[item.source])
    val = val.length == 1 ? val[0] : val.join(',')
    item.target.split(',').forEach((target) => {
      values[target] = val
    })
  }
  showText.value = labels.join(',')
  props.setFieldsValue(values)
  emit('change', values)
  // emit('update:modelValue', values)
}
const handleClick = () => {
  if (!attrs.disabled) {
    reportModal.show = true
  }
}
const handleClose = () => {
  reportModal.show = false
}
const handleChange = (data) => {
  console.log('选中的值：', data)
  callBack(data)
}
</script>

<style scoped></style>
