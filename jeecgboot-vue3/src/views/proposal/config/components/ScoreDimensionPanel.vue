<template>
  <div>
    <BasicTable @register="registerTable">
      <template #tableTitle>
        <a-button type="primary" preIcon="ant-design:plus-outlined" @click="handleAdd" v-auth="'proposal:config:scoreDimension:save'">新增</a-button>
      </template>
      <template #action="{ record }">
        <TableAction :actions="getTableAction(record)" />
      </template>
    </BasicTable>
    <ScoreDimensionModal @register="registerModal" @success="reload" />
  </div>
</template>
<script lang="ts" setup>
  import { BasicTable, TableAction } from '/@/components/Table';
  import { useModal } from '/@/components/Modal';
  import { useListPage } from '/@/hooks/system/useListPage';
  import { scoreDimensionColumns } from '../config.data';
  import { getScoreDimensionList, deleteScoreDimension } from '../config.api';
  import ScoreDimensionModal from '../components/ScoreDimensionModal.vue';

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

  function handleAdd() {
    openModal(true, { isUpdate: false });
  }
  function handleEdit(record) {
    openModal(true, { record, isUpdate: true });
  }
  async function handleDelete(record) {
    await deleteScoreDimension({ id: record.id }, reload);
  }
  function getTableAction(record) {
    return [
      { label: '编辑', onClick: handleEdit.bind(null, record), auth: 'proposal:config:scoreDimension:save' },
      {
        label: '删除',
        popConfirm: { title: '是否确认删除？', confirm: handleDelete.bind(null, record) },
        auth: 'proposal:config:scoreDimension:delete',
      },
    ];
  }
</script>
