-- =============================================================================
-- 提案改善系统 — 管理端菜单与按钮权限（sys_permission）
-- 目标库：inside_dev（与 application-dev.yml 一致）
-- 说明：
--   1. 页面组件位于 jeecgboot-vue3/src/views/mes/proposal/（与 MES 前端同事目录对齐）
--   2. id 使用 JeecgBoot 默认风格：19 位纯数字雪花（≤32 字符）；禁止 pr0p0sa* 等字母自定义 id
--   3. 使用固定数字 ID + NOT EXISTS 插入；文末 UPDATE 纠偏已存在行（可重复执行）
--   4. component 必须对应 views/ 真实路径：mes/proposal/...（不要写成 proposal/...）
--   5. url 仍为 /proposal/**，与 component 相互独立，不要把 /mes 写进访问路径
--   6. 文末自动给 admin / proposal_admin 授权全部提案菜单与按钮（幂等）
--   7. 若菜单不显示或空白页，请退出重新登录或刷新权限缓存
--   8. 前置：已执行 proposal_init.sql（含 proposal_admin 角色）
--   9. 旧库若仍是 pr0p0sa*，先跑 fix/20260902_fix_pr0p0sa_ids_to_snowflake.sql
-- =============================================================================

SET NAMES utf8mb4;

-- 重跑时先清理本菜单下按钮权限后重插（保留目录/二级菜单行，由下方 INSERT/UPDATE 纠偏）
DELETE FROM `sys_role_permission`
WHERE `permission_id` IN (
  SELECT `id` FROM (
    SELECT `id` FROM `sys_permission`
    WHERE `parent_id` IN ('2094103000000000002', '2094103000000000003')
      AND `menu_type` = 2
  ) t
);
DELETE FROM `sys_permission`
WHERE `parent_id` IN ('2094103000000000002', '2094103000000000003')
  AND `menu_type` = 2;

-- 一级目录：提案改善
INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`
)
SELECT
  '2094103000000000001', NULL, '提案改善', '/proposal', 'layouts/RouteView', NULL, NULL,
  0, NULL, '0', 20.0, 0, 'ant-design:bulb-outlined',
  1, 0, 0, 0, 0, 'SPEX 提案改善系统管理端',
  '1', 0, 0, 'admin', NOW(), NULL, NULL, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000001');

-- 二级菜单：提案管理
INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`
)
SELECT
  '2094103000000000002', '2094103000000000001', '提案管理', '/proposal/manage', 'mes/proposal/manage/index', NULL, NULL,
  1, NULL, '1', 1.0, 0, NULL,
  1, 0, 0, 0, 0, NULL,
  '1', 0, 0, 'admin', NOW(), NULL, NULL, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000002');

-- 二级菜单：提案配置
INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`
)
SELECT
  '2094103000000000003', '2094103000000000001', '提案配置', '/proposal/config', 'mes/proposal/config/index', NULL, NULL,
  1, NULL, '1', 2.0, 0, NULL,
  1, 0, 0, 0, 0, NULL,
  '1', 0, 0, 'admin', NOW(), NULL, NULL, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000003');

-- -----------------------------------------------------------------------------
-- 提案管理 — 按钮权限
-- -----------------------------------------------------------------------------
INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000004', '2094103000000000002', '添加提案', NULL, NULL, 0, NULL, NULL, 2, 'proposal:manage:add', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000004');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000005', '2094103000000000002', '编辑提案', NULL, NULL, 0, NULL, NULL, 2, 'proposal:manage:edit', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000005');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000006', '2094103000000000002', '删除提案', NULL, NULL, 0, NULL, NULL, 2, 'proposal:manage:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000006');

-- -----------------------------------------------------------------------------
-- 提案配置 — 按钮权限（六 Tab）
-- -----------------------------------------------------------------------------
INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000007', '2094103000000000003', '部门负责人-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:deptLeader:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000007');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000008', '2094103000000000003', '部门负责人-删除', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:deptLeader:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000008');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000009', '2094103000000000003', '委员会-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:committee:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000009');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000010', '2094103000000000003', '委员会-删除', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:committee:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000010');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000011', '2094103000000000003', '批准人-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:approver:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000011');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000012', '2094103000000000003', '批准人-删除', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:approver:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000012');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000013', '2094103000000000003', '评分维度-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:scoreDimension:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000013');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000014', '2094103000000000003', '评分维度-删除', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:scoreDimension:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000014');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000015', '2094103000000000003', '改善性质-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:improvementType:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000015');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000016', '2094103000000000003', '改善性质-删除', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:improvementType:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000016');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2094103000000000017', '2094103000000000003', '首页标语-保存', NULL, NULL, 0, NULL, NULL, 2, 'proposal:config:homeBroadcast:save', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2094103000000000017');

-- 修正父级 is_leaf
UPDATE `sys_permission` SET `is_leaf` = 0 WHERE `id` = '2094103000000000001';
UPDATE `sys_permission` SET `is_leaf` = 0 WHERE `id` = '2094103000000000002';
UPDATE `sys_permission` SET `is_leaf` = 0 WHERE `id` = '2094103000000000003';

-- -----------------------------------------------------------------------------
-- 自愈：INSERT 幂等不会覆盖已存在行。component 必须对应
-- jeecgboot-vue3/src/views/mes/proposal/ 下真实文件。
-- 若仍写 proposal/manage/index（无 mes 前缀），页面会空白提示「查看组件引用是否正确」。
-- url 保持 /proposal/**，不要改成 /mes/proposal/**。
-- -----------------------------------------------------------------------------
UPDATE `sys_permission`
SET `url` = '/proposal', `component` = 'layouts/RouteView', `name` = '提案改善'
WHERE `id` = '2094103000000000001';

UPDATE `sys_permission`
SET `url` = '/proposal/manage', `component` = 'mes/proposal/manage/index', `name` = '提案管理'
WHERE `id` = '2094103000000000002';

UPDATE `sys_permission`
SET `url` = '/proposal/config', `component` = 'mes/proposal/config/index', `name` = '提案配置'
WHERE `id` = '2094103000000000003';

-- -----------------------------------------------------------------------------
-- 角色授权：admin / proposal_admin ← 全部提案菜单 + 按钮（幂等）
-- 目录开头会 DELETE 按钮级 sys_role_permission，故授权必须放在文末重绑。
-- -----------------------------------------------------------------------------
INSERT INTO `sys_role_permission` (`id`, `role_id`, `permission_id`)
SELECT MD5(CONCAT(r.id, '#', p.id)), r.id, p.id
FROM `sys_role` r
JOIN `sys_permission` p ON p.id IN (
  '2094103000000000001',
  '2094103000000000002',
  '2094103000000000003',
  '2094103000000000004',
  '2094103000000000005',
  '2094103000000000006',
  '2094103000000000007',
  '2094103000000000008',
  '2094103000000000009',
  '2094103000000000010',
  '2094103000000000011',
  '2094103000000000012',
  '2094103000000000013',
  '2094103000000000014',
  '2094103000000000015',
  '2094103000000000016',
  '2094103000000000017'
)
WHERE r.role_code IN ('admin', 'proposal_admin')
  AND NOT EXISTS (
    SELECT 1 FROM `sys_role_permission` rp
    WHERE rp.role_id = r.id AND rp.permission_id = p.id
  );
