<template>
  <wd-popup v-model="show" position="right" @close="handleClose">
    <wd-cell-group border>
      <wd-cell custom-class="title" title="筛选"></wd-cell>
      <wd-radio-group v-model="star">
        <wd-cell title="全部消息" clickable @click="handleSelected('')">
          <wd-radio value=""></wd-radio>
        </wd-cell>
        <wd-cell title="星标消息" clickable @click="handleSelected('1')">
          <wd-radio value="1"></wd-radio>
        </wd-cell>
      </wd-radio-group>
      <wd-cell custom-class="date">
        <wd-calendar
          placeholder="请选开始日期"
          v-model="sartDate"
          @confirm="handleStartDateConfirm"
        />
      </wd-cell>
      <wd-cell custom-class="date">
        <wd-calendar
          :border="false"
          placeholder="请选结束日期"
          v-model="endDate"
          @confirm="handleEndDateConfirm"
        />
      </wd-cell>
    </wd-cell-group>
  </wd-popup>
</template>

<script lang="ts" setup>
//
import { ref } from 'vue'
const props = defineProps(['starFlag', 'conditionStartDate', 'conditionEndDate'])
const eimt = defineEmits(['change', 'close'])
const show = ref(true)
const star = ref(props.starFlag)
const sartDate = ref(props.conditionStartDate)
const endDate = ref(props.conditionEndDate)
const handleClose = () => {
  setTimeout(() => {
    eimt('close')
  }, 300)
}
const handleSelected = (val) => {
  star.value = val
  eimt('change', [star.value, sartDate.value, endDate.value])
}
const handleStartDateConfirm = ({ value }) => {
  sartDate.value = value
  eimt('change', [star.value, sartDate.value, endDate.value])
}
const handleEndDateConfirm = ({ value }) => {
  endDate.value = value
  eimt('change', [star.value, sartDate.value, endDate.value])
}
</script>

<style lang="scss" scoped>
//
.wd-cell {
  &.title {
    :deep(.wd-cell__title) {
      font-size: 17px;
    }
  }
}
.wd-cell-group {
  width: 150px;
  :deep(.wd-cell__wrapper) {
    align-items: center;
    .wd-cell__right {
      flex: 0.5;
    }
    .wd-radio {
      margin-top: 0;
    }
  }
}
.wd-cell {
  &.date {
    &:last-child {
      :deep(.wd-cell__wrapper) {
        border-bottom: 1px solid rgba(232, 232, 232, 0.5);
      }
    }
    :deep(.wd-cell__wrapper) {
      .wd-calendar__value {
        margin-right: 0;
        text-align: center;
      }
      .wd-calendar.is-border .wd-calendar__cell::after {
        display: none;
      }
      .wd-icon-arrow-right {
        display: none;
      }
      .wd-calendar__cell {
        padding: 0;
      }
      .wd-cell__left {
        display: none;
      }
      .wd-cell__right {
        flex: 1;
      }
    }
  }
}
</style>
