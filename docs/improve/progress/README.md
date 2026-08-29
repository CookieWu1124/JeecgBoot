# 提案改善 — 分段开发进度索引

> 按 **单据主表 `proposal`** 驱动的四段业务内容划分进度文档，便于日常开发追踪与验收对照。  
> 主规划见 [`../提案改善系统-实施规划.md`](../提案改善系统-实施规划.md)。

## 文档列表

| 序号 | 文件 | 业务段 | 规划 Phase | 当前整体进度 |
|------|------|--------|------------|--------------|
| 01 | [01_application_DEV_PROGRESS.md](./01_application_DEV_PROGRESS.md) | 申请单（含委员审核、批准人决策） | 1 + 2 | 🟡 委员审核已落地；批准人决策未开始 |
| 02 | [02_task_assignment_DEV_PROGRESS.md](./02_task_assignment_DEV_PROGRESS.md) | 任务分配 | 3（前半） | ⚪ 未开始 |
| 03 | [03_plan_DEV_PROGRESS.md](./03_plan_DEV_PROGRESS.md) | 计划书（条件分支） | 3（后半） | ⚪ 未开始 |
| 04 | [04_report_DEV_PROGRESS.md](./04_report_DEV_PROGRESS.md) | 报告书 + 六维评分 + 签核结案 | 4 | ⚪ 未开始 |

## 四段与完整链路

```text
01 申请单 ──► 02 任务分配 ──► 03 计划书（plan_required=1 时）──► 04 报告书 ──► 评分 ──► 签核
                  │                    │
                  └ plan_required=0 ───┴──► 直接 04 报告书
```

## 进度图例

| 标记 | 含义 |
|------|------|
| `[x]` | 已完成 |
| `[~]` | 进行中 / 部分完成 |
| `[ ]` | 未开始 |

## 跨段公共能力（不在四段内单独成文）

| 能力 | 规划 Phase | 说明 | 进度 |
|------|------------|------|------|
| 数据库初始化 | 1 | `proposal_init.sql` @ `inside_dev` | [x] 2026-08-28 |
| 管理端菜单权限 | 1 | `proposal_menu.sql` + 角色授权 | [x] admin / proposal_admin |
| 管理端配置（四 Tab） | 1 | 部门负责人 / 委员会（全局跨部门） / 批准人 / 评分维度 | [x] UI 对齐原型；inside_dev 业务配置已维护 |
| 管理端提案管理 | 1 | 仅查询+详情（发起在小程序）；列表/详情弹窗对齐原型 | [x] 2026-08-29 |
| 统计看板 | 5 | KPI、趋势、排行 | [ ] |
| HR 导入 / 组织树 | 1 | 复用 Jeecg `sys_user` / `sys_depart`；样例种子见 `sql/proposal_spex_user_seed.sql` | [~] 全量导入未做；斯派科样例 + 电气组别补种 SQL 已出 |
| 小程序工程骨架 | 1 | **`spex-app/`**（unibest） | [x] 2026-08-29 迁入；旧 `jeecg-uniapp/` 已删除 |
| 小程序提案业务页 | 1~2 | 发起/列表/详情/委员待办+审核已接真；批准仍 mock | [~] 委员审核方案1已落地 |
| 联调配置名册种子 | 1 | `proposal_config_seed.sql` | [x] 已与 inside_dev 管理端实配对齐 |

## 更新约定

- 每完成一项任务，在对应段文档中勾选 checklist 并填写 **变更记录** 日期。
- 涉及建表/改字段时，同步 [`../sql/proposal_init.sql`](../sql/proposal_init.sql)（见 `.cursor/rules/improve/proposal-sql-ddl.mdc`）。

## 环境就绪记录

| 项 | 状态 | 日期 |
|----|------|------|
| `inside_dev` 执行 `proposal_init.sql` | 已完成 | 2026-08-28 |
| `inside_dev` 执行 `proposal_menu.sql` | 已完成 | 2026-08-28 |
| `admin` / `proposal_admin` 角色菜单授权 | 已完成 | 2026-08-28 |
| `jeecg-uniapp/` 工程骨架纳入 monorepo | 已完成 → **2026-08-29 已删除**，改由 `spex-app/` | 2026-08-28 |
| **`spex-app/` 迁入 monorepo**（环境指向本地 JeecgBoot） | 已完成 | 2026-08-29 |
| **移除 `jeecg-uniapp/`** | 已完成 | 2026-08-29 |
| 斯派科样例用户种子 SQL | 已提供（待手工执行） | 2026-08-28 |
| 管理端提案管理/配置 UI 对齐原型 | 已完成 | 2026-08-28 |
| 提案申请发起/查询联调（小程序+管理端详情） | 已完成，申请段告一段落 | 2026-08-29 |
| 菜单 component 自愈（防 `mes/proposal/**` 空白页） | 已写入 `proposal_menu.sql` + DDL 规则 | 2026-08-29 |
| Phase2 方案1 委员并行审核 | 表+接口+小程序待办/审核+管理端意见表；`202608290001` 已补快照 | 2026-08-29 |
