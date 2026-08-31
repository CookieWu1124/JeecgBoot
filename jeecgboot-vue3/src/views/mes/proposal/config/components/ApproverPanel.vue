<template>
  <div class="approver-panel">
    <div class="approver-toolbar">
      <a-button type="primary" @click="handleChange" v-auth="'proposal:config:approver:save'">
        {{ current ? '更换批准人' : '配置批准人' }}
      </a-button>
    </div>

    <a-spin :spinning="loading">
      <div v-if="current" class="approver-card">
        <div class="approver-row">
          <div class="approver-name">{{ current.user?.realname || '-' }}</div>
          <div class="approver-fields">
            <div class="field-cell">
              <div class="field-label">工号</div>
              <div class="field-value">{{ current.user?.workNo || '-' }}</div>
            </div>
            <div class="field-cell">
              <div class="field-label">部门</div>
              <div class="field-value" :title="current.user?.deptName">{{ current.user?.deptName || '-' }}</div>
            </div>
            <div class="field-cell">
              <div class="field-label">职位</div>
              <div class="field-value">{{ current.user?.positionType || '-' }}</div>
            </div>
          </div>
        </div>
        <div class="approver-scopes">
          <span
            v-for="scope in current.signoffScopes || defaultScopes"
            :key="scope"
            class="scope-tag"
          >{{ scope }}</span>
        </div>
      </div>
      <a-empty v-else description="尚未配置批准人，请点击上方按钮选择" />
    </a-spin>

    <ApproverModal @register="registerModal" @success="loadData" />
  </div>
</template>
<script lang="ts" setup>
  import { onMounted, ref } from 'vue';
  import { useModal } from '/@/components/Modal';
  import { getApproverList } from '../config.api';
  import ApproverModal from '../components/ApproverModal.vue';

  const defaultScopes = ['申请单终审', '计划书终审', '报告书终审'];
  const loading = ref(false);
  const current = ref<Recordable | null>(null);
  const [registerModal, { openModal }] = useModal();

  async function loadData() {
    loading.value = true;
    try {
      const res = await getApproverList();
      const records = res?.records || [];
      current.value = records.length ? records[0] : null;
    } finally {
      loading.value = false;
    }
  }

  function handleChange() {
    openModal(true, {
      isUpdate: !!current.value,
      record: current.value || undefined,
    });
  }

  onMounted(loadData);
</script>
<style scoped lang="less">
  .approver-panel {
    padding: 8px 0 16px;
  }

  .approver-toolbar {
    margin-bottom: 16px;
  }

  /* 对齐图一原型：姓名左置 + 工号/部门/职位上标字段格 + 底部职责 Tag */
  .approver-card {
    width: 100%;
    border: 1px solid #f0f0f0;
    border-radius: 4px;
    background: #fff;
    padding: 20px 24px;
  }

  .approver-row {
    display: flex;
    align-items: center;
    gap: 24px;
    margin-bottom: 16px;
  }

  .approver-name {
    flex: 0 0 auto;
    min-width: 72px;
    font-size: 20px;
    font-weight: 600;
    line-height: 1.3;
    color: rgba(0, 0, 0, 0.88);
  }

  .approver-fields {
    flex: 1;
    min-width: 0;
    display: flex;
    gap: 16px;
  }

  .field-cell {
    flex: 1;
    min-width: 0;
    padding: 10px 16px;
    border: 1px solid #e8e8e8;
    border-radius: 4px;
    background: #fff;
  }

  .field-label {
    color: #999;
    font-size: 12px;
    line-height: 1.4;
    margin-bottom: 4px;
  }

  .field-value {
    color: #333;
    font-size: 14px;
    font-weight: 500;
    line-height: 1.4;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .approver-scopes {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
  }

  .scope-tag {
    display: inline-block;
    padding: 2px 10px;
    font-size: 12px;
    line-height: 20px;
    color: #fa8c16;
    background: #fff;
    border: 1px solid #d9d9d9;
    border-radius: 4px;
  }
</style>
