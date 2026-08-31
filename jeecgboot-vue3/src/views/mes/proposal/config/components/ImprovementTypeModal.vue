<template>
  <BasicModal
    v-bind="$attrs"
    @register="registerModal"
    :title="title"
    :helpMessage="subtitle"
    @ok="handleSubmit"
    :width="640"
  >
    <div class="type-modal">
      <a-form
        ref="formRef"
        :model="formState"
        :label-col="{ style: { width: '90px' } }"
        :wrapper-col="{ style: { flex: 1 } }"
      >
        <div class="section">
          <div class="section-hd">性质信息</div>
          <div class="section-bd">
            <div class="row-2">
              <a-form-item
                label="性质编码"
                name="typeCode"
                :rules="[{ required: true, message: '请输入性质编码' }]"
              >
                <a-input
                  v-model:value="formState.typeCode"
                  placeholder="如 SAFETY"
                  :disabled="isUpdate"
                />
              </a-form-item>
              <a-form-item
                label="改善性质"
                name="typeName"
                :rules="[{ required: true, message: '请输入性质名称' }]"
              >
                <a-input v-model:value="formState.typeName" placeholder="请输入性质名称" />
              </a-form-item>
            </div>
            <a-form-item label="性质说明" name="description">
              <a-textarea
                v-model:value="formState.description"
                :rows="3"
                placeholder="请输入性质说明"
              />
            </a-form-item>
            <div class="row-2">
              <a-form-item label="排序" name="sortNo">
                <a-input-number v-model:value="formState.sortNo" :min="0" style="width: 100%" />
              </a-form-item>
              <a-form-item label="状态" name="typeStatus">
                <div class="status-switch">
                  <span>启用</span>
                  <a-switch v-model:checked="statusEnabled" />
                </div>
              </a-form-item>
            </div>
          </div>
        </div>
      </a-form>
      <div class="required-hint">* 带「*」为必填项。编码创建后不可修改；已有提案引用时请停用而非删除。</div>
    </div>
  </BasicModal>
</template>
<script lang="ts" setup>
  import { computed, reactive, ref, unref } from 'vue';
  import type { FormInstance } from 'ant-design-vue';
  import { BasicModal, useModalInner } from '/@/components/Modal';
  import { saveImprovementType } from '../config.api';

  const emit = defineEmits(['success', 'register']);
  const formRef = ref<FormInstance>();
  const isUpdate = ref(false);
  const title = ref('新增改善性质');
  const subtitle = ref('配置改善性质编码、名称和启用状态');

  const formState = reactive({
    id: undefined as string | undefined,
    typeCode: undefined as string | undefined,
    typeName: undefined as string | undefined,
    description: undefined as string | undefined,
    typeStatus: 'active',
    sortNo: 0,
    remark: undefined as string | undefined,
  });

  const statusEnabled = computed({
    get: () => formState.typeStatus === 'active',
    set: (v: boolean) => {
      formState.typeStatus = v ? 'active' : 'disabled';
    },
  });

  function resetForm() {
    formState.id = undefined;
    formState.typeCode = undefined;
    formState.typeName = undefined;
    formState.description = undefined;
    formState.typeStatus = 'active';
    formState.sortNo = 0;
    formState.remark = undefined;
    formRef.value?.clearValidate();
  }

  const [registerModal, { setModalProps, closeModal }] = useModalInner(async (data) => {
    resetForm();
    setModalProps({ confirmLoading: false, okText: '确定', cancelText: '取消' });
    isUpdate.value = !!data?.isUpdate;
    title.value = unref(isUpdate) ? '编辑改善性质' : '新增改善性质';
    subtitle.value = unref(isUpdate)
      ? '修改性质名称、说明和启用状态（编码不可改）'
      : '配置改善性质编码、名称和启用状态';
    if (data?.record) {
      const rec = data.record;
      formState.id = rec.id;
      formState.typeCode = rec.typeCode;
      formState.typeName = rec.typeName;
      formState.description = rec.description;
      formState.typeStatus = rec.typeStatus || 'active';
      formState.sortNo = rec.sortNo ?? 0;
      formState.remark = rec.remark;
    }
  });

  async function handleSubmit() {
    try {
      await formRef.value?.validate();
      setModalProps({ confirmLoading: true });
      await saveImprovementType({
        id: formState.id,
        typeCode: formState.typeCode,
        typeName: formState.typeName,
        description: formState.description,
        typeStatus: formState.typeStatus,
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
  .type-modal {
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
    .required-hint {
      color: #999;
      font-size: 12px;
    }
  }
</style>
