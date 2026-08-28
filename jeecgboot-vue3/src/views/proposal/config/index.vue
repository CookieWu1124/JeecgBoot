<template>
  <div class="p-4">
    <a-tabs v-model:activeKey="activeKey" type="card">
      <a-tab-pane key="deptLeader" tab="部门负责人">
        <DeptLeaderPanel />
      </a-tab-pane>
      <a-tab-pane key="committee" tab="委员会成员">
        <CommitteePanel />
      </a-tab-pane>
      <a-tab-pane key="approver" tab="批准人">
        <ApproverPanel />
      </a-tab-pane>
      <a-tab-pane key="scoreDimension" tab="评分维度">
        <ScoreDimensionPanel />
      </a-tab-pane>
    </a-tabs>
  </div>
</template>
<script lang="ts" name="proposal-config" setup>
  import { ref } from 'vue';
  import DeptLeaderPanel from './components/DeptLeaderPanel.vue';
  import CommitteePanel from './components/CommitteePanel.vue';
  import ApproverPanel from './components/ApproverPanel.vue';
  import ScoreDimensionPanel from './components/ScoreDimensionPanel.vue';

  const activeKey = ref('deptLeader');
</script>
