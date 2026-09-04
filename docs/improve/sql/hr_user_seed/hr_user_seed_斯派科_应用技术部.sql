-- =============================================================================
-- HR 员工种子 — 斯派科 / 应用技术部
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
  '4113664932655774353', '4711055619678925456', '应用技术部', 3, '2', 'DEPT', 'S01A03',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A03');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '3504785889916690464', '4113664932655774353', '装夹体系', 1, '2', 'GROUP', 'S01A03A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A03A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '6391482445906492164', '4113664932655774353', '智能编程', 2, '2', 'GROUP', 'S01A03A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A03A02');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：斯派科 / 应用技术部
-- -----------------------------------------------------------------------------


-- 组别：装夹体系 (S01A03A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5764175182529850863', '600075', '王朋', 'e351d9069f3b052c', '32fc49d0', 'S01A03A01',
  1, 0, 1, '600075', 'admin', NOW(), 'admin', NOW(), 1, 0, '夹具设计工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600075');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3606479384184087586', '5764175182529850863', '3504785889916690464'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5764175182529850863' AND `dep_id` = '3504785889916690464'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2423243075524589138', '600077', '李志威', '3bbed6142bfea1fa', 'ddcf3c0f', 'S01A03A01',
  1, 0, 1, '600077', 'admin', NOW(), 'admin', NOW(), 1, 0, '夹具设计工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600077');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6507280523577892439', '2423243075524589138', '3504785889916690464'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2423243075524589138' AND `dep_id` = '3504785889916690464'
);


-- 组别：智能编程 (S01A03A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7677383600020477249', '600097', '谢甫', 'a033fa1083e39709', 'f3dd6e7f', 'S01A03A02',
  1, 0, 1, '600097', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CAM二次开发工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600097');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3165114908857407625', '7677383600020477249', '6391482445906492164'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7677383600020477249' AND `dep_id` = '6391482445906492164'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3707667483864926824', '600111', '罗佳兴', '4c55a1c89eba6d04', '11169d90', 'S01A03A02',
  1, 0, 1, '600111', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CAM二次开发工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600111');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5143908625157580424', '3707667483864926824', '6391482445906492164'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3707667483864926824' AND `dep_id` = '6391482445906492164'
);

