-- =============================================================================
-- HR 员工种子 — 斯派科 / 自动线服务部
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
  '9879870022984771817', '4711055619678925456', '自动线服务部', 5, '2', 'DEPT', 'S01A05',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A05');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '1348656806126651684', '9879870022984771817', '售后支持', 1, '2', 'GROUP', 'S01A05A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A05A01');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：斯派科 / 自动线服务部
-- -----------------------------------------------------------------------------


-- 组别：售后支持 (S01A05A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2294757001270851941', '600093', '谭远强', '74e870530d64b150', '93a88fd1', 'S01A05A01',
  1, 0, 1, '600093', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气技术员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600093');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4193238119077086568', '2294757001270851941', '1348656806126651684'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2294757001270851941' AND `dep_id` = '1348656806126651684'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2197167404812778757', '600102', '毛少强', '6d321dda6cca4851', 'ecf6b6a2', 'S01A05A01',
  1, 0, 1, '600102', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气技术员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600102');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3867310286029078809', '2197167404812778757', '1348656806126651684'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2197167404812778757' AND `dep_id` = '1348656806126651684'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4618963389033887011', '600106', '杜翔', '5249fd2463c68c98', 'f52d8a91', 'S01A05A01',
  1, 0, 1, '600106', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气技术员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600106');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6293947557483337847', '4618963389033887011', '1348656806126651684'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4618963389033887011' AND `dep_id` = '1348656806126651684'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9776215709936496906', '600107', '茹滨滨', 'a830dc0bcaf0ec11', 'd07f03dc', 'S01A05A01',
  1, 0, 1, '600107', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气技术员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600107');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6064256268706180587', '9776215709936496906', '1348656806126651684'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9776215709936496906' AND `dep_id` = '1348656806126651684'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6399712030272738367', '600110', '李辉乐', 'c2cd0190c4fe300f', '00ec2fc6', 'S01A05A01',
  1, 0, 1, '600110', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气技术员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600110');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1051448747763085385', '6399712030272738367', '1348656806126651684'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6399712030272738367' AND `dep_id` = '1348656806126651684'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6714943321369362722', '600112', '张文炳', 'b3cd6d0b729b3d34', '2314d7c4', 'S01A05A01',
  1, 0, 1, '600112', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气技术员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600112');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8464576392713241606', '6714943321369362722', '1348656806126651684'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6714943321369362722' AND `dep_id` = '1348656806126651684'
);

