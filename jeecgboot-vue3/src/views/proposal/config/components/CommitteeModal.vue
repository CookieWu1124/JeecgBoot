<template>
  <BasicModal v-bind="$attrs" @register="registerModal" :title="title" @ok="handleSubmit" :width="640">
    <BasicForm @register="registerForm" />
  </BasicModal>
</template>
<script lang="ts" setup>
  import { ref, unref } from 'vue';
  import { BasicModal, useModalInner } from '/@/components/Modal';
  import { BasicForm, useForm } from '/@/components/Form/index';
  import { committeeFormSchema } from '../config.data';
  import { saveCommittee } from '../config.api';

  const emit = defineEmits(['success', 'register']);
  const isUpdate = ref(false);
  const title = ref('委员会成员');

  const [registerForm, { resetFields, setFieldsValue, validate }] = useForm({
    schemas: committeeFormSchema,
    showActionButtonGroup: false,
    labelWidth: 110,
  });

  const [registerModal, { setModalProps, closeModal }] = useModalInner(async (data) => {
    await resetFields();
    setModalProps({ confirmLoading: false });
    isUpdate.value = !!data?.isUpdate;
    title.value = unref(isUpdate) ? '编辑委员' : '新增委员';
    if (data?.record) {
      await setFieldsValue({ ...data.record });
    }
  });

  async function handleSubmit() {
    try {
      const values = await validate();
      setModalProps({ confirmLoading: true });
      await saveCommittee(values);
      closeModal();
      emit('success');
    } finally {
      setModalProps({ confirmLoading: false });
    }
  }
</script>
