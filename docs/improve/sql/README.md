# 提案改善 — 数据库脚本

## 文件

| 脚本 | 说明 |
|------|------|
| `proposal_init.sql` | Phase 1 可执行 DDL + 角色/种子数据（V1.2，含 11 项通用字段） |
| `proposal_menu.sql` | 管理端菜单与按钮权限（`sys_permission`，幂等 INSERT） |
| `proposal_tables.md` | 表结构 / 数据字典（**必须与 proposal_init.sql 同步**） |

## 规则文档

| 路径 | 说明 |
|------|------|
| `.cursor/rules/improve/proposal-sql-ddl.mdc` | Cursor Agent DDL 变更规则 |
| `proposal_tables.md` §通用字段说明 | 11 项公共字段、`active` 逻辑删除、`tenant_id` 唯一索引后缀 |

> 模式参考历史项目 `My-JeecgBoot/docs/scm/procurement/sql/`（`*_tables.md` + `.cursor/rules/.../scm-proc-sql-ddl.mdc`）。

## 执行前提

1. 已导入 JeecgBoot 基础库（如 `jeecg-boot/db/jeecgboot-mysql-5.7.sql`）
2. **Flyway 已关闭**（`spring.flyway.enabled: false`），脚本需手工执行

## 执行方式

```bash
# 开发库 inside_dev（与 application-dev.yml 一致）
mysql -u root -p inside_dev < docs/improve/sql/proposal_init.sql
mysql -u root -p inside_dev < docs/improve/sql/proposal_menu.sql
```

或在 Navicat / DBeaver 中打开 `proposal_init.sql` 执行。

## 开发库执行记录

| 库 | 脚本 | 状态 | 日期 |
|----|------|------|------|
| `inside_dev` | `proposal_init.sql` | 已执行 | 2026-08-28 |
| `inside_dev` | `proposal_menu.sql` | 已执行 | 2026-08-28 |

> 菜单授权：`admin`、`proposal_admin` 角色已在库内授权提案相关菜单（2026-08-28）。

## 变更流程

1. 修改 `proposal_init.sql`（**任何改表/改字段都必须回写此文件**，见 `.cursor/rules/improve/proposal-sql-ddl.mdc`）
2. 同步 `proposal_tables.md`
3. 同步 Java `ProposalBaseEntity` 与各 `entity`
4. 开发库落地：新库直接执行 init；已有库另写 `fix/` 增量（若需要，且 fix 内容最终合并进 init）

## 特性

- 角色 INSERT 使用 `WHERE NOT EXISTS`，可重复执行（幂等）
- 业务表使用 **`active` Y/N** 替代 Jeecg 默认 `del_flag`
- 唯一索引组合键**末位含 `tenant_id`**
- 用户/部门外键语义指向 `sys_user.id`、`sys_depart.id`
