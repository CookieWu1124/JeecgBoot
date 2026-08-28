<template>
  <wd-datetime-picker
    :disabled="disabled"
    :labelWidth="labelWidth"
    v-model="currentTime"
    :label="label"
    @confirm="handleConfirm"
  />
</template>

<script setup>
// 定义 props
import dayjs from 'dayjs'
import { isString } from '@/utils/is'

const props = defineProps({
  label: {
    type: String,
    default: '',
    required: false,
  },
  labelWidth: {
    type: String,
    default: '80px',
    required: false,
  },
  name: {
    type: String,
    default: '',
    required: false,
  },
  type: {
    type: String,
    default: '',
    required: false,
  },
  value: {
    type: [String, Number],
    required: false,
  },
  disabled: {
    type: Boolean,
    default: false,
    required: false,
  },
})

// 定义 emits
const emit = defineEmits(['input', 'change', 'update:value'])
// 定义响应式数据;
const visible = ref(false)
const currentTime = ref('')

// 监听 value 的变化
watch(
  () => props.value,
  (val) => {
    if (val) {
      console.log("日期时间变化val",val);
      currentTime.value = val && isString(val) ? new Date(val).getTime() : val
    } else {
      currentTime.value = ''
    }
  },
)
// 选择器改变事件处理函数
const handleConfirm = (e) => {
  emit('update:value', currentTime.value)
  emit('change', currentTime.value)
}
</script>

<style></style>
