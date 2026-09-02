# HR 人员结构数据

## 文件说明

| 文件 | 说明 |
|------|------|
| `员工列表20260822.xls` | HR 提供的员工组织与岗位清单（2026-08-22 版，**1355** 人） |
| [**HR字段落库映射.md**](./HR字段落库映射.md) | **Excel 18 列 ↔ 数据库表字段** 完整映射（含未落库列、seed 范围） |

> **隐私提示**：该文件含真实工号、姓名等个人信息，仅限内网/私有仓库使用，勿外传或提交到公开仓库。

## 快速对照（6 列落库）

导入规则按「中心 → 部门 → 组别」逐级建树，用户挂在最细一级（通常为组别）。

| HR 列 | JeecgBoot 落点 | 说明 |
|-------|----------------|------|
| 中心 | `sys_depart` | `org_type = CENTER`，`depart_name` = 中心名 |
| 部门 | `sys_depart` | `org_type = DEPT`，父 = 中心 |
| 组别 | `sys_depart` | `org_type = GROUP`，父 = 部门 |
| 工号 | `sys_user.work_no` + **`username`** | 唯一；**`username = work_no`** |
| 姓名 | `sys_user.realname` | |
| 岗位 | `sys_user.position_type` | |
| （组织归属） | `sys_user_depart` | `user_id` ↔ 组别（或部门）`dep_id` |

**未落库**：部门简称、所属小组编码/名称、三级审批者、职级、聘用日期等 **12 列** — 详见 [HR字段落库映射.md](./HR字段落库映射.md)。

## HR 种子 SQL（全量）

| 脚本 | 说明 |
|------|------|
| [`../sql/hr_user_purge.sql`](../sql/hr_user_purge.sql) | 重导前清理旧 spex* 样例 + proposal 测试数据 |
| [`../sql/hr_user_seed_all.sql`](../sql/hr_user_seed_all.sql) | **1355 人** + 组织树（斯派科 `S01*` / 智能制造中心 `Z01*`） |
| [`../sql/hr_user_seed/`](../sql/hr_user_seed/) | 17 个按「中心+部门」拆分文件 |
| [`../sql/proposal_config_seed.sql`](../sql/proposal_config_seed.sql) | 提案负责人/委员/批准人（`work_no` 子查询） |

| [`../sql/hr_quick_queries.md`](../sql/hr_quick_queries.md) | **快捷 SQL**：按中心/部门查员工、按节点 id 展机构树 |

## 导入流程

```text
1. hr_user_purge.sql
2. hr_user_seed_all.sql（或 hr_user_seed/*.sql 分批）
3. proposal_config_seed.sql
4. 管理端授权提案菜单；按需调整配置
```

## 角色与账号

- 业务员工：提案待办走配置名册，**不依赖** Excel 审批者列
- 初始密码：导入时统一 `123456`，首次登录建议强制修改
- 离职处理：`sys_user.status = 2`（冻结），保留 `realname`，无法登录

## 给 Cursor AI 的说明

- `.xls` 为二进制格式；**列名与映射以 [HR字段落库映射.md](./HR字段落库映射.md) 为准**
- 全量 HR 种子已由 `scripts/hr_seed_gen.py` 生成；Excel 变更后重跑脚本
