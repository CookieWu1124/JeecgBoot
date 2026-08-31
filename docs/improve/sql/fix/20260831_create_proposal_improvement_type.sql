-- =============================================================================
-- 增量：改善性质配置表 proposal_improvement_type + 菜单按钮权限
-- 库：inside_dev（已有业务数据，勿整库重跑 proposal_init.sql）
-- 幂等：CREATE TABLE IF NOT EXISTS / INSERT WHERE NOT EXISTS
-- =============================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `proposal_improvement_type` (
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

-- 提案配置：改善性质按钮（id 均 32 字符；不跑整份 menu.sql，避免清掉已授权按钮）
INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3015cftys0000000000000001', 'pr0p0sa3003config000000000000001', '改善性质-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:improvementType:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3015cftys0000000000000001');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3016cftyd0000000000000001', 'pr0p0sa3003config000000000000001', '改善性质-删除', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:improvementType:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3016cftyd0000000000000001');

-- 给 admin / proposal_admin 授权新按钮（幂等）
INSERT INTO `sys_role_permission` (`id`, `role_id`, `permission_id`)
SELECT REPLACE(UUID(), '-', ''), r.id, p.id
FROM `sys_role` r
JOIN `sys_permission` p ON p.id IN ('pr0p0sa3015cftys0000000000000001', 'pr0p0sa3016cftyd0000000000000001')
WHERE r.role_code IN ('admin', 'proposal_admin')
  AND NOT EXISTS (
    SELECT 1 FROM `sys_role_permission` rp
    WHERE rp.role_id = r.id AND rp.permission_id = p.id
  );
