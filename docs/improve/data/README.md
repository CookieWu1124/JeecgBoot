# HR 人员结构数据

## 文件说明

| 文件 | 说明 |
|------|------|
| `员工列表20260822.xls` | HR 提供的员工组织与岗位清单（2026-08-22 版） |

> **隐私提示**：该文件含真实工号、姓名等个人信息，仅限内网/私有仓库使用，勿外传或提交到公开仓库。

## Excel 列与 JeecgBoot 映射

导入时按「中心 → 部门 → 组别」逐级建树，用户挂在最细一级（组别）。

| HR 列 | JeecgBoot 落点 | 说明 |
|-------|----------------|------|
| 中心 | `sys_depart` | `org_type = CENTER`，`parent_id` 指向根或上级 |
| 部门 | `sys_depart` | `org_type = DEPT`，父节点为中心 |
| 组别 | `sys_depart` | `org_type = GROUP`，父节点为部门 |
| 工号 | `sys_user.work_no` | 唯一；**`username = work_no`** |
| 姓名 | `sys_user.realname` | |
| 岗位 | `sys_user.position_type` | |

## 样例种子（联调用）

| 脚本 | 说明 |
|------|------|
| [`../sql/proposal_spex_user_seed.sql`](../sql/proposal_spex_user_seed.sql) | 从本 Excel 抽取「斯派科」中心 12 人 + 组织树；`username=work_no`，初始密码 `123456` |

## 导入流程（规划）

```text
1. 解析「中心/部门/组别」→ 逐级创建 sys_depart 树节点（幂等）
2. 解析「工号+姓名+岗位」→ 创建/更新 sys_user（username = workNo）
3. 关联 sys_user_depart → 用户挂在组别节点
4. 角色分配 → 管理端「角色管理」单独配置（委员/批准人互斥校验）
```

## 角色与账号

- 业务员工：仅分配 `proposal_*` 业务角色，**不分配**管理端菜单权限
- 初始密码：导入时统一设置，首次登录建议强制修改
- 离职处理：`sys_user.status = 2`（冻结），保留 `realname`，无法登录

## 给 Cursor AI 的说明

- `.xls` 为二进制格式，直接解析困难；字段映射以本 README 及 `../提案改善系统-实施规划.md` 第 9.4 节为准
- 开发 HR 导入功能时，以本目录 Excel 为验收样例
