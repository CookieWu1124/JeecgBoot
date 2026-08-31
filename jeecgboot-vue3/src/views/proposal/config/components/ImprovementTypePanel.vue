<template>
  <div>
    <BasicTable @register="registerTable">
      <template #tableTitle>
        <a-button type="primary" preIcon="ant-design:plus-outlined" @click="handleAdd" v-auth="'proposal:config:improvementType:save'">
          新增性质
        </a-button>
      </template>
      <template #action="{ record }">
        <TableAction :actions="getTableAction(record)" />
      </template>
    </BasicTable>
    <ImprovementTypeModal @register="registerModal" @success="reload" />
  </div>
</template>
<script lang="ts" setup>
  import { BasicTable, TableAction } from '/@/components/Table';
  import { useModal } from '/@/components/Modal';
  import { useListPage } from '/@/hooks/system/useListPage';
  import { improvementTypeColumns } from '../config.data';
  import { getImprovementTypeList, deleteImprovementType } from '../config.api';
  import ImprovementTypeModal from '../components/ImprovementTypeModal.vue';

  const [registerModal, { openModal }] = useModal();
  const { tableContext } = useListPage({
    designScope: 'proposal-config-improvementType',
    tableProps: {
      title: '改善性质',
      api: getImprovementTypeList,
      columns: improvementTypeColumns,
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
    await deleteImprovementType({ id: record.id }, reload);
  }
  function getTableAction(record) {
    return [
      { label: '编辑', onClick: handleEdit.bind(null, record), auth: 'proposal:config:improvementType:save' },
      {
        label: '删除',
        color: 'error',
        popConfirm: { title: '是否确认删除该改善性质？已有提案引用时请改为停用。', confirm: handleDelete.bind(null, record) },
        auth: 'proposal:config:improvementType:delete',
      },
    ];
  }
</script>
