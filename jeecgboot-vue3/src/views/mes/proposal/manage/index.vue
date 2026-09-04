<template>
  <div>
    <BasicTable @register="registerTable">
      <template #action="{ record }">
        <TableAction :actions="getTableAction(record)" />
      </template>
    </BasicTable>
    <ProposalModal @register="registerModal" />
  </div>
</template>
<script lang="ts" name="proposal-manage" setup>
  import { BasicTable, TableAction } from '/@/components/Table';
  import { useModal } from '/@/components/Modal';
  import { useListPage } from '/@/hooks/system/useListPage';
  import { columns, searchFormSchema } from './proposal.data';
  import { getProposalList } from './proposal.api';
  import ProposalModal from './components/ProposalModal.vue';

  const [registerModal, { openModal }] = useModal();

  const { tableContext } = useListPage({
    designScope: 'proposal-manage',
    tableProps: {
      api: getProposalList,
      columns,
      showIndexColumn: true,
      formConfig: {
        schemas: searchFormSchema,
        autoSubmitOnEnter: true,
        showAdvancedButton: false,
        // 固定 label 宽度，避免第二行 span:8 与首行 span:4 比例 labelCol 错位
        labelWidth: 80,
        baseColProps: { span: 4 },
        actionColOptions: { span: 4, style: { textAlign: 'left' } },
        fieldMapToTime: [['createTime', ['createTime_begin', 'createTime_end'], 'YYYY-MM-DD']],
      },
      actionColumn: {
        width: 80,
        title: '操作',
        fixed: 'right',
      },
    },
  });

  // 不绑定 rowSelection，去掉勾选列与「未选中任何数据」提示
  const [registerTable] = tableContext;

  function handleDetail(record) {
    openModal(true, { record });
  }

  function getTableAction(record) {
    return [
      {
        label: '详情',
        onClick: handleDetail.bind(null, record),
      },
    ];
  }
</script>
<style lang="less">
  .proposal-review-progress {
    display: inline-flex;
    align-items: center;
    gap: 8px;

    &__text {
      color: rgba(0, 0, 0, 0.65);
      font-size: 12px;
      white-space: nowrap;
    }
  }
</style>
