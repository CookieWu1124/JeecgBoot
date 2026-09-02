-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 钣金部
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
  '9784847798484275846', '9372856559755238914', '钣金部', 10, '2', 'DEPT', 'Z01A10',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A10');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '2403632151673875771', '9784847798484275846', '生产组', 1, '2', 'GROUP', 'Z01A10A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A10A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '2581647770585339700', '9784847798484275846', '工程组', 2, '2', 'GROUP', 'Z01A10A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A10A02');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 钣金部
-- -----------------------------------------------------------------------------


-- 组别：生产组 (Z01A10A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5000635322353275647', '02534', '崔自莹', '1b30742ffb1b4c09', '4e98c4f5', 'Z01A10A01',
  1, 0, 1, '02534', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02534');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5054995291522730256', '5000635322353275647', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5000635322353275647' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1928673416931581790', '03798', '陈德勇', 'bdb742da6b79bb75', '537e6369', 'Z01A10A01',
  1, 0, 1, '03798', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03798');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6458726824271734152', '1928673416931581790', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1928673416931581790' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9092952836585006897', '03897', '邹友平', 'd5109cf60b662041', 'ff44bffb', 'Z01A10A01',
  1, 0, 1, '03897', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03897');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3532735410622220851', '9092952836585006897', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9092952836585006897' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6357008085311333895', '04489', '向阳春', '3ad42b1c088a8a04', 'fb853906', 'Z01A10A01',
  1, 0, 1, '04489', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04489');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3618769815861873282', '6357008085311333895', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6357008085311333895' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9050673585925483719', '04658', '张海兵', '481abd8872a6bcba', 'c38a6e99', 'Z01A10A01',
  1, 0, 1, '04658', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04658');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3926771799736388874', '9050673585925483719', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9050673585925483719' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8916618930052176324', '05743', '李加胜', '940ca25b3de8086d', '669c9518', 'Z01A10A01',
  1, 0, 1, '05743', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05743');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1716194298310602537', '8916618930052176324', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8916618930052176324' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4822393059982138775', '05753', '黎定顺', '301e80999c7ed339', 'dcc839c4', 'Z01A10A01',
  1, 0, 1, '05753', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05753');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8998303782200409191', '4822393059982138775', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4822393059982138775' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9545412584524237167', '05920', '李尚均', '78fc56263abd4d54', 'fb629387', 'Z01A10A01',
  1, 0, 1, '05920', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05920');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9566726381684380769', '9545412584524237167', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9545412584524237167' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2353265471635844823', '05940', '李化明', 'bceaa3b4c1887fb9', 'd15ab189', 'Z01A10A01',
  1, 0, 1, '05940', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05940');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1081215946445950886', '2353265471635844823', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2353265471635844823' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2394191233169960615', '06556', '李伟', '13b6140f7bf29222', '446c24f0', 'Z01A10A01',
  1, 0, 1, '06556', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06556');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6596048316754415617', '2394191233169960615', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2394191233169960615' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9429373398530843772', '07459', '黄飞', '7bb1ccf03a909633', 'ffe2fd2d', 'Z01A10A01',
  1, 0, 1, '07459', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07459');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6614883162069862730', '9429373398530843772', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9429373398530843772' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5075526718010465798', '07655', '张衡武', 'b88a972c6851753e', 'bc3485ee', 'Z01A10A01',
  1, 0, 1, '07655', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07655');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8993990088135887293', '5075526718010465798', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5075526718010465798' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4979875118552245599', '07689', '谢全文', '7a79a32f3d743fe8', 'df7bf3d3', 'Z01A10A01',
  1, 0, 1, '07689', 'admin', NOW(), 'admin', NOW(), 1, 0, '镭射工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07689');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7235260745583280352', '4979875118552245599', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4979875118552245599' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4794052869182035922', '07961', '周美才', 'd6581f61a98304f6', 'd1cfaa10', 'Z01A10A01',
  1, 0, 1, '07961', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07961');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3808872225058446110', '4794052869182035922', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4794052869182035922' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9422981724780502638', '08010', '王立更', 'c14e92a53712819d', '24c5941c', 'Z01A10A01',
  1, 0, 1, '08010', 'admin', NOW(), 'admin', NOW(), 1, 0, '镭射工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08010');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9119491119956946171', '9422981724780502638', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9422981724780502638' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1206673013504580034', '08019', '赵朋', 'cd9ed87edc07c3c1', '6d35209e', 'Z01A10A01',
  1, 0, 1, '08019', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08019');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5909821296055799352', '1206673013504580034', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1206673013504580034' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6981711634118223272', '08403', '尹华林', '61fa7fa916c3ca8d', '7eef2d95', 'Z01A10A01',
  1, 0, 1, '08403', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08403');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6250507175147165895', '6981711634118223272', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6981711634118223272' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5413327158925436203', '08447', '陈守平', '365b434794ec02ab', '0c918d03', 'Z01A10A01',
  1, 0, 1, '08447', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08447');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7378002366498894912', '5413327158925436203', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5413327158925436203' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7882189570627883840', '08537', '文爽', '2fb8ddf13ea8a7a0', 'e366bfeb', 'Z01A10A01',
  1, 0, 1, '08537', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08537');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6376856241044373588', '7882189570627883840', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7882189570627883840' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7423040783253596915', '08542', '谢王文', '3dbc020a4627913a', 'ed29a364', 'Z01A10A01',
  1, 0, 1, '08542', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08542');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9470128227046294014', '7423040783253596915', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7423040783253596915' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8738335513158896514', '08544', '苏成国', '63620e8eafb65db4', 'c96e295c', 'Z01A10A01',
  1, 0, 1, '08544', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08544');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9542150128423801464', '8738335513158896514', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8738335513158896514' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4375467530278745120', '08636', '王敢', '33521111988af5e3', '9644e853', 'Z01A10A01',
  1, 0, 1, '08636', 'admin', NOW(), 'admin', NOW(), 1, 0, '镭射工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08636');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1861576284017535438', '4375467530278745120', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4375467530278745120' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7256090187659760031', '08642', '胡双仔', 'b22194f9692c5986', 'caed7fb4', 'Z01A10A01',
  1, 0, 1, '08642', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08642');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1281367565745984721', '7256090187659760031', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7256090187659760031' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6167156618235039445', '10668', '王靠周', 'c98010bf614df915', 'fcc09486', 'Z01A10A01',
  1, 0, 1, '10668', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10668');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3418880340174129097', '6167156618235039445', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6167156618235039445' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8691610810431408110', '10973', '赵虎', 'd9bdd2c8ff59a787', '27cb2efd', 'Z01A10A01',
  1, 0, 1, '10973', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10973');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9691973456900672420', '8691610810431408110', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8691610810431408110' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4902566506783900070', '11440', '谢健崇', 'fc81f169631a6623', '9f3a21ff', 'Z01A10A01',
  1, 0, 1, '11440', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11440');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4363339394037143058', '4902566506783900070', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4902566506783900070' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3148242944686540526', '11478', '廖圣明', 'bfaf9d4665273a11', '5266be26', 'Z01A10A01',
  1, 0, 1, '11478', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11478');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4855692502740445556', '3148242944686540526', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3148242944686540526' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7803754007331322824', '11547', '龙刚', '81a8f1b75ecd649e', '0c24c4b1', 'Z01A10A01',
  1, 0, 1, '11547', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11547');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2702818020471632441', '7803754007331322824', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7803754007331322824' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6453550786177029664', '12492', '周礼军', '280123a53999f54a', '137d9d45', 'Z01A10A01',
  1, 0, 1, '12492', 'admin', NOW(), 'admin', NOW(), 1, 0, '折弯工', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12492');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1099473751301013678', '6453550786177029664', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6453550786177029664' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5804412937500083179', '12499', '温华创', '8de337e50f9d47e3', '6eff42b4', 'Z01A10A01',
  1, 0, 1, '12499', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12499');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2835298963275985299', '5804412937500083179', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5804412937500083179' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4444443047079156136', '13814', '张旺', 'f7178c9f3a1d6ec8', '020e213c', 'Z01A10A01',
  1, 0, 1, '13814', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13814');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3826510665084833939', '4444443047079156136', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4444443047079156136' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6454791550108579396', '13892', '唐志勇', '2268bca7cfd908d7', 'bc594bb3', 'Z01A10A01',
  1, 0, 1, '13892', 'admin', NOW(), 'admin', NOW(), 1, 0, '折弯工', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13892');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9369453037692506710', '6454791550108579396', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6454791550108579396' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3987629873865972875', '14594', '王先华', '54330517121e40de', '958b4260', 'Z01A10A01',
  1, 0, 1, '14594', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14594');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8627981898705333214', '3987629873865972875', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3987629873865972875' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9169664649347402683', '14595', '陈仕平', '6fb4a6ef6e8b6d4c', '6b227858', 'Z01A10A01',
  1, 0, 1, '14595', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14595');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4094678281955586672', '9169664649347402683', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9169664649347402683' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5861697162546567538', '14787', '贺文亮', 'f5e3e3ccd6615890', '88a13a9f', 'Z01A10A01',
  1, 0, 1, '14787', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14787');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6877027630023761069', '5861697162546567538', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5861697162546567538' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6396856295538866753', '14966', '李银风', 'ce9748c2180ccf40', 'fd18434c', 'Z01A10A01',
  1, 0, 1, '14966', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14966');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7908778530858755358', '6396856295538866753', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6396856295538866753' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9374179522795923287', '15134', '窦龙波', 'dc7cc97aacd7747e', '050c06a3', 'Z01A10A01',
  1, 0, 1, '15134', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15134');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7482445826439377815', '9374179522795923287', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9374179522795923287' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7800120639632978727', '15141', '杨胜齐', '38d7368da213ac78', '094a9a47', 'Z01A10A01',
  1, 0, 1, '15141', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 380
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15141');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5652245274612617101', '7800120639632978727', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7800120639632978727' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4227043675030601663', '15159', '胡义钢', '44dcc3d518dd5910', 'e5500532', 'Z01A10A01',
  1, 0, 1, '15159', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 390
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15159');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5177232464963285708', '4227043675030601663', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4227043675030601663' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2147305742773673581', '15285', '王天德', '3992398b3effc9d5', 'f7c826b1', 'Z01A10A01',
  1, 0, 1, '15285', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 400
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15285');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4842782870282747081', '2147305742773673581', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2147305742773673581' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3468128273528995736', '15352', '徐家京', '23763f9caa44ac3f', '8fcc8714', 'Z01A10A01',
  1, 0, 1, '15352', 'admin', NOW(), 'admin', NOW(), 1, 0, '抛光', 410
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15352');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6180003892311032286', '3468128273528995736', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3468128273528995736' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6874445537167726927', '15635', '武端勇', 'f99ca85e4140aa3c', '92325480', 'Z01A10A01',
  1, 0, 1, '15635', 'admin', NOW(), 'admin', NOW(), 1, 0, '折弯工', 420
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15635');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6934183019145791292', '6874445537167726927', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6874445537167726927' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5904475594093841893', '15705', '何伟', 'e0402ce78fe3b46f', 'add446e9', 'Z01A10A01',
  1, 0, 1, '15705', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 430
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15705');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3379552575585171770', '5904475594093841893', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5904475594093841893' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2723667544052160365', '16881', '邹林臣', '98b16682f921fa10', '6b587c99', 'Z01A10A01',
  1, 0, 1, '16881', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 440
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16881');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4993232183193101826', '2723667544052160365', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2723667544052160365' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1425451809913733977', '17114', '杨彩云', '2371c3bf9b564ed6', '96d8c170', 'Z01A10A01',
  1, 0, 1, '17114', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 450
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17114');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2850152515998625413', '1425451809913733977', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1425451809913733977' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7740919688357249000', '17890', '胡怀伟', '28347c92c8a07de0', '2bdd1533', 'Z01A10A01',
  1, 0, 1, '17890', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 460
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17890');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7288632014230352482', '7740919688357249000', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7740919688357249000' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7117127347113931050', '18031', '李凯', '468318acee15ccac', '7305a11c', 'Z01A10A01',
  1, 0, 1, '18031', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 470
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18031');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2977878236910601072', '7117127347113931050', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7117127347113931050' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8776891215117368517', '19360', '张维', '20e8d5fccd0b0bd1', '55ddc795', 'Z01A10A01',
  1, 0, 1, '19360', 'admin', NOW(), 'admin', NOW(), 1, 0, '折弯工', 480
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19360');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2770797122050294986', '8776891215117368517', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8776891215117368517' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3620634457100009388', '19541', '陈志凯', '478a636f3a31ad0b', 'b9f17791', 'Z01A10A01',
  1, 0, 1, '19541', 'admin', NOW(), 'admin', NOW(), 1, 0, '折弯工', 490
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19541');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6422534791356377965', '3620634457100009388', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3620634457100009388' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1353083764922762830', '20833', '刘名宝', '173d040e224e38f2', '09653326', 'Z01A10A01',
  1, 0, 1, '20833', 'admin', NOW(), 'admin', NOW(), 1, 0, '镭射工', 500
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20833');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9435637195327731552', '1353083764922762830', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1353083764922762830' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2316072523139900488', '22693', '田杨平', 'a6b89b3d1b17fb20', '0ad6e7d8', 'Z01A10A01',
  1, 0, 1, '22693', 'admin', NOW(), 'admin', NOW(), 1, 0, '镭射工', 510
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22693');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3184651725735927373', '2316072523139900488', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2316072523139900488' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6608564887400462496', '22991', '赖和南', 'd0b290af24ee8336', '460af188', 'Z01A10A01',
  1, 0, 1, '22991', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 520
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22991');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1914382955776379651', '6608564887400462496', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6608564887400462496' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1548257384191709888', '23591', '李新尚', '26a4c54bb1545049', '377f5edf', 'Z01A10A01',
  1, 0, 1, '23591', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 530
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23591');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1662941261050209499', '1548257384191709888', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1548257384191709888' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8293732115654288582', '23891', '廖韬', '2dcd86a15d8349ec', 'b6afb04a', 'Z01A10A01',
  1, 0, 1, '23891', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 540
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23891');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8710586773512072053', '8293732115654288582', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8293732115654288582' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8190023952198462024', '23912', '覃文权', '4e5285a187a7165f', '2d637049', 'Z01A10A01',
  1, 0, 1, '23912', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 550
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23912');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7421510111192973921', '8190023952198462024', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8190023952198462024' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6050882485153631347', '23975', '余文康', '24be6224bc342605', '560ec83f', 'Z01A10A01',
  1, 0, 1, '23975', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 560
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23975');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2639864718271174246', '6050882485153631347', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6050882485153631347' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7026445715816860631', '24031', '刘春海', '2d400514b43250ab', '19e6ad90', 'Z01A10A01',
  1, 0, 1, '24031', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 570
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24031');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1499248932307644131', '7026445715816860631', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7026445715816860631' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5103876514660238223', '24097', '杨耀庭', 'fb6ce7590f6f0df5', '39b1437f', 'Z01A10A01',
  1, 0, 1, '24097', 'admin', NOW(), 'admin', NOW(), 1, 0, '镭射工', 580
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24097');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1916466023925329445', '5103876514660238223', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5103876514660238223' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7074840773413782579', '24794', '舒检', '1d4ffe704a0ce61e', 'a00f86d9', 'Z01A10A01',
  1, 0, 1, '24794', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 590
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24794');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7376025034618338168', '7074840773413782579', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7074840773413782579' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1859468880955355063', '25194', '杨聪', 'c74e639fcc87c294', '90d6be21', 'Z01A10A01',
  1, 0, 1, '25194', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 600
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25194');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9126863865303988417', '1859468880955355063', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1859468880955355063' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8031906282523989879', '25563', '全友', 'e2cca5c234d38e4c', '40474115', 'Z01A10A01',
  1, 0, 1, '25563', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 610
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25563');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2749337293985319368', '8031906282523989879', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8031906282523989879' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5163390296518515249', '26003', '袁鑫磊', 'c5d73d171dec801d', '1de13874', 'Z01A10A01',
  1, 0, 1, '26003', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 620
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26003');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5955858926242690395', '5163390296518515249', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5163390296518515249' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6423826217133452179', '26019', '何灿', 'b048ed56c291142e', '5f8e3cc4', 'Z01A10A01',
  1, 0, 1, '26019', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 630
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26019');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5880736347621313339', '6423826217133452179', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6423826217133452179' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5667103983108507895', '26104', '郑权山', 'e7c545c5b68f3f33', '98a1571d', 'Z01A10A01',
  1, 0, 1, '26104', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 640
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26104');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4931544662610418859', '5667103983108507895', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5667103983108507895' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5688963960195678492', '26115', '丁伦', '2aa2d834673ea327', 'd25f3fbf', 'Z01A10A01',
  1, 0, 1, '26115', 'admin', NOW(), 'admin', NOW(), 1, 0, '折弯工', 650
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26115');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8573923742435577128', '5688963960195678492', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5688963960195678492' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6758791876690991933', '26116', '彭辉鸿', '16ace841b4f79d52', '67617994', 'Z01A10A01',
  1, 0, 1, '26116', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 660
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26116');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6240019279353331669', '6758791876690991933', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6758791876690991933' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5916520042660337155', '26156', '张居沐', '73c1e7323798f5f3', 'ba7bb493', 'Z01A10A01',
  1, 0, 1, '26156', 'admin', NOW(), 'admin', NOW(), 1, 0, '折弯工', 670
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26156');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3500468563405937524', '5916520042660337155', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5916520042660337155' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6122655820888246362', '26166', '林文超', '091c0d88cb79419a', 'ca3773fe', 'Z01A10A01',
  1, 0, 1, '26166', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 680
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26166');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2068522648333439461', '6122655820888246362', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6122655820888246362' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9892166425090917953', '26231', '黎德海', '7e9cacde78708063', 'f18df306', 'Z01A10A01',
  1, 0, 1, '26231', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 690
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26231');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4206338798427424298', '9892166425090917953', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9892166425090917953' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4941973868010149791', '26330', '谢立鹏', 'f1b0d84808658386', 'c3a27aad', 'Z01A10A01',
  1, 0, 1, '26330', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 700
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26330');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7093864755881401893', '4941973868010149791', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4941973868010149791' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5451795615524732006', '26828', '廖璋越', '8509b025c7a39f51', '5e098b21', 'Z01A10A01',
  1, 0, 1, '26828', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 710
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26828');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2977545339037334975', '5451795615524732006', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5451795615524732006' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2876158915707846122', '26830', '吴照理', '81d16b0ddfed11ba', '3cfa3c47', 'Z01A10A01',
  1, 0, 1, '26830', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 720
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26830');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2019025846354792584', '2876158915707846122', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2876158915707846122' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8986986681031458668', '27207', '侯全仕', '89e62a448de75411', '9df1fce8', 'Z01A10A01',
  1, 0, 1, '27207', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 730
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27207');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5489906597174406513', '8986986681031458668', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8986986681031458668' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1292288899888317951', '27404', '袁波', 'd00fab185764e83f', '18286ea6', 'Z01A10A01',
  1, 0, 1, '27404', 'admin', NOW(), 'admin', NOW(), 1, 0, '折弯工', 740
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27404');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8448237714769870358', '1292288899888317951', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1292288899888317951' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8920764860592005975', '27405', '李鑫洋', 'f93753ffd4ce9ce9', '1c4cbc19', 'Z01A10A01',
  1, 0, 1, '27405', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 750
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27405');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8411575864517274317', '8920764860592005975', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8920764860592005975' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9823413570481733871', '27770', '史展鹏', 'f3e6927f2fc4ae9a', 'c21df788', 'Z01A10A01',
  1, 0, 1, '27770', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 760
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27770');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2376284368338123555', '9823413570481733871', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9823413570481733871' AND `dep_id` = '2403632151673875771'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3784708046730624986', '27816', '王建成', 'f47e6cae3df517b2', '78d32c48', 'Z01A10A01',
  1, 0, 1, '27816', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 770
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27816');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5552635977581740790', '3784708046730624986', '2403632151673875771'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3784708046730624986' AND `dep_id` = '2403632151673875771'
);


-- 组别：工程组 (Z01A10A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5125980820261814399', '03902', '刘求龙', 'e5200d7ab2937580', 'd5d2bbd7', 'Z01A10A02',
  1, 0, 1, '03902', 'admin', NOW(), 'admin', NOW(), 1, 0, '副经理', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03902');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3753462546382743152', '5125980820261814399', '2581647770585339700'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5125980820261814399' AND `dep_id` = '2581647770585339700'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8544132878649563253', '11052', '赖伟文', '79748874faebe50c', '9a0178e2', 'Z01A10A02',
  1, 0, 1, '11052', 'admin', NOW(), 'admin', NOW(), 1, 0, '钣金工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11052');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5016650604676224641', '8544132878649563253', '2581647770585339700'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8544132878649563253' AND `dep_id` = '2581647770585339700'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1226490645059567794', '14078', '唐小祥', 'cefa9cf9cf349826', '7451ba8b', 'Z01A10A02',
  1, 0, 1, '14078', 'admin', NOW(), 'admin', NOW(), 1, 0, '钣金工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14078');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7587244646375663765', '1226490645059567794', '2581647770585339700'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1226490645059567794' AND `dep_id` = '2581647770585339700'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2924294064684513831', '17189', '邓志群', 'c80a0438407f120f', '01dd9739', 'Z01A10A02',
  1, 0, 1, '17189', 'admin', NOW(), 'admin', NOW(), 1, 0, '钣金工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17189');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9389183336849511173', '2924294064684513831', '2581647770585339700'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2924294064684513831' AND `dep_id` = '2581647770585339700'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2747467650199356812', '17940', '徐伟栋', '0f0b81618f059d13', '59edb007', 'Z01A10A02',
  1, 0, 1, '17940', 'admin', NOW(), 'admin', NOW(), 1, 0, '钣金工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17940');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8541872868575526940', '2747467650199356812', '2581647770585339700'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2747467650199356812' AND `dep_id` = '2581647770585339700'
);

