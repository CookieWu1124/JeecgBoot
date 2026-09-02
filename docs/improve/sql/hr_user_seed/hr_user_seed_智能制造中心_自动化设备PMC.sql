-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 自动化设备PMC
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
  '1053418610151191268', '9372856559755238914', '自动化设备PMC', 7, '2', 'DEPT', 'Z01A07',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A07');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4002411630198746175', '1053418610151191268', '订单管理组', 1, '2', 'GROUP', 'Z01A07A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A07A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4326598418418154053', '1053418610151191268', '自动化设备PMC', 2, '2', 'GROUP', 'Z01A07A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A07A02');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '7653205597919897440', '1053418610151191268', '计划组', 3, '2', 'GROUP', 'Z01A07A03',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A07A03');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 自动化设备PMC
-- -----------------------------------------------------------------------------


-- 组别：订单管理组 (Z01A07A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2650701415166251233', '01827', '谢鹏飞', 'eac7b066946a2804', '89690acd', 'Z01A07A01',
  1, 0, 1, '01827', 'admin', NOW(), 'admin', NOW(), 1, 0, '副经理', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01827');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1457663920481864756', '2650701415166251233', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2650701415166251233' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6618825361267102290', '03330', '李深根', '1456a7357b5ff5ea', '12e16c6b', 'Z01A07A01',
  1, 0, 1, '03330', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03330');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2520304639711566856', '6618825361267102290', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6618825361267102290' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2793032208630773420', '07547', '黄栋材', 'f15d26a880ea4bae', '7beceda1', 'Z01A07A01',
  1, 0, 1, '07547', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07547');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4196426154600360403', '2793032208630773420', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2793032208630773420' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4707417309637366072', '13736', '蒋树林', '22726ff476f02ee2', '1e3228ce', 'Z01A07A01',
  1, 0, 1, '13736', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13736');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1418413783481008383', '4707417309637366072', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4707417309637366072' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3983875981915636866', '13781', '徐伟君', '329f237737de290d', 'd6f3d22f', 'Z01A07A01',
  1, 0, 1, '13781', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13781');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9288573848714416321', '3983875981915636866', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3983875981915636866' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6358710943545731607', '13998', '欧阳林', '9d93f2f5e08fc1e2', 'b4dbd2ac', 'Z01A07A01',
  1, 0, 1, '13998', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级PE工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13998');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5377320095263087713', '6358710943545731607', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6358710943545731607' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5005849440107833148', '14122', '王志梅', 'a7e629e7601d154e', '07766caf', 'Z01A07A01',
  1, 0, 1, '14122', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14122');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5966728029079957688', '5005849440107833148', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5005849440107833148' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1089405876848201591', '14606', '肖伟', '75c2ff69d23c1a8b', '41d4054d', 'Z01A07A01',
  1, 0, 1, '14606', 'admin', NOW(), 'admin', NOW(), 1, 0, 'PE工程师', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14606');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9275809363316761394', '1089405876848201591', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1089405876848201591' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1443842173708405525', '14826', '肖林林', '4e32c85ae84be994', '7b624716', 'Z01A07A01',
  1, 0, 1, '14826', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14826');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8252815284979552241', '1443842173708405525', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1443842173708405525' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5386977077734719705', '14911', '黄江杰', '50107868bcadd570', '4866f83d', 'Z01A07A01',
  1, 0, 1, '14911', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14911');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4293165739489212311', '5386977077734719705', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5386977077734719705' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2702864969085170859', '16937', '李鑫', 'a9ed3a2e26fedd96', '9734b7c1', 'Z01A07A01',
  1, 0, 1, '16937', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理项目工程师', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16937');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8008541157408967279', '2702864969085170859', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2702864969085170859' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5966134949806725454', '24902', '王悦', 'f5cf48a719aff0bf', '7dc8f76e', 'Z01A07A01',
  1, 0, 1, '24902', 'admin', NOW(), 'admin', NOW(), 1, 0, '工程师', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24902');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1931039990539006590', '5966134949806725454', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5966134949806725454' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8056358078082803138', '26131', '秦金胜', 'c85efa84a1b2b6e2', '510a505f', 'Z01A07A01',
  1, 0, 1, '26131', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26131');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7063191089199708744', '8056358078082803138', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8056358078082803138' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4091936750200227510', '26730', '姜艳红', 'cac0f7f69e01700b', '4e6ee694', 'Z01A07A01',
  1, 0, 1, '26730', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26730');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6788184058657404262', '4091936750200227510', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4091936750200227510' AND `dep_id` = '4002411630198746175'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3762093697243564842', '27790', '欧阳燕', 'f1d2780b747b66a2', '633e67ad', 'Z01A07A01',
  1, 0, 1, '27790', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27790');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8115340633897297230', '3762093697243564842', '4002411630198746175'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3762093697243564842' AND `dep_id` = '4002411630198746175'
);


-- 组别：自动化设备PMC (Z01A07A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9524043983333994646', '01790', '林杰', '2844cd7650c0a1d8', '6fc798c3', 'Z01A07A02',
  1, 0, 1, '01790', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级经理', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01790');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4371779265244878999', '9524043983333994646', '4326598418418154053'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9524043983333994646' AND `dep_id` = '4326598418418154053'
);


-- 组别：计划组 (Z01A07A03)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4774716869408931097', '05577', '库锡加', '0d79541f26568bc9', '28632352', 'Z01A07A03',
  1, 0, 1, '05577', 'admin', NOW(), 'admin', NOW(), 1, 0, '主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05577');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6170912852243194250', '4774716869408931097', '7653205597919897440'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4774716869408931097' AND `dep_id` = '7653205597919897440'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8672473295896771457', '06378', '蒋燕丽', '11ae369b633d0e95', 'a34cee38', 'Z01A07A03',
  1, 0, 1, '06378', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06378');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6682740993010218300', '8672473295896771457', '7653205597919897440'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8672473295896771457' AND `dep_id` = '7653205597919897440'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9924644935336320952', '06810', '林燕', 'a5cdb632d4727e1d', '24a49f07', 'Z01A07A03',
  1, 0, 1, '06810', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06810');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3182862894627539056', '9924644935336320952', '7653205597919897440'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9924644935336320952' AND `dep_id` = '7653205597919897440'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4579109744288469423', '08874', '陈之坤', '1301b69f94f915d1', '4f790b76', 'Z01A07A03',
  1, 0, 1, '08874', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08874');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3737703000818766846', '4579109744288469423', '7653205597919897440'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4579109744288469423' AND `dep_id` = '7653205597919897440'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1798054120213311298', '13136', '王余婷', 'e674bfdcf10cbb91', '1816e888', 'Z01A07A03',
  1, 0, 1, '13136', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13136');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8774838074003332257', '1798054120213311298', '7653205597919897440'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1798054120213311298' AND `dep_id` = '7653205597919897440'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7065888757397431620', '24899', '陈林', '303b50e1f331d38b', '740553bb', 'Z01A07A03',
  1, 0, 1, '24899', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24899');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6907555865986301330', '7065888757397431620', '7653205597919897440'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7065888757397431620' AND `dep_id` = '7653205597919897440'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6404157500152289222', '26138', '许凤', 'd99069cb5320d2a1', 'a780d933', 'Z01A07A03',
  1, 0, 1, '26138', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26138');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9216978697220842215', '6404157500152289222', '7653205597919897440'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6404157500152289222' AND `dep_id` = '7653205597919897440'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5083499497496575829', '27152', '孙传', '7aabc9a3bf0c6a30', '43dbfd6e', 'Z01A07A03',
  1, 0, 1, '27152', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27152');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9176766076389178412', '5083499497496575829', '7653205597919897440'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5083499497496575829' AND `dep_id` = '7653205597919897440'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6051240595598569220', '27304', '聂瑶歌', 'b644368d51cd330b', '665c2dbc', 'Z01A07A03',
  1, 0, 1, '27304', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27304');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3835094454616445886', '6051240595598569220', '7653205597919897440'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6051240595598569220' AND `dep_id` = '7653205597919897440'
);

