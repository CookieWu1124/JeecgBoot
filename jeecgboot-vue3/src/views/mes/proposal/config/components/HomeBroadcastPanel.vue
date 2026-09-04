<template>
  <div class="home-broadcast-panel">
    <a-card title="首页小广播标语" :bordered="false">
      <a-alert
        type="info"
        show-icon
        style="margin-bottom: 16px"
        message="全局唯一一条，修改后全员小程序首页同步展示。清空并保存则首页不显示该条。"
      />
      <a-form layout="vertical" :model="formState">
        <a-form-item label="标语文案" required>
          <a-textarea
            v-model:value="formState.content"
            :rows="3"
            :maxlength="200"
            show-count
            placeholder="例如：人人参与改善 · 点滴汇聚效益"
          />
        </a-form-item>
        <a-form-item>
          <a-button type="primary" :loading="saving" v-auth="'proposal:config:homeBroadcast:save'" @click="handleSave">
            保存
          </a-button>
        </a-form-item>
      </a-form>
    </a-card>
  </div>
</template>
<script lang="ts" setup>
  import { onMounted, reactive, ref } from 'vue';
  import { message } from 'ant-design-vue';
  import { getHomeBroadcast, saveHomeBroadcast } from '../config.api';

  const saving = ref(false);
  const formState = reactive({
    id: '' as string | undefined,
    content: '',
  });

  async function load() {
    const row = await getHomeBroadcast();
    formState.id = row?.id;
    formState.content = row?.content ?? '';
  }

  async function handleSave() {
    saving.value = true;
    try {
      await saveHomeBroadcast({ id: formState.id, content: formState.content ?? '' });
      message.success('保存成功');
      await load();
    } finally {
      saving.value = false;
    }
  }

  onMounted(() => {
    load();
  });
</script>
