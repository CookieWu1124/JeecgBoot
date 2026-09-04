# 03 — 计划书 · 开发进度

| 项 | 值 |
|----|-----|
| **业务段** | 改善计划书（条件分支：`plan_required=1`） |
| **规划 Phase** | Phase 3（后半） |
| **主表字段** | `plan_required`, `plan_round`, `review_progress`（计划书阶段复用或独立进度字段待定） |
| **子表** | `proposal_plan`, `proposal_plan_review`（规划，未建） |
| **最后更新** | 2026-08-28 |

---

## 1. 业务范围

**前置条件**：`proposal.plan_required = 1` 且状态为 `IN_PROGRESS`（任务已分配）。

| 子环节 | 说明 | 状态迁移 |
|--------|------|----------|
| 填写/暂存 | 实施负责人编辑计划书（4 段内容 + 计划日期） | 保持 `IN_PROGRESS` |
| 提交计划书 | 提交委员审核 | → `PLAN_PENDING_REVIEW` |
| 委员审核 | 可行/不可行，并行独立 | 全部可行 → `PLAN_PENDING_APPROVAL`；不可行 → `PLAN_REJECTED` |
| 批准人批准 | 批准/驳回 | 批准 → `IN_PROGRESS`；驳回 → `PLAN_REJECTED` |
| 驳回重提 | `plan_round` 递增后再次提交 | → `PLAN_PENDING_REVIEW` |

**跳过条件**：`plan_required = 0` 时本段整体跳过，[02](./02_task_assignment_DEV_PROGRESS.md) 完成后直接进入 [04 报告书](./04_report_DEV_PROGRESS.md)。

---

## 2. 状态 ↔ 主表

| 状态码 | 显示名 | 本段 |
|--------|--------|------|
| `IN_PROGRESS` | 进行中 | ✓ 填写计划书 |
| `PLAN_PENDING_REVIEW` | 计划书待审 | ✓ |
| `PLAN_PENDING_APPROVAL` | 计划书待批 | ✓ |
| `PLAN_REJECTED` | 计划书已驳回 | ✓ 可重提 |
| `IN_PROGRESS` | 进行中 | ✓ 计划书批准后回到实施，准备报告书 |

---

## 3. 状态 ↔ API

| 动作 | 方法 | 路径 | 端 | 进度 |
|------|------|------|-----|------|
| 获取计划书 | GET | `/proposal/plan/{proposalId}` | 共用 | [ ] |
| 保存/提交计划书 | POST | `/proposal/plan/{proposalId}` | 共用 | [ ] |
| 计划书委员待审 | GET | `/proposal/review/plan/pending` | 共用 | [ ] |
| 计划书委员审核 | POST | `/proposal/review/plan/{proposalId}` | 共用 | [ ] |
| 计划书批准决策 | POST | `/proposal/approval/plan/{proposalId}` | 共用 | [ ] |

---

## 4. 状态 ↔ 页面

### 4.1 小程序

| 原型页 | 功能 | 进度 |
|--------|------|------|
| 改善计划书 | 4 段内容 + 暂存/提交 | [ ] |
| 计划书委员待办 | 待审列表 | [ ] |
| 计划书委员审核 | 可行/不可行 + 意见 | [ ] |
| 计划书批准 | 批准人批准/驳回 | [ ] |
| 提案列表 | 计划书状态徽章 | [ ] |

### 4.2 管理端

| 页面 | 说明 | 进度 |
|------|------|------|
| 提案详情 — 计划书 Tab | 只读查看 + 审核记录 | [ ] |

---

## 5. 数据库

| 表 | Phase | 进度 | 备注 |
|----|-------|------|------|
| `proposal_plan` | 3 | [ ] | 计划书正文、轮次 |
| `proposal_plan_review` | 3 | [ ] | 委员计划书审核记录 |
| `proposal.plan_round` | 1 | [x] | 主表字段已存在 |
| `proposal.plan_required` | 1 | [x] | 申请批准时写入 |

---

## 6. 后端任务清单

| # | 任务 | 进度 |
|---|------|------|
| 1 | `proposal_plan` / `proposal_plan_review` DDL + Entity | [ ] |
| 2 | 计划书 CRUD（仅 `implement_leader_id` 可写） | [ ] |
| 3 | 提交时校验 `plan_required=1`、状态 `IN_PROGRESS` | [ ] |
| 4 | 计划书委员并行审核 + 汇总 | [ ] |
| 5 | 批准人计划书批准/驳回 | [ ] |
| 6 | 驳回重提：`plan_round++` | [ ] |
| 7 | 状态机 + 日志 + 待办 + 消息 | [~] 计划书跳转已预注册（含 `plan_required=1` 守卫）；待办/消息未做 |

---

## 7. 前端任务清单

| # | 任务 | 端 | 进度 |
|---|------|-----|------|
| 1 | 计划书表单页（含驳回后编辑） | 小程序 | [ ] |
| 2 | 计划书委员审核页 | 小程序 | [ ] |
| 3 | 计划书批准页 | 小程序 | [ ] |
| 4 | 轮次展示（第 N 轮） | 小程序 | [ ] |

---

## 8. 验收标准

- [ ] 仅 `plan_required=1` 的提案出现计划书入口
- [ ] 实施负责人可暂存/提交；他人不可编辑
- [ ] 委员全部「可行」→ `PLAN_PENDING_APPROVAL`
- [ ] 批准人批准后回到 `IN_PROGRESS`，可进入报告书阶段
- [ ] 驳回后 `plan_round` 递增，修改后可重提
- [ ] `plan_required=0` 的提案无计划书菜单/待办

---

## 9. 依赖与前置

- [ ] [02 任务分配](./02_task_assignment_DEV_PROGRESS.md) 完成（`IN_PROGRESS` + `implement_leader_id`）
- [ ] [01 申请单](./01_application_DEV_PROGRESS.md) 批准时已写入 `plan_required`
- [x] 委员会名册、批准人配置表已建（`inside_dev` 2026-08-28）

---

## 10. 变更记录

| 日期 | 说明 |
|------|------|
| 2026-08-28 | 初版进度文档 |
| 2026-08-28 | `inside_dev` 已执行 init SQL，主表 `plan_required`/`plan_round` 字段就绪 |
| 2026-08-31 | 状态机预注册计划书跳转；`plan_required≠1` 时 `SUBMIT_PLAN` 等会被拒绝 |
