# 提案改善 — 数据库脚本

## 文件职责（勿混用）

| 脚本 | 职责 | 新环境是否必跑 |
|------|------|----------------|
| `proposal_init.sql` | **业务表 DDL** + 角色 + 改善性质 / 评分维度种子 | ✅ 必跑 |
| `proposal_menu.sql` | **管理端菜单/按钮**（`sys_permission`） | ✅ 必跑 |
| `proposal_spex_user_seed.sql` | 斯派科样例组织 + MES/电气控制员工（`org_code=S01*`） | ⭕ 开发/联调建议跑 |
| `proposal_config_seed.sql` | 联调配置：部门负责人 / 委员会 / 批准人 | ⭕ 跑完用户种子后执行 |
| `proposal_spex_elc_user_seed.sql` | 增量：电气控制另 5 人（已跑过旧 seed 时用） | ⭕ 按需 |
| `fix/*.sql` | 已有库增量修复（勿当全量） | 仅旧库需要时 |
| `proposal_tables.md` | 表结构文档（与 init 同步） | 文档 |

> **不要把人员/组织种子写进 `proposal_menu.sql`**——菜单与样例数据职责分离。  
> 忘记 seed 时：开发联调缺样例账号；业务表与菜单不受影响。生产环境应走 HR 导入，不必依赖本 seed。

## 新环境一键部署顺序

```bash
# 1. Jeecg 基础库（若尚未导入）
# mysql -u root -p inside_dev < jeecg-boot/db/jeecgboot-mysql-5.7.sql

# 2. 提案业务表 + 角色 + 改善性质 / 六维种子
mysql -u root -p inside_dev < docs/improve/sql/proposal_init.sql

# 3. 管理端菜单权限
mysql -u root -p inside_dev < docs/improve/sql/proposal_menu.sql

# 4.（可选）斯派科联调样例用户/组织 — 开发库建议执行
mysql -u root -p inside_dev < docs/improve/sql/proposal_spex_user_seed.sql

# 5.（可选）联调配置名册 — 部门负责人/委员会/批准人
mysql -u root -p inside_dev < docs/improve/sql/proposal_config_seed.sql
```

执行后还需：管理端给 `admin` / `proposal_admin` **授权提案菜单**。配置种子执行后也可在「提案配置」中核对/调整。

## Jeecg `org_code` 优编码约定（重要）

Jeecg 部门编码为 **每级固定 3 位** = `1 个字母 + 2 位数字`（如 `A01`、`S01A01A01`）：

| 项 | 说明 |
|----|------|
| 同级容量 | 字母 A–Z × 数字 01–99 ≈ **26×99 = 2574** 个兄弟节点（不是 26×10×10） |
| 下级 | 在父编码后追加 3 位，如父 `S01` → 子 `S01A01`、`S01A02`… |
| 多部门 | 完全够用；斯派科样例使用 `S01` / `S01A01` / `S01A01A01` / `S01A01A02` |
| 禁止 | 自造非 3 倍数长度编码（如旧版 `SPX01` 长度为 5），否则 `queryByIds` 报「编码长度必须能被固定位数整除」 |

## 规则文档

| 路径 | 说明 |
|------|------|
| `.cursor/rules/improve/proposal-sql-ddl.mdc` | Cursor Agent DDL 变更规则 |
| `proposal_tables.md` §通用字段说明 | 11 项公共字段、`active` 逻辑删除、`tenant_id` 唯一索引后缀 |

## 执行前提

1. 已导入 JeecgBoot 基础库（如 `jeecg-boot/db/jeecgboot-mysql-5.7.sql`）
2. **Flyway 已关闭**（`spring.flyway.enabled: false`），脚本需手工执行

## 开发库执行记录

| 库 | 脚本 | 状态 | 日期 |
|----|------|------|------|
| `inside_dev` | `proposal_init.sql` | 已执行 | 2026-08-28 |
| `inside_dev` | `proposal_menu.sql` | 已执行 | 2026-08-28 |
| `inside_dev` | `proposal_spex_user_seed.sql` | 已提供（含 org_code 修正） | 2026-08-28 |
| `inside_dev` | `proposal_config_seed.sql` | 已与管理端实配对齐（3 负责人 / 5 委员 / 1 批准人） | 2026-08-28 |
| `inside_dev` | `fix/20260828_fix_spex_org_code.sql` | 旧 SPX* 编码库需执行 | 2026-08-28 |

> 菜单授权：`admin`、`proposal_admin` 角色已在库内授权提案相关菜单（2026-08-28）。

## 变更流程

1. 改表/改字段 → 必须回写 `proposal_init.sql`（见 `.cursor/rules/improve/proposal-sql-ddl.mdc`）
2. 同步 `proposal_tables.md` + Java entity
3. 已有库另写 `fix/` 增量，且最终合并进 init
4. 联调样例账号/组织变更 → 只改 `proposal_spex_user_seed.sql`（**不要**写进 menu/init）

## 特性

- 角色 INSERT 使用 `WHERE NOT EXISTS`，可重复执行（幂等）
- 业务表使用 **`active` Y/N** 替代 Jeecg 默认 `del_flag`
- 唯一索引组合键**末位含 `tenant_id`**
- 用户/部门外键语义指向 `sys_user.id`、`sys_depart.id`
