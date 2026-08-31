<template>
  <BasicModal
    v-bind="$attrs"
    @register="registerModal"
    :title="title"
    :helpMessage="subtitle"
    @ok="handleSubmit"
    :width="640"
  >
    <div class="dim-modal">
      <a-form
        ref="formRef"
        :model="formState"
        :label-col="{ style: { width: '90px' } }"
        :wrapper-col="{ style: { flex: 1 } }"
      >
        <div class="section">
          <div class="section-hd">维度信息</div>
          <div class="section-bd">
            <div class="row-2">
              <a-form-item
                label="维度编码"
                name="dimCode"
                :rules="[{ required: true, message: '请输入维度编码' }]"
              >
                <a-input
                  v-model:value="formState.dimCode"
                  placeholder="如 tangible"
                  :disabled="isUpdate"
                />
              </a-form-item>
              <a-form-item
                label="评分维度"
                name="dimName"
                :rules="[{ required: true, message: '请输入评分维度' }]"
              >
                <a-input v-model:value="formState.dimName" placeholder="请输入维度名称" />
              </a-form-item>
            </div>
            <a-form-item label="维度说明" name="description">
              <a-textarea
                v-model:value="formState.description"
                :rows="3"
                placeholder="请输入维度说明"
              />
            </a-form-item>
          </div>
        </div>

        <div class="section">
          <div class="section-hd">权重设置</div>
          <div class="section-bd">
            <div class="row-2 weight-row">
              <a-form-item
                label="权重(%)"
                name="weightPct"
                :rules="[{ required: true, message: '请输入权重' }]"
              >
                <a-input-number
                  v-model:value="formState.weightPct"
                  :min="0"
                  :max="100"
                  style="width: 100%"
                />
              </a-form-item>
              <a-form-item label="状态" name="dimStatus">
                <div class="status-switch">
                  <span>启用</span>
                  <a-switch v-model:checked="statusEnabled" />
                </div>
              </a-form-item>
            </div>
            <div class="weight-bar" :class="weightBarClass">
              <span>启用权重合计</span>
              <span>
                <em>{{ liveWeightTotal }}%</em>
                不可超过 100%
              </span>
            </div>
          </div>
        </div>
      </a-form>
      <div class="required-hint">* 带「*」为必填项</div>
    </div>
  </BasicModal>
</template>
<script lang="ts" setup>
  import { computed, reactive, ref, unref } from 'vue';
  import type { FormInstance } from 'ant-design-vue';
  import { BasicModal, useModalInner } from '/@/components/Modal';
  import { saveScoreDimension } from '../config.api';

  const emit = defineEmits(['success', 'register']);
  const formRef = ref<FormInstance>();
  const isUpdate = ref(false);
  const title = ref('新增评分维度');
  const subtitle = ref('配置评分维度名称、权重和启用状态');
  /** 其他已启用维度的权重合计（不含当前编辑行原权重） */
  const otherActiveWeight = ref(0);

  const formState = reactive({
    id: undefined as string | undefined,
    dimCode: undefined as string | undefined,
    dimName: undefined as string | undefined,
    description: undefined as string | undefined,
    weightPct: undefined as number | undefined,
    dimStatus: 'active',
    sortNo: 0,
    remark: undefined as string | undefined,
  });

  const statusEnabled = computed({
    get: () => formState.dimStatus === 'active',
    set: (v: boolean) => {
      formState.dimStatus = v ? 'active' : 'disabled';
    },
  });

  const liveWeightTotal = computed(() => {
    const current = statusEnabled.value ? Number(formState.weightPct) || 0 : 0;
    return otherActiveWeight.value + current;
  });

  const weightBarClass = computed(() => {
    const total = liveWeightTotal.value;
    if (total > 100) {
      return 'is-over';
    }
    if (total === 100) {
      return 'is-ok';
    }
    return 'is-warn';
  });

  function resetForm() {
    formState.id = undefined;
    formState.dimCode = undefined;
    formState.dimName = undefined;
    formState.description = undefined;
    formState.weightPct = undefined;
    formState.dimStatus = 'active';
    formState.sortNo = 0;
    formState.remark = undefined;
    otherActiveWeight.value = 0;
    formRef.value?.clearValidate();
  }

  const [registerModal, { setModalProps, closeModal }] = useModalInner(async (data) => {
    resetForm();
    setModalProps({ confirmLoading: false, okText: '确定', cancelText: '取消' });
    isUpdate.value = !!data?.isUpdate;
    title.value = unref(isUpdate) ? '编辑评分维度' : '新增评分维度';
    subtitle.value = unref(isUpdate)
      ? '修改评分维度名称、权重和启用状态'
      : '配置评分维度名称、权重和启用状态';

    const listWeight = Number(data?.weightTotal) || 0;
    if (data?.record) {
      const rec = data.record;
      formState.id = rec.id;
      formState.dimCode = rec.dimCode;
      formState.dimName = rec.dimName;
      formState.description = rec.description;
      formState.weightPct = rec.weightPct;
      formState.dimStatus = rec.dimStatus || 'active';
      formState.sortNo = rec.sortNo ?? 0;
      formState.remark = rec.remark;
      // 合计中先去掉本行原启用权重，再按表单实时加回
      const selfActive = rec.dimStatus === 'active' ? Number(rec.weightPct) || 0 : 0;
      otherActiveWeight.value = Math.max(0, listWeight - selfActive);
    } else {
      otherActiveWeight.value = listWeight;
    }
  });

  async function handleSubmit() {
    try {
      await formRef.value?.validate();
      setModalProps({ confirmLoading: true });
      await saveScoreDimension({
        id: formState.id,
        dimCode: formState.dimCode,
        dimName: formState.dimName,
        description: formState.description,
        weightPct: formState.weightPct,
        dimStatus: formState.dimStatus,
        sortNo: formState.sortNo ?? 0,
        remark: formState.remark,
      });
      closeModal();
      emit('success');
    } finally {
      setModalProps({ confirmLoading: false });
    }
  }
</script>

<style scoped lang="less">
  .dim-modal {
    .section {
      border: 1px solid #f0f0f0;
      border-radius: 6px;
      overflow: hidden;
      margin-bottom: 16px;
    }
    .section-hd {
      background: #fafafa;
      color: #666;
      font-size: 13px;
      font-weight: 500;
      padding: 8px 14px;
      border-bottom: 1px solid #f0f0f0;
    }
    .section-bd {
      padding: 16px 14px 8px;
    }
    .row-2 {
      display: grid;
      grid-template-columns: 1fr 1fr;
      column-gap: 16px;
    }
    .status-switch {
      display: flex;
      align-items: center;
      gap: 10px;
      height: 32px;
      color: #595959;
    }
    .weight-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 4px 0 8px;
      padding: 10px 12px;
      border-radius: 4px;
      font-size: 13px;
      em {
        font-style: normal;
        font-weight: 600;
        margin-right: 6px;
      }
      &.is-ok {
        background: #f6ffed;
        color: #389e0d;
        border: 1px solid #b7eb8f;
      }
      &.is-warn {
        background: #fffbe6;
        color: #d48806;
        border: 1px solid #ffe58f;
      }
      &.is-over {
        background: #fff2f0;
        color: #cf1322;
        border: 1px solid #ffccc7;
      }
    }
    .required-hint {
      color: #999;
      font-size: 12px;
    }
  }
</style>
