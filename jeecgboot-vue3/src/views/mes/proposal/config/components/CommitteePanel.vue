<template>
  <div>
    <BasicTable @register="registerTable">
      <template #tableTitle>
        <a-button type="primary" preIcon="ant-design:plus-outlined" @click="handleAdd" v-auth="'proposal:config:committee:save'">
          添加成员
        </a-button>
      </template>
      <template #action="{ record }">
        <TableAction :actions="getTableAction(record)" />
      </template>
    </BasicTable>
    <CommitteeModal @register="registerModal" @success="reload" />
  </div>
</template>
<script lang="ts" setup>
  import { BasicTable, TableAction } from '/@/components/Table';
  import { useModal } from '/@/components/Modal';
  import { useListPage } from '/@/hooks/system/useListPage';
  import { committeeColumns } from '../config.data';
  import { getCommitteeList, deleteCommittee } from '../config.api';
  import CommitteeModal from '../components/CommitteeModal.vue';

  const [registerModal, { openModal }] = useModal();
  const { tableContext } = useListPage({
    designScope: 'proposal-config-committee',
    tableProps: {
      title: '委员会成员',
      api: getCommitteeList,
      columns: committeeColumns,
      useSearchForm: false,
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
    await deleteCommittee({ id: record.id }, reload);
  }
  function getTableAction(record) {
    return [
      { label: '编辑', onClick: handleEdit.bind(null, record), auth: 'proposal:config:committee:save' },
      {
        label: '移除',
        color: 'error',
        popConfirm: { title: '是否确认移除该委员？', confirm: handleDelete.bind(null, record) },
        auth: 'proposal:config:committee:delete',
      },
    ];
  }
</script>
