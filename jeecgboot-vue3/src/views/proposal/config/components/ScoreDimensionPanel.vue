<template>
  <div>
    <BasicTable @register="registerTable" :afterFetch="afterFetch">
      <template #tableTitle>
        <div class="score-toolbar">
          <a-button type="primary" preIcon="ant-design:plus-outlined" @click="handleAdd" v-auth="'proposal:config:scoreDimension:save'">
            新增维度
          </a-button>
          <div class="weight-summary">
            <span>当前权重合计 {{ weightTotal }}%</span>
            <a-progress
              :percent="Math.min(weightTotal, 100)"
              :status="weightTotal === 100 ? 'success' : weightTotal > 100 ? 'exception' : 'active'"
              :show-info="false"
              style="width: 180px; margin: 0"
            />
            <span v-if="weightTotal !== 100" class="weight-tip">{{ weightTotal > 100 ? '已超过 100%' : '建议合计为 100%' }}</span>
          </div>
        </div>
      </template>
      <template #action="{ record }">
        <TableAction :actions="getTableAction(record)" />
      </template>
    </BasicTable>
    <ScoreDimensionModal @register="registerModal" @success="reload" />
  </div>
</template>
<script lang="ts" setup>
  import { ref } from 'vue';
  import { BasicTable, TableAction } from '/@/components/Table';
  import { useModal } from '/@/components/Modal';
  import { useListPage } from '/@/hooks/system/useListPage';
  import { scoreDimensionColumns } from '../config.data';
  import { getScoreDimensionList, deleteScoreDimension } from '../config.api';
  import ScoreDimensionModal from '../components/ScoreDimensionModal.vue';

  const weightTotal = ref(0);
  const [registerModal, { openModal }] = useModal();
  const { tableContext } = useListPage({
    designScope: 'proposal-config-scoreDimension',
    tableProps: {
      title: '评分维度',
      api: getScoreDimensionList,
      columns: scoreDimensionColumns,
      useSearchForm: false,
      pagination: false,
      actionColumn: { width: 140 },
    },
  });
  const [registerTable, { reload }] = tableContext;

  function afterFetch(list) {
    const records = Array.isArray(list) ? list : [];
    weightTotal.value = records
      .filter((r) => r.dimStatus === 'active')
      .reduce((sum, r) => sum + (Number(r.weightPct) || 0), 0);
    return records;
  }

  function handleAdd() {
    openModal(true, { isUpdate: false, weightTotal: weightTotal.value });
  }
  function handleEdit(record) {
    openModal(true, { record, isUpdate: true, weightTotal: weightTotal.value });
  }
  async function handleDelete(record) {
    await deleteScoreDimension({ id: record.id }, reload);
  }
  function getTableAction(record) {
    return [
      { label: '编辑', onClick: handleEdit.bind(null, record), auth: 'proposal:config:scoreDimension:save' },
      {
        label: '删除',
        color: 'error',
        popConfirm: { title: '是否确认删除该维度？', confirm: handleDelete.bind(null, record) },
        auth: 'proposal:config:scoreDimension:delete',
      },
    ];
  }
</script>
<style scoped>
  .score-toolbar {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }
  .weight-summary {
    display: flex;
    align-items: center;
    gap: 12px;
    color: #595959;
    font-size: 13px;
  }
  .weight-tip {
    color: #fa8c16;
  }
</style>
