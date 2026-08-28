# 提案改善系统 — 业务表结构

> 数据库：MySQL 5.7+ | 字符集：utf8mb4 | 主键：varchar(36)，应用层 IdType.ASSIGN_ID 生成  
> 可执行 DDL：`proposal_init.sql`（V1.2）  
> Cursor 规则：`.cursor/rules/improve/proposal-sql-ddl.mdc`

## 目录

- [proposal_dept_leader](#proposal_dept_leader) — 改善部门负责人配置
- [proposal_committee_member](#proposal_committee_member) — 提案委员会名册
- [proposal_approver](#proposal_approver) — 提案批准人配置
- [proposal_score_dimension](#proposal_score_dimension) — 六维评分维度配置
- [proposal](#proposal) — 提案主表
- [proposal_application](#proposal_application) — 提案申请书
- [proposal_attachment](#proposal_attachment) — 提案附件
- [proposal_status_log](#proposal_status_log) — 提案状态变更日志

---

## 通用字段说明

除各表「业务字段」外，每张表均包含以下 11 个通用字段（下文不再重复列出）：

| 字段名 | 数据类型 | 允许空 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| `create_no` | varchar(50) | 是 | NULL | 创建人工号 |
| `create_by` | varchar(50) | 是 | NULL | 创建人名称 |
| `create_time` | datetime | 否 | CURRENT_TIMESTAMP | 创建日期 |
| `update_no` | varchar(50) | 是 | NULL | 更新人工号 |
| `update_by` | varchar(50) | 是 | NULL | 更新人名称 |
| `update_time` | datetime | 否 | CURRENT_TIMESTAMP ON UPDATE | 修改日期 |
| `sys_org_code` | varchar(64) | 是 | NULL | 所属部门 |
| `sys_org_name` | varchar(300) | 是 | NULL | 机构名称 |
| `tenant_id` | varchar(36) | 否 | '' | 租户ID |
| `remark` | varchar(300) | 是 | NULL | 备注 |
| `active` | varchar(4) | 是 | Y | 是否有效(逻辑删除取反)：N-否，Y-是 |

### 与 JeecgBoot 默认差异

| 项 | Jeecg 默认 | 本项目约定 |
|----|-----------|-----------|
| 逻辑删除 | `del_flag` 0/1 | `active` Y/N（取反语义） |
| 租户 | `tenant_id` int | `tenant_id` varchar(36) 默认空串 |
| 创建人 | 仅 `create_by` | 增加 `create_no`（工号）+ `create_by`（姓名） |
| 唯一索引 | 单字段 | **组合键末位加 `tenant_id`** |

### 提案编号规则

- 格式：`YYYYMMDD` + 4 位流水（不足左补 0），如 `202608280001`
- 取当日最大流水时**不要**加 `active='Y'`（软删记录仍占唯一键）

---

## proposal_dept_leader

**表说明**：改善部门负责人配置（管理端「提案配置 → 改善部门负责人」）

### 业务字段

| 字段名 | 数据类型 | 允许空 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | varchar(36) | 否 | 主键 |
| `dept_id` | varchar(36) | 否 | 改善部门 sys_depart.id |
| `leader_user_id` | varchar(36) | 是 | 负责人 sys_user.id，可空表示未配置 |

> 通用字段见 [通用字段说明](#通用字段说明)。

### 索引与约束

- **主键**：(`id`)
- **唯一索引** `uk_proposal_dept_leader_dept`：(`dept_id`, `tenant_id`)

---

## proposal_committee_member

**表说明**：提案委员会名册（动态人数；审核=在任全员；评分=score_enabled 子集）

### 业务字段

| 字段名 | 数据类型 | 允许空 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | varchar(36) | 否 | 主键 |
| `user_id` | varchar(36) | 否 | 委员 sys_user.id（不加 role_id） |
| `score_enabled` | tinyint(1) | 否 | 是否参与六维评分 0否1是 |
| `seat_no` | int | 是 | 评分席位号 |
| `member_status` | varchar(16) | 否 | 在任状态 active/inactive |
| `sort_no` | int | 是 | 排序 |

### 索引与约束

- **主键**：(`id`)
- **唯一索引** `uk_proposal_committee_member_user`：(`user_id`, `tenant_id`)

---

## proposal_approver

**表说明**：提案批准人配置（全局，通常 1 人）

### 业务字段

| 字段名 | 数据类型 | 允许空 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | varchar(36) | 否 | 主键 |
| `user_id` | varchar(36) | 否 | 批准人 sys_user.id |
| `approver_status` | varchar(16) | 否 | 启用状态 active/inactive |

### 索引与约束

- **主键**：(`id`)
- **普通索引** `idx_proposal_approver_user`：(`user_id`)

---

## proposal_score_dimension

**表说明**：六维评分维度配置（权重合计 100%）

### 业务字段

| 字段名 | 数据类型 | 允许空 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | varchar(36) | 否 | 主键 |
| `dim_code` | varchar(32) | 否 | 维度编码 tangible/spread 等 |
| `dim_name` | varchar(64) | 否 | 维度名称 |
| `description` | varchar(200) | 是 | 维度说明 |
| `weight_pct` | int | 否 | 权重百分比 |
| `sort_no` | int | 是 | 排序 |
| `dim_status` | varchar(16) | 否 | 启用状态 active/disabled |

### 索引与约束

- **主键**：(`id`)
- **唯一索引** `uk_proposal_score_dimension_code`：(`dim_code`, `tenant_id`)

---

## proposal

**表说明**：提案主表

### 业务字段

| 字段名 | 数据类型 | 允许空 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | varchar(36) | 否 | 主键 |
| `proposal_no` | varchar(20) | 是 | 提案编号（提交时生成） |
| `title` | varchar(100) | 否 | 提案名称 |
| `status` | varchar(32) | 否 | 状态枚举 |
| `improvement_types` | varchar(200) | 是 | 改善性质 JSON |
| `dept_id` | varchar(36) | 是 | 改善部门 |
| `dept_leader_id` | varchar(36) | 是 | 部门负责人 |
| `proposer_id` | varchar(36) | 否 | 提案人 |
| `implement_leader_id` | varchar(36) | 是 | 实施负责人 |
| `team_type` | varchar(16) | 是 | PERSONAL/TEAM |
| `plan_required` | tinyint(1) | 是 | 是否形成计划书 |
| `award_amount` | decimal(10,2) | 是 | 核定提案奖金额 |
| `plan_round` | int | 是 | 计划书轮次 |
| `review_progress` | varchar(16) | 是 | 审核进度 如 3/7 |
| `score_progress` | varchar(16) | 是 | 评分进度 如 2/4 |
| `score_total` | decimal(5,1) | 是 | 加权总分 |
| `score_grade` | char(1) | 是 | 评定等级 A/B/C/D |
| `filed_date` | date | 是 | 立案日期 |
| `closed_date` | date | 是 | 结案日期 |
| `version` | int | 否 | 乐观锁 |

### 索引与约束

- **主键**：(`id`)
- **唯一索引** `uk_proposal_no`：(`proposal_no`, `tenant_id`)

---

## proposal_application

**表说明**：提案申请书（与主表 1:1）

### 业务字段

| 字段名 | 数据类型 | 允许空 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | varchar(36) | 否 | 主键 |
| `proposal_id` | varchar(36) | 否 | 提案ID |
| `current_situation` | text | 是 | 目前状况及问题 |
| `improvement_suggestion` | text | 是 | 改善意见 |
| `email` | varchar(100) | 是 | 通知邮箱 |
| `submit_time` | datetime | 是 | 提交时间 |

### 索引与约束

- **主键**：(`id`)
- **唯一索引** `uk_proposal_application_proposal`：(`proposal_id`, `tenant_id`)

---

## proposal_attachment

**表说明**：提案附件（现场图片等）

### 业务字段

| 字段名 | 数据类型 | 允许空 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | varchar(36) | 否 | 主键 |
| `proposal_id` | varchar(36) | 否 | 提案ID |
| `biz_type` | varchar(32) | 否 | 业务类型 APPLICATION_IMAGE 等 |
| `file_name` | varchar(255) | 是 | 文件名 |
| `file_url` | varchar(500) | 否 | 文件地址 |
| `file_size` | bigint | 是 | 文件大小字节 |
| `sort_no` | int | 是 | 排序 |

### 索引与约束

- **主键**：(`id`)
- **普通索引** `idx_proposal_attachment_proposal`：(`proposal_id`)

---

## proposal_status_log

**表说明**：提案状态变更日志

### 业务字段

| 字段名 | 数据类型 | 允许空 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | varchar(36) | 否 | 主键 |
| `proposal_id` | varchar(36) | 否 | 提案ID |
| `from_status` | varchar(32) | 是 | 原状态 |
| `to_status` | varchar(32) | 否 | 新状态 |
| `action` | varchar(64) | 是 | 动作编码 SUBMIT/WITHDRAW 等 |
| `operator_id` | varchar(36) | 是 | 操作人 sys_user.id |

> 状态变更说明写入通用字段 `remark`。

### 索引与约束

- **主键**：(`id`)
- **普通索引** `idx_proposal_status_log_proposal`：(`proposal_id`)
