# 04 — 报告书 · 开发进度

| 项 | 值 |
|----|-----|
| **业务段** | 报告书 + 六维评分 + 批准人签核结案 |
| **规划 Phase** | Phase 4 |
| **主表字段** | `score_progress`, `score_total`, `score_grade`, `filed_date`, `closed_date` |
| **子表** | `proposal_report`, `proposal_score`, `proposal_signoff`（规划，未建） |
| **最后更新** | 2026-08-28 |

---

## 1. 业务范围

**入口**：`IN_PROGRESS`，且满足其一：

- `plan_required = 0`（任务分配后直接写报告书）
- `plan_required = 1` 且计划书已批准

| 子环节 | 说明 | 状态迁移 |
|--------|------|----------|
| 填写/提交报告书 | 4 段内容 + 参与人员 | → `PENDING_EVALUATION` |
| 六维评分 | `score_enabled=1` 的委员并行打分；加权算总分 | 进度 `score_progress`；完成 → `PENDING_SIGNOFF` |
| 等级评定 | 按总分规则 A/B/C/D → `score_grade` | 随评分完成 |
| 报告书签核 | 批准人确认结案 | → `COMPLETED`，写 `closed_date` |

---

## 2. 状态 ↔ 主表

| 状态码 | 显示名 | 本段 |
|--------|--------|------|
| `IN_PROGRESS` | 进行中 | ✓ 填写报告书 |
| `PENDING_EVALUATION` | 待评定 | ✓ 评分收集中 |
| `PENDING_SIGNOFF` | 待签核 | ✓ |
| `COMPLETED` | 已完成 | ✓ 终态 |

---

## 3. 状态 ↔ API

| 动作 | 方法 | 路径 | 端 | 进度 |
|------|------|------|-----|------|
| 获取报告书 | GET | `/proposal/report/{proposalId}` | 共用 | [ ] |
| 保存/提交报告书 | POST | `/proposal/report/{proposalId}` | 共用 | [ ] |
| 获取评分 | GET | `/proposal/score/{proposalId}` | 共用 | [ ] |
| 提交评分 | POST | `/proposal/score/{proposalId}` | 共用 | [ ] |
| 批准人签核 | POST | `/proposal/signoff/{proposalId}` | 共用 | [ ] |
| 批准人待办（签核） | GET | `/proposal/approval/pending` | 共用 | [ ] 与 01 共用入口 |

---

## 4. 状态 ↔ 页面

### 4.1 小程序

| 原型页 | 功能 | 进度 |
|--------|------|------|
| 报告书 | 4 段内容 + 参与人员 + 提交 | [ ] |
| 六维评分 | 评分委员按维度打分 | [ ] |
| 报告书签核 | 批准人签核结案 | [ ] |
| 提案详情 | 评分结果、等级、结案日期 | [ ] |
| 我的 / 统计 | 个人成绩入口（Phase 5） | [ ] |

### 4.2 管理端

| 页面 | 说明 | 进度 |
|------|------|------|
| 提案详情 — 报告/评分/签核 | 全流程只读 | [ ] |
| 评分维度配置 Tab | 权重维护 | [x] 配置 CRUD 已有 |
| 统计看板 | KPI 与排行 | [ ] Phase 5 |

---

## 5. 数据库

| 表 | Phase | 进度 | 备注 |
|----|-------|------|------|
| `proposal_report` | 4 | [ ] | 报告书正文 |
| `proposal_score` | 4 | [ ] | 按委员 + 维度明细 |
| `proposal_signoff` | 4 | [ ] | 签核记录 |
| `proposal_score_dimension` | 1 | [x] | 六维配置 + 种子数据 |
| `proposal` 评分/日期字段 | 1 | [x] | 列已存在 |

---

## 6. 后端任务清单

| # | 任务 | 进度 |
|---|------|------|
| 1 | `proposal_report` / `proposal_score` / `proposal_signoff` DDL + Entity | [ ] |
| 2 | 报告书 CRUD（实施负责人） | [ ] |
| 3 | 提交报告书 → `PENDING_EVALUATION`，初始化评分快照 | [ ] |
| 4 | 评分委员列表（`score_enabled=1`） | [ ] |
| 5 | 并行评分 + `score_progress` + 加权 `score_total` | [ ] |
| 6 | 等级 `score_grade` 规则 | [ ] |
| 7 | 全部评分完成 → `PENDING_SIGNOFF` | [ ] |
| 8 | 批准人签核 → `COMPLETED` + `closed_date` | [ ] |
| 9 | 状态机 + 日志 + 待办 + 消息 | [~] `SUBMIT_REPORT`/`SCORE_DONE`/`SIGNOFF` 已预注册；`plan_required=1` 须带 `Context.planApproved()` |

---

## 7. 前端任务清单

| # | 任务 | 端 | 进度 |
|---|------|-----|------|
| 1 | 报告书表单页 | 小程序 | [ ] |
| 2 | 六维评分页（维度来自配置 API） | 小程序 | [ ] |
| 3 | 报告书签核页 | 小程序 | [ ] |
| 4 | 评分矩阵/总分/等级展示 | 小程序 | [ ] |

---

## 8. 验收标准

- [ ] `plan_required=0`：任务分配后可直接提交报告书
- [ ] `plan_required=1`：计划书批准后才可提交报告书
- [ ] 仅评分委员（`score_enabled=1`）可打分，人数可少于审核委员
- [ ] 权重来自 `proposal_score_dimension`，加权总分正确
- [ ] 等级 A/B/C/D 与规则一致
- [ ] 签核后 `COMPLETED`，`closed_date` 自动填写
- [ ] 全流程 `proposal_status_log` 可追溯

---

## 9. 依赖与前置

- [ ] [02 任务分配](./02_task_assignment_DEV_PROGRESS.md) → `IN_PROGRESS`
- [ ] [03 计划书](./03_plan_DEV_PROGRESS.md) 完成或跳过（`plan_required=0`）
- [x] `proposal_score_dimension` 六维种子已入库（`inside_dev` 2026-08-28）
- [x] 委员会 `score_enabled` / `seat_no` 配置能力（管理端页面 + 表已建）

---

## 10. 变更记录

| 日期 | 说明 |
|------|------|
| 2026-08-28 | 初版进度文档 |
| 2026-08-28 | `inside_dev` 已执行 init SQL，评分维度种子及主表评分字段就绪 |
| 2026-08-31 | 状态机预注册报告书/评分/签核跳转；`plan_required=1` 交报告书须 `Context.planApproved()` |
