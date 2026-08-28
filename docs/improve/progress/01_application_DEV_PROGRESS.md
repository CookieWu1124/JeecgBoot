# 01 — 申请单 · 开发进度

| 项 | 值 |
|----|-----|
| **业务段** | 申请单（含委员并行审核、批准人申请决策） |
| **规划 Phase** | Phase 1（骨架）+ Phase 2（审核流） |
| **主表字段** | `title`, `improvement_types`, `dept_id`, `proposer_id`, `dept_leader_id`, `plan_required`*, `award_amount`* |
| **子表** | `proposal_application`, `proposal_attachment` |
| **最后更新** | 2026-08-28 |

> \* `plan_required`、`award_amount` 在**批准人决策**时写入，逻辑上仍属申请阶段收尾。

---

## 1. 业务范围

| 子环节 | 说明 | 终态/出口 |
|--------|------|-----------|
| 草稿/填写 | 2 步发起：内容 + 确认提交 | `DRAFT` |
| 提交申请 | 校验部门负责人、委员会名册；生成编号 | → `PENDING_REVIEW` |
| 委员审核 | 在任委员并行独立意见；进度 `review_progress` | → `PENDING_APPROVAL` |
| 批准人决策 | 批准/不批准；写入 `plan_required`、`award_amount` | 批准 → `PENDING_ASSIGN`；不批准 → `REJECTED_FINAL` |
| 撤回 | 仅 `PENDING_REVIEW` 且提案人 | → `WITHDRAWN` |

---

## 2. 状态 ↔ 主表

| 状态码 | 显示名 | 本段 |
|--------|--------|------|
| `DRAFT` | 草稿 | ✓ |
| `PENDING_REVIEW` | 待审核 | ✓ |
| `PENDING_APPROVAL` | 待批准 | ✓ |
| `REJECTED_FINAL` | 不批准 | ✓ 终态 |
| `WITHDRAWN` | 已撤回 | ✓ 终态 |
| `PENDING_ASSIGN` | 待指派 | 出口 → [02 任务分配](./02_task_assignment_DEV_PROGRESS.md) |

---

## 3. 状态 ↔ API

| 状态/动作 | 方法 | 路径 | 端 | 进度 |
|-----------|------|------|-----|------|
| 创建草稿 | POST | `/proposal/create` | 共用 | [x] |
| 更新草稿 | PUT | `/proposal/{id}/draft` | 共用 | [x] |
| 提交申请 | PUT | `/proposal/{id}/submit` | 共用 | [x] |
| 撤回 | POST | `/proposal/{id}/withdraw` | 共用 | [x] |
| 列表/详情 | GET | `/proposal/list`, `/proposal/{id}` | 共用 | [x] |
| 委员待审列表 | GET | `/proposal/review/committee/pending` | 共用 | [ ] |
| 委员提交意见 | POST | `/proposal/review/committee/{proposalId}` | 共用 | [ ] |
| 批准人待办 | GET | `/proposal/approval/pending` | 共用 | [ ] |
| 申请批准决策 | POST | `/proposal/approval/application/{proposalId}` | 共用 | [ ] |
| 管理端列表 CRUD | * | `/proposal/admin/manage/*` | 管理端 | [x] |
| 配置（委员/批准人） | * | `/proposal/admin/config/*` | 管理端 | [x] |

---

## 4. 状态 ↔ 页面

### 4.1 小程序（原型 `improveSys.html`）

| 原型页 | 功能 | 进度 |
|--------|------|------|
| 发起提案（2 步） | 填写申请书 + 附件 + 提交 | [ ] |
| 申请委员待办 | 委员待审列表 | [ ] |
| 申请委员审核 | 采用/不采用 + 计划书建议 + 奖励建议 | [ ] |
| 批准人待办 | 申请批准入口 | [ ] |
| 申请批准 | 批准/不批准 + 核定 `plan_required` / 奖励 | [ ] |
| 提案列表 Tab | 含待审核进度展示 | [ ] |
| 提案详情 | 申请阶段信息展示 | [ ] |

### 4.2 管理端（`jeecgboot-vue3`）

| 页面 | 路径 | 进度 |
|------|------|------|
| 提案管理列表 | `views/proposal/manage/index` | [x] |
| 提案配置（委员/批准人 Tab） | `views/proposal/config/index` | [x] |
| 提案详情（全流程时间线） | — | [ ] Phase 5 |

---

## 5. 数据库

| 表 | Phase | 进度 | 备注 |
|----|-------|------|------|
| `proposal` | 1 | [x] | 主表 |
| `proposal_application` | 1 | [x] | 申请书正文 |
| `proposal_attachment` | 1 | [x] | 现场图片等 |
| `proposal_status_log` | 1 | [x] | 提交/撤回已写日志 |
| `proposal_committee_member` | 1 | [x] | 审核名册 |
| `proposal_approver` | 1 | [x] | 批准人配置 |
| `proposal_dept_leader` | 1 | [x] | 提交前校验 |
| `proposal_committee_review` | 2 | [ ] | 委员审核记录 + 提交快照 |
| `proposal_approval` | 2 | [ ] | 批准人决策记录 |

---

## 6. 后端任务清单

| # | 任务 | 进度 |
|---|------|------|
| 1 | `ProposalController` 创建/草稿/提交/撤回/列表/详情 | [x] |
| 2 | 提交校验：部门负责人、委员会非空、申请书必填 | [x] |
| 3 | 提案编号生成 `proposal_no` | [x] |
| 4 | 附件上传关联（最多 4 张） | [x] |
| 5 | `ProposalStatusEnum` + 状态日志 | [~] 部分动作已写 |
| 6 | `ProposalStateMachine` 统一迁移校验 | [ ] |
| 7 | `proposal_committee_review` 实体/Mapper/并行审核汇总 | [ ] |
| 8 | 委员全部完成 → `PENDING_APPROVAL` | [ ] |
| 9 | `proposal_approval` + 批准/不批准 + 写 `plan_required` | [ ] |
| 10 | 待办聚合（委员/批准人） | [ ] |
| 11 | 站内消息 `SysAnnouncement` | [ ] |

---

## 7. 前端任务清单

| # | 任务 | 端 | 进度 |
|---|------|-----|------|
| 1 | 发起提案 2 步表单页 | 小程序 | [ ] |
| 2 | 图片上传组件对接 `/sys/common/upload` | 小程序 | [ ] |
| 3 | 委员审核页 | 小程序 | [ ] |
| 4 | 批准人申请批准页 | 小程序 | [ ] |
| 5 | 列表审核进度 `review_progress` 展示 | 小程序 | [ ] |
| 6 | 管理端提案列表（基础 CRUD） | 管理端 | [x] |
| 7 | 管理端用户/部门名称回显（非 ID） | 管理端 | [ ] |
| 8 | 管理端菜单可见（SQL + 角色授权） | 管理端 | [x] |

---

## 8. 验收标准

- [ ] 提案人可完成 2 步提交，状态为 `PENDING_REVIEW`，`review_progress` 为 `0/N`
- [ ] 在任委员可并行提交独立意见，全部完成后进入 `PENDING_APPROVAL`
- [ ] 批准人「不批准」→ `REJECTED_FINAL`，不可再编辑
- [ ] 批准人「批准」→ `PENDING_ASSIGN`，并写入 `plan_required`、`award_amount`
- [ ] `PENDING_REVIEW` 下提案人可撤回 → `WITHDRAWN`
- [ ] 未配置部门负责人或委员会为空时，提交被拒绝并提示

---

## 9. 依赖与前置

- [x] `proposal_init.sql` 已在 `inside_dev` 全量执行（2026-08-28）
- [x] `proposal_menu.sql` 菜单权限已执行
- [x] `admin`、`proposal_admin` 角色已授权提案相关菜单
- [ ] 委员会名册、部门负责人、批准人已在管理端配置（业务数据）
- [ ] HR 用户导入，`username = work_no`

---

## 10. 变更记录

| 日期 | 说明 |
|------|------|
| 2026-08-28 | 初版进度文档；Phase 1 后端提交/撤回、管理端列表与配置页已落地 |
| 2026-08-28 | `inside_dev` 已执行 `proposal_init.sql`、`proposal_menu.sql`；admin / proposal_admin 已授权菜单 |
