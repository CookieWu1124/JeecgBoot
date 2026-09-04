<template>
  <div class="proposal-pick-input">
    <a-input
      class="pick-field"
      :value="label"
      :placeholder="placeholder"
      readonly
      :disabled="disabled"
      @click="handleOpen"
    />
    <a-button type="primary" :disabled="disabled" @click="handleOpen">选择</a-button>
  </div>
</template>
<script lang="ts" setup>
  const props = defineProps({
    label: { type: String, default: '' },
    placeholder: { type: String, default: '请选择' },
    disabled: { type: Boolean, default: false },
  });

  const emit = defineEmits(['open']);

  function handleOpen() {
    if (props.disabled) {
      return;
    }
    emit('open');
  }
</script>
<style scoped lang="less">
  .proposal-pick-input {
    display: flex;
    gap: 8px;
    width: 100%;
    .pick-field {
      flex: 1;
      min-width: 0;
      cursor: pointer;
    }
    :deep(.ant-input[disabled]) {
      cursor: not-allowed;
    }
  }
</style>
