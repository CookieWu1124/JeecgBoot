# 02 — 任务分配 · 开发进度

| 项 | 值 |
|----|-----|
| **业务段** | 任务分配（部门负责人指派 / 任务池 / 领取 / 转团队） |
| **规划 Phase** | Phase 3（前半） |
| **主表字段** | `implement_leader_id`, `team_type`, `dept_leader_id` |
| **子表** | `proposal_task`, `proposal_task_member`（规划，未建） |
| **最后更新** | 2026-08-28 |

---

## 1. 业务范围

| 子环节 | 说明 | 状态迁移 |
|--------|------|----------|
| 待指派 | 申请已批准，部门负责人需处理 | `PENDING_ASSIGN` |
| 直接指派 | 指定实施负责人（可多人时指定 leader） | → `IN_PROGRESS` |
| 放入任务池 | 部门内公开领取 | → `PENDING_CLAIM` |
| 个人领取 | 员工从任务池领取 | → `IN_PROGRESS` |
| 转团队 | 领取后添加成员、指定实施负责人 | 更新 `team_type=TEAM` |

**出口**：进入 `IN_PROGRESS` 后，按 `plan_required` 进入 [03 计划书](./03_plan_DEV_PROGRESS.md) 或 [04 报告书](./04_report_DEV_PROGRESS.md)。

---

## 2. 状态 ↔ 主表

| 状态码 | 显示名 | 本段 |
|--------|--------|------|
| `PENDING_ASSIGN` | 待指派 | ✓ 入口 |
| `PENDING_CLAIM` | 待领取 | ✓ |
| `IN_PROGRESS` | 进行中 | ✓ 出口 |

---

## 3. 状态 ↔ API

| 动作 | 方法 | 路径 | 端 | 进度 |
|------|------|------|-----|------|
| 待指派列表 | GET | `/proposal/task/pending` | 共用 | [ ] |
| 确认指派 | POST | `/proposal/task/assign` | 共用 | [ ] |
| 放入任务池 | POST | `/proposal/task/pool` | 共用 | [ ] |
| 任务池列表 | GET | `/proposal/task/pool` | 共用 | [ ] |
| 个人领取 | POST | `/proposal/task/claim/{proposalId}` | 共用 | [ ] |
| 转团队 | POST | `/proposal/task/convert-team` | 共用 | [ ] |

---

## 4. 状态 ↔ 页面

### 4.1 小程序

| 原型页 | 功能 | 进度 |
|--------|------|------|
| 任务指派 | 部门负责人指派 / 放任务池 | [ ] |
| 部门任务池 | 待领取列表 | [ ] |
| 领取转团队 | 领取 + 加成员 + 指定实施负责人 | [ ] |
| 首页/待办 | 部门负责人「待指派」角标 | [ ] |

### 4.2 管理端

| 页面 | 说明 | 进度 |
|------|------|------|
| 提案详情 — 任务区 | 指派记录、团队成员 | [ ] |
| 管理端批量指派 | 可选，Phase 5 | [ ] |

---

## 5. 数据库

| 表 | Phase | 进度 | 备注 |
|----|-------|------|------|
| `proposal_task` | 3 | [ ] | 指派/池/领取动作记录 |
| `proposal_task_member` | 3 | [ ] | 团队成员 |
| `proposal` 主表字段 | 1 | [x] | `implement_leader_id`, `team_type` 列已存在 |

> 建表时同步 [`../sql/proposal_init.sql`](../sql/proposal_init.sql)。

---

## 6. 后端任务清单

| # | 任务 | 进度 |
|---|------|------|
| 1 | `ProposalTask` 实体 + DDL | [ ] |
| 2 | `ProposalTaskMember` 实体 + DDL | [ ] |
| 3 | 待指派列表（按 `proposal_dept_leader` 过滤当前用户） | [ ] |
| 4 | 指派 API：校验 `PENDING_ASSIGN`、写 `implement_leader_id` | [ ] |
| 5 | 任务池 API：→ `PENDING_CLAIM` | [ ] |
| 6 | 领取 API：校验同部门、→ `IN_PROGRESS` | [ ] |
| 7 | 转团队：成员列表 + 指定 leader | [ ] |
| 8 | 状态机迁移 + `proposal_status_log` | [~] `ASSIGN`/`PUT_POOL`/`CLAIM` 已预注册；业务 API 接 `stateMachine.transit()` |
| 9 | 待办项：部门负责人「待指派」 | [ ] |

---

## 7. 前端任务清单

| # | 任务 | 端 | 进度 |
|---|------|-----|------|
| 1 | 任务指派页 | 小程序 | [ ] |
| 2 | 部门任务池页 | 小程序 | [ ] |
| 3 | 领取转团队页 | 小程序 | [ ] |
| 4 | 实施负责人选择器（JSelectUser 同类） | 小程序 | [ ] |

---

## 8. 验收标准

- [ ] 部门负责人可将已批准提案指派给指定用户 → `IN_PROGRESS`
- [ ] 部门负责人可放入任务池 → `PENDING_CLAIM`
- [ ] 同部门员工可领取 → `IN_PROGRESS`，`implement_leader_id` 正确
- [ ] 领取后可转团队并维护成员列表
- [ ] 非负责人无法指派；非本部门无法领取
- [ ] 计划书/报告书由**实施负责人**统一填写（仅一份）

---

## 9. 依赖与前置

- [x] [01 申请单](./01_application_DEV_PROGRESS.md) 批准人决策完成（出口 `APPROVED`；本段入口 `PENDING_ASSIGN` 待定）
- [x] `proposal_dept_leader` 配置表已建（`inside_dev` 2026-08-28）
- [ ] 部门树 / 用户部门关系正确（`sys_user_depart`）

---

## 10. 变更记录

| 日期 | 说明 |
|------|------|
| 2026-08-28 | 初版进度文档 |
| 2026-08-28 | `inside_dev` 已执行 init SQL，主表及配置表就绪 |
| 2026-08-31 | 状态机预注册 `ASSIGN`/`PUT_POOL`/`CLAIM`；实现 API 时走 `ProposalStateMachine.transit()` |
