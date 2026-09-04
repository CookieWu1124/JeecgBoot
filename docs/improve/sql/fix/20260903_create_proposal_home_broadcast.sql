-- -----------------------------------------------------------------------------
-- 首页小广播标语（全局一条 / 租户一行）
-- 目标库：inside_dev（手工执行）
-- 幂等：可重复执行
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `proposal_home_broadcast` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `content` varchar(200) NOT NULL DEFAULT '' COMMENT '标语文案',
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
  KEY `idx_proposal_home_broadcast_active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='首页小广播标语';

-- 已建库若仍带 uk_proposal_home_broadcast_tenant，请另执行 20260903_drop_proposal_home_broadcast_uk.sql

INSERT INTO `proposal_home_broadcast` (`id`, `content`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`)
SELECT '2094102200000000001', '人人参与改善 · 点滴汇聚效益', 'admin', NOW(), 'admin', NOW(), '', 'Y'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `proposal_home_broadcast` WHERE `id` = '2094102200000000001');

-- 按钮权限（挂在提案配置菜单下，不新建菜单）
INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000017', '2094103000000000003', '首页标语-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:homeBroadcast:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000017');

-- 按角色分别授权：勿用 UUID() 一次插多行（MySQL 可能只算一次 UUID，主键冲突）
INSERT INTO `sys_role_permission` (`id`, `role_id`, `permission_id`)
SELECT MD5(CONCAT(r.id, '#2094103000000000017')), r.id, '2094103000000000017'
FROM `sys_role` r
WHERE r.role_code IN ('admin', 'proposal_admin')
  AND NOT EXISTS (
    SELECT 1 FROM `sys_role_permission` rp
    WHERE rp.role_id = r.id AND rp.permission_id = '2094103000000000017'
  );
