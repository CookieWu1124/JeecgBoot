<template>
  <div style="display: contents">
    <BasicModal
    v-bind="$attrs"
    @register="registerModal"
    :title="title"
    :helpMessage="subtitle"
    @ok="handleSubmit"
    :width="560"
  >
    <div class="committee-modal">
      <a-form ref="formRef" :model="formState" :label-col="{ style: { width: '100px' } }" :wrapper-col="{ style: { flex: 1 } }">
        <div class="section">
          <div class="section-hd">人员信息</div>
          <div class="section-bd">
            <a-form-item
              label="选择员工"
              name="userId"
              :rules="[{ required: true, message: '请选择员工' }]"
            >
              <ProposalPickInput
                :label="selectedUser?.realname || ''"
                placeholder="请选择员工"
                :disabled="isUpdate"
                @open="openUserModal(true)"
              />
            </a-form-item>
            <a-form-item label=" " :colon="false">
              <div class="user-preview" :class="{ empty: !selectedUser }">
                <template v-if="selectedUser">
                  <div class="preview-cell" v-for="item in userPreviewCells" :key="item.label">
                    <div class="preview-label">{{ item.label }}</div>
                    <div class="preview-value" :title="item.value">{{ item.value }}</div>
                  </div>
                </template>
                <div v-else class="preview-placeholder">选择员工后展示姓名、工号、部门与职位。</div>
              </div>
            </a-form-item>
          </div>
        </div>

        <div class="section">
          <div class="section-hd">评分席位</div>
          <div class="section-bd seat-row">
            <a-form-item label="参与评分" name="scoreEnabled" class="seat-item">
              <a-switch
                v-model:checked="scoreEnabledChecked"
                checked-children="是"
                un-checked-children="否"
              />
            </a-form-item>
            <a-form-item
              v-if="scoreEnabledChecked"
              label="评分席位号"
              name="seatNo"
              class="seat-item seat-no"
              :rules="[{ required: true, message: '请填写评分席位号' }]"
            >
              <a-input-number
                v-model:value="formState.seatNo"
                :min="1"
                :max="99"
                placeholder="请输入席位号"
                style="width: 120px"
              />
            </a-form-item>
          </div>
        </div>
      </a-form>
      <div class="required-hint">* 带「*」为必填项</div>
    </div>
  </BasicModal>
  <UserSelectModal
    @register="registerUserModal"
    :is-radio-selection="true"
    row-key="id"
    label-key="realname"
    :max-select-count="1"
    modal-title="选择员工"
    @getSelectResult="onUserSelected"
  />
  </div>
</template>
<script lang="ts" setup>
  import { computed, reactive, ref, unref } from 'vue';
  import type { FormInstance } from 'ant-design-vue';
  import { BasicModal, useModal, useModalInner } from '/@/components/Modal';
  import UserSelectModal from '/@/components/Form/src/jeecg/components/modal/UserSelectModal.vue';
  import { getUserProfile, saveCommittee, UserProfile } from '../config.api';
  import { pickSingleSelection } from '../pickSingle';
  import ProposalPickInput from './ProposalPickInput.vue';

  const emit = defineEmits(['success', 'register']);
  const formRef = ref<FormInstance>();
  const isUpdate = ref(false);
  const title = ref('添加委员会成员');
  const subtitle = '维护委员会成员和评分席位属性';
  const selectedUser = ref<UserProfile | null>(null);

  const formState = reactive({
    id: undefined as string | undefined,
    userId: undefined as string | undefined,
    scoreEnabled: 1,
    seatNo: undefined as number | undefined,
    memberStatus: 'active',
    sortNo: 0,
  });

  const scoreEnabledChecked = computed({
    get: () => Number(formState.scoreEnabled) === 1,
    set: (v: boolean) => {
      formState.scoreEnabled = v ? 1 : 0;
      if (!v) {
        formState.seatNo = undefined;
      }
    },
  });

  const userPreviewCells = computed(() => {
    const u = selectedUser.value;
    if (!u) {
      return [];
    }
    return [
      { label: '姓名', value: u.realname || '-' },
      { label: '工号', value: u.workNo || '-' },
      { label: '部门', value: u.deptName || '-' },
      { label: '职位', value: u.positionType || '-' },
    ];
  });

  function resetForm() {
    formState.id = undefined;
    formState.userId = undefined;
    formState.scoreEnabled = 1;
    formState.seatNo = undefined;
    formState.memberStatus = 'active';
    formState.sortNo = 0;
    selectedUser.value = null;
    formRef.value?.clearValidate();
  }

  async function loadUserPreview(userId?: string | null, fallback?: Partial<UserProfile> & Recordable) {
    const profile = await getUserProfile(userId);
    if (profile) {
      selectedUser.value = profile;
      return;
    }
    if (fallback?.realname || fallback?.workNo || fallback?.user) {
      selectedUser.value = {
        id: String(userId || ''),
        realname: fallback.realname || fallback.user?.realname,
        workNo: fallback.workNo || fallback.user?.workNo,
        deptName: fallback.deptName || fallback.userDeptName || fallback.user?.deptName,
        positionType: fallback.positionType || fallback.user?.positionType,
      };
      return;
    }
    selectedUser.value = null;
  }

  const [registerUserModal, { openModal: openUserModal }] = useModal();

  function onUserSelected(options, values) {
    const { id } = pickSingleSelection(options, values);
    formState.userId = id;
    loadUserPreview(id);
    formRef.value?.validateFields(['userId']);
  }

  const [registerModal, { setModalProps, closeModal }] = useModalInner(async (data) => {
    resetForm();
    setModalProps({ confirmLoading: false, okText: '确定', cancelText: '取消' });
    isUpdate.value = !!data?.isUpdate;
    title.value = unref(isUpdate) ? '编辑委员会成员' : '添加委员会成员';

    if (data?.record) {
      formState.id = data.record.id;
      formState.userId = data.record.userId;
      formState.scoreEnabled = Number(data.record.scoreEnabled) === 0 ? 0 : 1;
      formState.seatNo = data.record.seatNo;
      formState.memberStatus = data.record.memberStatus || 'active';
      formState.sortNo = data.record.sortNo ?? 0;
      await loadUserPreview(data.record.userId, data.record);
    }
  });

  async function handleSubmit() {
    try {
      await formRef.value?.validate();
      setModalProps({ confirmLoading: true });
      await saveCommittee({
        id: formState.id,
        userId: formState.userId,
        scoreEnabled: formState.scoreEnabled,
        seatNo: formState.scoreEnabled === 1 ? formState.seatNo : null,
        memberStatus: formState.memberStatus || 'active',
        sortNo: formState.sortNo ?? 0,
      });
      closeModal();
      emit('success');
    } finally {
      setModalProps({ confirmLoading: false });
    }
  }
</script>

<style scoped lang="less">
  .committee-modal {
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
    .user-preview {
      display: flex;
      min-height: 56px;
      border: 1px solid #e8e8e8;
      border-radius: 4px;
      background: #fafafa;
      overflow: hidden;
      &.empty {
        align-items: center;
        padding: 0 12px;
      }
      .preview-placeholder {
        color: #bfbfbf;
        font-size: 13px;
      }
      .preview-cell {
        flex: 1;
        min-width: 0;
        padding: 8px 12px;
        border-right: 1px solid #e8e8e8;
        &:last-child {
          border-right: none;
        }
      }
      .preview-label {
        color: #999;
        font-size: 12px;
        line-height: 1.4;
        margin-bottom: 2px;
      }
      .preview-value {
        color: #333;
        font-size: 13px;
        font-weight: 500;
        line-height: 1.4;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }
    }
    .seat-row {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      column-gap: 32px;
      .seat-item {
        margin-bottom: 8px;
        width: auto !important;
        max-width: none;
        :deep(.ant-form-item-row) {
          flex-wrap: nowrap;
          width: auto;
        }
        :deep(.ant-form-item-control) {
          flex: none;
          max-width: none;
        }
      }
    }
    .required-hint {
      color: #999;
      font-size: 12px;
    }
  }
</style>
