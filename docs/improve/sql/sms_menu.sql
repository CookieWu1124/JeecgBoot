-- =============================================================================
-- 销售管理模块 — 管理端菜单与按钮权限（sys_permission）
-- 来源：inside_dev @ 47.107.78.177（2026-08-27 同事新增）
-- 特性：固定 id + WHERE NOT EXISTS 幂等；文末 UPDATE 纠偏；admin 角色授权
-- 说明：
--   1. sys_permission.id 为 varchar(32)，本批均为 19 位雪花 id
--   2. 页面组件位于 jeecgboot-vue3/src/views/mes/sms/
--   3. 可重复执行；执行后请退出重新登录或刷新权限缓存
-- =============================================================================

SET NAMES utf8mb4;

-- -----------------------------------------------------------------------------
-- 菜单树
-- -----------------------------------------------------------------------------
INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`
)
SELECT
  '2092853334712434689', NULL, '销售管理', '/sms', 'layouts/default/index', NULL, NULL,
  0, NULL, '0', 1.0, 0, 'ant-design:shop-filled',
  1, 0, 0, 0, 0, NULL,
  NULL, 0, 0, 'admin', NOW(), NULL, NULL, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092853334712434689');

INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`
)
SELECT
  '2092853890768093185', '2092853334712434689', '客户跟踪', '/sms/track', 'layouts/default/index', NULL, NULL,
  1, NULL, '0', 1.0, 0, NULL,
  1, 0, 1, 0, 0, NULL,
  NULL, 0, 0, 'admin', NOW(), NULL, NULL, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092853890768093185');

INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`
)
SELECT
  '2092854063900573697', '2092853890768093185', '跟踪记录', '/mes/sms/track/SmsTrackRecordsList', 'mes/sms/track/SmsTrackRecordsList', NULL, NULL,
  1, NULL, '0', 1.0, 0, NULL,
  1, 0, 0, 0, 0, NULL,
  NULL, 0, 0, 'admin', NOW(), NULL, NULL, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092854063900573697');

INSERT INTO `sys_permission` (
  `id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`,
  `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`,
  `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`,
  `status`, `del_flag`, `rule_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `internal_or_external`
)
SELECT
  '2092854597135024129', '2092853890768093185', '商务宴请', '/mes/sms/track/SmsSoSalesDinnerApplyList', 'mes/sms/track/SmsSoSalesDinnerApplyList', NULL, NULL,
  1, NULL, '0', 2.0, 0, NULL,
  1, 0, 0, 0, 0, NULL,
  NULL, 0, 0, 'admin', NOW(), NULL, NULL, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092854597135024129');

-- -----------------------------------------------------------------------------
-- 按钮权限
-- -----------------------------------------------------------------------------
INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092855649418788866', '2092854063900573697', '新增客户', '/sms:smsTrackRecords:add', NULL, 0, NULL, NULL, 2, 'sms:smsTrackRecords:add', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092855649418788866');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092855978990419969', '2092854063900573697', '导出', '/sms:smsTrackRecords:exportXls', NULL, 0, NULL, NULL, 2, 'sms:smsTrackRecords:exportXls', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092855978990419969');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092856293244452865', '2092854063900573697', '编辑', '/sms:smsTrackRecords:edit', NULL, 0, NULL, NULL, 2, 'sms:smsTrackRecords:edit', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092856293244452865');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092856391609270273', '2092854063900573697', '删除', '/sms:smsTrackRecords:delete', NULL, 0, NULL, NULL, 2, 'sms:smsTrackRecords:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092856391609270273');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092856487243595778', '2092854063900573697', '项目新增', '/sms:smsSoSalesProject:add', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesProject:add', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092856487243595778');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092856593866997761', '2092854063900573697', '项目批量删除', '/sms:smsSoSalesProject:deleteBatch', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesProject:deleteBatch', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092856593866997761');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092856687542583298', '2092854063900573697', '项目编辑', '/sms:smsSoSalesProject:edit', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesProject:edit', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092856687542583298');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092856787316686850', '2092854063900573697', '项目删除', '/sms:smsSoSalesProject:delete', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesProject:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092856787316686850');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092856886159654914', '2092854063900573697', '拜访新增', '/sms:smsSoSalesVisit:add', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesVisit:add', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092856886159654914');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092856998160154626', '2092854063900573697', '拜访批量删除', '/sms:smsSoSalesVisit:deleteBatch', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesVisit:deleteBatch', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092856998160154626');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092857083027701761', '2092854063900573697', '拜访编辑', '/sms:smsSoSalesVisit:edit', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesVisit:edit', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092857083027701761');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092857167580676097', '2092854063900573697', '拜访删除', '/sms:smsSoSalesVisit:delete', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesVisit:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092857167580676097');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092857677087948801', '2092854597135024129', '新增', '/sms:smsSoSalesDinnerApply:add', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesDinnerApply:add', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092857677087948801');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092857768691548161', '2092854597135024129', '批量删除', '/sms:smsSoSalesDinnerApply:deleteBatch', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesDinnerApply:deleteBatch', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092857768691548161');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092857864212627458', '2092854597135024129', '编辑', '/sms:smsSoSalesDinnerApply:edit', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesDinnerApply:edit', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092857864212627458');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092857946223853569', '2092854597135024129', '删除', '/sms:smsSoSalesDinnerApply:delete', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesDinnerApply:delete', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092857946223853569');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092858030571307009', '2092854597135024129', '审核', '/sms:smsSoSalesDinnerApply:audit', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesDinnerApply:audit', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092858030571307009');

INSERT INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `is_route`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`)
SELECT '2092858117322096641', '2092854597135024129', '审核详情', '/sms:smsSoSalesDinnerApply:auditDetail', NULL, 0, NULL, NULL, 2, 'sms:smsSoSalesDinnerApply:auditDetail', '1', NULL, 0, NULL, 1, 0, 0, 0, NULL, 'admin', NOW(), NULL, NULL, 0, 0, '1', 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_permission` WHERE `id` = '2092858117322096641');

-- -----------------------------------------------------------------------------
-- 自愈：纠偏已存在行的 url / component / name / is_leaf
-- -----------------------------------------------------------------------------
UPDATE `sys_permission`
SET `name` = '销售管理', `url` = '/sms', `component` = 'layouts/default/index', `is_leaf` = 0, `menu_type` = 0, `sort_no` = 1.0, `icon` = 'ant-design:shop-filled', `keep_alive` = 0
WHERE `id` = '2092853334712434689';

UPDATE `sys_permission`
SET `name` = '客户跟踪', `url` = '/sms/track', `component` = 'layouts/default/index', `is_leaf` = 0, `menu_type` = 1, `sort_no` = 1.0, `icon` = NULL, `keep_alive` = 1, `parent_id` = '2092853334712434689'
WHERE `id` = '2092853890768093185';

UPDATE `sys_permission`
SET `name` = '跟踪记录', `url` = '/mes/sms/track/SmsTrackRecordsList', `component` = 'mes/sms/track/SmsTrackRecordsList', `is_leaf` = 0, `menu_type` = 1, `sort_no` = 1.0, `icon` = NULL, `keep_alive` = 0, `parent_id` = '2092853890768093185'
WHERE `id` = '2092854063900573697';

UPDATE `sys_permission`
SET `name` = '商务宴请', `url` = '/mes/sms/track/SmsSoSalesDinnerApplyList', `component` = 'mes/sms/track/SmsSoSalesDinnerApplyList', `is_leaf` = 0, `menu_type` = 1, `sort_no` = 2.0, `icon` = NULL, `keep_alive` = 0, `parent_id` = '2092853890768093185'
WHERE `id` = '2092854597135024129';

UPDATE `sys_permission`
SET `name` = '新增客户', `url` = '/sms:smsTrackRecords:add', `perms` = 'sms:smsTrackRecords:add', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092855649418788866';

UPDATE `sys_permission`
SET `name` = '导出', `url` = '/sms:smsTrackRecords:exportXls', `perms` = 'sms:smsTrackRecords:exportXls', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092855978990419969';

UPDATE `sys_permission`
SET `name` = '编辑', `url` = '/sms:smsTrackRecords:edit', `perms` = 'sms:smsTrackRecords:edit', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092856293244452865';

UPDATE `sys_permission`
SET `name` = '删除', `url` = '/sms:smsTrackRecords:delete', `perms` = 'sms:smsTrackRecords:delete', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092856391609270273';

UPDATE `sys_permission`
SET `name` = '项目新增', `url` = '/sms:smsSoSalesProject:add', `perms` = 'sms:smsSoSalesProject:add', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092856487243595778';

UPDATE `sys_permission`
SET `name` = '项目批量删除', `url` = '/sms:smsSoSalesProject:deleteBatch', `perms` = 'sms:smsSoSalesProject:deleteBatch', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092856593866997761';

UPDATE `sys_permission`
SET `name` = '项目编辑', `url` = '/sms:smsSoSalesProject:edit', `perms` = 'sms:smsSoSalesProject:edit', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092856687542583298';

UPDATE `sys_permission`
SET `name` = '项目删除', `url` = '/sms:smsSoSalesProject:delete', `perms` = 'sms:smsSoSalesProject:delete', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092856787316686850';

UPDATE `sys_permission`
SET `name` = '拜访新增', `url` = '/sms:smsSoSalesVisit:add', `perms` = 'sms:smsSoSalesVisit:add', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092856886159654914';

UPDATE `sys_permission`
SET `name` = '拜访批量删除', `url` = '/sms:smsSoSalesVisit:deleteBatch', `perms` = 'sms:smsSoSalesVisit:deleteBatch', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092856998160154626';

UPDATE `sys_permission`
SET `name` = '拜访编辑', `url` = '/sms:smsSoSalesVisit:edit', `perms` = 'sms:smsSoSalesVisit:edit', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092857083027701761';

UPDATE `sys_permission`
SET `name` = '拜访删除', `url` = '/sms:smsSoSalesVisit:delete', `perms` = 'sms:smsSoSalesVisit:delete', `parent_id` = '2092854063900573697', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092857167580676097';

UPDATE `sys_permission`
SET `name` = '新增', `url` = '/sms:smsSoSalesDinnerApply:add', `perms` = 'sms:smsSoSalesDinnerApply:add', `parent_id` = '2092854597135024129', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092857677087948801';

UPDATE `sys_permission`
SET `name` = '批量删除', `url` = '/sms:smsSoSalesDinnerApply:deleteBatch', `perms` = 'sms:smsSoSalesDinnerApply:deleteBatch', `parent_id` = '2092854597135024129', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092857768691548161';

UPDATE `sys_permission`
SET `name` = '编辑', `url` = '/sms:smsSoSalesDinnerApply:edit', `perms` = 'sms:smsSoSalesDinnerApply:edit', `parent_id` = '2092854597135024129', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092857864212627458';

UPDATE `sys_permission`
SET `name` = '删除', `url` = '/sms:smsSoSalesDinnerApply:delete', `perms` = 'sms:smsSoSalesDinnerApply:delete', `parent_id` = '2092854597135024129', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092857946223853569';

UPDATE `sys_permission`
SET `name` = '审核', `url` = '/sms:smsSoSalesDinnerApply:audit', `perms` = 'sms:smsSoSalesDinnerApply:audit', `parent_id` = '2092854597135024129', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092858030571307009';

UPDATE `sys_permission`
SET `name` = '审核详情', `url` = '/sms:smsSoSalesDinnerApply:auditDetail', `perms` = 'sms:smsSoSalesDinnerApply:auditDetail', `parent_id` = '2092854597135024129', `menu_type` = 2, `is_leaf` = 1
WHERE `id` = '2092858117322096641';

-- -----------------------------------------------------------------------------
-- 角色授权：admin ← 全部销售管理菜单 + 按钮（幂等）
-- -----------------------------------------------------------------------------
INSERT INTO `sys_role_permission` (`id`, `role_id`, `permission_id`)
SELECT REPLACE(UUID(), '-', ''), r.id, p.id
FROM `sys_role` r
JOIN `sys_permission` p ON p.id IN (
  '2092853334712434689',
  '2092853890768093185',
  '2092854063900573697',
  '2092854597135024129',
  '2092855649418788866',
  '2092855978990419969',
  '2092856293244452865',
  '2092856391609270273',
  '2092856487243595778',
  '2092856593866997761',
  '2092856687542583298',
  '2092856787316686850',
  '2092856886159654914',
  '2092856998160154626',
  '2092857083027701761',
  '2092857167580676097',
  '2092857677087948801',
  '2092857768691548161',
  '2092857864212627458',
  '2092857946223853569',
  '2092858030571307009',
  '2092858117322096641'
)
WHERE r.role_code = 'admin'
  AND NOT EXISTS (
    SELECT 1 FROM `sys_role_permission` rp
    WHERE rp.role_id = r.id AND rp.permission_id = p.id
  );

