<template>
  <view class="chip-row">
    <view
      v-for="item in items"
      :key="item.key"
      class="chip"
      :class="{ 'chip--on': item.key === active }"
      hover-class="chip-press"
      @click="$emit('change', item.key)"
    >
      <text class="chip__txt">{{ item.label }}</text>
    </view>
  </view>
</template>

<script lang="ts" setup>
export interface StatsChipItem {
  key: string
  label: string
}

defineProps<{
  items: StatsChipItem[]
  active: string
}>()

defineEmits<{
  change: [key: string]
}>()
</script>

<style lang="scss" scoped>
.chip-row {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.chip {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 32px;
  padding: 0 16px;
  border: 1px solid rgba(255, 255, 255, 0.7);
  border-radius: 9999px;
  background: rgba(255, 255, 255, 0.62);
  box-sizing: border-box;
  touch-action: manipulation;
}

.chip__txt {
  color: #5a6380;
  font-size: 12px;
  letter-spacing: 0.5px;
  line-height: 1;
}

.chip--on {
  border-color: transparent;
  background: linear-gradient(135deg, #40a9ff, #1890ff);
  box-shadow: 0 5px 14px rgba(24, 144, 255, 0.3);
}

.chip--on .chip__txt {
  color: #fff;
  font-weight: 500;
}

.chip-press {
  opacity: 0.86;
}
</style>
