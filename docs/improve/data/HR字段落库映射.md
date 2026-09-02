# HR 员工列表 — Excel 列与数据库落库映射

> **数据源**：[`员工列表20260822.xls`](./员工列表20260822.xls)（2026-08-22 版，共 **1355** 行员工）  
> **归档日期**：2026-09-02  
> **当前实现形态**：**全量 HR 种子已生成** — [`hr_user_seed_all.sql`](../sql/hr_user_seed_all.sql)（1355 人 + 102 组织节点）；按部门拆分见 [`hr_user_seed/`](../sql/hr_user_seed/)。重导前先跑 [`hr_user_purge.sql`](../sql/hr_user_purge.sql)。

---

## 1. Excel 全列清单（18 列）

| # | Excel 列名 | 示例（斯派科 / 600013 曾金） | 是否落库（当前规则） |
|---|------------|------------------------------|----------------------|
| 1 | 工号 | `600013` | ✅ 落库 |
| 2 | 姓名 | `曾金` | ✅ 落库 |
| 3 | 中心 | `斯派科` | ✅ 落库（组织树） |
| 4 | 部门 | `自动线开发部` | ✅ 落库（组织树） |
| 5 | 组别 | `MES开发` | ✅ 落库（组织树） |
| 6 | 部门简称 | `MES开发` | ❌ 未落库 |
| 7 | 所属小组编码 | `05010303` | ❌ 未落库 |
| 8 | 所属小组 | `MES开发` | ❌ 未落库 |
| 9 | 一级审批者工号 | `600013` | ❌ 未落库 |
| 10 | 一级审批者 | `曾金` | ❌ 未落库 |
| 11 | 二级审批者工号 | `600084` | ❌ 未落库 |
| 12 | 二级审批者 | `汪秦军` | ❌ 未落库 |
| 13 | 三级审批者工号 | `900001` | ❌ 未落库 |
| 14 | 三级审批者 | `徐国梁` | ❌ 未落库 |
| 15 | 岗位 | `高级主管` | ✅ 落库 |
| 16 | 职级代码 | `M9` | ❌ 未落库 |
| 17 | 职级 | `东莞职员高级主管/高级工程师（绩效）` | ❌ 未落库 |
| 18 | 聘用日期 | `2018-12-27` | ❌ 未落库 |

**Excel 组织分布（全表）：**

| 中心 | 人数 |
|------|------|
| 斯派科 | 45 |
| 智能制造中心 | 1310 |

> 当前 seed 只覆盖斯派科中的 **17** 人（联调样例），其余 **1328** 人及 Excel 中未映射列均未导入。

---

## 2. 总览：落库到哪几张表

```text
Excel「中心 / 部门 / 组别」  ──► sys_depart（3 级树 + org_code 系统生成）
Excel「工号 / 姓名 / 岗位」  ──► sys_user
组织归属（通常挂组别）      ──► sys_user_depart（user_id ↔ dep_id）
```

**不来自 Excel、由导入规则/种子脚本写入的：**

| 内容 | 落点 |
|------|------|
| 登录账号 | `sys_user.username` = Excel **工号** |
| 初始密码 | `sys_user.password` + `salt`（联调 seed 固定 `123456`） |
| 机构编码 | `sys_depart.org_code`、`sys_user.org_code`（Jeecg 3 位优编码，**非** Excel「所属小组编码」） |
| 提案委员/批准人/部门负责人 | `proposal_*` 配置表（管理端或 `proposal_config_seed.sql`，**非** Excel 审批者列） |

---

## 3. 逐列映射明细

### 3.1 组织树：`sys_depart`

| Excel 列 | DB 表 | DB 字段 | 规则 |
|----------|-------|---------|------|
| **中心** | `sys_depart` | `depart_name` | 第 1 级节点 |
| | | `org_type` | 固定 `'CENTER'` |
| | | `parent_id` | `NULL`（或 Jeecg 根下） |
| | | `org_code` | **系统生成**：斯派科 `S01*`、智能制造中心 `Z01*`（每级 3 位优编码） |
| | | `org_category` | seed 用 `'1'` |
| **部门** | `sys_depart` | `depart_name` | 第 2 级，父 = 中心 |
| | | `org_type` | 固定 `'DEPT'` |
| | | `parent_id` | 中心节点 `id` |
| | | `org_code` | **系统生成**（样例 `S01A01`） |
| | | `org_category` | seed 用 `'2'` |
| **组别** | `sys_depart` | `depart_name` | 第 3 级，父 = 部门 |
| | | `org_type` | 固定 `'GROUP'` |
| | | `parent_id` | 部门节点 `id` |
| | | `org_code` | **系统生成**（样例 `S01A01A01`、`S01A01A02`） |
| | | `org_category` | seed 用 `'2'` |
| | | `iz_leaf` | 组别一般为叶子 `1` |

**Jeecg `org_code` 约定**（与 Excel 无关）：

- 每级 **3 位**：1 字母 + 2 数字（如 `S01` → `S01A01` → `S01A01A01`）
- **禁止**直接把 Excel「所属小组编码」如 `05010303` 写入 `org_code`（长度/规则不兼容）
- 详见 [`../sql/README.md`](../sql/README.md) §Jeecg org_code

**斯派科样例组织树（已写入 seed）：**

```text
斯派科 (S01, CENTER)
└── 自动线开发部 (S01A01, DEPT)
    ├── MES开发 (S01A01A01, GROUP)
    └── 电气控制 (S01A01A02, GROUP)
```

### 3.2 用户：`sys_user`

| Excel 列 | DB 表 | DB 字段 | 规则 |
|----------|-------|---------|------|
| **工号** | `sys_user` | `work_no` | 原样；业务唯一键 |
| | `sys_user` | `username` | **必须等于工号**（登录账号） |
| **姓名** | `sys_user` | `realname` | 原样 |
| **岗位** | `sys_user` | `position_type` | 原样（如「高级主管」「JAVA开发工程师」） |
| — | `sys_user` | `org_code` | **冗余**：用户主属机构编码，一般 = 所挂 `sys_depart.org_code`（组别或部门级） |
| — | `sys_user` | `password` / `salt` | 导入时统一初始密码（seed：`123456`，Jeecg `PasswordUtil` 加密） |
| — | `sys_user` | `status` | 默认 `1` 正常；离职手工改 `2` 冻结 |
| — | `sys_user` | `del_flag` | 默认 `0` |
| — | `sys_user` | `user_identity` | seed：普通员工 `1`；副经理挂部门级时 `2` |
| — | `sys_user` | `sort` | seed 内手工排序，非 Excel 来源 |

**特殊规则（样例 seed 已出现）：**

- 绝大多数员工挂在 **组别**（`org_code` = 组别编码，如 `S01A01A01`）
- **汪秦军 600084** 为副经理，挂在 **部门级** `S01A01`，`sys_user_depart` 指向部门节点而非组别

### 3.3 用户-部门关联：`sys_user_depart`

| 来源 | DB 表 | DB 字段 | 规则 |
|------|-------|---------|------|
| Excel 中心+部门+组别推导 | `sys_user_depart` | `user_id` | `sys_user.id` |
| | `sys_user_depart` | `dep_id` | 通常 = **组别** `sys_depart.id`；部门级干部 = **部门** 节点 id |
| | `sys_user_depart` | `ID` | 主键（seed 内固定 id，幂等插入） |

展示时 Jeecg 按 `sys_user.org_code` / 部门树拼接「父部门 · 组别」。

---

## 4. 明确未落库的 Excel 列

| Excel 列 | 未落库原因 / 后续可考虑 |
|----------|-------------------------|
| 部门简称 | 与组别/部门名重复度高；当前用 `depart_name` 即可 |
| 所属小组编码 | HR 侧编码体系；与 Jeecg `org_code` 规则不同，未直接映射 |
| 所属小组 | 与「组别」列语义重叠；未单独建表 |
| 一级/二级/三级审批者（工号+姓名） | **提案审批链**走 `proposal_dept_leader` / `proposal_committee_member` / `proposal_approver` 配置，不用 HR 审批列 |
| 职级代码 / 职级 | Jeecg 无对应标准字段；若需要可扩展 `sys_user` 或字典 |
| 聘用日期 | 未纳入导入；可映射 `sys_user` 扩展字段或 `remark`（未做） |

---

## 5. 与提案业务表的关系（非 Excel 直导）

Excel **不会**直接写入以下表；联调由 [`proposal_config_seed.sql`](../sql/proposal_config_seed.sql) 或管理端配置：

| 业务配置 | 表 | 与 Excel 关系 |
|----------|-----|----------------|
| 改善部门负责人 | `proposal_dept_leader` | 从已导入 `sys_user` 中选人 |
| 委员会名册 | `proposal_committee_member` | 同上 |
| 批准人 | `proposal_approver` | 同上 |

inside_dev 实配示例（均须先存在 `sys_user`）：

| 角色 | 工号 | 姓名 |
|------|------|------|
| 部门负责人 | 600013 / 600084 / 600088 | 曾金 / 汪秦军 / 张小朋 |
| 批准人 | 600084 | 汪秦军 |
| 委员 | 600013 / 600026 / 600051 / 600088 / 600099 | 曾金 / 陈泽波 / 刘恋 / 张小朋 / 吴浪 |

---

## 6. 全量 seed 范围（1355 人）

| 脚本 | 说明 |
|------|------|
| [`hr_user_seed_all.sql`](../sql/hr_user_seed_all.sql) | 全表 1355 人 + 2 中心 / 17 部门 / 83 组别 |
| [`hr_user_seed/`](../sql/hr_user_seed/) | 17 个按「中心+部门」拆分文件 |
| [`hr_user_purge.sql`](../sql/hr_user_purge.sql) | 重导前清理旧 spex* 样例与 proposal 测试数据 |

密码：`123456` · `username = work_no` · ID 为 19 位纯数字（非 `spexuser*` 前缀）

**斯派科联调关键账号**（`proposal_config_seed.sql` 引用）：

| 工号 | 姓名 | 组别 | 岗位 |
|------|------|------|------|
| 600013 | 曾金 | MES开发 | 高级主管 |
| 600026 | 陈泽波 | MES开发 | 高级MES开发工程师 |
| 600051 | 刘恋 | 电气控制 | 电气工程师 |
| 600084 | 汪秦军 | 自动线开发部（组别） | 副经理 |
| 600088 | 张小朋 | 电气控制 | 主任工程师 |
| 600099 | 吴浪 | MES开发 | JAVA开发工程师 |

> 电气控制组别 `org_code` 为 `S01A01A03`（按 Excel 部门下组别排序生成，与旧样例 `A02` 不同）。

---

## 7. 全量导入执行顺序

```text
1. hr_user_purge.sql          — 清理旧样例 + proposal 测试数据
2. hr_user_seed_all.sql       — 或按 hr_user_seed/*.sql 分批
3. proposal_config_seed.sql   — 联调负责人/委员/批准人（work_no 子查询）
```

重新生成 SQL：`python scripts/hr_seed_gen.py`（需 `jeecg-boot-base-core` 已编译）。

全量导入开发时，以本文件 + 本 Excel 为验收基准。

---

## 8. 关联文档

| 文档 | 说明 |
|------|------|
| [README.md](./README.md) | 本目录入口 |
| [../提案改善系统-实施规划.md](../提案改善系统-实施规划.md) §9.3–9.5 | 组织/用户/HR 映射原则 |
| [../sql/README.md](../sql/README.md) | seed 执行顺序 |
| [../sql/hr_user_seed_all.sql](../sql/hr_user_seed_all.sql) | HR 全量 SQL |
| [../progress/README.md](../progress/README.md) | 阶段进度 |

---

## 9. 变更记录

| 日期 | 说明 |
|------|------|
| 2026-09-02 | 初版：解析 Excel 18 列；明确 6 列落库 + 12 列未落库 |
| 2026-09-02 | 全量 HR 种子：`hr_user_seed_all.sql` + 17 拆分文件；`Z01*` 智能制造中心 |
