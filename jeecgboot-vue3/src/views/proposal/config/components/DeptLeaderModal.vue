<template>
  <BasicModal v-bind="$attrs" @register="registerModal" :title="title" @ok="handleSubmit" :width="640">
    <BasicForm @register="registerForm" />
  </BasicModal>
</template>
<script lang="ts" setup>
  import { ref, unref } from 'vue';
  import { BasicModal, useModalInner } from '/@/components/Modal';
  import { BasicForm, useForm } from '/@/components/Form/index';
  import { deptLeaderFormSchema } from '../config.data';
  import { saveDeptLeader } from '../config.api';

  const emit = defineEmits(['success', 'register']);
  const isUpdate = ref(false);
  const title = ref('部门负责人配置');

  const [registerForm, { resetFields, setFieldsValue, validate }] = useForm({
    schemas: deptLeaderFormSchema,
    showActionButtonGroup: false,
    labelWidth: 110,
  });

  const [registerModal, { setModalProps, closeModal }] = useModalInner(async (data) => {
    await resetFields();
    setModalProps({ confirmLoading: false });
    isUpdate.value = !!data?.isUpdate;
    title.value = unref(isUpdate) ? '编辑部门负责人' : '新增部门负责人';
    if (data?.record) {
      await setFieldsValue({ ...data.record });
    }
  });

  async function handleSubmit() {
    try {
      const values = await validate();
      setModalProps({ confirmLoading: true });
      await saveDeptLeader(values);
      closeModal();
      emit('success');
    } finally {
      setModalProps({ confirmLoading: false });
    }
  }
</script>
