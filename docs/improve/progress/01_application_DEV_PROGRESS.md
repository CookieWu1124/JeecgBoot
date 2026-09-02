# 01 — 申请单 · 开发进度

| 项 | 值 |
|----|-----|
| **业务段** | 申请单（含委员并行审核、批准人申请决策） |
| **规划 Phase** | Phase 1（骨架）+ Phase 2（审核流） |
| **主表字段** | `title`, `improvement_types`, `dept_id`, `proposer_id`, `dept_leader_id`, `plan_required`*, `award_amount`* |
| **子表** | `proposal_application`, `proposal_attachment` |
| **最后更新** | 2026-09-01 |
| **本段状态** | 🟢 **已归档暂停**：申请段业务闭环 + 微信登录公共能力已落地；出口仍停在 `APPROVED`（不进待指派）。下一里程碑 → [02 任务分配](./02_task_assignment_DEV_PROGRESS.md) |

> \* `plan_required`、`award_amount` 在**批准人决策**时写入，逻辑上仍属申请阶段收尾。

---

## 0. 本段归档快照（2026-09-01）

开发在此暂停，后续联调有问题再开。代码已在远程分支 `v3.9.3-spex-inside`（最近归档提交含对接清单）。

### 已交付

| 块 | 结论 |
|----|------|
| 申请段业务 | 发起一次进审核中 → 委员并行审 → 批准人决策；四档状态；无草稿/撤回 |
| 小程序 spex-app | 登录、首页、发起、列表、详情、待办、委员审、批准已接真 |
| 管理端 Vue3 | 提案只读列表/详情；配置五 Tab；用户管理「解绑微信」 |
| 对接文档 | `docs/improve/api/` 两份清单可直接发给前端同事 |

### 微信登录（系统公共能力，不绑提案模块）

两种登录并存：工号+密码 `/sys/mLogin`；工号+微信授权 `/sys/wxMini/*`（仅小程序）。登录后不选部门。H5 测不了授权。

**产品拍板（方案 A，联调期暂维持，后续若要上生产可重开需求对齐参考图）：**

- 进登录页自动 `silentLogin`：已绑定且**不是主动退出** → 进工作台。
- 主动退出写本地 `wx-skip-silent-login`，再进登录页**不打** `silentLogin`（避免闪一下又进来）。
- 点「微信授权登录」每次走 `bind`（按钮是 `getPhoneNumber`）。已绑定则后端直接发 Token，不再调 `getuserphonenumber`；未绑定才换号、写绑定。
- 退出只清 Token，**不解绑**。解绑在管理端用户列表。改手机号 ≠ 解绑。

**与参考图（`登录绑定流程图.png`）的差异（有意为之，便于联调）：**

| 环节 | 参考图 / 业界常见 | 本仓库方案 A（当前） |
|------|-------------------|----------------------|
| 主动退出后再进 | 仍 `onMounted` 静默 OpenID → 已绑定则进工作台 | 写 `wx-skip-silent-login`，**不静默**，停在登录页 |
| 已绑定用户再登录 | 走 `silentLogin`（免费 `jscode2session`） | 退出后须手动点「微信授权登录」→ 走 `bind` 入口（后端已绑定时短路发 Token，不调取号 API） |
| 工号+密码切换账号 | 参考图未单独画；业界少见同机换号 | **保留**：退出后不静默，可切「工号+密码」测其他角色 |
| 退出是否解绑 | 仅清 Token，绑定保留 | 一致 |

**`silentLogin` 后端顺序（与参考图一致，未搞反）：** 必须先 `jsCode` → `jscode2session` 得 OpenID，再查 `sys_third_account`。不能在静默阶段传工号/手机号代替 OpenID（见对接清单 §3.3、`微信授权登录-生命周期脉络.md` §「静默登录为何先换 OpenID」）。

测 `silentLogin`：不要点退出；开发者工具清数据缓存（含 `token` / `wx-skip-silent-login`）后点编译。测退出后切密码：先点退出，确认 Storage 有 `wx-skip-silent-login`，再切登录模式。教程见 `微信开发者工具-小程序联调教程.md`。

### 明确未做 / 下一阶段

- 02 任务分配、03 计划书、04 报告书评分签核
- 站内消息 `SysAnnouncement`
- 统计看板；HR 全量导入
- 微信登录方案 B（退出后再点只 silent、不弹手机号）**不做**

### 发给同事

| 对象 | 文档 |
|------|------|
| 小程序前端 | `docs/improve/api/提案小程序-接口对接清单.md` |
| 管理端前端 | `docs/improve/api/提案管理端-接口对接清单.md` |
| 测微信授权 | 另附 `docs/improve/微信开发者工具-小程序联调教程.md` |

---

## 1. 业务范围

| 子环节 | 说明 | 终态/出口 |
|--------|------|-----------|
| 填写并提交 | 2 步确认：内容 + 确认提交（**不落草稿**） | → `PENDING_REVIEW`（审核中） |
| 委员审核 | 在任委员并行独立意见；进度 `review_progress` | → `PENDING_APPROVAL`（待批准） |
| 批准人决策 | 批准/不批准；写入 `plan_required`、`award_amount` | 批准 → `APPROVED`；不批准 → `REJECTED_FINAL` |

---

## 2. 状态 ↔ 主表

| 状态码 | 显示名 | 本段 |
|--------|--------|------|
| `PENDING_REVIEW` | 审核中 | ✓ |
| `PENDING_APPROVAL` | 待批准 | ✓ |
| `APPROVED` | 已批准 | ✓ 申请段通过（阶段 2 待定） |
| `REJECTED_FINAL` | 不批准 | ✓ 终态 |

---

## 3. 状态 ↔ API

| 状态/动作 | 方法 | 路径 | 端 | 进度 |
|-----------|------|------|-----|------|
| 发起提案 | POST | `/proposal/create` | 共用 | [x] 一次提交，进入审核中 |
| 单独提交 | PUT | `/proposal/{id}/submit` | 共用 | [x] **已并入发起**；重复调用幂等 |
| 列表/详情 | GET | `/proposal/list`, `/proposal/{id}` | 共用 | [x] |
| 委员待审列表 | GET | `/proposal/review/committee/pending` | 共用 | [x] |
| 委员提交意见 | POST | `/proposal/review/committee/{proposalId}` | 共用 | [x] |
| 批准人待办 | GET | `/proposal/approval/pending` | 共用 | [x] |
| 申请批准决策 | POST | `/proposal/approval/application/{proposalId}` | 共用 | [x] |
| 首页聚合 | GET | `/proposal/app/home` | 小程序 | [x] |
| 管理端列表/详情 | * | `/proposal/admin/manage/*` | 管理端 | [x] 列表+详情含申请书/留痕/委员意见/批准决策 |
| 配置（委员/批准人） | * | `/proposal/admin/config/*` | 管理端 | [x] |

---

## 4. 状态 ↔ 页面

### 4.1 小程序（原型 `improveSys.html`）

| 原型页 | 功能 | 进度 |
|--------|------|------|
| 发起提案（2 步） | 填写申请书 + 附件 + 提交 | [x] `pages/proposal/apply` 已接 create/submit |
| 申请委员待办 | 委员待审列表 | [x] `pages/todo` 接 pending |
| 申请委员审核 | 采用/不采用 + 计划书建议 + 奖励建议 | [x] `pages/proposal/review` 已接真实接口 |
| 批准人待办 | 申请批准入口 | [x] pages/todo 待核定 |
| 申请批准 | 批准/不批准 + 核定 `plan_required` / 奖励 | [x] `pages/proposal/approve` 已接真 |
| 首页 | KPI + 待办摘要 + 动态 | [x] `pages/index` 接 `GET /proposal/app/home` |
| 提案列表 Tab | 含待审核进度展示 | [x] `pages/proposal/index` 已接 list |
| 提案详情 | 申请阶段信息展示 | [x] `pages/proposal/detail` 已接 detail |

### 4.2 管理端（`jeecgboot-vue3`）

| 页面 | 路径 | 进度 |
|------|------|------|
| 提案管理列表（仅查询+详情） | `views/mes/proposal/manage/index` | [x] 筛选/列对齐原型；无新增/勾选 |
| 提案配置（五 Tab） | `views/mes/proposal/config/index` | [x] 部门负责人 / 委员会 / 批准人卡片 / **改善性质** / 评分维度 |
| 提案详情弹窗 | `views/mes/proposal/manage/components/ProposalModal` | [x] 对齐原型：摘要卡/四 Tab/申请单分块；委员意见表已接；计划书·报告书占位；操作留痕已接 status_log |

---

## 5. 数据库

| 表 | Phase | 进度 | 备注 |
|----|-------|------|------|
| `proposal` | 1 | [x] | 主表 |
| `proposal_application` | 1 | [x] | 申请书正文 |
| `proposal_attachment` | 1 | [x] | 现场图片等 |
| `proposal_status_log` | 1 | [x] | 提交/委员齐/批准等由状态机写日志 |
| `proposal_committee_member` | 1 | [x] | 审核名册 |
| `proposal_approver` | 1 | [x] | 批准人配置 |
| `proposal_dept_leader` | 1 | [x] | 提交前校验 |
| `proposal_improvement_type` | 1 | [x] | 改善性质配置；`inside_dev` 用 fix 增量 |
| `proposal_committee_review` | 2 | [x] | 委员审核记录 + 提交快照；`inside_dev` 已建表并对 202608290001 补种 |
| `proposal_approval` | 2 | [x] | 批准人决策记录；`inside_dev` 已建表 |

---

## 6. 后端任务清单

| # | 任务 | 进度 |
|---|------|------|
| 1 | `ProposalController` 创建/列表/详情 | [x] |
| 2 | 提交校验：部门负责人、委员会非空、申请书必填 | [x] |
| 3 | 提案编号生成 `proposal_no` | [x] |
| 4 | 附件上传关联（最多 4 张） | [x] |
| 5 | `ProposalStatusEnum` + 状态日志 | [x] 改状态统一由 StateMachine 写日志 |
| 6 | `ProposalStateMachine` 统一迁移校验 | [x] 申请段已接入；02/03/04 路线已预注册 |
| 7 | `proposal_committee_review` 实体/Mapper/并行审核汇总 | [x] |
| 8 | 委员全部完成 → `PENDING_APPROVAL` | [x] |
| 9 | `proposal_approval` + 批准/不批准 + 写 `plan_required` | [x] |
| 10 | 待办聚合（委员/批准人） | [x] 委员+批准人 pending 已通 |
| 11 | 站内消息 `SysAnnouncement` | [ ] **本段不做**，留给后续 |
| 12 | 微信小程序登录 `/sys/wxMini`（silent / bind / unbind） | [x] 系统公共；Shiro 已放行 silent/bind |

---

## 7. 前端任务清单

| # | 任务 | 端 | 进度 |
|---|------|-----|------|
| 1 | 发起提案 2 步表单页 | 小程序 | [x] |
| 2 | 图片上传组件对接 `/sys/common/upload` | 小程序 | [x] 发起页已接 |
| 3 | 委员审核页 | 小程序 | [x] `review.vue` + 待办入口 |
| 4 | 批准人申请批准页 | 小程序 | [x] `approve.vue` |
| 5 | 列表审核进度 `review_progress` 展示 | 小程序 | [x] 列表已展示 reviewProgress |
| 6 | 管理端提案列表（查询对齐原型） | 管理端 | [x] 仅查询+详情；筛选/列/进度条/状态 Tag |
| 7 | 管理端用户/部门名称回显（非 ID） | 管理端 | [x] 配置五 Tab + 列表 + 详情（提案人所属部门≠改善部门） |
| 8 | 管理端菜单可见（SQL + 角色授权） | 管理端 | [x] `proposal_menu.sql` 含 component 自愈 UPDATE |
| 9 | 管理端提案配置对齐原型 | 管理端 | [x] 批准人卡片、委员选人预览、权重合计等 |
| 10 | 小程序发起提案 2 步页 | 小程序 | [x] `pages/proposal/apply`；确认后只调 create（一次进审核中） |
| 12 | 小程序首页聚合 | 小程序 | [x] `pages/index` 接 `/proposal/app/home` |
| 11 | 管理端详情弹窗对齐原型 | 管理端 | [x] 申请单正文来自 `proposal_application`；留痕来自 `proposal_status_log`；委员意见来自 `committeeReviews` |
| 13 | 工号+密码 / 工号+微信授权双登录 | 小程序 | [x] 方案 A：退出跳过静默；点授权走 bind |
| 14 | 用户管理解绑微信 | 管理端 | [x] `POST /sys/wxMini/unbind`，不清 phone |

---

## 8. 验收标准

- [x] 提案人可完成 2 步提交，状态为 `PENDING_REVIEW`，`review_progress` 为 `0/N`（inside_dev 已联调）
- [x] 在任委员可并行提交独立意见，全部完成后进入 `PENDING_APPROVAL`（`202608290001` 已 5/5 → 待核定，管理端已验）
- [x] 批准人「不批准」→ `REJECTED_FINAL`，不可再编辑（已联调）
- [x] 批准人「批准」→ `APPROVED`，并写入 `plan_required`、`award_amount`（**不进入** `PENDING_ASSIGN`）
- [x] 申请段无撤回、无草稿接口
- [x] 未配置部门负责人或委员会为空时，提交被拒绝并提示
- [x] 管理端详情可查看申请书正文（目前状况/改善意见）与操作留痕
- [x] 管理端详情可查看委员审核意见列表（含未审快照行）
- [x] 小程序两种登录并存；微信授权仅小程序；退出不解绑
- [x] 管理端可解绑微信（只删 `sys_third_account`）
- [~] 微信授权真机/开发者工具：开发侧已通主路径；后续联调问题再开（非阻塞归档）

---

## 9. 依赖与前置

- [x] `proposal_init.sql` 已在 `inside_dev` 全量执行（2026-08-28）
- [x] `proposal_menu.sql` 菜单权限已执行
- [x] `admin`、`proposal_admin` 角色已授权提案相关菜单
- [x] 委员会名册、部门负责人、批准人已在管理端配置（`inside_dev` 实配）
- [x] 联调配置种子已与库对齐：`proposal_config_seed.sql`（3 负责人 / 5 委员 / 1 批准人）
- [x] `spex-app/` 已迁入 monorepo（unibest；登录 AES；发起/列表/详情已对接真实接口）
- [x] 旧 `jeecg-uniapp/` 已删除（2026-08-29）
- [x] `proposal_committee_review` 已在 `inside_dev` 建表（`fix/20260829_create_proposal_committee_review.sql`）
- [x] `proposal_approval` 已在 `inside_dev` 建表（`fix/20260829_create_proposal_approval.sql`）

---

## 10. 变更记录

| 日期 | 说明 |
|------|------|
| 2026-08-28 | 初版进度文档；Phase 1 后端提交/撤回、管理端列表与配置页已落地 |
| 2026-08-28 | `inside_dev` 已执行 `proposal_init.sql`、`proposal_menu.sql`；admin / proposal_admin 已授权菜单 |
| 2026-08-28 | 修正：曾纳入 `jeecg-uniapp/` 骨架；补充斯派科样例用户种子 SQL 路径 |
| 2026-08-28 | 提案配置：改善部门改为单选；部门/用户名称回显（queryByIds） |
| 2026-08-28 | 提案配置四 Tab 对齐原型列（工号/职位/评分职责/批准人卡片/权重合计）；保存补审计字段；无需改表 |
| 2026-08-28 | **管理端告一段落**：提案管理改为仅查询（去新增/勾选），筛选与列表列对齐原型；批准人卡片对齐 SPEX 原型；委员会维持全局跨部门名册（不按部门拆席位）；提交日期筛选 label 对齐 |
| 2026-08-28 | **配数据+发起提案**：新增 `proposal_config_seed.sql`；共用接口 `GET /proposal/meta/improvementDepts`；小程序发起页曾在旧 uniapp 落地 |
| 2026-08-28 | **配置种子对齐 inside_dev**：按管理端实配重写 `proposal_config_seed.sql`（MES/自动线/电气 3 负责人；批准人汪秦军；委员 5 席含曾金/陈泽波/刘恋/张小朋/吴浪） |
| 2026-08-29 | **移动端切换**：迁入 `spex-app/`（unibest），删除 `jeecg-uniapp/`；登录对接 Jeecg；提案 API 骨架就绪、页面仍 mock |
| 2026-08-29 | **发起联调**：spex-app 发起/列表/详情对接 create+submit+list+detail；密码 AES；审核/批准仍 mock |
| 2026-08-29 | **管理端详情对齐原型**：`ProposalModal` 摘要卡+四 Tab；`getAdminDetail` 返回申请书/附件/status_log；提案人部门按用户 orgCode 回显 |
| 2026-08-29 | **菜单 component 纠偏**：误写 `mes/proposal/**` 导致空白页；`proposal_menu.sql` 增加固定 id 自愈 UPDATE；规则写入 `proposal-sql-ddl.mdc` |
| 2026-08-29 | **提案申请（发起/查询）告一段落**：小程序发起+列表+详情、管理端列表+详情已齐；下一里程碑为委员并行审核（Phase 2） |
| 2026-08-29 | **Phase2 方案1 委员并行审核**：建表 proposal_committee_review；submit 快照 + 在途 ensure；pending/submit 接口；5/5→PENDING_APPROVAL；spex-app 待办+审核页接真；管理端详情展示委员意见；贺志龙单已补 5 条快照；批准人仍待做 |
| 2026-08-29 | **Phase2 批准人申请决策**：建表 proposal_approval；pending/决策接口；写 plan_required/award_amount；spex-app 待核定+approve 接真；管理端详情展示批准结果；申请段 Phase2 收齐 |
| 2026-08-29 | **申请段 Phase2 联调归档**：`202608290001` 委员 5/5 → 待核定（管理端已验）；批准人决策链路已验；本段关闭，下一里程碑 02 任务分配 |
| 2026-08-29 | **App 对接清单**：新增 `docs/improve/api/提案小程序-接口对接清单.md`（申请段接口/字段/示例/联调账号），供小程序前端同事联调 |
| 2026-08-31 | **状态文案唯一真相**：`GET /proposal/meta/statuses`；列表/详情带 `statusLabel`；管理端筛选 ApiSelect，不再写死中文 |
| 2026-08-31 | **状态机提前落地**：`ProposalStateMachine` + `ProposalAction`；提交/撤回/委员齐/批准/不批准改走 `transit()`；02/03/04 合法跳转已预注册 |
| 2026-08-31 | **改善性质落库**：表 `proposal_improvement_type`；配置 Tab 在评分维度前；`GET /proposal/meta/improvementTypes`；提交校验启用码；列表/详情带 `improvementTypesLabel` |
| 2026-08-31 | **管理端页面迁目录**：`views/proposal` → `views/mes/proposal`；菜单 `component` 改为 `mes/proposal/**`，访问 url 仍为 `/proposal/**` |
| 2026-08-31 | **管理端对接清单补系统选人/选部门**：S5 `/sys/user/list`、S6 部门树及 S1–S4 字段；`SysUser`/`SysDepart` 补 `@Operation` 以便 Knife4j 可见 |
| 2026-08-31 | **列表/详情嵌套回显**：配置与提案管理 list/detail 一次返回人员部门摘要，去掉前端 N+1 |
| 2026-08-31 | **申请段状态精简**：四档 审核中/待批准/已批准/不批准；新增 `APPROVED`；批准不再进入待指派；取消撤回 |
| 2026-08-31 | **取消暂存**：`POST /proposal/create` 一次进入审核中；更新草稿失败；列表去掉草稿 Tab |
| 2026-08-31 | **去掉 DRAFT**：枚举与状态机不再有草稿；发起直接写 `PENDING_REVIEW`；流转 `from_status` 为空；存量见 `20260831_purge_proposal_draft.sql` |
| 2026-08-31 | **去掉草稿/撤回接口**：删除 `PUT /{id}/draft`、`POST /{id}/withdraw`；枚举去掉 `WITHDRAWN`；存量见 `20260831_purge_proposal_withdrawn.sql` |
| 2026-08-31 | **首页接真实聚合**：`GET /proposal/app/home`；待办=委员未审+批准人待核定；已结案含已批准/不批准 |
| 2026-08-31 | **首页按位置并集**：待办/动态随提案人·委员·批准人·部门负责人变化；动态只查 5 条 |
| 2026-09-01 | **微信登录对接清单**：小程序 A1a/A1b/A1c + 管理端 S7 解绑；发给前端同事以 `docs/improve/api/` 两份清单为准 |
| 2026-09-01 | **申请段归档暂停**：业务闭环 + 微信登录方案 A（退出不自动 silent，点授权走 bind）拍板；下一里程碑 02 任务分配 |
| 2026-09-02 | **文档补记**：方案 A 与参考图差异对照；`silentLogin` 先 jscode2session 再查 OpenID 的设计说明（顺序未搞反） |
