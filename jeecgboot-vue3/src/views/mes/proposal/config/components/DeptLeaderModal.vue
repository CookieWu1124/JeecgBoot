<template>
  <div style="display: contents">
    <BasicModal v-bind="$attrs" @register="registerModal" :title="title" @ok="handleSubmit" :width="640">
    <a-form
      ref="formRef"
      :model="formState"
      :label-col="{ style: { width: '110px' } }"
      :wrapper-col="{ style: { flex: 1 } }"
    >
      <a-form-item label="改善部门" name="deptId" :rules="[{ required: true, message: '请选择改善部门' }]">
        <ProposalPickInput
          :label="deptLabel"
          placeholder="请选择改善部门"
          :disabled="isUpdate"
          @open="openDeptPicker"
        />
      </a-form-item>
      <a-form-item
        label="部门负责人"
        name="leaderUserId"
        :rules="[{ required: true, message: formState.deptId ? '请选择本部门负责人' : '请先选择改善部门' }]"
      >
        <ProposalPickInput
          :label="leaderLabel"
          placeholder="请选择部门负责人"
          :disabled="!formState.deptId"
          @open="openLeaderPicker"
        />
      </a-form-item>
      <a-form-item label="备注" name="remark">
        <a-textarea v-model:value="formState.remark" :rows="2" placeholder="请输入备注" />
      </a-form-item>
    </a-form>
  </BasicModal>
  <DeptSelectModal
    @register="registerDeptModal"
    :multiple="false"
    :sync="false"
    :checkStrictly="true"
    modal-title="选择改善部门"
    @getSelectResult="onDeptSelected"
  />
  <UserSelectModal
    @register="registerUserModal"
    :is-radio-selection="true"
    row-key="id"
    label-key="realname"
    :custom-list-api="queryDeptUsers"
    :max-select-count="1"
    modal-title="选择本部门负责人"
    @getSelectResult="onLeaderSelected"
  />
  </div>
</template>
<script lang="ts" setup>
  import { reactive, ref, unref } from 'vue';
  import type { FormInstance } from 'ant-design-vue';
  import { BasicModal, useModal, useModalInner } from '/@/components/Modal';
  import DeptSelectModal from '/@/components/Form/src/jeecg/components/modal/DeptSelectModal.vue';
  import UserSelectModal from '/@/components/Form/src/jeecg/components/modal/UserSelectModal.vue';
  import { useMessage } from '/@/hooks/web/useMessage';
  import { defHttp } from '/@/utils/http/axios';
  import { saveDeptLeader } from '../config.api';
  import { pickSingleSelection } from '../pickSingle';
  import ProposalPickInput from './ProposalPickInput.vue';

  const emit = defineEmits(['success', 'register']);
  const { createMessage } = useMessage();
  const formRef = ref<FormInstance>();
  const isUpdate = ref(false);
  const title = ref('部门负责人配置');
  const deptLabel = ref('');
  const leaderLabel = ref('');

  const formState = reactive({
    id: undefined as string | undefined,
    deptId: undefined as string | undefined,
    leaderUserId: undefined as string | undefined,
    remark: undefined as string | undefined,
  });

  const [registerDeptModal, { openModal: openDeptModal }] = useModal();
  const [registerUserModal, { openModal: openUserModal }] = useModal();

  function resetForm() {
    formState.id = undefined;
    formState.deptId = undefined;
    formState.leaderUserId = undefined;
    formState.remark = undefined;
    deptLabel.value = '';
    leaderLabel.value = '';
    formRef.value?.clearValidate();
  }

  function queryDeptUsers(params) {
    const departId = formState.deptId;
    if (!departId) {
      return Promise.resolve({ records: [], total: 0 });
    }
    return defHttp.get({
      url: '/sys/user/queryUserComponentData',
      params: { ...params, departId },
    });
  }

  function openDeptPicker() {
    if (unref(isUpdate)) {
      return;
    }
    openDeptModal(true);
  }

  function openLeaderPicker() {
    if (!formState.deptId) {
      createMessage.warning('请先选择改善部门');
      return;
    }
    openUserModal(true);
  }

  function onDeptSelected(options, values) {
    const picked = pickSingleSelection(options, values);
    const changed = picked.id !== formState.deptId;
    formState.deptId = picked.id;
    deptLabel.value = picked.label;
    if (changed) {
      formState.leaderUserId = undefined;
      leaderLabel.value = '';
    }
    formRef.value?.validateFields(['deptId']);
  }

  function onLeaderSelected(options, values) {
    const picked = pickSingleSelection(options, values);
    formState.leaderUserId = picked.id;
    leaderLabel.value = picked.label;
    formRef.value?.validateFields(['leaderUserId']);
  }

  const [registerModal, { setModalProps, closeModal }] = useModalInner(async (data) => {
    resetForm();
    setModalProps({ confirmLoading: false });
    isUpdate.value = !!data?.isUpdate;
    title.value = unref(isUpdate) ? '更换部门负责人' : '新增部门负责人';
    if (data?.record) {
      formState.id = data.record.id;
      formState.deptId = data.record.deptId;
      formState.leaderUserId = data.record.leaderUserId;
      formState.remark = data.record.remark;
      deptLabel.value = data.record.dept?.departName || '';
      leaderLabel.value = data.record.leader?.realname || '';
    }
  });

  async function handleSubmit() {
    try {
      await formRef.value?.validate();
      setModalProps({ confirmLoading: true });
      await saveDeptLeader({
        id: formState.id,
        deptId: formState.deptId,
        leaderUserId: formState.leaderUserId,
        remark: formState.remark,
      });
      closeModal();
      emit('success');
    } finally {
      setModalProps({ confirmLoading: false });
    }
  }
</script>
