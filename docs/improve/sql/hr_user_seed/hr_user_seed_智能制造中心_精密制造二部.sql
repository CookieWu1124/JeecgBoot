-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 精密制造二部
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
  '9372856559755238914', NULL, '智能制造中心', 80, '1', 'CENTER', 'Z01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4692327628221759430', '9372856559755238914', '精密制造二部', 2, '2', 'DEPT', 'Z01A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A02');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '8303933779144374865', '4692327628221759430', 'NC车组', 1, '2', 'GROUP', 'Z01A02A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A02A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '8086229327261579466', '4692327628221759430', '铣床组', 2, '2', 'GROUP', 'Z01A02A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A02A02');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4893581587940293594', '4692327628221759430', '磨床组', 3, '2', 'GROUP', 'Z01A02A03',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A02A03');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9754573822162691658', '4692327628221759430', 'HCNC组', 4, '2', 'GROUP', 'Z01A02A04',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A02A04');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4769991788055081951', '4692327628221759430', '钳工组', 5, '2', 'GROUP', 'Z01A02A05',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A02A05');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4548098076592638827', '4692327628221759430', '车床组', 6, '2', 'GROUP', 'Z01A02A06',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A02A06');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '7981672569808741619', '4692327628221759430', 'IMCNC组', 7, '2', 'GROUP', 'Z01A02A07',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A02A07');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 精密制造二部
-- -----------------------------------------------------------------------------


-- 组别：NC车组 (Z01A02A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6408905822115221098', '01069', '马睿康', 'd30fea18bcf08bf8', 'e43ae79d', 'Z01A02A01',
  1, 0, 1, '01069', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01069');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8598245049800448014', '6408905822115221098', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6408905822115221098' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4192674994298296684', '01448', '赵刚', 'a915b25887bff363', '2b19dc96', 'Z01A02A01',
  1, 0, 1, '01448', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01448');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4810732408234355300', '4192674994298296684', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4192674994298296684' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5908420521036783943', '03921', '吴金右', 'b6ebc8ee1bdd815c', '68cffe7e', 'Z01A02A01',
  1, 0, 1, '03921', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03921');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7386832208213264935', '5908420521036783943', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5908420521036783943' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3907341353747557625', '06472', '王帅', '382b9f0d467ce68d', 'a0f28f2a', 'Z01A02A01',
  1, 0, 1, '06472', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06472');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7827284288571360176', '3907341353747557625', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3907341353747557625' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4854089722018102581', '07588', '熊武', '7052da156e160e4c', '51a287d6', 'Z01A02A01',
  1, 0, 1, '07588', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07588');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1267276626272374269', '4854089722018102581', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4854089722018102581' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5567887417461657038', '09489', '杨志伟', '8377bd09723b23a4', '3cf9876b', 'Z01A02A01',
  1, 0, 1, '09489', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09489');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5097041543478812506', '5567887417461657038', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5567887417461657038' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8077809259104369187', '17350', '杨焱平', '396f7eb14841f061', 'aa6361c4', 'Z01A02A01',
  1, 0, 1, '17350', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17350');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5253358392362697239', '8077809259104369187', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8077809259104369187' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5524251655546797281', '18512', '刘帅', '34ecfd12ea741fad', '7d290336', 'Z01A02A01',
  1, 0, 1, '18512', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18512');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5532325394603361513', '5524251655546797281', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5524251655546797281' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5233925565377697397', '18513', '邱锦涛', '22c92dfced15b08c', 'd6f39a38', 'Z01A02A01',
  1, 0, 1, '18513', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18513');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9228298863859825647', '5233925565377697397', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5233925565377697397' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9212303015985153476', '19743', '钟日成', 'df600885c5f39b9f', '4d2486bb', 'Z01A02A01',
  1, 0, 1, '19743', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19743');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4010699461170905725', '9212303015985153476', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9212303015985153476' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9477205943963499977', '20737', '邓永辉', '52e34cd07497dda8', 'db77ac71', 'Z01A02A01',
  1, 0, 1, '20737', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20737');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5140253209129930671', '9477205943963499977', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9477205943963499977' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6461078896729431285', '21458', '白雪帅', '5404184b7e3c4316', 'f9857018', 'Z01A02A01',
  1, 0, 1, '21458', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21458');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2776750447971948326', '6461078896729431285', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6461078896729431285' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9085270892391833579', '21826', '黄洋杰', 'cddd3fddeb6ba625', '63e9a130', 'Z01A02A01',
  1, 0, 1, '21826', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21826');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1159675267694487320', '9085270892391833579', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9085270892391833579' AND `dep_id` = '8303933779144374865'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7091733182462485468', '22272', '段卓翔', '40d3b78e82595c2e', '93485eee', 'Z01A02A01',
  1, 0, 1, '22272', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22272');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3092560275918824904', '7091733182462485468', '8303933779144374865'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7091733182462485468' AND `dep_id` = '8303933779144374865'
);


-- 组别：铣床组 (Z01A02A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9494793570126102665', '02309', '赖成友', '70f016654bb5e001', 'fc3fe962', 'Z01A02A02',
  1, 0, 1, '02309', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02309');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6564172387582934083', '9494793570126102665', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9494793570126102665' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2394598922667605070', '05997', '石自成', '0511ee15a17ebda2', '048d1923', 'Z01A02A02',
  1, 0, 1, '05997', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05997');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6402844415626171711', '2394598922667605070', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2394598922667605070' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8013766910539597130', '06391', '陆应恩', '7a677bde85f9a03c', '59cc0609', 'Z01A02A02',
  1, 0, 1, '06391', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06391');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8715633918443408902', '8013766910539597130', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8013766910539597130' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6340547047597423258', '09681', '蔡永金', '16a724d8ed7e0364', '99b241d4', 'Z01A02A02',
  1, 0, 1, '09681', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09681');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4041763637227356790', '6340547047597423258', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6340547047597423258' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6261951935217684859', '15571', '奉益安', 'bbf1cabcf0c0ae87', 'afffa3aa', 'Z01A02A02',
  1, 0, 1, '15571', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15571');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7635327535985772803', '6261951935217684859', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6261951935217684859' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3880928961980697572', '23408', '邓显显', '96856831c44927b6', '71ad73d4', 'Z01A02A02',
  1, 0, 1, '23408', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23408');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7208243329527847019', '3880928961980697572', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3880928961980697572' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2537825871678834149', '24070', '邓忠侨', '1226c2e2e934ab52', '1e5d171e', 'Z01A02A02',
  1, 0, 1, '24070', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24070');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7265767808358006332', '2537825871678834149', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2537825871678834149' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2523071424323491242', '24679', '邱晨晨', '8029676611df3fef', 'cee8a66f', 'Z01A02A02',
  1, 0, 1, '24679', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24679');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3299081823120421401', '2523071424323491242', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2523071424323491242' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7872232989466371376', '24791', '朱旭', '80b9bfe72be58e65', '38a6be8e', 'Z01A02A02',
  1, 0, 1, '24791', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24791');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6697924021223568299', '7872232989466371376', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7872232989466371376' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8448217695157698977', '24804', '赖庆泉', '9f7154c283cf90ef', 'c99a62b3', 'Z01A02A02',
  1, 0, 1, '24804', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24804');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6108648169982803908', '8448217695157698977', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8448217695157698977' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2138386595256163906', '24926', '胡玉龙', '7d71e090fa364a2c', '81ec099b', 'Z01A02A02',
  1, 0, 1, '24926', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24926');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6729774829948829761', '2138386595256163906', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2138386595256163906' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7133730149835618948', '25533', '黎鸿胜', '9701e6bea55f7d1d', 'c53e90e4', 'Z01A02A02',
  1, 0, 1, '25533', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25533');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8301334821803114378', '7133730149835618948', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7133730149835618948' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8493628102131585898', '25534', '郑佳宝', '1651eed313c9483a', 'b2c7652e', 'Z01A02A02',
  1, 0, 1, '25534', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25534');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1958436054348682343', '8493628102131585898', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8493628102131585898' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1747581800057809089', '26010', '袁季涵', '22b324ff924c532c', 'f101d1a8', 'Z01A02A02',
  1, 0, 1, '26010', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26010');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4079947392772259178', '1747581800057809089', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1747581800057809089' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4499103554781348948', '26135', '夏候宇', 'cd99667ec135da9d', '74163eb4', 'Z01A02A02',
  1, 0, 1, '26135', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26135');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4261236816829570246', '4499103554781348948', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4499103554781348948' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5304031254442900212', '26157', '郑石磊', 'a63878e0e1bb6c59', '002af638', 'Z01A02A02',
  1, 0, 1, '26157', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26157');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5309823001505275799', '5304031254442900212', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5304031254442900212' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8917134953172951967', '26158', '王宏祥', '2bc37eaceba48277', 'a3dd4eb3', 'Z01A02A02',
  1, 0, 1, '26158', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26158');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9942843524522279871', '8917134953172951967', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8917134953172951967' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9646782032473510184', '26256', '段文斌', 'ae7677495b0307b2', '056ba3fe', 'Z01A02A02',
  1, 0, 1, '26256', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26256');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1881781340728095303', '9646782032473510184', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9646782032473510184' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4191811365076067516', '26358', '熊善明', '687990d84ace8f62', '8dfe3259', 'Z01A02A02',
  1, 0, 1, '26358', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26358');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6755038331774063197', '4191811365076067516', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4191811365076067516' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6977248391326483559', '26592', '张鑫', 'a49feb3c5eadd7fd', 'de57f182', 'Z01A02A02',
  1, 0, 1, '26592', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26592');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4992211292334289720', '6977248391326483559', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6977248391326483559' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2794275247409941437', '26815', '易翔军', '4474752e6c05f5c9', '97762d5a', 'Z01A02A02',
  1, 0, 1, '26815', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26815');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1263141836463076893', '2794275247409941437', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2794275247409941437' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3007076640990027874', '26822', '周宇轩', 'debdfcbd73fa24f4', '8891c3c8', 'Z01A02A02',
  1, 0, 1, '26822', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26822');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9503372512954911885', '3007076640990027874', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3007076640990027874' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1150627545235524034', '27027', '张衡', 'c992fdbc135e32c4', '8a878f84', 'Z01A02A02',
  1, 0, 1, '27027', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27027');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4148947509592532929', '1150627545235524034', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1150627545235524034' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1595328195624339091', '27028', '胡泽宇', '62f48b9a7e0925b5', 'be14bebf', 'Z01A02A02',
  1, 0, 1, '27028', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27028');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7199707996864395147', '1595328195624339091', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1595328195624339091' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5025544241380653577', '27149', '蒋奕', '4854a8a6f9d58b2f', '90384572', 'Z01A02A02',
  1, 0, 1, '27149', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27149');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6407613191347806147', '5025544241380653577', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5025544241380653577' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2927652756136118972', '27468', '易辰宇', '0a5ba5ec381150af', '5113b0d1', 'Z01A02A02',
  1, 0, 1, '27468', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27468');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3539503955384747830', '2927652756136118972', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2927652756136118972' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5211447741564655462', '27495', '蔡志毅', '7bff2d878694ad06', 'be876afe', 'Z01A02A02',
  1, 0, 1, '27495', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27495');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9716210893226868266', '5211447741564655462', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5211447741564655462' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9494034412113469688', '27496', '肖书航', '7911c50878cdddd4', '840f6685', 'Z01A02A02',
  1, 0, 1, '27496', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27496');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1117424373457682671', '9494034412113469688', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9494034412113469688' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4283481238283714203', '27497', '王鑫河', 'e12a330bf8ce9068', 'ba9d607b', 'Z01A02A02',
  1, 0, 1, '27497', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27497');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6497746418114459250', '4283481238283714203', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4283481238283714203' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2762979389855775820', '27498', '袁豫', 'f4922c90d8b50fe8', 'f16cd209', 'Z01A02A02',
  1, 0, 1, '27498', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27498');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6434178279646710594', '2762979389855775820', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2762979389855775820' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1392964530216415319', '27499', '戴明', '789011eb9db0666e', 'f70ba89e', 'Z01A02A02',
  1, 0, 1, '27499', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27499');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2164939289467086139', '1392964530216415319', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1392964530216415319' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1613666572569440913', '27507', '陆俊', '6be339dcbb45c133', '7aab0b99', 'Z01A02A02',
  1, 0, 1, '27507', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27507');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9203530625158843964', '1613666572569440913', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1613666572569440913' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8602567496649917255', '27649', '王重飞', '299521ba1d9e032b', '44f33c4c', 'Z01A02A02',
  1, 0, 1, '27649', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27649');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1383947188790918063', '8602567496649917255', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8602567496649917255' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5064270570254774204', '27675', '刘金龙', '3821f1c2606f01f0', 'ffd7afaa', 'Z01A02A02',
  1, 0, 1, '27675', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27675');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7592897053022119533', '5064270570254774204', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5064270570254774204' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7968704569486095507', '27774', '张彬', '276e89961252eb6d', 'ea4742ad', 'Z01A02A02',
  1, 0, 1, '27774', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27774');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6863021238084900986', '7968704569486095507', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7968704569486095507' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7765489761225519999', '27785', '李洋', '7870939907e4d131', '68249e8e', 'Z01A02A02',
  1, 0, 1, '27785', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27785');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8681394788990172313', '7765489761225519999', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7765489761225519999' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4300712839628908505', '27788', '张振轩', 'b9503b3e25940471', 'b3eda2c2', 'Z01A02A02',
  1, 0, 1, '27788', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27788');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6108910260399103030', '4300712839628908505', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4300712839628908505' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8791588724794118152', '27807', '杨波', '3be2bef7707db720', '8456771d', 'Z01A02A02',
  1, 0, 1, '27807', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 380
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27807');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1967062537067856920', '8791588724794118152', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8791588724794118152' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7976602428271996578', '27808', '蒋海俊', 'bca4f04335ceed0a', '45efa4d4', 'Z01A02A02',
  1, 0, 1, '27808', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 390
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27808');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3327197199291582986', '7976602428271996578', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7976602428271996578' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7301370578513503299', '27819', '毛茂林', 'a89f4d7468d62fbe', '594671c9', 'Z01A02A02',
  1, 0, 1, '27819', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 400
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27819');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3810238648007164057', '7301370578513503299', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7301370578513503299' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6187607506917639893', '27822', '陈永兵', '1ba3f36387448bcf', '444ad3cd', 'Z01A02A02',
  1, 0, 1, '27822', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 410
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27822');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2237115448611832347', '6187607506917639893', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6187607506917639893' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9150997370207420440', '27839', '邓广林', 'e3c90a9ce9ac8cd0', '6a806771', 'Z01A02A02',
  1, 0, 1, '27839', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 420
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27839');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2349720323136975552', '9150997370207420440', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9150997370207420440' AND `dep_id` = '8086229327261579466'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5798234415767584142', '27874', '王睆', '1dac91ae70a7e58f', 'aed19d7f', 'Z01A02A02',
  1, 0, 1, '27874', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 430
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27874');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9521720612504456429', '5798234415767584142', '8086229327261579466'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5798234415767584142' AND `dep_id` = '8086229327261579466'
);


-- 组别：磨床组 (Z01A02A03)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9613580358217641254', '01080', '程常', '1192c94879af693d', 'd35771d6', 'Z01A02A03',
  1, 0, 1, '01080', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01080');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1597707210870500995', '9613580358217641254', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9613580358217641254' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8391050992009450730', '02670', '向雪春', '5ae90a1a2e45a90d', '575fa267', 'Z01A02A03',
  1, 0, 1, '02670', 'admin', NOW(), 'admin', NOW(), 1, 0, '普加主管', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02670');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4294662862398607912', '8391050992009450730', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8391050992009450730' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8589941650840840491', '03602', '潘广岳', 'f340af5013ab094c', '28032cec', 'Z01A02A03',
  1, 0, 1, '03602', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03602');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3018959393751812963', '8589941650840840491', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8589941650840840491' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2652939579887875977', '06373', '吴名朝', '4efaa3c4b894c38d', '860a6d5d', 'Z01A02A03',
  1, 0, 1, '06373', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06373');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8002409996196568476', '2652939579887875977', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2652939579887875977' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6348533165478738073', '06665', '杨群智', '4f96b53bfd222ab8', 'b30507ee', 'Z01A02A03',
  1, 0, 1, '06665', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06665');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5120148476932620228', '6348533165478738073', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6348533165478738073' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3795909068927304139', '08001', '张晓东', '672c90509102bbeb', '41fed2ea', 'Z01A02A03',
  1, 0, 1, '08001', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08001');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6970599996056951499', '3795909068927304139', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3795909068927304139' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6261589459733980994', '08431', '伍雄胤', '38703f613603e9e0', 'fa9566e4', 'Z01A02A03',
  1, 0, 1, '08431', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08431');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8669862769256176802', '6261589459733980994', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6261589459733980994' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1240763208569281477', '08967', '田成', 'cf1487dade57df33', 'bbe5fe3f', 'Z01A02A03',
  1, 0, 1, '08967', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08967');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2742984276314122013', '1240763208569281477', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1240763208569281477' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6626355149890971655', '10448', '文军', 'bc0b27257a45867a', '685d3d65', 'Z01A02A03',
  1, 0, 1, '10448', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10448');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2681944626098800309', '6626355149890971655', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6626355149890971655' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3117753765809494842', '12906', '阮华君', '06782a9cea73d14d', 'cb04cec2', 'Z01A02A03',
  1, 0, 1, '12906', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12906');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9426655565053096342', '3117753765809494842', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3117753765809494842' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6225570780226771372', '13294', '刘玉贵', 'e36fd41cdaea37da', '49b6b5b4', 'Z01A02A03',
  1, 0, 1, '13294', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13294');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5605083546997159459', '6225570780226771372', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6225570780226771372' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2549595575870131323', '14495', '席君豪', 'cf277c34e8b2c0e3', '0f42fb09', 'Z01A02A03',
  1, 0, 1, '14495', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14495');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1769251382669259941', '2549595575870131323', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2549595575870131323' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8157963643222923005', '14972', '赵祖良', '66ada4297f2a8e80', '33bc0066', 'Z01A02A03',
  1, 0, 1, '14972', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14972');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9348095830138915679', '8157963643222923005', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8157963643222923005' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9229725099600027752', '15104', '徐锦', 'faf595e62ae777b6', '42da0b0f', 'Z01A02A03',
  1, 0, 1, '15104', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15104');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4108263432869273378', '9229725099600027752', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9229725099600027752' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3703396854906370896', '15355', '邓先华', 'fffe830c6374bb3e', '10639a92', 'Z01A02A03',
  1, 0, 1, '15355', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15355');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5884361714317708173', '3703396854906370896', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3703396854906370896' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7388000309223907375', '15459', '张世超', '11c524e49e787a87', '1bc94f11', 'Z01A02A03',
  1, 0, 1, '15459', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15459');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8774018110868707252', '7388000309223907375', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7388000309223907375' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6313142778025277699', '15535', '黄忠岳', '7d96ac496eef9729', 'e3505010', 'Z01A02A03',
  1, 0, 1, '15535', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15535');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2049458399899472615', '6313142778025277699', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6313142778025277699' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3424093220540833959', '15672', '吴志专', '621d00add2cbcb24', '5a8fefa7', 'Z01A02A03',
  1, 0, 1, '15672', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15672');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2899064570005964002', '3424093220540833959', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3424093220540833959' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7783021830874569393', '16663', '杨昌盛', 'ed5071c4ee09e9d0', '21bce7b6', 'Z01A02A03',
  1, 0, 1, '16663', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16663');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8197098856917875256', '7783021830874569393', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7783021830874569393' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3866122299015733465', '17260', '徐美国', '2c7e50764c38b510', '7d17cf7d', 'Z01A02A03',
  1, 0, 1, '17260', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17260');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5694905597251696225', '3866122299015733465', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3866122299015733465' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6408172046506688185', '18584', '黄宇翔', 'e11e16f24f5b4d37', '72965fc4', 'Z01A02A03',
  1, 0, 1, '18584', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18584');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9184936949653425557', '6408172046506688185', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6408172046506688185' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7050823247314007444', '18585', '谭灿', '45d72f4359f2d8a3', '50cc456a', 'Z01A02A03',
  1, 0, 1, '18585', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18585');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4861390973844221145', '7050823247314007444', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7050823247314007444' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2837218545401300837', '19087', '钟元炳', '63105faaf15c6d6f', '2bc717a0', 'Z01A02A03',
  1, 0, 1, '19087', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19087');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9951597125413930689', '2837218545401300837', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2837218545401300837' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9763388534526805102', '19166', '郭晓威', '812e101192825792', '91e44299', 'Z01A02A03',
  1, 0, 1, '19166', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19166');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3406904893413044466', '9763388534526805102', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9763388534526805102' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8946155587879185327', '19313', '李义平', 'f833f2f5b3becd83', '2d6320f9', 'Z01A02A03',
  1, 0, 1, '19313', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19313');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1275380678996783732', '8946155587879185327', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8946155587879185327' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2841986061423422311', '20486', '伍顺', 'c1badce33863bea2', 'a8da0b87', 'Z01A02A03',
  1, 0, 1, '20486', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20486');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5683597907931155508', '2841986061423422311', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2841986061423422311' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4527896400700005631', '21180', '邓建文', '77ab758ef7cf82b2', '0bc3dbcb', 'Z01A02A03',
  1, 0, 1, '21180', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21180');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7419278984921365949', '4527896400700005631', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4527896400700005631' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6815513405358381239', '23657', '尹炳源', '7f05759d46cdb12c', '83626838', 'Z01A02A03',
  1, 0, 1, '23657', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23657');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6675554928472687290', '6815513405358381239', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6815513405358381239' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6982349828282549955', '23900', '张马进', 'fe90796e5df24ce7', '8a7c3e6a', 'Z01A02A03',
  1, 0, 1, '23900', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23900');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2012147485349488689', '6982349828282549955', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6982349828282549955' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7737386045422360967', '23936', '郭永鹏', '839fa959d406e6ea', 'dbf5690e', 'Z01A02A03',
  1, 0, 1, '23936', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23936');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6650892398573233831', '7737386045422360967', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7737386045422360967' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6527560282167963380', '24744', '程安逸', '8edaa50155b372f7', '5822eb04', 'Z01A02A03',
  1, 0, 1, '24744', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习磨工', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24744');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8442622240237104783', '6527560282167963380', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6527560282167963380' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3280599077482952277', '25627', '侯开征', 'cfdcad0dd25884bf', 'da6a35c6', 'Z01A02A03',
  1, 0, 1, '25627', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25627');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6888899901164511207', '3280599077482952277', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3280599077482952277' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9989366013373648190', '26159', '果金舵', '9c9b0ec2c9833bc5', 'ee3e9128', 'Z01A02A03',
  1, 0, 1, '26159', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26159');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5604124246120941958', '9989366013373648190', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9989366013373648190' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6502139595988289126', '26201', '李嗣政', '2c9a5488e9beab22', 'e36e901e', 'Z01A02A03',
  1, 0, 1, '26201', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26201');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8392876241142114803', '6502139595988289126', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6502139595988289126' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8425986248766898972', '27040', '易旻昊', '69ddff282b0275e0', '2eb40dd6', 'Z01A02A03',
  1, 0, 1, '27040', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27040');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3948839779016857455', '8425986248766898972', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8425986248766898972' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8634571337137100250', '27399', '熊文超', '702e7586c9353b37', '1fae8df2', 'Z01A02A03',
  1, 0, 1, '27399', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习磨工', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27399');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6906551811923786356', '8634571337137100250', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8634571337137100250' AND `dep_id` = '4893581587940293594'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7572531088514096946', '27797', '陈堪富', '1b9cd88dd2e0a15f', 'b3085af5', 'Z01A02A03',
  1, 0, 1, '27797', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27797');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2523465663094393161', '7572531088514096946', '4893581587940293594'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7572531088514096946' AND `dep_id` = '4893581587940293594'
);


-- 组别：HCNC组 (Z01A02A04)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1518826035348101130', '02463', '林耀南', '37eb4fd1d6cd6e32', 'ea59d702', 'Z01A02A04',
  1, 0, 1, '02463', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02463');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3320354134094633234', '1518826035348101130', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1518826035348101130' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9019674578643884714', '02951', '黄辉', '59d73c84d87b79ce', '490b5c39', 'Z01A02A04',
  1, 0, 1, '02951', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02951');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2293457709947900587', '9019674578643884714', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9019674578643884714' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8839636020251124633', '03141', '刘志敏', '130c9b187e583943', '72af3a28', 'Z01A02A04',
  1, 0, 1, '03141', 'admin', NOW(), 'admin', NOW(), 1, 0, '生产副经理', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03141');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5196280667320828321', '8839636020251124633', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8839636020251124633' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1240711731212707471', '03226', '钟剑聪', '727a24d2c6b07a26', 'f30cc612', 'Z01A02A04',
  1, 0, 1, '03226', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03226');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8953936135681045693', '1240711731212707471', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1240711731212707471' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5872268634559517742', '03373', '杨海东', '18f614c599a94c2b', 'f3644b36', 'Z01A02A04',
  1, 0, 1, '03373', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03373');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5064569275314653429', '5872268634559517742', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5872268634559517742' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9686509072216732572', '03760', '卢世仁', 'e712220920dd59c0', '4e73ff5b', 'Z01A02A04',
  1, 0, 1, '03760', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03760');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5900054833479762336', '9686509072216732572', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9686509072216732572' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2480425637313497317', '04229', '刘建亮', '6f359e4df9fec20a', 'bcb98682', 'Z01A02A04',
  1, 0, 1, '04229', 'admin', NOW(), 'admin', NOW(), 1, 0, '主管', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04229');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4698157244205395472', '2480425637313497317', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2480425637313497317' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1859473325057253075', '04292', '刘海忠', '35790851776e717f', '4ae75b6f', 'Z01A02A04',
  1, 0, 1, '04292', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04292');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5627644300742666708', '1859473325057253075', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1859473325057253075' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5442374984008817092', '05728', '张力豪', '97633676bc40bdfd', '6dadec21', 'Z01A02A04',
  1, 0, 1, '05728', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05728');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4594461533355486521', '5442374984008817092', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5442374984008817092' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8019388796926035566', '05762', '陈廷华', '33f52090b66aeefb', 'bbcb3327', 'Z01A02A04',
  1, 0, 1, '05762', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05762');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3020637330920771988', '8019388796926035566', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8019388796926035566' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9607162950524699054', '06647', '黄伟智', '0f4933cc87230e39', '09e3c86f', 'Z01A02A04',
  1, 0, 1, '06647', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06647');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8774699351565589316', '9607162950524699054', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9607162950524699054' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5239929807729434413', '06943', '赵希江', 'fdaa056c76eee04e', '2ea7e01f', 'Z01A02A04',
  1, 0, 1, '06943', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06943');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5379892257190133596', '5239929807729434413', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5239929807729434413' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7107445917429449304', '07915', '高锋', 'd5f731174743466f', '08faa4eb', 'Z01A02A04',
  1, 0, 1, '07915', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07915');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7486238327317629087', '7107445917429449304', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7107445917429449304' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7765035304621844638', '07948', '翁国权', '1458c112dbc001fd', '37b3afb9', 'Z01A02A04',
  1, 0, 1, '07948', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07948');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6268899593680457625', '7765035304621844638', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7765035304621844638' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7573989314328811821', '07993', '覃祚勒', 'bf3d23c2ff6cc9d6', '03a4f6ee', 'Z01A02A04',
  1, 0, 1, '07993', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07993');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2996483206197545386', '7573989314328811821', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7573989314328811821' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3439715558244572469', '08284', '邓志伟', 'c661aad8b7ee0ed5', 'cf4b4eb4', 'Z01A02A04',
  1, 0, 1, '08284', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08284');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8472025927177583043', '3439715558244572469', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3439715558244572469' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2871755618952650042', '09235', '陆红刚', '5b8eff9a2eb2ba1f', 'a71ba0b1', 'Z01A02A04',
  1, 0, 1, '09235', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09235');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6959340742214459454', '2871755618952650042', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2871755618952650042' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4269515408897065486', '10190', '肖继杰', 'aa220e302265818f', '4ea8d55c', 'Z01A02A04',
  1, 0, 1, '10190', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10190');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5014001890942476414', '4269515408897065486', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4269515408897065486' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5167769268611547997', '10613', '蒋水清', 'c0f878a4408549e3', '1302b34b', 'Z01A02A04',
  1, 0, 1, '10613', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10613');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5068602016558547164', '5167769268611547997', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5167769268611547997' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4559456273348253072', '11256', '刘前平', '7c2759111c6c9c2d', 'dec31eeb', 'Z01A02A04',
  1, 0, 1, '11256', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11256');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7290141245883040468', '4559456273348253072', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4559456273348253072' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7115703555117597357', '11355', '卢观林', 'e340cb0e2c2a57d0', 'e860f013', 'Z01A02A04',
  1, 0, 1, '11355', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11355');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5001366419505842204', '7115703555117597357', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7115703555117597357' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5791472240142809256', '13926', '李仲兴', 'a1015735242d7abb', 'c74b0c5c', 'Z01A02A04',
  1, 0, 1, '13926', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13926');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1882918055735441684', '5791472240142809256', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5791472240142809256' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6271554607460555789', '14341', '肖菊成', '470bbd9522742cb5', '0e192fd2', 'Z01A02A04',
  1, 0, 1, '14341', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14341');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9831307580714191027', '6271554607460555789', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6271554607460555789' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9598138850055042852', '15095', '陈彪', '6b492a83750d2c01', '032bf216', 'Z01A02A04',
  1, 0, 1, '15095', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15095');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8559739990630173652', '9598138850055042852', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9598138850055042852' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9582835195655447265', '15097', '陶坤坤', '4cb3263710013b7a', '17518e0d', 'Z01A02A04',
  1, 0, 1, '15097', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15097');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3036257541078102177', '9582835195655447265', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9582835195655447265' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5900352508260345406', '16448', '尹海军', 'ea67d99dc7e16427', '23bf9b4e', 'Z01A02A04',
  1, 0, 1, '16448', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16448');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5439335110503969070', '5900352508260345406', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5900352508260345406' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4492945522323805994', '16452', '何增亮', '5bc43a4ebf746dce', 'ba503952', 'Z01A02A04',
  1, 0, 1, '16452', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16452');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7260044139561042610', '4492945522323805994', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4492945522323805994' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1389686961806491349', '16685', '洪苏', '4520f098c60b8d92', 'c8e4da4d', 'Z01A02A04',
  1, 0, 1, '16685', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16685');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3893911463997293833', '1389686961806491349', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1389686961806491349' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3712589651113353834', '17143', '彭宇剑', '191db39ed4572fc5', '488758f7', 'Z01A02A04',
  1, 0, 1, '17143', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17143');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7094020807619565944', '3712589651113353834', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3712589651113353834' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3655942119528983705', '17145', '刘敏胜', '665c15cc31fa6231', '2c8f129e', 'Z01A02A04',
  1, 0, 1, '17145', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17145');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2359725685932193464', '3655942119528983705', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3655942119528983705' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2425548971438682338', '17311', '陈高智', '5f62f09b80c35c7a', '501061e5', 'Z01A02A04',
  1, 0, 1, '17311', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17311');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7786697818447637546', '2425548971438682338', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2425548971438682338' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3779892438813101733', '19164', '韦泽绵', '4dfa00f9fb6a265b', 'c1edcfc8', 'Z01A02A04',
  1, 0, 1, '19164', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19164');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3950547766400590125', '3779892438813101733', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3779892438813101733' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1161060284386419751', '19718', '吴帮', 'ed6add410498ee36', 'd217ac83', 'Z01A02A04',
  1, 0, 1, '19718', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19718');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9331037231597784622', '1161060284386419751', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1161060284386419751' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4847001514501797256', '20735', '李锦添', '62aebe921e43c336', '8b085ff6', 'Z01A02A04',
  1, 0, 1, '20735', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20735');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1647236860874512220', '4847001514501797256', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4847001514501797256' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3133635102390900820', '21445', '刘润东', '05a2abd4390b411a', 'eccbbfef', 'Z01A02A04',
  1, 0, 1, '21445', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21445');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8052327798349732297', '3133635102390900820', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3133635102390900820' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4144380782084443052', '22226', '余俊', 'ec4f25197472370f', 'c894b3ac', 'Z01A02A04',
  1, 0, 1, '22226', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22226');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1372427428680311240', '4144380782084443052', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4144380782084443052' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4975589083361252427', '22276', '廖杰', 'fcfdf6ea0c295057', '3c8f17e4', 'Z01A02A04',
  1, 0, 1, '22276', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22276');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9703718738207431066', '4975589083361252427', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4975589083361252427' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9762611881845089233', '22323', '宋绍瑞', 'ece17b3b6423ba1e', 'b6930d58', 'Z01A02A04',
  1, 0, 1, '22323', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 380
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22323');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9617846927229541330', '9762611881845089233', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9762611881845089233' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1022437002775097060', '22454', '周月良', '26f059b2721470af', 'f0480ca9', 'Z01A02A04',
  1, 0, 1, '22454', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 390
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22454');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4320019943420567378', '1022437002775097060', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1022437002775097060' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1127305279026051893', '22471', '王祖昊', '3b3ad89619f55e69', 'a95e5fbe', 'Z01A02A04',
  1, 0, 1, '22471', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 400
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22471');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1553407900876888427', '1127305279026051893', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1127305279026051893' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4206668477297634486', '22494', '陈洲权', 'd6c5f3772d4e909e', 'afb764a3', 'Z01A02A04',
  1, 0, 1, '22494', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 410
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22494');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3969157148255615600', '4206668477297634486', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4206668477297634486' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2511984851535886476', '22629', '凌会江', 'eee64ccfca56f6ba', '7a358a9a', 'Z01A02A04',
  1, 0, 1, '22629', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 420
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22629');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2753560148325712665', '2511984851535886476', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2511984851535886476' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6078108658677183156', '22791', '李振华', '99c032fcdd00a30f', 'd250144c', 'Z01A02A04',
  1, 0, 1, '22791', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 430
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22791');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5969574216119728720', '6078108658677183156', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6078108658677183156' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9977797259688171034', '23226', '纪业城', '710072a1a4ac95fa', '2e56f96f', 'Z01A02A04',
  1, 0, 1, '23226', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 440
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23226');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1995941769690241252', '9977797259688171034', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9977797259688171034' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1648243104955278977', '23230', '梁炬尤', '08d4f83f66ff8ae1', 'c7df7461', 'Z01A02A04',
  1, 0, 1, '23230', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 450
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23230');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3679892117877970921', '1648243104955278977', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1648243104955278977' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2754945814306580944', '23235', '黄嘉俊', 'a1c2fed1f745faa3', '63df99fe', 'Z01A02A04',
  1, 0, 1, '23235', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 460
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23235');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8592433298753317128', '2754945814306580944', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2754945814306580944' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3181033492314376246', '23243', '单昱秦', '4e1212e03a2b8b81', 'f3b97112', 'Z01A02A04',
  1, 0, 1, '23243', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 470
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23243');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8299447470835573326', '3181033492314376246', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3181033492314376246' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1922546338374214699', '23410', '满檐飞', '7178c8758c156fa7', 'aa2df8ca', 'Z01A02A04',
  1, 0, 1, '23410', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 480
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23410');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5414391902474161638', '1922546338374214699', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1922546338374214699' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8971093359491380221', '23436', '陶付豫', 'e9cf1d38ca61c191', 'b5ddf22b', 'Z01A02A04',
  1, 0, 1, '23436', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 490
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23436');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6246013126862443334', '8971093359491380221', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8971093359491380221' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9823708018423111229', '23450', '曾宪盛', '5b5fe9c216237c6d', 'cbba14b9', 'Z01A02A04',
  1, 0, 1, '23450', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 500
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23450');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8938860318434724340', '9823708018423111229', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9823708018423111229' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7811736841867984535', '23485', '李衍招', '5969360ebef91a1d', 'e7b6624e', 'Z01A02A04',
  1, 0, 1, '23485', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 510
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23485');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6841682131383747094', '7811736841867984535', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7811736841867984535' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3423884488331453714', '23629', '李海林', '84a1b399e4b7aadb', '710806eb', 'Z01A02A04',
  1, 0, 1, '23629', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 520
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23629');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5595610076666816246', '3423884488331453714', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3423884488331453714' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8150298965755147329', '23656', '黄伟雄', 'abbc0119a0662507', 'dfa1bbf3', 'Z01A02A04',
  1, 0, 1, '23656', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 530
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23656');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1307069352494312846', '8150298965755147329', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8150298965755147329' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1208711057614060742', '24213', '刘嘉威', '18a51d94297dc92f', 'ec7f30b0', 'Z01A02A04',
  1, 0, 1, '24213', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 540
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24213');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6888038445523416469', '1208711057614060742', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1208711057614060742' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1868341916843177737', '24317', '李博韬', '4cef8e956430bc7c', '01e07faa', 'Z01A02A04',
  1, 0, 1, '24317', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 550
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24317');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1514988320323525148', '1868341916843177737', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1868341916843177737' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6554257967219031082', '24330', '李子轩', '85be3cd3b8ef096b', '7b3848ae', 'Z01A02A04',
  1, 0, 1, '24330', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 560
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24330');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6679153606567385442', '6554257967219031082', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6554257967219031082' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3554163369340598740', '24349', '王开洪', '52cc57feed2e4936', '07fa505f', 'Z01A02A04',
  1, 0, 1, '24349', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 570
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24349');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7856809968347397932', '3554163369340598740', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3554163369340598740' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5969268110977620815', '24430', '刘志文', '9046ba5a191e93e3', 'a36e681a', 'Z01A02A04',
  1, 0, 1, '24430', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 580
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24430');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9176923474130284551', '5969268110977620815', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5969268110977620815' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3066594223502764388', '24451', '刘明龙', 'b67d518131c222b7', 'ddeed719', 'Z01A02A04',
  1, 0, 1, '24451', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 590
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24451');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5471983297443197079', '3066594223502764388', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3066594223502764388' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8056628913105733164', '24490', '刘文武', 'd3890be1fac898ab', '80611574', 'Z01A02A04',
  1, 0, 1, '24490', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 600
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24490');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4567927563303475637', '8056628913105733164', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8056628913105733164' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3223179815843336296', '24692', '邬启煌', 'dc9fe4add1b00201', '18316cd9', 'Z01A02A04',
  1, 0, 1, '24692', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 610
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24692');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7858677611625714959', '3223179815843336296', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3223179815843336296' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1809908331478954562', '24698', '马志华', '49dbb4e1517a7ce6', '139f2d7b', 'Z01A02A04',
  1, 0, 1, '24698', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 620
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24698');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5819958942723216572', '1809908331478954562', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1809908331478954562' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7929695538572047229', '24788', '张云飞', 'e5498aae4b167446', '25512834', 'Z01A02A04',
  1, 0, 1, '24788', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 630
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24788');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3052761680054910961', '7929695538572047229', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7929695538572047229' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6514956680740893908', '24824', '张腾宇', '44e8c25c76b3fa72', '672a833d', 'Z01A02A04',
  1, 0, 1, '24824', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 640
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24824');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6065948753184287688', '6514956680740893908', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6514956680740893908' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3398336581235965937', '24870', '熊康', 'c92ec3b5ea71becc', '0777bac8', 'Z01A02A04',
  1, 0, 1, '24870', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 650
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24870');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4058647707505184284', '3398336581235965937', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3398336581235965937' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5900516155084280207', '24873', '唐宇森', '3210c5ae6a4db02c', 'f557f543', 'Z01A02A04',
  1, 0, 1, '24873', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 660
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24873');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2687641229161465983', '5900516155084280207', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5900516155084280207' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2048228472732908657', '24885', '潘雨霏', '18203bd42c257f80', 'eb8d6f28', 'Z01A02A04',
  1, 0, 1, '24885', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 670
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24885');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9909738392715423759', '2048228472732908657', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2048228472732908657' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6657252004695593512', '24889', '欧阳柳峰', '8e26c0e062b681e7', 'e3185f6a', 'Z01A02A04',
  1, 0, 1, '24889', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 680
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24889');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9133961403816746268', '6657252004695593512', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6657252004695593512' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8728278984511002142', '24893', '詹韶鸿', 'f1b10735e379b675', '3779eefa', 'Z01A02A04',
  1, 0, 1, '24893', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 690
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24893');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2158409282758594792', '8728278984511002142', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8728278984511002142' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5414012608917883381', '24918', '吴东源', 'f81234264c4564bd', '9d370a18', 'Z01A02A04',
  1, 0, 1, '24918', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 700
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24918');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5320081743182610960', '5414012608917883381', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5414012608917883381' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4764045463652983943', '24946', '邱广生', 'e987feb97ff6a49f', '2af90424', 'Z01A02A04',
  1, 0, 1, '24946', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 710
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24946');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7493404552436141268', '4764045463652983943', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4764045463652983943' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7234754135635480186', '25693', '方敏', '836a55d8fe25966e', '680fb7d7', 'Z01A02A04',
  1, 0, 1, '25693', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 720
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25693');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2085733991733169527', '7234754135635480186', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7234754135635480186' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5478074122285026996', '25929', '徐轶', '16d99c9f171b004c', 'b07ccfc6', 'Z01A02A04',
  1, 0, 1, '25929', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 730
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25929');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1797489125691902829', '5478074122285026996', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5478074122285026996' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1149693396672716802', '25997', '匡应', '839f23ce8a1fa05d', 'bcc98d77', 'Z01A02A04',
  1, 0, 1, '25997', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 740
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25997');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2152673608800430081', '1149693396672716802', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1149693396672716802' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9746053369449099925', '26099', '罗庆荣', '52a390a51deb9063', '8407a88c', 'Z01A02A04',
  1, 0, 1, '26099', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 750
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26099');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1978293874496585453', '9746053369449099925', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9746053369449099925' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8326347570648910890', '26118', '谢文奇', '915b1d242cc59f20', 'bef8cad8', 'Z01A02A04',
  1, 0, 1, '26118', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 760
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26118');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6628063394179410451', '8326347570648910890', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8326347570648910890' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4243501992070608698', '26184', '管雄雄', '3dc678a4dce895a7', '008a11eb', 'Z01A02A04',
  1, 0, 1, '26184', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 770
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26184');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1428079555031967627', '4243501992070608698', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4243501992070608698' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1545062731585758114', '26436', '陈惠杰', 'e651d0dd3cd3b172', 'e59a16aa', 'Z01A02A04',
  1, 0, 1, '26436', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 780
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26436');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9941038789998805541', '1545062731585758114', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1545062731585758114' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1386238072458631775', '26597', '杨达', '1077c3054d8fddc3', '30b78e50', 'Z01A02A04',
  1, 0, 1, '26597', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 790
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26597');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6369086239726598657', '1386238072458631775', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1386238072458631775' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3055407204767308387', '26817', '孙建', 'e34725a09151ac87', 'a1d8cfd3', 'Z01A02A04',
  1, 0, 1, '26817', 'admin', NOW(), 'admin', NOW(), 1, 0, '主管', 800
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26817');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9228804279801798525', '3055407204767308387', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3055407204767308387' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1651840242807740169', '26992', '张景成', '20305b55b4425cdf', '6bd2ac56', 'Z01A02A04',
  1, 0, 1, '26992', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 810
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26992');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5718464861993839652', '1651840242807740169', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1651840242807740169' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7688869898690153864', '27006', '王志诚', 'fcfd6fffeaeacb6f', '253fa26b', 'Z01A02A04',
  1, 0, 1, '27006', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 820
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27006');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9533480551902326888', '7688869898690153864', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7688869898690153864' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6868252373184339070', '27047', '任歌', '2348513947be99b2', '3110944f', 'Z01A02A04',
  1, 0, 1, '27047', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 830
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27047');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1219256046426993723', '6868252373184339070', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6868252373184339070' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4578065838703510828', '27048', '苏永康', '42b45bd2575ba949', '076a2721', 'Z01A02A04',
  1, 0, 1, '27048', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 840
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27048');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9811730713137135305', '4578065838703510828', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4578065838703510828' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3827317118204705387', '27049', '马政', '7a430a5ad3425710', '9cc49d97', 'Z01A02A04',
  1, 0, 1, '27049', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 850
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27049');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1732506941233873207', '3827317118204705387', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3827317118204705387' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3127687924843561853', '27051', '佘强生', '1829c31010a85b58', '2e3c6728', 'Z01A02A04',
  1, 0, 1, '27051', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 860
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27051');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1529042945542107981', '3127687924843561853', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3127687924843561853' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6386474236822624530', '27052', '周林', 'a5488563bba88cbb', '9b26c5f7', 'Z01A02A04',
  1, 0, 1, '27052', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 870
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27052');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6301225839623737947', '6386474236822624530', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6386474236822624530' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1186732976016038535', '27053', '李俊逸', '067635bd587355d0', 'f3977658', 'Z01A02A04',
  1, 0, 1, '27053', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 880
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27053');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1882277287293943825', '1186732976016038535', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1186732976016038535' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2947876815948076097', '27054', '龚韧', '276fe93c3bb82207', 'a7625de7', 'Z01A02A04',
  1, 0, 1, '27054', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 890
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27054');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8824225420471201409', '2947876815948076097', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2947876815948076097' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3042075306662291243', '27289', '张俊辉', '43787d98cbdd7a5f', 'abd49c5c', 'Z01A02A04',
  1, 0, 1, '27289', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 900
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27289');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9931145173807170578', '3042075306662291243', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3042075306662291243' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7663692667978617128', '27306', '罗宜弘', 'd9921a78b7b7ed54', '5616b24b', 'Z01A02A04',
  1, 0, 1, '27306', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 910
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27306');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8102905434035065931', '7663692667978617128', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7663692667978617128' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3724849475958933283', '27484', '李文发', '3be6ed9fa6952e2d', '8a3a0768', 'Z01A02A04',
  1, 0, 1, '27484', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 920
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27484');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1549839504287487366', '3724849475958933283', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3724849475958933283' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9431257528074223445', '27486', '张潇', 'cfcb5ff4b5fba841', '679dbff9', 'Z01A02A04',
  1, 0, 1, '27486', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 930
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27486');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1988860279487764166', '9431257528074223445', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9431257528074223445' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3881789454302863176', '27487', '谢郭涛', 'fa21a0603e905c4e', 'd6cc9751', 'Z01A02A04',
  1, 0, 1, '27487', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 940
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27487');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6179366927678473429', '3881789454302863176', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3881789454302863176' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5786278883805130619', '27488', '罗佳宝', '9b3b35d724ea0280', '8a84bd4e', 'Z01A02A04',
  1, 0, 1, '27488', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 950
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27488');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1304451058837612751', '5786278883805130619', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5786278883805130619' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8036967460563241342', '27489', '李正宇', 'dc080e3523d2e55a', 'aec7f810', 'Z01A02A04',
  1, 0, 1, '27489', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 960
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27489');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7432526174336418221', '8036967460563241342', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8036967460563241342' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2743749558245552282', '27524', '覃健进', 'f16b7f42d2756515', '4f2ca69e', 'Z01A02A04',
  1, 0, 1, '27524', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 970
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27524');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6047255844833317943', '2743749558245552282', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2743749558245552282' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1204562316624449665', '27529', '盆俊杰', '0f670280e0c4c778', '95ced88f', 'Z01A02A04',
  1, 0, 1, '27529', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 980
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27529');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3991077041784015356', '1204562316624449665', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1204562316624449665' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3876518692323139653', '27541', '贾彭朕', '8d1d41abb6c73917', 'f0bec959', 'Z01A02A04',
  1, 0, 1, '27541', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 990
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27541');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1271885445150029207', '3876518692323139653', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3876518692323139653' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5869559495484796879', '27549', '周灏', '0143063e6d6271be', '834f38f7', 'Z01A02A04',
  1, 0, 1, '27549', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 1000
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27549');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4124902229240953329', '5869559495484796879', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5869559495484796879' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8554433463654893884', '27553', '王旭', '9fe024fbb2fa1aa2', 'f0f9d160', 'Z01A02A04',
  1, 0, 1, '27553', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 1010
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27553');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1529551806891351430', '8554433463654893884', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8554433463654893884' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6857313560221158255', '27714', '彭世高', '8848ec56c9d636be', '1b66ea21', 'Z01A02A04',
  1, 0, 1, '27714', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 1020
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27714');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2914101143836978614', '6857313560221158255', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6857313560221158255' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6690512067723228309', '27718', '谢俊辉', 'ded56efb17c45a5f', '78bcb2fc', 'Z01A02A04',
  1, 0, 1, '27718', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 1030
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27718');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7277792737375934795', '6690512067723228309', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6690512067723228309' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1492650222375241923', '27779', '梁崇掌', 'f6517627d1a8cdef', '57af9b2f', 'Z01A02A04',
  1, 0, 1, '27779', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 1040
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27779');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9375518658047088879', '1492650222375241923', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1492650222375241923' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7401463376322179601', '27786', '黄英树', '421c60f67b9e2965', 'ac0f8ce3', 'Z01A02A04',
  1, 0, 1, '27786', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 1050
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27786');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7394759238077539644', '7401463376322179601', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7401463376322179601' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6901059766561945981', '27791', '熊丹', '0a24bf576cca13d9', '67c01580', 'Z01A02A04',
  1, 0, 1, '27791', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 1060
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27791');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2977763141336147569', '6901059766561945981', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6901059766561945981' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2948211644110550022', '27793', '田维坤', '5bf825431a717863', '6d99fbd9', 'Z01A02A04',
  1, 0, 1, '27793', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 1070
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27793');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1294115991345246729', '2948211644110550022', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2948211644110550022' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7544190011282759700', '27805', '熊亮', 'feece7d2426612b6', '08f3438f', 'Z01A02A04',
  1, 0, 1, '27805', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 1080
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27805');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4589855221640317796', '7544190011282759700', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7544190011282759700' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3379516124839610140', '27814', '李跃龙', '56df1d6e7f4b6493', 'e548424c', 'Z01A02A04',
  1, 0, 1, '27814', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 1090
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27814');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2177352898757019692', '3379516124839610140', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3379516124839610140' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8078632576029218334', '27830', '李星悦', 'd0d09abab6bc2781', '0ca20ed7', 'Z01A02A04',
  1, 0, 1, '27830', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 1100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27830');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4654469932138327611', '8078632576029218334', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8078632576029218334' AND `dep_id` = '9754573822162691658'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1113290763580282272', '27864', '肖坤林', '42c2b41e49732a28', '14946b99', 'Z01A02A04',
  1, 0, 1, '27864', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 1110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27864');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4107456227346340552', '1113290763580282272', '9754573822162691658'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1113290763580282272' AND `dep_id` = '9754573822162691658'
);


-- 组别：钳工组 (Z01A02A05)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1048597431142884012', '02936', '苏丰收', '5170610c3d0805fa', '10c75c1e', 'Z01A02A05',
  1, 0, 1, '02936', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02936');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8793656087536475558', '1048597431142884012', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1048597431142884012' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7152933690523786187', '04154', '韦广甜', '095ae6bbb74c5f74', '22cd06ec', 'Z01A02A05',
  1, 0, 1, '04154', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04154');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3425927885535077233', '7152933690523786187', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7152933690523786187' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1807428772329353368', '04571', '颜伟仔', 'fac8e2f1130d7256', 'f7b6619b', 'Z01A02A05',
  1, 0, 1, '04571', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04571');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3533023959075758887', '1807428772329353368', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1807428772329353368' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1246689349695521067', '05592', '罗洲文', 'e2e659213ccee129', '9aaacca0', 'Z01A02A05',
  1, 0, 1, '05592', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05592');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3530988437826230243', '1246689349695521067', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1246689349695521067' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6349617676465297868', '06589', '张东', 'e456f9af50ee2d17', '4bdb21d7', 'Z01A02A05',
  1, 0, 1, '06589', 'admin', NOW(), 'admin', NOW(), 1, 0, '清洗工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06589');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8000993787330334544', '6349617676465297868', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6349617676465297868' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8230615675129071475', '13913', '李绍聪', '8d504b1597e69271', 'e46af3ad', 'Z01A02A05',
  1, 0, 1, '13913', 'admin', NOW(), 'admin', NOW(), 1, 0, '装配工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13913');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2907697940119297009', '8230615675129071475', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8230615675129071475' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2435690251035438100', '14996', '周浩', '1028dd1a943623e8', '6c4a1df3', 'Z01A02A05',
  1, 0, 1, '14996', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14996');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4864492753818455659', '2435690251035438100', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2435690251035438100' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3567099122203355675', '15565', '唐伟', 'c77f0d1972902e3a', 'bd09d6f1', 'Z01A02A05',
  1, 0, 1, '15565', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15565');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1638542539834709033', '3567099122203355675', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3567099122203355675' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9547698741483798090', '15912', '肖应新', '89e90cc30d566791', '7afda9b7', 'Z01A02A05',
  1, 0, 1, '15912', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15912');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6644822035257638610', '9547698741483798090', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9547698741483798090' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8942188209006737699', '17394', '应春美', 'c28ede2fc234f4b5', '8af71ab7', 'Z01A02A05',
  1, 0, 1, '17394', 'admin', NOW(), 'admin', NOW(), 1, 0, '清洗工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17394');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3182580056960726742', '8942188209006737699', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8942188209006737699' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9793008199178568992', '17400', '吕湘春', '09548235d76113fc', '93f446b6', 'Z01A02A05',
  1, 0, 1, '17400', 'admin', NOW(), 'admin', NOW(), 1, 0, '清洗工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17400');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5011423511179717897', '9793008199178568992', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9793008199178568992' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8667465085988113298', '18927', '卢碧霞', 'db54f4c672807d67', 'a4368fda', 'Z01A02A05',
  1, 0, 1, '18927', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18927');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7465056455653796477', '8667465085988113298', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8667465085988113298' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9687643164282668263', '19186', '甘建青', '592b37570b885935', 'e30174d5', 'Z01A02A05',
  1, 0, 1, '19186', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19186');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9981546551267558152', '9687643164282668263', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9687643164282668263' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1062851234965760768', '23402', '王小雨', 'bcf4926b7e70a000', 'facde484', 'Z01A02A05',
  1, 0, 1, '23402', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23402');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8357273403075436221', '1062851234965760768', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1062851234965760768' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6194477017985265806', '24485', '吕湘', '1dddcd2dac7608ae', '9bfdb457', 'Z01A02A05',
  1, 0, 1, '24485', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24485');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8955547329812061909', '6194477017985265806', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6194477017985265806' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1423184902330319700', '25909', '谭敏', 'eade867964b8c7c5', 'fab56145', 'Z01A02A05',
  1, 0, 1, '25909', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25909');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7716797242586724679', '1423184902330319700', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1423184902330319700' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8291302393503125765', '26031', '陈添明', 'dd48bc2a95066f44', '478c90db', 'Z01A02A05',
  1, 0, 1, '26031', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26031');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6325732293377613802', '8291302393503125765', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8291302393503125765' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3347859300440826232', '26114', '吴石瑞', '8356b4a93e39e795', 'c0ce8394', 'Z01A02A05',
  1, 0, 1, '26114', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26114');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5824963921921713439', '3347859300440826232', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3347859300440826232' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4979167753413349727', '26147', '唐漳', 'f7b8fadf2c8e59fa', 'a6b93872', 'Z01A02A05',
  1, 0, 1, '26147', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26147');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5001486611837524047', '4979167753413349727', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4979167753413349727' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2608561569237946846', '26149', '訾远涛', '8c5ccb53fdf8270a', '4d7e25a2', 'Z01A02A05',
  1, 0, 1, '26149', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26149');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4703849250227311301', '2608561569237946846', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2608561569237946846' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7044020517152176747', '26152', '贺青洋', '824b503660bfa6bf', 'fc63bcc5', 'Z01A02A05',
  1, 0, 1, '26152', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26152');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4561157158082944442', '7044020517152176747', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7044020517152176747' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4249060999548298411', '26194', '张红梅', '1cc81bb0e2380df8', 'fb5ccd2e', 'Z01A02A05',
  1, 0, 1, '26194', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26194');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6645846307812013208', '4249060999548298411', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4249060999548298411' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1353917357510578462', '26220', '刘金玉', '8a6e6922ce878bc5', '6393d972', 'Z01A02A05',
  1, 0, 1, '26220', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26220');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8869125244512766400', '1353917357510578462', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1353917357510578462' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8019637970751763478', '26417', '李艳芝', '5de4b6376a020d81', '7916c40e', 'Z01A02A05',
  1, 0, 1, '26417', 'admin', NOW(), 'admin', NOW(), 1, 0, '普工', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26417');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3283708283660436994', '8019637970751763478', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8019637970751763478' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3017029087627832343', '26492', '白晓慧', 'cbe8176fbb62126f', '4632e4f0', 'Z01A02A05',
  1, 0, 1, '26492', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26492');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2656300838041050707', '3017029087627832343', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3017029087627832343' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6770480586161936116', '26765', '廖茹丹', 'fc21bd302c20d942', 'e3b6634c', 'Z01A02A05',
  1, 0, 1, '26765', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26765');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6112191969789814446', '6770480586161936116', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6770480586161936116' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8863267633103659717', '26907', '刘广贞', 'fa641b816cb97131', '0d16a6e2', 'Z01A02A05',
  1, 0, 1, '26907', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26907');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6822903524284253743', '8863267633103659717', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8863267633103659717' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3772141998559134391', '26940', '李娟', '3bc87b36180bb9d2', 'e1bab990', 'Z01A02A05',
  1, 0, 1, '26940', 'admin', NOW(), 'admin', NOW(), 1, 0, '清洗工', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26940');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1277578943315969529', '3772141998559134391', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3772141998559134391' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2505946970512831176', '26960', '谢冬丽', '3379caf3eb12d7c3', '60406139', 'Z01A02A05',
  1, 0, 1, '26960', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26960');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7308521760903199327', '2505946970512831176', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2505946970512831176' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1471811368187994814', '27009', '谢志勇', '6a9e6d392776aac6', 'ac681a6d', 'Z01A02A05',
  1, 0, 1, '27009', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27009');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5432903568808184880', '1471811368187994814', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1471811368187994814' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3062690139992889339', '27026', '曾赐泽', '1b9fb9b624c4663a', '48ceb102', 'Z01A02A05',
  1, 0, 1, '27026', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27026');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9818289337290993026', '3062690139992889339', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3062690139992889339' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7386251432359410667', '27029', '李锦东', '4ddffc425a03fea2', '51baef31', 'Z01A02A05',
  1, 0, 1, '27029', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27029');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3709677411589176736', '7386251432359410667', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7386251432359410667' AND `dep_id` = '4769991788055081951'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3961171462583257848', '27315', '刘阳', '5222ca95ee22d7b4', '7c7e9cd9', 'Z01A02A05',
  1, 0, 1, '27315', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27315');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9820581214261221862', '3961171462583257848', '4769991788055081951'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3961171462583257848' AND `dep_id` = '4769991788055081951'
);


-- 组别：车床组 (Z01A02A06)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2672004200532167852', '04124', '成伟杰', '42aff65401abfd28', '33e29127', 'Z01A02A06',
  1, 0, 1, '04124', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04124');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1829206690214085711', '2672004200532167852', '4548098076592638827'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2672004200532167852' AND `dep_id` = '4548098076592638827'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5598493871363972342', '07521', '谢赛君', 'a706fe3f20debf41', 'd9438e8c', 'Z01A02A06',
  1, 0, 1, '07521', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07521');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6169867624954020390', '5598493871363972342', '4548098076592638827'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5598493871363972342' AND `dep_id` = '4548098076592638827'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4229124977280878963', '09904', '陈国初', '389030d4cbbd8d7d', 'ecbca7fa', 'Z01A02A06',
  1, 0, 1, '09904', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09904');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1556097557501472945', '4229124977280878963', '4548098076592638827'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4229124977280878963' AND `dep_id` = '4548098076592638827'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5558463837423534644', '16642', '袁文', '8056da0fff5a1d94', '6b133f7d', 'Z01A02A06',
  1, 0, 1, '16642', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16642');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8730113794307929210', '5558463837423534644', '4548098076592638827'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5558463837423534644' AND `dep_id` = '4548098076592638827'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6335502472153858031', '22676', '莫洪杰', '4b2747ab7e31efcf', '4c5913d3', 'Z01A02A06',
  1, 0, 1, '22676', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22676');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1109636327495989590', '6335502472153858031', '4548098076592638827'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6335502472153858031' AND `dep_id` = '4548098076592638827'
);


-- 组别：IMCNC组 (Z01A02A07)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8543170454710895272', '04240', '刘朋', '0b1b3c381b223503', '0c6b53c7', 'Z01A02A07',
  1, 0, 1, '04240', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04240');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8283235534192564044', '8543170454710895272', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8543170454710895272' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9599114873591036431', '04509', '莫谋欧', 'dcbf0230d59e2818', 'fcedf3fb', 'Z01A02A07',
  1, 0, 1, '04509', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04509');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4322454551826185072', '9599114873591036431', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9599114873591036431' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2419562583333589591', '04926', '梁昭业', '03abaa2c12a6435c', '603f8e16', 'Z01A02A07',
  1, 0, 1, '04926', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04926');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4336630695053997632', '2419562583333589591', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2419562583333589591' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5394980891117388443', '04927', '梁春源', '2a8487f1ef8e6bdb', '4a245c6b', 'Z01A02A07',
  1, 0, 1, '04927', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04927');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7327456352662701210', '5394980891117388443', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5394980891117388443' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2547779431633386615', '08126', '李龙', 'e35451b5a5be99a0', '9f82d92b', 'Z01A02A07',
  1, 0, 1, '08126', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08126');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9549620181798785133', '2547779431633386615', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2547779431633386615' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8868080054336420372', '08171', '雷锋土', 'ceab49b79bb901dc', '381c92f2', 'Z01A02A07',
  1, 0, 1, '08171', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08171');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5548112069717248360', '8868080054336420372', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8868080054336420372' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8823906415188046850', '08411', '翁运建', '9403393c659e885a', '49a1ef6c', 'Z01A02A07',
  1, 0, 1, '08411', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08411');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8749574686136606548', '8823906415188046850', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8823906415188046850' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3052353190758715158', '08511', '苏火荣', '54893a48db3ba8b0', '184579dd', 'Z01A02A07',
  1, 0, 1, '08511', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08511');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7013358670823031388', '3052353190758715158', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3052353190758715158' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1210123900655909283', '09910', '谢功达', '43ad8dc7123683c6', 'cfe72666', 'Z01A02A07',
  1, 0, 1, '09910', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09910');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7613669700547464134', '1210123900655909283', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1210123900655909283' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5077620822524166010', '09934', '刘湖东', 'f1ec23fa83804657', '2ed597b3', 'Z01A02A07',
  1, 0, 1, '09934', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09934');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6214521819931529674', '5077620822524166010', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5077620822524166010' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6690018123640018336', '12010', '曾新宇', 'a58082ce37e1ec8c', 'b9b56ff4', 'Z01A02A07',
  1, 0, 1, '12010', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12010');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4819347278057707047', '6690018123640018336', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6690018123640018336' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4794456560008323899', '15390', '黄灿铭', '1a131ec76b2b23d5', '61877f12', 'Z01A02A07',
  1, 0, 1, '15390', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15390');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9563483347668270229', '4794456560008323899', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4794456560008323899' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1415886451325561023', '17089', '王建荣', 'f3c4d6a7d1a5ece2', 'cef7f67d', 'Z01A02A07',
  1, 0, 1, '17089', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17089');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1106599334900533124', '1415886451325561023', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1415886451325561023' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9936118854152965360', '19609', '宁新豪', 'a42f6b89aa57b335', 'd9f197b4', 'Z01A02A07',
  1, 0, 1, '19609', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19609');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4575093405968089084', '9936118854152965360', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9936118854152965360' AND `dep_id` = '7981672569808741619'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8799552458064511313', '19825', '石求兵', 'd15223a5958f1860', 'e42758d8', 'Z01A02A07',
  1, 0, 1, '19825', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19825');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4477252141027954455', '8799552458064511313', '7981672569808741619'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8799552458064511313' AND `dep_id` = '7981672569808741619'
);

