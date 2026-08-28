-- =============================================================================
-- 提案改善系统 — 管理端菜单与按钮权限（sys_permission）
-- 目标库：inside_dev（与 application-dev.yml 一致）
-- 说明：
--   1. 页面组件位于 jeecgboot-vue3/src/views/proposal/
--   2. sys_permission.id 为 varchar(32)，所有 ID 必须 ≤32 字符
--   3. 使用固定 ID + NOT EXISTS，可重复执行（幂等）
--   4. 执行后请在「角色管理」为 admin / proposal_admin 等角色授权菜单
--   5. 若菜单不显示，请退出重新登录或刷新权限缓存
-- =============================================================================

SET NAMES utf8mb4;

-- 若曾执行过旧版（ID 超长失败/截断），先清理已插入的按钮权限后重插
DELETE FROM `sys_role_permission`
WHERE `permission_id` IN (
  SELECT `id` FROM (
    SELECT `id` FROM `sys_permission`
    WHERE `parent_id` IN ('pr0p0sa3002manage00000000000001', 'pr0p0sa3003config000000000000001')
      AND `menu_type` = 2
  ) t
);
DELETE FROM `sys_permission`
WHERE `parent_id` IN ('pr0p0sa3002manage00000000000001', 'pr0p0sa3003config000000000000001')
  AND `menu_type` = 2;

-- 一级目录：提案改善（id 长度 30）
INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`
)
SELECT
  'pr0p0sa3001menu000000000000001', NULL, '提案改善', '/proposal', 'layouts/RouteView', NULL, NULL,
  0, NULL, '0', 20.0, 0, 'ant-design:bulb-outlined',
  1, 0, 0, 0, 0, 'SPEX 提案改善系统管理端',
  '1', 0, 0, 'admin', NOW(), NULL, NULL, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3001menu000000000000001');

-- 二级菜单：提案管理（id 长度 31）
INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`
)
SELECT
  'pr0p0sa3002manage00000000000001', 'pr0p0sa3001menu000000000000001', '提案管理', '/proposal/manage', 'proposal/manage/index', NULL, NULL,
  1, NULL, '1', 1.0, 0, NULL,
  1, 0, 0, 0, 0, NULL,
  '1', 0, 0, 'admin', NOW(), NULL, NULL, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3002manage00000000000001');

-- 二级菜单：提案配置（id 长度 32）
INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`
)
SELECT
  'pr0p0sa3003config000000000000001', 'pr0p0sa3001menu000000000000001', '提案配置', '/proposal/config', 'proposal/config/index', NULL, NULL,
  1, NULL, '1', 2.0, 0, NULL,
  1, 0, 0, 0, 0, NULL,
  '1', 0, 0, 'admin', NOW(), NULL, NULL, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3003config000000000000001');

-- -----------------------------------------------------------------------------
-- 提案管理 — 按钮权限（id 均 32 字符）
-- -----------------------------------------------------------------------------
INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3004mgadd0000000000000001', 'pr0p0sa3002manage00000000000001', '添加提案', NULL, NULL, 0, NULL, NULL, 2, 'proposal:manage:add', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3004mgadd0000000000000001');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3005mgedt0000000000000001', 'pr0p0sa3002manage00000000000001', '编辑提案', NULL, NULL, 0, NULL, NULL, 2, 'proposal:manage:edit', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3005mgedt0000000000000001');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3006mgdel0000000000000001', 'pr0p0sa3002manage00000000000001', '删除提案', NULL, NULL, 0, NULL, NULL, 2, 'proposal:manage:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3006mgdel0000000000000001');

-- -----------------------------------------------------------------------------
-- 提案配置 — 按钮权限（四 Tab，id 均 32 字符）
-- -----------------------------------------------------------------------------
INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3007cfdls0000000000000001', 'pr0p0sa3003config000000000000001', '部门负责人-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:deptLeader:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3007cfdls0000000000000001');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3008cfdld0000000000000001', 'pr0p0sa3003config000000000000001', '部门负责人-删除', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:deptLeader:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3008cfdld0000000000000001');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3009cfcms0000000000000001', 'pr0p0sa3003config000000000000001', '委员会-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:committee:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3009cfcms0000000000000001');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3010cfcmd0000000000000001', 'pr0p0sa3003config000000000000001', '委员会-删除', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:committee:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3010cfcmd0000000000000001');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3011cfaps0000000000000001', 'pr0p0sa3003config000000000000001', '批准人-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:approver:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3011cfaps0000000000000001');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3012cfapd0000000000000001', 'pr0p0sa3003config000000000000001', '批准人-删除', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:approver:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3012cfapd0000000000000001');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3013cfsds0000000000000001', 'pr0p0sa3003config000000000000001', '评分维度-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:scoreDimension:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3013cfsds0000000000000001');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT 'pr0p0sa3014cfsdd0000000000000001', 'pr0p0sa3003config000000000000001', '评分维度-删除', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:scoreDimension:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = 'pr0p0sa3014cfsdd0000000000000001');

-- 修正父级 is_leaf
UPDATE `sys_permission` SET `is_leaf` = 0 WHERE `id` = 'pr0p0sa3001menu000000000000001';
UPDATE `sys_permission` SET `is_leaf` = 0 WHERE `id` = 'pr0p0sa3002manage00000000000001';
UPDATE `sys_permission` SET `is_leaf` = 0 WHERE `id` = 'pr0p0sa3003config000000000000001';
