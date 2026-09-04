-- =============================================================================
-- HR 员工种子 — 斯派科 / 项目部
-- 来源：docs/improve/data/员工列表20260822.xls（按中心+部门拆分）
-- 全量见 hr_user_seed_all.sql；幂等可重复执行
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 组织树（本部门分支）
-- -----------------------------------------------------------------------------

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4711055619678925456', NULL, '斯派科', 90, '1', 'CENTER', 'S01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9988038040260208099', '4711055619678925456', '项目部', 4, '2', 'DEPT', 'S01A04',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A04');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '7650445053729821485', '9988038040260208099', '项目管理', 1, '2', 'GROUP', 'S01A04A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A04A01');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：斯派科 / 项目部
-- -----------------------------------------------------------------------------


-- 组别：项目管理 (S01A04A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4505078223991411253', '600083', '戴攀', '9f806aab510453c2', '9f167514', 'S01A04A01',
  1, 0, 1, '600083', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级项目工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600083');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7389558159485697996', '4505078223991411253', '7650445053729821485'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4505078223991411253' AND `dep_id` = '7650445053729821485'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8703497980289408155', '600103', '黄炜翔', 'cc54d8ca1a5a7120', '633d4cc9', 'S01A04A01',
  1, 0, 1, '600103', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理项目工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600103');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4905534278040566036', '8703497980289408155', '7650445053729821485'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8703497980289408155' AND `dep_id` = '7650445053729821485'
);

