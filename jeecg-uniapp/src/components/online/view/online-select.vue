<template>
  <wd-picker
    :label-width="labelWidth"
    :label="label"
    filterable
    v-model="selected"
    :columns="options"
    :disabled="disabled"
    placeholder="请选择"
    @change="handleChange"
  ></wd-picker>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue'
import { isArray, isString } from 'lodash'
import {http} from "@/utils/http"; // 假设使用 lodash 来判断类型

// 定义 props
const props = defineProps({
  dict: {
    type: [Array, String],
    default: () => [],
    required: true,
  },
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
  dictStr: {
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

// 定义响应式数据
const selected = ref('请选择')
const options = ref([])

// 初始化选项
const initSelections = async () => {
  options.value = []
  if (props.type === 'sel_search' && props.dictStr) {
    let temp = props.dictStr
    if (temp.indexOf(' ') > 0) {
      temp = encodeURI(props.dictStr)
    }
    try {
      const res = await http.get('/sys/dict/getDictItems/' + temp)
      if (res.success) {
        options.value = res.result;
      }
    } catch (error) {
      console.error('请求数据出错:', error)
    }
  }
  else {
    if (!props.dict || props.dict.length === 0) {
      return
    }
    if (isString(props.dict)) {
      try {
        const res = await http.get('/sys/dict/getDictItems/' + props.dict)
        if (res.success) {
          options.value = res.result;
        }
      } catch (error) {
        console.error('请求数据出错:', error)
      }
    } else {
      props.dict.forEach((item) => {
        options.value.push(item)
      })
    }
  }
}

// 选择器改变事件处理函数
const handleChange = (e) => {
  emit('update:value', selected.value);
  emit('change', selected.value);
}

// 监听 dict 和 value 的变化
watch(() => props.dict, () => {
    initSelections();
});
// 监听 value 的变化
watch(
  () => props.value,
  (val) => {
      selected.value = !val? [] : props.value;
  },
  { immediate: true },
)

// 组件挂载时初始化选项
onMounted(() => {
  initSelections()
})
</script>

<style></style>
