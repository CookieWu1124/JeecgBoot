<template>
  <BasicModal
    v-bind="$attrs"
    @register="registerModal"
    :width="980"
    :canFullscreen="false"
    :showOkBtn="false"
    :showCancelBtn="false"
    destroyOnClose
    wrapClassName="proposal-detail-modal"
  >
    <template #title>
      <div class="pd-title">
        <Icon icon="ant-design:file-text-outlined" :size="20" color="#1890ff" />
        <div class="pd-title__text">
          <div class="pd-title__main">提案详情</div>
          <div class="pd-title__sub">查看申请单、计划书、报告书与关键操作留痕</div>
        </div>
      </div>
    </template>

    <div v-if="detail" class="pd-body">
      <div class="pd-hero">
        <div class="pd-hero__row">
          <h3 class="pd-hero__title">{{ detail.title }}</h3>
          <a-tag :color="detail.statusColor">{{ detail.statusLabel }}</a-tag>
        </div>
        <div class="pd-cards">
          <div class="pd-card pd-card--blue">
            <div class="pd-card__lab">提案编号</div>
            <div class="pd-card__val">{{ detail.proposalNo }}</div>
          </div>
          <div class="pd-card pd-card--green">
            <div class="pd-card__lab">提案人</div>
            <div class="pd-card__val">{{ detail.proposerName }}</div>
          </div>
          <div class="pd-card pd-card--purple">
            <div class="pd-card__lab">改善部门</div>
            <div class="pd-card__val">{{ detail.deptName }}</div>
          </div>
          <div class="pd-card pd-card--orange">
            <div class="pd-card__lab">提交时间</div>
            <div class="pd-card__val">{{ detail.submitTime }}</div>
          </div>
        </div>
      </div>

      <a-tabs v-model:activeKey="activeTab" class="pd-tabs">
        <a-tab-pane key="apply" tab="申请单">
          <div class="pd-section">
            <div class="pd-section__hd">提案人信息</div>
            <div class="pd-section__bd">
              <div class="pd-grid">
                <div class="pd-field">
                  <span class="pd-field__lab">姓名</span>
                  <span class="pd-field__val">{{ detail.proposerName }}</span>
                </div>
                <div class="pd-field">
                  <span class="pd-field__lab">工号</span>
                  <span class="pd-field__val">{{ detail.proposerWorkNo }}</span>
                </div>
                <div class="pd-field">
                  <span class="pd-field__lab">职位</span>
                  <span class="pd-field__val">{{ detail.proposerPost }}</span>
                </div>
                <div class="pd-field">
                  <span class="pd-field__lab">部门</span>
                  <span class="pd-field__val">{{ detail.proposerDeptName }}</span>
                </div>
                <div class="pd-field">
                  <span class="pd-field__lab">提交时间</span>
                  <span class="pd-field__val">{{ detail.submitTime }}</span>
                </div>
              </div>
            </div>
          </div>

          <div class="pd-section">
            <div class="pd-section__hd">提案基本信息</div>
            <div class="pd-section__bd">
              <div class="pd-field pd-field--block">
                <span class="pd-field__lab">提案名称</span>
                <span class="pd-field__val">{{ detail.title }}</span>
              </div>
              <div class="pd-story-row">
                <div class="pd-story">
                  <div class="pd-story__lab">目前状况及问题</div>
                  <div class="pd-story__body">{{ detail.currentSituation }}</div>
                </div>
                <div class="pd-story">
                  <div class="pd-story__lab">改善意见</div>
                  <div class="pd-story__body">{{ detail.improvementSuggestion }}</div>
                </div>
              </div>
              <div class="pd-grid pd-grid--3">
                <div class="pd-field">
                  <span class="pd-field__lab">改善性质</span>
                  <span class="pd-field__val">{{ detail.improvementTypesLabel }}</span>
                </div>
                <div class="pd-field">
                  <span class="pd-field__lab">改善部门</span>
                  <span class="pd-field__val"
                    >{{ detail.deptName }}
                    <template v-if="detail.deptLeaderName && detail.deptLeaderName !== '-'">
                      · 部门负责人 {{ detail.deptLeaderName }}
                    </template>
                  </span>
                </div>
                <div class="pd-field">
                  <span class="pd-field__lab">核定提案奖</span>
                  <span class="pd-field__val">{{ detail.awardAmountText }}</span>
                </div>
              </div>
            </div>
          </div>

          <div class="pd-section">
            <div class="pd-section__hd">委员会审核意见</div>
            <div class="pd-section__bd pd-section__bd--table">
              <a-table
                size="small"
                :columns="reviewColumns"
                :data-source="detail.reviews"
                :pagination="false"
                row-key="id"
                :locale="{ emptyText: '暂无审核记录（委员审核在小程序完成）' }"
              />
            </div>
          </div>
        </a-tab-pane>

        <a-tab-pane key="plan" tab="计划书">
          <div class="pd-empty">计划书内容将在任务指派与计划书流程开通后展示</div>
        </a-tab-pane>

        <a-tab-pane key="report" tab="报告书">
          <div class="pd-empty">报告书、评分与签核内容将在后续阶段展示</div>
        </a-tab-pane>

        <a-tab-pane key="trace" tab="操作留痕">
          <a-timeline v-if="detail.statusLogs?.length" class="pd-timeline">
            <a-timeline-item v-for="log in detail.statusLogs" :key="log.id">
              <div class="pd-trace__action">{{ log.actionLabel }}</div>
              <div class="pd-trace__meta">
                {{ log.operatorName }} · {{ log.fromStatusLabel }} → {{ log.toStatusLabel }} ·
                {{ log.createTime || '-' }}
              </div>
              <div v-if="log.remark" class="pd-trace__remark">{{ log.remark }}</div>
            </a-timeline-item>
          </a-timeline>
          <div v-else class="pd-empty">暂无操作留痕</div>
        </a-tab-pane>
      </a-tabs>
    </div>
    <div v-else class="pd-empty">加载中…</div>

    <template #footer>
      <div class="pd-footer">
        <div class="pd-footer__tip">
          <span class="pd-footer__dot" />
          管理后台用于查询、配置、统计和留痕查询；审核、评分等业务处理在小程序完成
        </div>
        <a-button @click="closeModal">关闭</a-button>
      </div>
    </template>
  </BasicModal>
</template>

<script lang="ts" setup>
  import { ref } from 'vue';
  import { BasicModal, useModalInner } from '/@/components/Modal';
  import { Icon } from '/@/components/Icon';
  import { getProposalById } from '../proposal.api';

  defineEmits(['register']);

  const activeTab = ref('apply');
  const detail = ref<Recordable | null>(null);

  const reviewColumns = [
    { title: '委员', dataIndex: 'memberName', width: 100 },
    { title: '状态', dataIndex: 'statusLabel', width: 90 },
    { title: '结论', dataIndex: 'conclusion', width: 90 },
    { title: '建议形成计划书', dataIndex: 'planRequiredLabel', width: 120 },
    { title: '建议奖金', dataIndex: 'suggestAward', width: 100 },
    { title: '综合评价', dataIndex: 'comment', ellipsis: true },
  ];

  const [registerModal, { setModalProps, closeModal }] = useModalInner(async (data) => {
    activeTab.value = 'apply';
    detail.value = null;
    setModalProps({ confirmLoading: false, loading: true });
    try {
      if (data?.record?.id) {
        detail.value = await getProposalById({ id: data.record.id });
      } else if (data?.record) {
        detail.value = data.record;
      }
    } finally {
      setModalProps({ loading: false });
    }
  });
</script>

<style lang="less">
  .proposal-detail-modal {
    .ant-modal-header {
      padding: 14px 24px 10px;
      border-bottom: 1px solid #f0f0f0;
    }
    .ant-modal-body {
      padding: 12px 24px 8px;
    }
    .ant-modal-footer {
      padding: 10px 24px 14px;
      border-top: 1px solid #f0f0f0;
    }
  }
</style>

<style scoped lang="less">
  .pd-title {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    &__main {
      font-size: 16px;
      font-weight: 600;
      color: #1f1f1f;
      line-height: 1.3;
    }
    &__sub {
      margin-top: 2px;
      font-size: 12px;
      color: #8c8c8c;
      font-weight: 400;
      line-height: 1.4;
    }
  }

  .pd-body {
    min-height: 360px;
  }

  .pd-hero {
    margin-bottom: 4px;
    &__row {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 12px;
    }
    &__title {
      margin: 0;
      font-size: 18px;
      font-weight: 600;
      color: #1f1f1f;
      line-height: 1.4;
    }
  }

  .pd-cards {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px;
    margin-bottom: 8px;
  }

  .pd-card {
    background: #fff;
    border: 1px solid #f0f0f0;
    border-radius: 6px;
    padding: 10px 12px 10px 14px;
    border-left: 3px solid #1890ff;
    &--blue {
      border-left-color: #1890ff;
    }
    &--green {
      border-left-color: #52c41a;
    }
    &--purple {
      border-left-color: #722ed1;
    }
    &--orange {
      border-left-color: #fa8c16;
    }
    &__lab {
      font-size: 12px;
      color: #8c8c8c;
      margin-bottom: 4px;
    }
    &__val {
      font-size: 14px;
      color: #262626;
      font-weight: 500;
      word-break: break-all;
    }
  }

  .pd-tabs {
    :deep(.ant-tabs-nav) {
      margin-bottom: 12px;
    }
  }

  .pd-section {
    border: 1px solid #e8f0fe;
    border-radius: 6px;
    overflow: hidden;
    margin-bottom: 12px;
    &__hd {
      background: #e6f4ff;
      color: #1d39c4;
      font-size: 13px;
      font-weight: 600;
      padding: 8px 14px;
      border-bottom: 1px solid #d6e4ff;
    }
    &__bd {
      padding: 14px 14px 8px;
      background: #fff;
      &--table {
        padding: 8px;
      }
    }
  }

  .pd-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 10px 16px;
    &--3 {
      margin-top: 12px;
      grid-template-columns: repeat(3, 1fr);
    }
  }

  .pd-field {
    display: flex;
    flex-direction: column;
    gap: 2px;
    min-width: 0;
    &--block {
      margin-bottom: 10px;
    }
    &__lab {
      font-size: 12px;
      color: #8c8c8c;
    }
    &__val {
      font-size: 13px;
      color: #262626;
      line-height: 1.5;
      word-break: break-word;
    }
  }

  .pd-story-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
  }

  .pd-story {
    border: 1px solid #f0f0f0;
    border-radius: 6px;
    background: #fafafa;
    padding: 10px 12px;
    min-height: 96px;
    &__lab {
      font-size: 12px;
      color: #8c8c8c;
      margin-bottom: 6px;
    }
    &__body {
      font-size: 13px;
      color: #434343;
      line-height: 1.65;
      white-space: pre-wrap;
      word-break: break-word;
    }
  }

  .pd-empty {
    padding: 48px 16px;
    text-align: center;
    color: #bfbfbf;
    font-size: 13px;
  }

  .pd-timeline {
    padding: 8px 8px 0;
  }

  .pd-trace {
    &__action {
      font-size: 14px;
      font-weight: 500;
      color: #262626;
    }
    &__meta {
      margin-top: 2px;
      font-size: 12px;
      color: #8c8c8c;
    }
    &__remark {
      margin-top: 4px;
      font-size: 12px;
      color: #595959;
    }
  }

  .pd-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    width: 100%;
    &__tip {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 12px;
      color: #8c8c8c;
      text-align: left;
      line-height: 1.4;
    }
    &__dot {
      flex-shrink: 0;
      width: 6px;
      height: 6px;
      border-radius: 50%;
      background: #1890ff;
    }
  }
</style>
