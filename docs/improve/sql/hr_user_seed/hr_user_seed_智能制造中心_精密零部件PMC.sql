-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 精密零部件PMC
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
  '2203369674840962826', '9372856559755238914', '精密零部件PMC', 5, '2', 'DEPT', 'Z01A05',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A05');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4732685441619075539', '2203369674840962826', '计划组', 1, '2', 'GROUP', 'Z01A05A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A05A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '1411278562665095202', '2203369674840962826', '订单管理组', 2, '2', 'GROUP', 'Z01A05A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A05A02');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 精密零部件PMC
-- -----------------------------------------------------------------------------


-- 组别：计划组 (Z01A05A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7383486376735446403', '01305', '杨洋', '49e3023277d5fc04', 'f1d79668', 'Z01A05A01',
  1, 0, 1, '01305', 'admin', NOW(), 'admin', NOW(), 1, 0, '经理', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01305');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9403223829885799888', '7383486376735446403', '4732685441619075539'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7383486376735446403' AND `dep_id` = '4732685441619075539'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5104869023604547898', '08613', '王春梅', 'afcf87d8859f2c57', '88d89077', 'Z01A05A01',
  1, 0, 1, '08613', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08613');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9727670204862477677', '5104869023604547898', '4732685441619075539'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5104869023604547898' AND `dep_id` = '4732685441619075539'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2674206123078296311', '09930', '肖娴', 'bfc26b10fc6fdaec', '4411e227', 'Z01A05A01',
  1, 0, 1, '09930', 'admin', NOW(), 'admin', NOW(), 1, 0, '工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09930');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9095507922338135351', '2674206123078296311', '4732685441619075539'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2674206123078296311' AND `dep_id` = '4732685441619075539'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8497632472976202175', '11177', '侯凡', '7450a818c3006a3a', 'c77ed932', 'Z01A05A01',
  1, 0, 1, '11177', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11177');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8648364589540476989', '8497632472976202175', '4732685441619075539'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8497632472976202175' AND `dep_id` = '4732685441619075539'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3533874386850439964', '13843', '胡双双', 'b9bb56d13da86a7a', 'cb343c70', 'Z01A05A01',
  1, 0, 1, '13843', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13843');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1367003951944104129', '3533874386850439964', '4732685441619075539'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3533874386850439964' AND `dep_id` = '4732685441619075539'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6602678038296450142', '18505', '杨烨', 'ae2ce8fef1a35252', '126d4d5c', 'Z01A05A01',
  1, 0, 1, '18505', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18505');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3205689270789855763', '6602678038296450142', '4732685441619075539'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6602678038296450142' AND `dep_id` = '4732685441619075539'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2129295085368942386', '24396', '张娜', '0f1d795232878935', 'f90df569', 'Z01A05A01',
  1, 0, 1, '24396', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24396');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9230351733673427665', '2129295085368942386', '4732685441619075539'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2129295085368942386' AND `dep_id` = '4732685441619075539'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9841670457276650501', '25587', '邓语芳', 'b0e4d73bc732f1ef', 'e703b2c6', 'Z01A05A01',
  1, 0, 1, '25587', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25587');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6468150974439391530', '9841670457276650501', '4732685441619075539'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9841670457276650501' AND `dep_id` = '4732685441619075539'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2163118390760474799', '26093', '杨念娇', '991f9a44429494ab', '1bf46364', 'Z01A05A01',
  1, 0, 1, '26093', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26093');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3597468669517072162', '2163118390760474799', '4732685441619075539'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2163118390760474799' AND `dep_id` = '4732685441619075539'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7301690189505459852', '27465', '陈阳高', '1b1782418e9eb9cd', '741a9a6e', 'Z01A05A01',
  1, 0, 1, '27465', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27465');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8259695732253345970', '7301690189505459852', '4732685441619075539'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7301690189505459852' AND `dep_id` = '4732685441619075539'
);


-- 组别：订单管理组 (Z01A05A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9807841799636307728', '02085', '覃敏', '4bdad9a966f9bf99', '1c025cb7', 'Z01A05A02',
  1, 0, 1, '02085', 'admin', NOW(), 'admin', NOW(), 1, 0, '主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02085');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7479618998689940187', '9807841799636307728', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9807841799636307728' AND `dep_id` = '1411278562665095202'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1558071275671478358', '02139', '文磊春', 'bdfb86f3d59ed413', 'bc118881', 'Z01A05A02',
  1, 0, 1, '02139', 'admin', NOW(), 'admin', NOW(), 1, 0, '工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02139');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7320260922272356387', '1558071275671478358', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1558071275671478358' AND `dep_id` = '1411278562665095202'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8134564682586615478', '03888', '罗江文', 'ee9ce5041249d399', 'ac696ef7', 'Z01A05A02',
  1, 0, 1, '03888', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03888');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4432452858460803138', '8134564682586615478', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8134564682586615478' AND `dep_id` = '1411278562665095202'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7064062859313573286', '07688', '余广斌', '89f2bf4ba40be6b8', 'cf1f725e', 'Z01A05A02',
  1, 0, 1, '07688', 'admin', NOW(), 'admin', NOW(), 1, 0, '工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07688');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4271647656013451907', '7064062859313573286', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7064062859313573286' AND `dep_id` = '1411278562665095202'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1022824368087705839', '10974', '郑璇', '6c29c19e6951ceeb', '922db0c1', 'Z01A05A02',
  1, 0, 1, '10974', 'admin', NOW(), 'admin', NOW(), 1, 0, '工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10974');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4392918077115865772', '1022824368087705839', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1022824368087705839' AND `dep_id` = '1411278562665095202'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4185571488899229994', '14965', '郭小丹', 'ac1a7e1f81b3dc77', '90980d33', 'Z01A05A02',
  1, 0, 1, '14965', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14965');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9632976326208226148', '4185571488899229994', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4185571488899229994' AND `dep_id` = '1411278562665095202'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9402149462765285965', '16727', '黄金美', 'c217c1d3635b01f1', 'ee227024', 'Z01A05A02',
  1, 0, 1, '16727', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16727');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8918066526860359326', '9402149462765285965', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9402149462765285965' AND `dep_id` = '1411278562665095202'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6251259076576489674', '24895', '黄玉芬', '4daa6ed9e1bb2feb', 'f6a34af9', 'Z01A05A02',
  1, 0, 1, '24895', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24895');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2671227308542182338', '6251259076576489674', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6251259076576489674' AND `dep_id` = '1411278562665095202'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9846683938504153793', '24927', '雷冬梅', 'e5b6f3f12389744e', 'e223b0e9', 'Z01A05A02',
  1, 0, 1, '24927', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24927');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4836796407247204896', '9846683938504153793', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9846683938504153793' AND `dep_id` = '1411278562665095202'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3363932206232636762', '26987', '全宣其', '7cbb313ed988d870', 'e329442e', 'Z01A05A02',
  1, 0, 1, '26987', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26987');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3789005439167908869', '3363932206232636762', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3363932206232636762' AND `dep_id` = '1411278562665095202'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6413153637135033810', '27012', '刘海勇', 'ec7bb43724980b88', '779ac591', 'Z01A05A02',
  1, 0, 1, '27012', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27012');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6257505893663028444', '6413153637135033810', '1411278562665095202'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6413153637135033810' AND `dep_id` = '1411278562665095202'
);

