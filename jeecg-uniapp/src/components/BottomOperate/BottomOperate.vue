<template>
  <wd-popup v-model="show" position="bottom" @close="handleClose">
    <view class="contetn">
      <wd-text v-if="title" :text="title"></wd-text>
      <wd-cell-group border>
        <wd-cell
          v-for="(item, index) in options"
          :icon="item.icon"
          :label="item.label"
          :custom-class="item.color"
          clickable
          @click="handleClick(item)"
        ></wd-cell>
      </wd-cell-group>
    </view>
  </wd-popup>
</template>

<script setup lang="ts">
import { ref } from 'vue'
defineOptions({
  name: 'BottomOperate',
  options: {
    styleIsolation: 'shared',
  },
})
const eimt = defineEmits(['change', 'close'])
const show = ref(true)
const props = defineProps(['title', 'data', 'options'])
const handleClose = () => {
  show.value = false
  setTimeout(() => {
    eimt('close')
  }, 300)
}
const handleClick = (item) => {
  eimt('change', { option: item, data: props.data })
  handleClose()
}
</script>

<style lang="scss" scoped>
.contetn {
  padding: 10px;
  .wd-text.is-default {
    font-size: 14px;
    color: #666;
  }
  :deep(.wd-cell) {
    padding-left: 0;
    --wot-cell-label-color: #444;
    --wot-cell-label-fs: 14px;
    &.red {
      color: red;
      --wot-cell-label-color: red;
    }
  }
}
</style>
