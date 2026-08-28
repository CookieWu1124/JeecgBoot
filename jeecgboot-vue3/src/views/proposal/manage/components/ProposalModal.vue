<template>
  <BasicModal
    v-bind="$attrs"
    @register="registerModal"
    title="提案详情"
    :showOkBtn="false"
    cancelText="关闭"
    :width="720"
  >
    <BasicForm @register="registerForm" />
  </BasicModal>
</template>
<script lang="ts" setup>
  import { BasicModal, useModalInner } from '/@/components/Modal';
  import { BasicForm, useForm } from '/@/components/Form/index';
  import { detailFormSchema } from '../proposal.data';
  import { getProposalById } from '../proposal.api';

  defineEmits(['register']);

  const [registerForm, { resetFields, setFieldsValue }] = useForm({
    schemas: detailFormSchema,
    showActionButtonGroup: false,
    labelWidth: 110,
  });

  const [registerModal, { setModalProps }] = useModalInner(async (data) => {
    await resetFields();
    setModalProps({ confirmLoading: false });
    if (data?.record?.id) {
      const record = await getProposalById({ id: data.record.id });
      await setFieldsValue({ ...record });
    } else if (data?.record) {
      await setFieldsValue({ ...data.record });
    }
  });
</script>
