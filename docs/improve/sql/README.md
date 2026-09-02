# 提案改善 — 数据库脚本

## 文件职责（勿混用）

| 脚本 | 职责 | 新环境是否必跑 |
|------|------|----------------|
| `proposal_init.sql` | **业务表 DDL** + 角色 + 改善性质 / 评分维度种子 | ✅ 必跑 |
| `proposal_menu.sql` | **管理端菜单/按钮**（`sys_permission`） | ✅ 必跑 |
| `hr_user_purge.sql` | **重导前清理**：旧 spex* 样例、S01/Z01 组织、proposal 测试数据 | ⭕ 重导 HR 时先跑 |
| `hr_user_seed_all.sql` | **HR 全量**：1355 人 + 102 组织节点（2 中心 / 17 部门 / 83 组别） | ⭕ 开发/联调建议跑 |
| `hr_user_seed/*.sql` | 按「中心 + 部门」拆分的 17 份（内容与 all 一致，便于分批） | ⭕ 按需 |
| `proposal_config_seed.sql` | 联调配置：部门负责人 / 委员会 / 批准人（`work_no`/`org_code` 子查询） | ⭕ 跑完 HR 种子后执行 |
| `fix/*.sql` | 已有库增量修复（勿当全量） | 仅旧库需要时 |
| `proposal_tables.md` | 表结构文档（与 init 同步） | 文档 |
| `hr_quick_queries.md` | **HR 组织/员工快捷 SQL**（按中心部门查人、按 id 展树） | 文档 |

> **不要把人员/组织种子写进 `proposal_menu.sql`**——菜单与样例数据职责分离。  
> 旧版 `proposal_spex_user_seed.sql` / `proposal_spex_elc_user_seed.sql` 已删除，请只用 `hr_user_seed_*`。

## 新环境 / 重导 HR 执行顺序

```bash
# 1. Jeecg 基础库（若尚未导入）
# mysql -u root -p inside_dev < jeecg-boot/db/jeecgboot-mysql-5.7.sql

# 2. 提案业务表 + 角色 + 改善性质 / 六维种子
mysql -u root -p inside_dev < docs/improve/sql/proposal_init.sql

# 3. 管理端菜单权限
mysql -u root -p inside_dev < docs/improve/sql/proposal_menu.sql

# 4.（重导时）清理旧样例 + proposal 测试数据
mysql -u root -p inside_dev < docs/improve/sql/hr_user_purge.sql

# 5. HR 全量组织 + 1355 用户（或按部门跑 hr_user_seed/*.sql）
mysql -u root -p inside_dev < docs/improve/sql/hr_user_seed_all.sql

# 6. 联调配置名册 — 部门负责人/委员会/批准人
mysql -u root -p inside_dev < docs/improve/sql/proposal_config_seed.sql
```

执行后还需：管理端给 `admin` / `proposal_admin` **授权提案菜单**。配置种子执行后也可在「提案配置」中核对/调整。

## Jeecg `org_code` 优编码约定（重要）

Jeecg 部门编码为 **每级固定 3 位** = `1 个字母 + 2 位数字`（如 `A01`、`S01A01A01`）：

| 项 | 说明 |
|----|------|
| 同级容量 | 字母 A–Z × 数字 01–99 ≈ **26×99 = 2574** 个兄弟节点 |
| 下级 | 在父编码后追加 3 位，如父 `S01` → 子 `S01A01`、`S01A02`… |
| HR 导入前缀 | **斯派科** `S01*`；**智能制造中心** `Z01*`（避免与其它中心冲突） |
| 禁止 | 自造非 3 倍数长度编码；勿把 Excel「所属小组编码」写入 `org_code` |

## ID 与密码约定（HR 种子）

| 项 | 规则 |
|----|------|
| `sys_user.id` / `sys_depart.id` | 19 位纯数字（确定性生成，非 `spexuser*` / `spexdept*`） |
| `username` | = Excel 工号 |
| 初始密码 | 统一 `123456`（Jeecg `PasswordUtil.encrypt(username, '123456', salt)`） |
| 重新生成 | `python scripts/hr_seed_gen.py`（需已编译 `jeecg-boot-base-core`） |

## 规则文档

| 路径 | 说明 |
|------|------|
| `.cursor/rules/improve/proposal-sql-ddl.mdc` | Cursor Agent DDL 变更规则 |
| `proposal_tables.md` §通用字段说明 | 11 项公共字段、`active` 逻辑删除、`tenant_id` 唯一索引后缀 |
| `../data/HR字段落库映射.md` | Excel 18 列 ↔ 库表映射 |

## 执行前提

1. 已导入 JeecgBoot 基础库（如 `jeecg-boot/db/jeecgboot-mysql-5.7.sql`）
2. **Flyway 已关闭**（`spring.flyway.enabled: false`），脚本需手工执行

## 变更流程

1. 改表/改字段 → 必须回写 `proposal_init.sql`（见 `.cursor/rules/improve/proposal-sql-ddl.mdc`）
2. 同步 `proposal_tables.md` + Java entity
3. 已有库另写 `fix/` 增量，且最终合并进 init
4. HR Excel 变更 → 重跑 `scripts/hr_seed_gen.py`，提交生成的 SQL

## 特性

- 角色 / HR / 配置 INSERT 使用 `WHERE NOT EXISTS`，可重复执行（幂等）
- 业务表使用 **`active` Y/N** 替代 Jeecg 默认 `del_flag`
- 唯一索引组合键**末位含 `tenant_id`**
- 用户/部门外键语义指向 `sys_user.id`、`sys_depart.id`
