<template>
  <div>
    <BasicTable @register="registerTable" :rowSelection="rowSelection">
      <template #tableTitle>
        <a-button type="primary" preIcon="ant-design:plus-outlined" @click="handleAdd" v-auth="'proposal:manage:add'">新增</a-button>
      </template>
      <template #action="{ record }">
        <TableAction :actions="getTableAction(record)" />
      </template>
    </BasicTable>
    <ProposalModal @register="registerModal" @success="reload" />
  </div>
</template>
<script lang="ts" name="proposal-manage" setup>
  import { BasicTable, TableAction } from '/@/components/Table';
  import { useModal } from '/@/components/Modal';
  import { useListPage } from '/@/hooks/system/useListPage';
  import { columns, searchFormSchema } from './proposal.data';
  import { getProposalList, deleteProposal } from './proposal.api';
  import ProposalModal from './components/ProposalModal.vue';

  const [registerModal, { openModal }] = useModal();

  const { tableContext } = useListPage({
    designScope: 'proposal-manage',
    tableProps: {
      title: '提案管理',
      api: getProposalList,
      columns,
      formConfig: {
        schemas: searchFormSchema,
        autoSubmitOnEnter: true,
      },
      actionColumn: {
        width: 160,
        fixed: 'right',
      },
    },
  });

  const [registerTable, { reload }, { rowSelection }] = tableContext;

  function handleAdd() {
    openModal(true, { isUpdate: false });
  }

  function handleEdit(record) {
    openModal(true, { record, isUpdate: true });
  }

  async function handleDelete(record) {
    await deleteProposal({ id: record.id }, reload);
  }

  function getTableAction(record) {
    return [
      {
        label: '编辑',
        onClick: handleEdit.bind(null, record),
        auth: 'proposal:manage:edit',
      },
      {
        label: '删除',
        popConfirm: {
          title: '是否确认删除？',
          confirm: handleDelete.bind(null, record),
        },
        auth: 'proposal:manage:delete',
      },
    ];
  }
</script>
