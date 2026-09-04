-- =============================================================================
-- 对齐个人库 47.107.78.177/inside_dev ← 公司库 192.168.123.101/inside_dev
-- 范围：提案配置按钮权限（parent_id = 2094103000000000003）
-- 公司库已复核：委员会-添加 perms = proposal:config:committee:add
-- 执行库：个人 inside_dev；执行后重新登录清权限缓存
-- =============================================================================

SET NAMES utf8mb4;

-- -----------------------------------------------------------------------------
-- 1) 删除个人库多余项（公司库无）
-- -----------------------------------------------------------------------------
DELETE FROM `sys_role_permission`
WHERE `permission_id` IN (
  '2094103000000000008',  -- 旧部门负责人-删除 id（公司库改用 2095669402780868610）
  '2094103000000000009',  -- 委员会-保存（改用 add/edit）
  '2094103000000000012'   -- 批准人-删除（公司库无）
);

DELETE FROM `sys_permission`
WHERE `id` IN (
  '2094103000000000008',
  '2094103000000000009',
  '2094103000000000012'
);

-- -----------------------------------------------------------------------------
-- 2) 已有同 id：按公司库改 name / perms
-- -----------------------------------------------------------------------------
UPDATE `sys_permission`
SET `name` = '批准人-配置', `perms` = 'proposal:config:approver:save',
    `update_by` = 'admin', `update_time` = NOW()
WHERE `id` = '2094103000000000011';

UPDATE `sys_permission`
SET `name` = '改善性质-添加', `perms` = 'proposal:config:improvementType:add',
    `update_by` = 'admin', `update_time` = NOW()
WHERE `id` = '2094103000000000015';

UPDATE `sys_permission`
SET `name` = '评分维度-新增', `perms` = 'proposal:config:scoreDimension:add',
    `update_by` = 'admin', `update_time` = NOW()
WHERE `id` = '2094103000000000013';

UPDATE `sys_permission`
SET `name` = '部门负责人-保存', `perms` = 'proposal:config:deptLeader:save',
    `update_by` = 'admin', `update_time` = NOW()
WHERE `id` = '2094103000000000007';

UPDATE `sys_permission`
SET `name` = '委员会-删除', `perms` = 'proposal:config:committee:delete',
    `update_by` = 'admin', `update_time` = NOW()
WHERE `id` = '2094103000000000010';

UPDATE `sys_permission`
SET `name` = '改善性质-删除', `perms` = 'proposal:config:improvementType:delete',
    `update_by` = 'admin', `update_time` = NOW()
WHERE `id` = '2094103000000000016';

UPDATE `sys_permission`
SET `name` = '评分维度-删除', `perms` = 'proposal:config:scoreDimension:delete',
    `update_by` = 'admin', `update_time` = NOW()
WHERE `id` = '2094103000000000014';

UPDATE `sys_permission`
SET `name` = '首页标语-保存', `perms` = 'proposal:config:homeBroadcast:save',
    `update_by` = 'admin', `update_time` = NOW()
WHERE `id` = '2094103000000000017';

-- -----------------------------------------------------------------------------
-- 3) 插入公司库有、个人库可能没有的按钮（幂等）
-- -----------------------------------------------------------------------------
INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `create_by`, `create_time`, `update_by`, `update_time`,
  `del_flag`, `rule_flag`, `status`, `internal_or_external`
)
SELECT '2095666029281189890', '2094103000000000003', '委员会-添加', NULL, NULL, 0, NULL, NULL,
       2, 'proposal:config:committee:add', '1', NULL, 0, NULL,
       1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2095666029281189890');

-- 若该 id 已存在但 perms 曾配错，强制纠正
UPDATE `sys_permission`
SET `name` = '委员会-添加', `perms` = 'proposal:config:committee:add',
    `parent_id` = '2094103000000000003', `menu_type` = 2,
    `update_by` = 'admin', `update_time` = NOW()
WHERE `id` = '2095666029281189890';

INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `create_by`, `create_time`, `update_by`, `update_time`,
  `del_flag`, `rule_flag`, `status`, `internal_or_external`
)
SELECT '2095667544930689025', '2094103000000000003', '委员会-编辑', NULL, NULL, 0, NULL, NULL,
       2, 'proposal:config:committee:edit', '1', NULL, 0, NULL,
       1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2095667544930689025');

INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `create_by`, `create_time`, `update_by`, `update_time`,
  `del_flag`, `rule_flag`, `status`, `internal_or_external`
)
SELECT '2095667812799913986', '2094103000000000003', '改善性质-编辑', NULL, NULL, 0, NULL, NULL,
       2, 'proposal:config:improvementType:edit', '1', NULL, 0, NULL,
       1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2095667812799913986');

INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `create_by`, `create_time`, `update_by`, `update_time`,
  `del_flag`, `rule_flag`, `status`, `internal_or_external`
)
SELECT '2095668717456760833', '2094103000000000003', '评分维度-编辑', NULL, NULL, 0, NULL, NULL,
       2, 'proposal:config:scoreDimension:edit', '1', NULL, 0, NULL,
       1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2095668717456760833');

INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `create_by`, `create_time`, `update_by`, `update_time`,
  `del_flag`, `rule_flag`, `status`, `internal_or_external`
)
SELECT '2095669402780868610', '2094103000000000003', '部门负责人-删除', NULL, NULL, 0, NULL, NULL,
       2, 'proposal:config:deptLeader:delete', '1', NULL, 0, NULL,
       1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2095669402780868610');

-- -----------------------------------------------------------------------------
-- 4) admin / proposal_admin 授权（幂等）
-- -----------------------------------------------------------------------------
INSERT INTO `sys_role_permission` (`id`, `role_id`, `permission_id`)
SELECT MD5(CONCAT(r.id, '#', p.id)), r.id, p.id
FROM `sys_role` r
JOIN `sys_permission` p ON p.id IN (
  '2094103000000000007',
  '2094103000000000010',
  '2094103000000000011',
  '2094103000000000013',
  '2094103000000000014',
  '2094103000000000015',
  '2094103000000000016',
  '2094103000000000017',
  '2095666029281189890',
  '2095667544930689025',
  '2095667812799913986',
  '2095668717456760833',
  '2095669402780868610'
)
WHERE r.role_code IN ('admin', 'proposal_admin')
  AND NOT EXISTS (
    SELECT 1 FROM `sys_role_permission` rp
    WHERE rp.role_id = r.id AND rp.permission_id = p.id
  );

-- -----------------------------------------------------------------------------
-- 5) 核对（可选，应 13 条）
-- SELECT id, name, perms FROM sys_permission
-- WHERE parent_id = '2094103000000000003' AND menu_type = 2
-- ORDER BY name;
