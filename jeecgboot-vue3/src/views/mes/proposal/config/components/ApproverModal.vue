<template>
  <div style="display: contents">
    <BasicModal v-bind="$attrs" @register="registerModal" :title="title" @ok="handleSubmit" :width="640">
    <a-form
      ref="formRef"
      :model="formState"
      :label-col="{ style: { width: '110px' } }"
      :wrapper-col="{ style: { flex: 1 } }"
    >
      <a-form-item label="批准人" name="userId" :rules="[{ required: true, message: '请选择批准人' }]">
        <ProposalPickInput :label="userLabel" placeholder="请选择批准人" @open="openUserModal(true)" />
      </a-form-item>
      <a-form-item label="备注" name="remark">
        <a-textarea v-model:value="formState.remark" :rows="2" placeholder="请输入备注" />
      </a-form-item>
    </a-form>
  </BasicModal>
  <UserSelectModal
    @register="registerUserModal"
    :is-radio-selection="true"
    row-key="id"
    label-key="realname"
    :max-select-count="1"
    modal-title="选择批准人"
    @getSelectResult="onUserSelected"
  />
  </div>
</template>
<script lang="ts" setup>
  import { reactive, ref, unref } from 'vue';
  import type { FormInstance } from 'ant-design-vue';
  import { BasicModal, useModal, useModalInner } from '/@/components/Modal';
  import UserSelectModal from '/@/components/Form/src/jeecg/components/modal/UserSelectModal.vue';
  import { saveApprover } from '../config.api';
  import { pickSingleSelection } from '../pickSingle';
  import ProposalPickInput from './ProposalPickInput.vue';

  const emit = defineEmits(['success', 'register']);
  const formRef = ref<FormInstance>();
  const isUpdate = ref(false);
  const title = ref('批准人');
  const userLabel = ref('');

  const formState = reactive({
    id: undefined as string | undefined,
    userId: undefined as string | undefined,
    remark: undefined as string | undefined,
    approverStatus: 'active',
  });

  const [registerUserModal, { openModal: openUserModal }] = useModal();

  function resetForm() {
    formState.id = undefined;
    formState.userId = undefined;
    formState.remark = undefined;
    formState.approverStatus = 'active';
    userLabel.value = '';
    formRef.value?.clearValidate();
  }

  function onUserSelected(options, values) {
    const picked = pickSingleSelection(options, values);
    formState.userId = picked.id;
    userLabel.value = picked.label;
    formRef.value?.validateFields(['userId']);
  }

  const [registerModal, { setModalProps, closeModal }] = useModalInner(async (data) => {
    resetForm();
    setModalProps({ confirmLoading: false });
    isUpdate.value = !!data?.isUpdate;
    title.value = unref(isUpdate) ? '更换批准人' : '配置批准人';
    if (data?.record) {
      formState.id = data.record.id;
      formState.userId = data.record.userId;
      formState.remark = data.record.remark;
      formState.approverStatus = data.record.approverStatus || 'active';
      userLabel.value = data.record.user?.realname || '';
    }
  });

  async function handleSubmit() {
    try {
      await formRef.value?.validate();
      setModalProps({ confirmLoading: true });
      await saveApprover({
        id: formState.id,
        userId: formState.userId,
        remark: formState.remark,
        approverStatus: formState.approverStatus,
      });
      closeModal();
      emit('success');
    } finally {
      setModalProps({ confirmLoading: false });
    }
  }
</script>
