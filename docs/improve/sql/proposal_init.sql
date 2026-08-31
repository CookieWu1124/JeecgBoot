-- =============================================================================
-- 提案改善系统 — Phase 1 数据库初始化脚本
-- 版本：V1.4
-- 日期：2026-08-31
-- 说明：
--   1. 用户/角色/组织复用 JeecgBoot sys_* 表，本脚本建提案配置表 + 业务表
--   2. 业务表通用字段约定见 docs/improve/sql/proposal_tables.md
--   3. 登录：username = work_no，POST /sys/login，与管理端共用 JWT
--   4. 委员会：动态名册；审核=在任全员；评分=score_enabled=1 子集（方案③）
--   5. 执行前请确保已导入 jeecgboot-mysql 基础库
--   6. 路径：docs/improve/sql/proposal_init.sql（手工执行，Flyway 已关闭）
-- =============================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------------------------------
-- 一、提案业务角色（sys_role 初始化，幂等）
-- -----------------------------------------------------------------------------

INSERT INTO `sys_role` (`id`, `role_name`, `role_code`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`)
SELECT 'pr0p0sa1001committee000000000001', '提案-委员', 'proposal_committee', '提案改善系统：申请/计划书委员审核；粗权限可选，业务待办读委员会名册', 'admin', NOW(), 'admin', NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_role` WHERE `role_code` = 'proposal_committee');

INSERT INTO `sys_role` (`id`, `role_name`, `role_code`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`)
SELECT 'pr0p0sa1002approver000000000001', '提案-批准人', 'proposal_approver', '提案改善系统：申请批准/计划书批准/报告书签核；实际批准人读配置表', 'admin', NOW(), 'admin', NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_role` WHERE `role_code` = 'proposal_approver');

INSERT INTO `sys_role` (`id`, `role_name`, `role_code`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`)
SELECT 'pr0p0sa1003deptleader00000000001', '提案-部门负责人', 'proposal_dept_leader', '提案改善系统：任务指派/部门任务池；实际负责人读按部门配置', 'admin', NOW(), 'admin', NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_role` WHERE `role_code` = 'proposal_dept_leader');

INSERT INTO `sys_role` (`id`, `role_name`, `role_code`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`)
SELECT 'pr0p0sa1005admin0000000000000001', '提案-管理员', 'proposal_admin', '提案改善系统：后台配置与统计', 'admin', NOW(), 'admin', NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_role` WHERE `role_code` = 'proposal_admin');

-- -----------------------------------------------------------------------------
-- 二、提案配置表（管理端「提案配置」维护，业务名册来源）
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS `proposal_dept_leader`;
CREATE TABLE `proposal_dept_leader` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `dept_id` varchar(36) NOT NULL COMMENT '改善部门 sys_depart.id',
  `leader_user_id` varchar(36) DEFAULT NULL COMMENT '部门负责人 sys_user.id，可空表示未配置',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_proposal_dept_leader_dept` (`dept_id`, `tenant_id`),
  KEY `idx_proposal_dept_leader_user` (`leader_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='改善部门负责人配置';

DROP TABLE IF EXISTS `proposal_committee_member`;
CREATE TABLE `proposal_committee_member` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `user_id` varchar(36) NOT NULL COMMENT '委员 sys_user.id（不加 role_id）',
  `score_enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否参与六维评分 0否1是',
  `seat_no` int DEFAULT NULL COMMENT '评分席位号；score_enabled=0 时为空',
  `member_status` varchar(16) NOT NULL DEFAULT 'active' COMMENT '在任状态 active/inactive',
  `sort_no` int DEFAULT 0 COMMENT '排序',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_proposal_committee_member_user` (`user_id`, `tenant_id`),
  KEY `idx_proposal_committee_member_status` (`member_status`),
  KEY `idx_proposal_committee_member_score` (`score_enabled`, `seat_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提案委员会名册';

DROP TABLE IF EXISTS `proposal_approver`;
CREATE TABLE `proposal_approver` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `user_id` varchar(36) NOT NULL COMMENT '批准人 sys_user.id',
  `approver_status` varchar(16) NOT NULL DEFAULT 'active' COMMENT '启用状态 active/inactive',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  KEY `idx_proposal_approver_user` (`user_id`),
  KEY `idx_proposal_approver_status` (`approver_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提案批准人配置';

DROP TABLE IF EXISTS `proposal_improvement_type`;
CREATE TABLE `proposal_improvement_type` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `type_code` varchar(32) NOT NULL COMMENT '性质编码 如 SAFETY，创建后不可改',
  `type_name` varchar(64) NOT NULL COMMENT '性质名称',
  `description` varchar(200) DEFAULT NULL COMMENT '性质说明',
  `sort_no` int DEFAULT 0 COMMENT '排序',
  `type_status` varchar(16) NOT NULL DEFAULT 'active' COMMENT '启用状态 active/disabled',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_proposal_improvement_type_code` (`type_code`, `tenant_id`),
  KEY `idx_proposal_improvement_type_status` (`type_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='改善性质配置';

-- 默认五类改善性质（幂等；与现网码一致）
INSERT INTO `proposal_improvement_type` (`id`, `type_code`, `type_name`, `description`, `sort_no`, `type_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2101safety00000000000001', 'SAFETY', '安全改善', '安全隐患、防护、作业规范等改善', 1, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_improvement_type` WHERE `type_code` = 'SAFETY' AND `tenant_id` = '');

INSERT INTO `proposal_improvement_type` (`id`, `type_code`, `type_name`, `description`, `sort_no`, `type_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2102quality0000000000001', 'QUALITY', '品质改善', '质量、不良、检验与标准相关改善', 2, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_improvement_type` WHERE `type_code` = 'QUALITY' AND `tenant_id` = '');

INSERT INTO `proposal_improvement_type` (`id`, `type_code`, `type_name`, `description`, `sort_no`, `type_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2103efficiency0000000001', 'EFFICIENCY', '效率改善', '节拍、工时、流程效率相关改善', 3, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_improvement_type` WHERE `type_code` = 'EFFICIENCY' AND `tenant_id` = '');

INSERT INTO `proposal_improvement_type` (`id`, `type_code`, `type_name`, `description`, `sort_no`, `type_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2104delivery000000000001', 'DELIVERY', '交付改善', '交期、齐套、物流与响应相关改善', 4, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_improvement_type` WHERE `type_code` = 'DELIVERY' AND `tenant_id` = '');

INSERT INTO `proposal_improvement_type` (`id`, `type_code`, `type_name`, `description`, `sort_no`, `type_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2105cost0000000000000001', 'COST', '成本改善', '物料、能耗、浪费与费用相关改善', 5, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_improvement_type` WHERE `type_code` = 'COST' AND `tenant_id` = '');

DROP TABLE IF EXISTS `proposal_score_dimension`;
CREATE TABLE `proposal_score_dimension` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `dim_code` varchar(32) NOT NULL COMMENT '维度编码 如 tangible/spread',
  `dim_name` varchar(64) NOT NULL COMMENT '维度名称',
  `description` varchar(200) DEFAULT NULL COMMENT '维度说明',
  `weight_pct` int NOT NULL DEFAULT 0 COMMENT '权重百分比',
  `sort_no` int DEFAULT 0 COMMENT '排序',
  `dim_status` varchar(16) NOT NULL DEFAULT 'active' COMMENT '启用状态 active/disabled',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_proposal_score_dimension_code` (`dim_code`, `tenant_id`),
  KEY `idx_proposal_score_dimension_status` (`dim_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='六维评分维度配置';

-- 默认六维评分配置（幂等）
INSERT INTO `proposal_score_dimension` (`id`, `dim_code`, `dim_name`, `description`, `weight_pct`, `sort_no`, `dim_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2001tangible000000000001', 'tangible', '有形绩效', '节约金额、效率提升、成本降低等可量化收益', 30, 1, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_score_dimension` WHERE `dim_code` = 'tangible' AND `tenant_id` = '');

INSERT INTO `proposal_score_dimension` (`id`, `dim_code`, `dim_name`, `description`, `weight_pct`, `sort_no`, `dim_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2002intangible00000000001', 'intangible', '无形绩效', '安全、质量、士气、客户体验等非直接金额收益', 10, 2, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_score_dimension` WHERE `dim_code` = 'intangible' AND `tenant_id` = '');

INSERT INTO `proposal_score_dimension` (`id`, `dim_code`, `dim_name`, `description`, `weight_pct`, `sort_no`, `dim_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2003difficulty00000000001', 'difficulty', '难易度', '问题复杂度、跨部门协同难度和落地阻力', 20, 3, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_score_dimension` WHERE `dim_code` = 'difficulty' AND `tenant_id` = '');

INSERT INTO `proposal_score_dimension` (`id`, `dim_code`, `dim_name`, `description`, `weight_pct`, `sort_no`, `dim_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2004thinking0000000000001', 'thinking', '思考性', '问题分析深度、方案完整性和逻辑性', 10, 4, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_score_dimension` WHERE `dim_code` = 'thinking' AND `tenant_id` = '');

INSERT INTO `proposal_score_dimension` (`id`, `dim_code`, `dim_name`, `description`, `weight_pct`, `sort_no`, `dim_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2005spread000000000000001', 'spread', '推广性', '是否可复制到其他产线、部门或类似场景', 15, 5, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_score_dimension` WHERE `dim_code` = 'spread' AND `tenant_id` = '');

INSERT INTO `proposal_score_dimension` (`id`, `dim_code`, `dim_name`, `description`, `weight_pct`, `sort_no`, `dim_status`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT 'pr0p0sa2006innovation000000000001', 'innovation', '创新性', '方案新颖程度、技术或管理方法创新', 15, 6, 'active', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_score_dimension` WHERE `dim_code` = 'innovation' AND `tenant_id` = '');

-- -----------------------------------------------------------------------------
-- 三、提案主表
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS `proposal`;
CREATE TABLE `proposal` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `proposal_no` varchar(20) DEFAULT NULL COMMENT '提案编号 YYYYMMDD+4位流水',
  `title` varchar(100) NOT NULL COMMENT '提案名称',
  `status` varchar(32) NOT NULL DEFAULT 'DRAFT' COMMENT '状态枚举',
  `improvement_types` varchar(200) DEFAULT NULL COMMENT '改善性质 JSON 数组',
  `dept_id` varchar(36) DEFAULT NULL COMMENT '改善部门 sys_depart.id',
  `dept_leader_id` varchar(36) DEFAULT NULL COMMENT '部门负责人 sys_user.id',
  `proposer_id` varchar(36) NOT NULL COMMENT '提案人 sys_user.id',
  `implement_leader_id` varchar(36) DEFAULT NULL COMMENT '实施负责人 sys_user.id',
  `team_type` varchar(16) DEFAULT NULL COMMENT 'PERSONAL/TEAM',
  `plan_required` tinyint(1) DEFAULT NULL COMMENT '是否形成计划书 0否1是',
  `award_amount` decimal(10,2) DEFAULT NULL COMMENT '核定提案奖金额',
  `plan_round` int DEFAULT 0 COMMENT '计划书当前轮次',
  `review_progress` varchar(16) DEFAULT NULL COMMENT '审核进度 如3/7（分母为快照审核人数）',
  `score_progress` varchar(16) DEFAULT NULL COMMENT '评分进度 如2/4（分母为快照评分人数）',
  `score_total` decimal(5,1) DEFAULT NULL COMMENT '加权总分',
  `score_grade` char(1) DEFAULT NULL COMMENT '评定等级 A/B/C/D',
  `filed_date` date DEFAULT NULL COMMENT '立案日期',
  `closed_date` date DEFAULT NULL COMMENT '结案日期',
  `version` int NOT NULL DEFAULT 0 COMMENT '乐观锁',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_proposal_no` (`proposal_no`, `tenant_id`),
  KEY `idx_proposal_status` (`status`),
  KEY `idx_proposal_proposer` (`proposer_id`),
  KEY `idx_proposal_dept` (`dept_id`),
  KEY `idx_proposal_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提案主表';

-- -----------------------------------------------------------------------------
-- 四、申请书
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS `proposal_application`;
CREATE TABLE `proposal_application` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `proposal_id` varchar(36) NOT NULL COMMENT '提案ID',
  `current_situation` text COMMENT '目前状况及问题',
  `improvement_suggestion` text COMMENT '改善意见',
  `submit_time` datetime DEFAULT NULL COMMENT '提交时间',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_proposal_application_proposal` (`proposal_id`, `tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提案申请书';

-- -----------------------------------------------------------------------------
-- 五、附件（现场图片等）
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS `proposal_attachment`;
CREATE TABLE `proposal_attachment` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `proposal_id` varchar(36) NOT NULL COMMENT '提案ID',
  `biz_type` varchar(32) NOT NULL DEFAULT 'APPLICATION_IMAGE' COMMENT '业务类型 APPLICATION_IMAGE等',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名',
  `file_url` varchar(500) NOT NULL COMMENT '文件地址',
  `file_size` bigint DEFAULT NULL COMMENT '文件大小字节',
  `sort_no` int DEFAULT 0 COMMENT '排序',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  KEY `idx_proposal_attachment_proposal` (`proposal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提案附件';

-- -----------------------------------------------------------------------------
-- 六、状态变更日志
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS `proposal_status_log`;
CREATE TABLE `proposal_status_log` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `proposal_id` varchar(36) NOT NULL COMMENT '提案ID',
  `from_status` varchar(32) DEFAULT NULL COMMENT '原状态',
  `to_status` varchar(32) NOT NULL COMMENT '新状态',
  `action` varchar(64) DEFAULT NULL COMMENT '动作编码',
  `operator_id` varchar(36) DEFAULT NULL COMMENT '操作人 sys_user.id',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注（含状态变更说明）',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  KEY `idx_proposal_status_log_proposal` (`proposal_id`),
  KEY `idx_proposal_status_log_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提案状态变更日志';

-- -----------------------------------------------------------------------------
-- 七、委员审核记录（申请阶段快照）
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS `proposal_committee_review`;
CREATE TABLE `proposal_committee_review` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `proposal_id` varchar(36) NOT NULL COMMENT '提案ID',
  `reviewer_id` varchar(36) NOT NULL COMMENT '委员 sys_user.id（提交时名册快照）',
  `conclusion` varchar(16) DEFAULT NULL COMMENT '审核结论 ADOPT/REJECT；未审为空',
  `plan_required` tinyint(1) DEFAULT NULL COMMENT '是否形成计划书建议（参考）0否1是',
  `award_suggestion` decimal(10,2) DEFAULT NULL COMMENT '建议奖励金额',
  `comment` text COMMENT '综合评价',
  `review_time` datetime DEFAULT NULL COMMENT '提交审核时间；未审为空',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_proposal_committee_review` (`proposal_id`, `reviewer_id`, `tenant_id`),
  KEY `idx_proposal_committee_review_reviewer` (`reviewer_id`),
  KEY `idx_proposal_committee_review_pending` (`proposal_id`, `conclusion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='委员审核记录（申请阶段快照）';

-- -----------------------------------------------------------------------------
-- 八、批准人决策记录（申请阶段）
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS `proposal_approval`;
CREATE TABLE `proposal_approval` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `proposal_id` varchar(36) NOT NULL COMMENT '提案ID',
  `approver_id` varchar(36) NOT NULL COMMENT '批准人 sys_user.id',
  `stage` varchar(32) NOT NULL DEFAULT 'APPLICATION' COMMENT '阶段 APPLICATION/PLAN/SIGNOFF',
  `decision` varchar(16) NOT NULL COMMENT 'APPROVE/REJECT',
  `plan_required` tinyint(1) DEFAULT NULL COMMENT '核定是否形成计划书 0否1是（批准时）',
  `award_amount` decimal(10,2) DEFAULT NULL COMMENT '核定提案奖金额（批准时）',
  `comment` text COMMENT '不批准原因或备注',
  `approve_time` datetime DEFAULT NULL COMMENT '决策时间',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_proposal_approval_stage` (`proposal_id`, `stage`, `tenant_id`),
  KEY `idx_proposal_approval_approver` (`approver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='批准人决策记录';

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- 状态枚举参考（应用层 ProposalStatusEnum，非数据库约束）：
-- DRAFT, PENDING_REVIEW, PENDING_APPROVAL, REJECTED_FINAL, WITHDRAWN,
-- PENDING_ASSIGN, PENDING_CLAIM, IN_PROGRESS, PLAN_PENDING_REVIEW,
-- PLAN_PENDING_APPROVAL, PLAN_REJECTED, PENDING_EVALUATION,
-- PENDING_SIGNOFF, COMPLETED
--
-- 改善性质：proposal_improvement_type 配置表（种子 SAFETY/QUALITY/EFFICIENCY/DELIVERY/COST）
--   提案主表 improvement_types 仍存 JSON 数组字符串，码必须是当前启用行
--
-- 配置表说明：
-- proposal_committee_member：member_status=active 在任委员参与审核；score_enabled=1 参与评分
-- proposal_dept_leader：按改善部门配置负责人，leader_user_id 可空
-- =============================================================================
