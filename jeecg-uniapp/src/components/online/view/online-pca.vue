<template>
  <view>
    <wd-picker
      :columns="columns"
      :label-width="labelWidth"
      :label="label"
      :required="required"
      v-model="selected"
      :column-change="onChangeDistrict"
      @confirm="handleConfirm"
    />
  </view>
</template>

<script lang="ts" setup>
import { areaData } from '@/components/online/area-picker-data'
import {getAreaArrByCode} from '@/common/areaData/Area'
import {isString} from "@/utils/is";
// 接收 props
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
  value: {
    type: [String,Array],
    required: false,
  },
  placeholder: {
    type: String,
    required: false,
    default: '请选择省市区',
  },
  disabled: {
    type: Boolean,
    default: false,
    required: false,
  },
  required: {
    type: Boolean,
    default: false,
    required: false,
  },
})
// 定义 emits
const emits = defineEmits(['input', 'change', 'update:value'])

// 定义响应式数据
const selected = ref([])
const district = { ...areaData }
const columns = ref([
  district[0],
  district[district[0][0].value],
  district[district[district[0][0].value][0].value]
])
const onChangeDistrict = (pickerView, value, columnIndex, resolve) => {
  const item = value[columnIndex]
  if (columnIndex === 0) {
    pickerView.setColumnData(1, district[item.value])
    pickerView.setColumnData(2, district[district[item.value][0].value])
  } else if (columnIndex === 1) {
    pickerView.setColumnData(2, district[item.value])
  }
  resolve()
}

const handleConfirm = ({value}) => {
  emits('update:value', value);
}
// 监听 value 变化
watch(
  () => props.value,
  async (val) => {
    if(props.value && isString(props.value)){
      let arr = getAreaArrByCode(props.value);
      selected.value = arr;
      await initColumnData(arr);
    }
  },
  { immediate: true },
)
/**
 * 初始化列数据
 * @param val
 */
function initColumnData(val){
  if(val && val.length){
    let first = district[0];
    let second = district[selected.value[0]];
    let third = district[selected.value[1]];
    columns.value = [first, second, third]
  }
}
</script>
