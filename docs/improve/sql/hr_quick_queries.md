# HR 组织 / 员工 — 快捷 SQL 查询

> **归档约定**：本文档是提案改善模块内 **人员/组织结构的只读快捷查询 SQL 唯一存放处**（Cursor 规则：`.cursor/rules/improve/proposal-hr-queries.mdc`）。新增/调整同类 SELECT 请写在本文件，勿散落 seed 或其它 md。

> **适用库**：`inside_dev`（及已执行 `hr_user_seed_all.sql` 的环境）  
> **组织模型**：`CENTER` → `DEPT` → `GROUP`（3 级，`sys_depart` + `sys_user_depart`）  
> **HR 前缀**：斯派科 `S01*` · 智能制造中心 `Z01*`

本文提供两类常用查询：

1. **按中心 / 部门（可含组别）查员工** — 一行尽量看清「是谁、在哪、什么岗、能否登录」  
2. **按父级节点 `id` 展开下级机构树** — 缩进展示，一眼看出层级与编码

---

## 0. 先找节点 id（可选）

按名称定位中心 / 部门，供 §2 传入 `@root_id`：

```sql
-- 查中心
SELECT id, depart_name, org_code, org_type
FROM sys_depart
WHERE del_flag = '0'
  AND org_type = 'CENTER'
  AND depart_name IN ('斯派科', '智能制造中心');

-- 查某中心下的部门（例：智能制造中心 → 品质部）
SELECT d.id, d.depart_name, d.org_code, d.org_type, c.depart_name AS center_name
FROM sys_depart d
JOIN sys_depart c ON c.id = d.parent_id AND c.del_flag = '0'
WHERE d.del_flag = '0'
  AND d.org_type = 'DEPT'
  AND c.depart_name = '智能制造中心'
  AND d.depart_name = '品质部';
```

---

## 1. 按中心 / 部门查员工（全貌一行）

### 1.1 主查询（改 WHERE 条件即可）

**说明**：

- 用户通过 `sys_user_depart` 挂在 **组别** 或 **部门**（极少数，如副经理挂部门级）
- `org_path` 为「中心 / 部门 / 组别」可读路径；挂部门级时组别列为 `(部门直属)`
- `status`：1 正常 · 2 冻结；`del_flag`：0 有效

```sql
SELECT
    u.id                                          AS user_id,
    u.username                                    AS work_no,
    u.realname                                    AS name,
    center.depart_name                            AS center_name,
    dept.depart_name                              AS dept_name,
    IFNULL(grp.depart_name, '(部门直属)')          AS group_name,
    CONCAT(
        center.depart_name, ' / ',
        dept.depart_name,
        IF(grp.depart_name IS NOT NULL, CONCAT(' / ', grp.depart_name), '')
    )                                             AS org_path,
    center.org_code                               AS center_org_code,
    dept.org_code                                 AS dept_org_code,
    IFNULL(grp.org_code, dept.org_code)           AS leaf_org_code,
    u.org_code                                    AS user_org_code,
    u.position_type                               AS position,
    CASE u.status WHEN 1 THEN '正常' WHEN 2 THEN '冻结' ELSE CONCAT('其他(', u.status, ')') END AS account_status,
    CASE u.user_identity WHEN 1 THEN '普通员工' WHEN 2 THEN '上级' ELSE CONCAT('身份(', u.user_identity, ')') END AS user_identity,
    u.phone,
    u.email,
    leaf.id                                       AS dep_id,
    leaf.org_type                                 AS dep_level,
    u.sort,
    u.create_time
FROM sys_user u
JOIN sys_user_depart ud ON ud.user_id = u.id
JOIN sys_depart leaf ON leaf.id = ud.dep_id AND leaf.del_flag = '0'
LEFT JOIN sys_depart grp
       ON grp.id = leaf.id AND grp.org_type = 'GROUP'
LEFT JOIN sys_depart dept
       ON dept.id = CASE
                        WHEN leaf.org_type = 'GROUP' THEN leaf.parent_id
                        WHEN leaf.org_type = 'DEPT'  THEN leaf.id
                      END
                  AND dept.del_flag = '0'
LEFT JOIN sys_depart center
       ON center.id = dept.parent_id AND center.del_flag = '0'
WHERE u.del_flag = 0
  -- ========== 筛选条件（按需保留/修改）==========
  AND center.depart_name = '智能制造中心'   -- 中心名；查斯派科则改为 '斯派科'
  AND dept.depart_name   = '品质部'         -- 部门名；查整个中心则注释本行
  -- AND grp.depart_name = 'HCNC组'         -- 可选：再限定组别
  -- AND u.username = '600013'              -- 可选：单个工号
ORDER BY dept.depart_name, grp.depart_order, grp.depart_name, u.sort, u.username;
```

### 1.2 按 `org_code` 前缀查（适合已知编码）

```sql
-- 例：智能制造中心 Z01 下全部；仅品质部 Z01A08 及其组别 Z01A08A*
SELECT
    u.username AS work_no,
    u.realname,
    u.org_code,
    u.position_type,
    d.depart_name AS attach_depart,
    d.org_code    AS attach_org_code,
    d.org_type
FROM sys_user u
JOIN sys_user_depart ud ON ud.user_id = u.id
JOIN sys_depart d ON d.id = ud.dep_id AND d.del_flag = '0'
WHERE u.del_flag = 0
  AND (d.org_code LIKE 'Z01A08%' OR u.org_code LIKE 'Z01A08%')
ORDER BY d.org_code, u.username;
```

### 1.3 汇总：某部门下各组别人数

```sql
SELECT
    center.depart_name AS center_name,
    dept.depart_name   AS dept_name,
    IFNULL(grp.depart_name, '(部门直属)') AS group_name,
    grp.org_code       AS group_org_code,
    COUNT(DISTINCT u.id) AS headcount
FROM sys_user u
JOIN sys_user_depart ud ON ud.user_id = u.id
JOIN sys_depart leaf ON leaf.id = ud.dep_id AND leaf.del_flag = '0'
LEFT JOIN sys_depart grp ON grp.id = leaf.id AND grp.org_type = 'GROUP'
LEFT JOIN sys_depart dept ON dept.id = IF(leaf.org_type = 'GROUP', leaf.parent_id, leaf.id) AND dept.del_flag = '0'
LEFT JOIN sys_depart center ON center.id = dept.parent_id AND center.del_flag = '0'
WHERE u.del_flag = 0
  AND center.depart_name = '智能制造中心'
  AND dept.depart_name   = '品质部'
GROUP BY center.depart_name, dept.depart_name, grp.depart_name, grp.org_code, grp.depart_order
ORDER BY grp.depart_order, grp.depart_name;
```

---

## 2. 按父级节点 id 展开机构树

### 2.1 固定 3 级展开（MySQL 5.7+ 通用，推荐）

传入 **`@root_id`**（中心或部门的 `sys_depart.id`），列出该节点及全部下级，带缩进与每层人数。

```sql
-- 使用前替换根节点 id（例：智能制造中心或品质部）
SET @root_id = '9372856559755238914';   -- ← 改成实际 id

SELECT
    t.level_no,
    t.tree_line,
    t.id,
    t.parent_id,
    t.depart_name,
    t.org_type,
    t.org_code,
    t.depart_order,
    t.iz_leaf,
    t.headcount
FROM (
    /* 第 0 层：根本身 */
    SELECT
        0 AS level_no,
        r.depart_name AS tree_line,
        r.id, r.parent_id, r.depart_name, r.org_type, r.org_code,
        r.depart_order, r.iz_leaf,
        (SELECT COUNT(DISTINCT ud.user_id)
         FROM sys_user_depart ud
         WHERE ud.dep_id = r.id) AS headcount
    FROM sys_depart r
    WHERE r.id = @root_id AND r.del_flag = '0'

    UNION ALL

    /* 第 1 层：直接子节点 */
    SELECT
        1,
        CONCAT('├── ', c1.depart_name),
        c1.id, c1.parent_id, c1.depart_name, c1.org_type, c1.org_code,
        c1.depart_order, c1.iz_leaf,
        (SELECT COUNT(DISTINCT ud.user_id) FROM sys_user_depart ud WHERE ud.dep_id = c1.id)
    FROM sys_depart c1
    WHERE c1.parent_id = @root_id AND c1.del_flag = '0'

    UNION ALL

    /* 第 2 层：孙子节点（组别） */
    SELECT
        2,
        CONCAT('│   ├── ', c2.depart_name),
        c2.id, c2.parent_id, c2.depart_name, c2.org_type, c2.org_code,
        c2.depart_order, c2.iz_leaf,
        (SELECT COUNT(DISTINCT ud.user_id) FROM sys_user_depart ud WHERE ud.dep_id = c2.id)
    FROM sys_depart c1
    JOIN sys_depart c2 ON c2.parent_id = c1.id AND c2.del_flag = '0'
    WHERE c1.parent_id = @root_id AND c1.del_flag = '0'

    UNION ALL

    /* 第 3 层：曾孙（HR 种子通常不到此层，预留） */
    SELECT
        3,
        CONCAT('│   │   ├── ', c3.depart_name),
        c3.id, c3.parent_id, c3.depart_name, c3.org_type, c3.org_code,
        c3.depart_order, c3.iz_leaf,
        (SELECT COUNT(DISTINCT ud.user_id) FROM sys_user_depart ud WHERE ud.dep_id = c3.id)
    FROM sys_depart c1
    JOIN sys_depart c2 ON c2.parent_id = c1.id AND c2.del_flag = '0'
    JOIN sys_depart c3 ON c3.parent_id = c2.id AND c3.del_flag = '0'
    WHERE c1.parent_id = @root_id AND c1.del_flag = '0'
) t
ORDER BY t.level_no, t.depart_order, t.org_code;
```

**读法示例**（根 = 品质部）：

```text
level  tree_line              org_type   org_code    headcount
0      品质部                 DEPT       Z01A08      0
1      ├── IQC                GROUP      Z01A08A01   12
1      ├── HCNC组             GROUP      Z01A08A02   111
2      │   ├── （若有更深层）  ...
```

### 2.2 按 `org_code` 前缀展开（不依赖 id）

已知中心 / 部门编码时，可直接用前缀拉整棵子树：

```sql
SET @root_org_code = 'Z01A08';   -- 例：品质部

SELECT
    CASE d.org_type
        WHEN 'CENTER' THEN d.depart_name
        WHEN 'DEPT'   THEN CONCAT('├── ', d.depart_name)
        WHEN 'GROUP'  THEN CONCAT('│   ├── ', d.depart_name)
        ELSE d.depart_name
    END AS tree_line,
    d.id,
    d.parent_id,
    d.depart_name,
    d.org_type,
    d.org_code,
    d.depart_order,
    (SELECT COUNT(DISTINCT ud.user_id) FROM sys_user_depart ud WHERE ud.dep_id = d.id) AS headcount
FROM sys_depart d
WHERE d.del_flag = '0'
  AND (d.org_code = @root_org_code OR d.org_code LIKE CONCAT(@root_org_code, '%'))
ORDER BY d.org_code;
```

### 2.3 MySQL 8.0+ 递归版（层级更深时）

`inside_dev` 若为 MySQL 8，可用 `WITH RECURSIVE` 不限深度：

```sql
SET @root_id = '9372856559755238914';

WITH RECURSIVE org_tree AS (
    SELECT
        d.id, d.parent_id, d.depart_name, d.org_type, d.org_code,
        d.depart_order, d.iz_leaf,
        0 AS level_no,
        CAST(d.depart_name AS CHAR(500)) AS tree_line
    FROM sys_depart d
    WHERE d.id = @root_id AND d.del_flag = '0'

    UNION ALL

    SELECT
        c.id, c.parent_id, c.depart_name, c.org_type, c.org_code,
        c.depart_order, c.iz_leaf,
        t.level_no + 1,
        CONCAT(t.tree_line, ' / ', c.depart_name)
    FROM sys_depart c
    JOIN org_tree t ON c.parent_id = t.id
    WHERE c.del_flag = '0'
)
SELECT
    level_no,
    CONCAT(REPEAT('    ', level_no), depart_name) AS tree_line,
    id, parent_id, depart_name, org_type, org_code, depart_order, iz_leaf,
    (SELECT COUNT(DISTINCT ud.user_id) FROM sys_user_depart ud WHERE ud.dep_id = org_tree.id) AS headcount
FROM org_tree
ORDER BY org_code;
```

---

## 3. 常用组合示例

| 场景 | 做法 |
|------|------|
| 斯派科 / 自动线开发部 全部员工 | §1.1：`center='斯派科'`, `dept='自动线开发部'` |
| 智能制造中心 / 品质部 / HCNC组 | §1.1：再加 `grp.depart_name='HCNC组'` |
| 只看某中心组织架构 | §0 查中心 `id` → §2.1 设 `@root_id` |
| 只看某部门下有哪些组 | §2.2：`@root_org_code='Z01A08'` |
| 部门各组编制分布 | §1.3 汇总 |

---

## 4. 注意

- **Jeecg 平台默认组织**（`A01*` 等 demo 树）与 HR 树（`S01*` / `Z01*`）并存；查 HR 时请用中心名或 `S01`/`Z01` 前缀，避免混淆。
- `headcount` 统计的是 **`sys_user_depart.dep_id` 直挂** 的人数；员工挂在组别，部门节点本身通常为 0。
- 微信绑定在 `sys_third_account`，不在上述员工全貌中；需要时可 `LEFT JOIN sys_third_account sta ON sta.sys_user_id = u.id AND sta.third_type = 'wechat_mp'`。

---

## 关联

| 文档 | 说明 |
|------|------|
| [../data/HR字段落库映射.md](../data/HR字段落库映射.md) | Excel ↔ 表字段 |
| [README.md](./README.md) | seed 执行顺序 |
| [hr_user_seed_all.sql](./hr_user_seed_all.sql) | 全量 HR 数据 |
