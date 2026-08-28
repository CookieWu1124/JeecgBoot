<template>
  <div>
    <BasicTable @register="registerTable">
      <template #tableTitle>
        <a-button type="primary" preIcon="ant-design:plus-outlined" @click="handleAdd" v-auth="'proposal:config:deptLeader:save'">
          新增
        </a-button>
      </template>
      <template #action="{ record }">
        <TableAction :actions="getTableAction(record)" />
      </template>
    </BasicTable>
    <DeptLeaderModal @register="registerModal" @success="reload" />
  </div>
</template>
<script lang="ts" setup>
  import { BasicTable, TableAction } from '/@/components/Table';
  import { useModal } from '/@/components/Modal';
  import { useListPage } from '/@/hooks/system/useListPage';
  import { deptLeaderColumns } from '../config.data';
  import { getDeptLeaderList, deleteDeptLeader } from '../config.api';
  import DeptLeaderModal from '../components/DeptLeaderModal.vue';

  const [registerModal, { openModal }] = useModal();
  const { tableContext } = useListPage({
    designScope: 'proposal-config-deptLeader',
    tableProps: {
      title: '改善部门负责人',
      api: getDeptLeaderList,
      columns: deptLeaderColumns,
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
    await deleteDeptLeader({ id: record.id }, reload);
  }
  function getTableAction(record) {
    const configured = !!record.leaderUserId;
    return [
      {
        label: configured ? '更换' : '配置',
        onClick: handleEdit.bind(null, record),
        auth: 'proposal:config:deptLeader:save',
      },
      {
        label: '删除',
        popConfirm: { title: '是否确认删除该改善部门配置？', confirm: handleDelete.bind(null, record) },
        auth: 'proposal:config:deptLeader:delete',
      },
    ];
  }
</script>
