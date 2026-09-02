-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 精密制造三部
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
  '5069740885942591882', '9372856559755238914', '精密制造三部', 4, '2', 'DEPT', 'Z01A04',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A04');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4550818037483279009', '5069740885942591882', '钳工组', 1, '2', 'GROUP', 'Z01A04A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A04A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '3050268640532328847', '5069740885942591882', '铣床组', 2, '2', 'GROUP', 'Z01A04A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A04A02');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '3674186270167843599', '5069740885942591882', '磨床组', 3, '2', 'GROUP', 'Z01A04A03',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A04A03');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '8460269186886607626', '5069740885942591882', 'FCNC组', 4, '2', 'GROUP', 'Z01A04A04',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A04A04');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '5113500673432871674', '5069740885942591882', '车床组', 5, '2', 'GROUP', 'Z01A04A05',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A04A05');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '1322000867748989711', '5069740885942591882', '快走丝组', 6, '2', 'GROUP', 'Z01A04A06',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A04A06');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 精密制造三部
-- -----------------------------------------------------------------------------


-- 组别：钳工组 (Z01A04A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1904081783615435721', '01226', '梁日盛', '2576882b89de9fa2', '22e4e5ab', 'Z01A04A01',
  1, 0, 1, '01226', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01226');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3626704874464001321', '1904081783615435721', '4550818037483279009'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1904081783615435721' AND `dep_id` = '4550818037483279009'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6677705164802101908', '02938', '姚德云', '682b5c343d67e64b', 'da21bf53', 'Z01A04A01',
  1, 0, 1, '02938', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02938');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2703215417634869702', '6677705164802101908', '4550818037483279009'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6677705164802101908' AND `dep_id` = '4550818037483279009'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8804115614819899207', '06894', '丁丹丹', '1f03b4283ce321eb', '4c8f0742', 'Z01A04A01',
  1, 0, 1, '06894', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06894');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1714910647974935124', '8804115614819899207', '4550818037483279009'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8804115614819899207' AND `dep_id` = '4550818037483279009'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5634866209142919511', '07423', '向美花', '9193d67801eb27a6', '93c6fdb3', 'Z01A04A01',
  1, 0, 1, '07423', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07423');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5984924356009626711', '5634866209142919511', '4550818037483279009'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5634866209142919511' AND `dep_id` = '4550818037483279009'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8698155154341038091', '07711', '王明星', 'b2defec94bee2757', '8e9d2425', 'Z01A04A01',
  1, 0, 1, '07711', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07711');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4915283591166069704', '8698155154341038091', '4550818037483279009'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8698155154341038091' AND `dep_id` = '4550818037483279009'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2015671832684394487', '09613', '李玉珍', 'cae16f9b14776602', 'dcc0fa2c', 'Z01A04A01',
  1, 0, 1, '09613', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09613');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3836940169462551835', '2015671832684394487', '4550818037483279009'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2015671832684394487' AND `dep_id` = '4550818037483279009'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7595031793001440638', '15506', '汪双', '5b24d562a8c507ee', '9989acaf', 'Z01A04A01',
  1, 0, 1, '15506', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15506');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7495189639384632542', '7595031793001440638', '4550818037483279009'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7595031793001440638' AND `dep_id` = '4550818037483279009'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8555211085670272624', '20996', '赖阳燕', 'ec9c98d530e8ab5e', '0387d952', 'Z01A04A01',
  1, 0, 1, '20996', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20996');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1719345385784750057', '8555211085670272624', '4550818037483279009'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8555211085670272624' AND `dep_id` = '4550818037483279009'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6104837878853294026', '24397', '柳秀祥', 'f473dad51c14ba83', 'b6a36147', 'Z01A04A01',
  1, 0, 1, '24397', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24397');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2061081005034508616', '6104837878853294026', '4550818037483279009'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6104837878853294026' AND `dep_id` = '4550818037483279009'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5763121147527808784', '26399', '孙宏滨', '684ed6e7a3a30d5e', 'd8f796a3', 'Z01A04A01',
  1, 0, 1, '26399', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26399');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5885285458740671726', '5763121147527808784', '4550818037483279009'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5763121147527808784' AND `dep_id` = '4550818037483279009'
);


-- 组别：铣床组 (Z01A04A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2050253672201518383', '01556', '王斌', '3b8b434861a9fc5e', 'efe6ba1c', 'Z01A04A02',
  1, 0, 1, '01556', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01556');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6026825707709076786', '2050253672201518383', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2050253672201518383' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8745553315650828897', '04459', '潘金星', '80c347958461957a', 'a2be2c82', 'Z01A04A02',
  1, 0, 1, '04459', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04459');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8738619570280861202', '8745553315650828897', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8745553315650828897' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7456730592752220167', '04647', '彭清峰', '1e35c1d2cda8b5c6', '791100c0', 'Z01A04A02',
  1, 0, 1, '04647', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04647');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2433735744017912793', '7456730592752220167', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7456730592752220167' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7246054330105412392', '07304', '张甫枝', '0a106f51711b2661', 'd79c957e', 'Z01A04A02',
  1, 0, 1, '07304', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07304');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4930433483775739908', '7246054330105412392', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7246054330105412392' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8262996288207975007', '08377', '黄仕戈', 'f7890b995021162a', '47bb8558', 'Z01A04A02',
  1, 0, 1, '08377', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08377');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5453170497030602885', '8262996288207975007', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8262996288207975007' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4814488357715211122', '09579', '李锐荣', '91a77574ebf13108', 'c26bcfea', 'Z01A04A02',
  1, 0, 1, '09579', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09579');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6755622156146561156', '4814488357715211122', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4814488357715211122' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4145272794898472921', '09809', '黄东生', 'c3a8d1b50bac02e4', '61fc0489', 'Z01A04A02',
  1, 0, 1, '09809', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09809');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9820938526337349788', '4145272794898472921', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4145272794898472921' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2824749269763604047', '09895', '黄永桥', '9dd1810ae3a36bb6', 'bcf2dd76', 'Z01A04A02',
  1, 0, 1, '09895', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09895');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8197146546869731151', '2824749269763604047', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2824749269763604047' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6241234010359589880', '10480', '周赞', '0520cadf03ebf870', 'ea4a24b6', 'Z01A04A02',
  1, 0, 1, '10480', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10480');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2556670457944765966', '6241234010359589880', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6241234010359589880' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9015917926875418158', '10914', '刘涛', '1ddc55066512cbb7', '98c5eff5', 'Z01A04A02',
  1, 0, 1, '10914', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10914');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9528823676728725992', '9015917926875418158', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9015917926875418158' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4586281889279294541', '12640', '黄卓土', 'c549eeb0a3c8304e', 'a101bb4e', 'Z01A04A02',
  1, 0, 1, '12640', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12640');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2345197834375308357', '4586281889279294541', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4586281889279294541' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2730952901278341684', '15267', '王圣子', '33a778067ced30cf', '7cd08595', 'Z01A04A02',
  1, 0, 1, '15267', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15267');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9905373803939401052', '2730952901278341684', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2730952901278341684' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2497388205993549449', '15636', '辜波', '197cdb5bdfb5df53', 'ada10843', 'Z01A04A02',
  1, 0, 1, '15636', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15636');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8991509185859969886', '2497388205993549449', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2497388205993549449' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8443336974775578777', '15676', '白幸', '1ba410e250a2ffcb', '9865eab4', 'Z01A04A02',
  1, 0, 1, '15676', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15676');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5926179604419900167', '8443336974775578777', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8443336974775578777' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6143612399596532024', '17419', '蒋锦涛', '952d1429dbe4c5fb', '408997eb', 'Z01A04A02',
  1, 0, 1, '17419', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17419');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4856330050523997847', '6143612399596532024', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6143612399596532024' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3227182569156143049', '17532', '周英彪', '6cbd191388a7e34e', 'dccd2e72', 'Z01A04A02',
  1, 0, 1, '17532', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17532');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8841096812711096456', '3227182569156143049', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3227182569156143049' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7790845178393494355', '17533', '黎德涛', 'cd41ad01830a3b0e', '0e4cb73d', 'Z01A04A02',
  1, 0, 1, '17533', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17533');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6771912144239165502', '7790845178393494355', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7790845178393494355' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9049940606888046021', '17570', '刘治终', '3351169b2fb509ea', '6a8a87c8', 'Z01A04A02',
  1, 0, 1, '17570', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17570');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4312131188251710493', '9049940606888046021', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9049940606888046021' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3514990867475956416', '17654', '宋方强', '783e9288ee8d4e6b', 'bcf66ce1', 'Z01A04A02',
  1, 0, 1, '17654', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17654');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6327398499276800859', '3514990867475956416', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3514990867475956416' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2857824345115939568', '17849', '吴望旺', 'e31c6e94e50754e9', 'e56cf63f', 'Z01A04A02',
  1, 0, 1, '17849', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17849');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7149325435705797656', '2857824345115939568', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2857824345115939568' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2053698542597235893', '18101', '胡致平', '2b443e7f57411f4b', 'cf4f15f7', 'Z01A04A02',
  1, 0, 1, '18101', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18101');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9015484783167780002', '2053698542597235893', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2053698542597235893' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6689008628313386710', '19187', '刘永东', '5e4546f0e872e66c', '5498be40', 'Z01A04A02',
  1, 0, 1, '19187', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19187');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7436252927533042196', '6689008628313386710', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6689008628313386710' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5386683024853369169', '19331', '孙加加', 'e3ac3b68b79c4635', 'e4741223', 'Z01A04A02',
  1, 0, 1, '19331', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19331');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7988799803499362338', '5386683024853369169', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5386683024853369169' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8822045564414610833', '19361', '成金龙', '29d0606aad55f35f', 'eab06ed1', 'Z01A04A02',
  1, 0, 1, '19361', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19361');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7287879127607055200', '8822045564414610833', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8822045564414610833' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6653958479177723888', '19445', '王建波', 'cfefb3ed842524e6', 'c1fb8141', 'Z01A04A02',
  1, 0, 1, '19445', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19445');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8373876418800025433', '6653958479177723888', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6653958479177723888' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1626281482488174837', '21111', '任传超', '8f4032df09873565', 'dacbc285', 'Z01A04A02',
  1, 0, 1, '21111', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21111');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3776736374800748878', '1626281482488174837', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1626281482488174837' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5587770471789745210', '24296', '周国望', '16230e889303b551', '0b4099cc', 'Z01A04A02',
  1, 0, 1, '24296', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24296');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7061680102341141607', '5587770471789745210', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5587770471789745210' AND `dep_id` = '3050268640532328847'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7893787612610976754', '25927', '艾利松', '20cb50c8d1495a10', '6f4ddf75', 'Z01A04A02',
  1, 0, 1, '25927', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25927');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9938960405385181686', '7893787612610976754', '3050268640532328847'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7893787612610976754' AND `dep_id` = '3050268640532328847'
);


-- 组别：磨床组 (Z01A04A03)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6582249573923420701', '01558', '叶迟古', 'e111a1312ead8613', '6542f59c', 'Z01A04A03',
  1, 0, 1, '01558', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01558');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6357624046563417483', '6582249573923420701', '3674186270167843599'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6582249573923420701' AND `dep_id` = '3674186270167843599'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7485646297112952533', '05863', '张文富', 'ff29c60f999417ed', '8a5492b5', 'Z01A04A03',
  1, 0, 1, '05863', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05863');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5964134685861337123', '7485646297112952533', '3674186270167843599'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7485646297112952533' AND `dep_id` = '3674186270167843599'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5592276457594328573', '07439', '丁建领', '41404cc0faf07fac', 'ad3bd649', 'Z01A04A03',
  1, 0, 1, '07439', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07439');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4442263990191891437', '5592276457594328573', '3674186270167843599'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5592276457594328573' AND `dep_id` = '3674186270167843599'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2330428367450345343', '09826', '周济广', '9ead4d0068af3e61', 'd446699a', 'Z01A04A03',
  1, 0, 1, '09826', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09826');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9822108778164418342', '2330428367450345343', '3674186270167843599'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2330428367450345343' AND `dep_id` = '3674186270167843599'
);


-- 组别：FCNC组 (Z01A04A04)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6710130650295416882', '02047', '黄明喜', '32ba95382cd7e564', 'd97829f6', 'Z01A04A04',
  1, 0, 1, '02047', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02047');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7309269386312566635', '6710130650295416882', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6710130650295416882' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1382072234602566790', '01701', '李锋泉', '10d6f43c993e2f76', 'ddc034c5', 'Z01A04A04',
  1, 0, 1, '01701', 'admin', NOW(), 'admin', NOW(), 1, 0, '经理', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01701');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6482206303317174713', '1382072234602566790', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1382072234602566790' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9562418864164335020', '03419', '肖燕泉', '0fd5312cf99d3cc7', '508d7359', 'Z01A04A04',
  1, 0, 1, '03419', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03419');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5718156175545562877', '9562418864164335020', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9562418864164335020' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9026455970327850226', '03613', '方志远', '3e36583510ae727f', 'b79ca0a1', 'Z01A04A04',
  1, 0, 1, '03613', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03613');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2462091916968126335', '9026455970327850226', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9026455970327850226' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1565152278504373978', '03757', '黄德任', 'b68ce32003b870b9', 'd3b4a21c', 'Z01A04A04',
  1, 0, 1, '03757', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03757');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1239285011361686516', '1565152278504373978', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1565152278504373978' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4284370930001785450', '03766', '谢宏晃', '1c3d4514c34c4f79', '2ef4ba65', 'Z01A04A04',
  1, 0, 1, '03766', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03766');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1330585232728938601', '4284370930001785450', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4284370930001785450' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4632960894243381285', '04349', '甘顺', '996f5d3486ad4821', '25272d6e', 'Z01A04A04',
  1, 0, 1, '04349', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04349');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2676956987584859491', '4632960894243381285', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4632960894243381285' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9986160814943616891', '04446', '庞育龙', '21fff6d09758a6dc', 'b48edc16', 'Z01A04A04',
  1, 0, 1, '04446', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04446');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7980990917242200227', '9986160814943616891', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9986160814943616891' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2433822013927897862', '04557', '杜文博', '67bd617b6b8284aa', '226a043e', 'Z01A04A04',
  1, 0, 1, '04557', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04557');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9771953017304458134', '2433822013927897862', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2433822013927897862' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2375965045723351481', '05789', '周忠美', '9d644ba317ef26e1', '02460605', 'Z01A04A04',
  1, 0, 1, '05789', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05789');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8854467040887805918', '2375965045723351481', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2375965045723351481' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8252582197436098331', '06566', '陈少俊', '01d7030dd7efac61', 'd24027dd', 'Z01A04A04',
  1, 0, 1, '06566', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06566');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7813020505885521091', '8252582197436098331', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8252582197436098331' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1378313718334623928', '07288', '徐杨浩', '4175b6501d29eefa', 'f6a15772', 'Z01A04A04',
  1, 0, 1, '07288', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07288');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2072952113242440348', '1378313718334623928', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1378313718334623928' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4087072863885174987', '07796', '邱发余', 'dcce4f431a6aa4f7', '605f4645', 'Z01A04A04',
  1, 0, 1, '07796', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07796');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4903781436847891740', '4087072863885174987', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4087072863885174987' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6173117242685532156', '07937', '宋胜周', 'fe52a4e14de46f59', '56046b16', 'Z01A04A04',
  1, 0, 1, '07937', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07937');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1124284532081993582', '6173117242685532156', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6173117242685532156' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1245081676681245701', '08989', '赵小飞', 'adc5581b05616853', '07f4e2c2', 'Z01A04A04',
  1, 0, 1, '08989', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08989');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2491685839552966445', '1245081676681245701', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1245081676681245701' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1863373058404908471', '09182', '刘荣杰', '65de731f4c4ad561', 'aa896081', 'Z01A04A04',
  1, 0, 1, '09182', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09182');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6772075741444428629', '1863373058404908471', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1863373058404908471' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8150541521035586084', '09568', '孙豪', '9b175145aad2895b', '2c5e2950', 'Z01A04A04',
  1, 0, 1, '09568', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09568');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5296042138176334363', '8150541521035586084', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8150541521035586084' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5474435766392577642', '10516', '舒钟华', 'f6bf4e424e0c0744', 'b7a2058b', 'Z01A04A04',
  1, 0, 1, '10516', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10516');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6073225231474576082', '5474435766392577642', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5474435766392577642' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5058361900565971995', '11169', '李旭朋', 'b979eabe70875114', 'a1419964', 'Z01A04A04',
  1, 0, 1, '11169', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11169');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4262179726394598995', '5058361900565971995', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5058361900565971995' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8217966435296132666', '11523', '冯关生', '6b23660030b4a1d9', '9f8930b5', 'Z01A04A04',
  1, 0, 1, '11523', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11523');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7213740944487659159', '8217966435296132666', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8217966435296132666' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3658470412863572513', '13443', '刘广', '73e6ef9f05440a5d', 'b33a8e5f', 'Z01A04A04',
  1, 0, 1, '13443', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13443');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1044566131285984369', '3658470412863572513', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3658470412863572513' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8493604385788823024', '14070', '艾安瑞', '21f61b031f2140c3', '26923c2f', 'Z01A04A04',
  1, 0, 1, '14070', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14070');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1289015031317529428', '8493604385788823024', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8493604385788823024' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3485821707942852486', '14883', '彭绍杰', 'b11d4ff2dd2255d0', 'a14e45e6', 'Z01A04A04',
  1, 0, 1, '14883', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14883');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4505898020533282213', '3485821707942852486', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3485821707942852486' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9008474769422732221', '15525', '徐建', '9a77be84997cddf3', '2430f423', 'Z01A04A04',
  1, 0, 1, '15525', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15525');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5106651172297301343', '9008474769422732221', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9008474769422732221' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6319730755481739425', '17392', '袁楚昌', '458059252d0a3c20', '9803810f', 'Z01A04A04',
  1, 0, 1, '17392', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17392');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2681847892741755726', '6319730755481739425', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6319730755481739425' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1330725811671409818', '17424', '雷永威', '7d36ff07fee5b94d', '952596b9', 'Z01A04A04',
  1, 0, 1, '17424', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17424');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8083915419215026767', '1330725811671409818', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1330725811671409818' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4278841021974128939', '18583', '谢云达', 'c64b846f392b9983', '6758d9a6', 'Z01A04A04',
  1, 0, 1, '18583', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18583');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5618018912897984229', '4278841021974128939', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4278841021974128939' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4082884598880030540', '18945', '彭汉杰', 'c1936938b914cb6f', '2cd3ea5d', 'Z01A04A04',
  1, 0, 1, '18945', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18945');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1844300031621655392', '4082884598880030540', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4082884598880030540' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6351028268745892775', '19040', '朱坤', '3b1ae566794b0954', 'd810b3de', 'Z01A04A04',
  1, 0, 1, '19040', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19040');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7841805928492414461', '6351028268745892775', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6351028268745892775' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2776393957886893422', '19583', '谭文飞', '0efe58965310e3eb', '74a9d1ad', 'Z01A04A04',
  1, 0, 1, '19583', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19583');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1291311435555894381', '2776393957886893422', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2776393957886893422' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1915358260398974303', '20864', '杨彪', '36740785f5174468', '8079735e', 'Z01A04A04',
  1, 0, 1, '20864', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20864');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7893144131932779148', '1915358260398974303', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1915358260398974303' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1188841136009028538', '20945', '许华敬', 'e357a7caf3706186', '167ad68d', 'Z01A04A04',
  1, 0, 1, '20945', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20945');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5363189353138207012', '1188841136009028538', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1188841136009028538' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7476709021338821722', '21060', '张翔', 'cf758cabb1940eba', '42f6686b', 'Z01A04A04',
  1, 0, 1, '21060', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21060');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8280930098405365381', '7476709021338821722', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7476709021338821722' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5183536231821136535', '21397', '莫少忠', 'f557914072e038bf', '88ab60d8', 'Z01A04A04',
  1, 0, 1, '21397', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21397');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2894223835328550657', '5183536231821136535', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5183536231821136535' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1425536817008640538', '22462', '吴佳桐', '32b31669a01d8c49', 'e57539b2', 'Z01A04A04',
  1, 0, 1, '22462', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22462');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1181630886508729391', '1425536817008640538', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1425536817008640538' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2162560551936709509', '22677', '曾雅俊', '63fba968a3f2c9e5', 'ff5d2c20', 'Z01A04A04',
  1, 0, 1, '22677', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22677');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5829172430980212287', '2162560551936709509', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2162560551936709509' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6272040796699339909', '23274', '汤锦棋', 'bbd6e46424ccd5a2', '1fa2dd16', 'Z01A04A04',
  1, 0, 1, '23274', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23274');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8568649760439849296', '6272040796699339909', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6272040796699339909' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3789670755737620690', '24044', '袁志敏', '7045fb35af3c6f42', '870d079c', 'Z01A04A04',
  1, 0, 1, '24044', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 380
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24044');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1175167150995288863', '3789670755737620690', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3789670755737620690' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5215828738369007224', '24189', '黎明炬', 'cb97db8df0b4c11c', '789359ed', 'Z01A04A04',
  1, 0, 1, '24189', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 390
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24189');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3381161304154276760', '5215828738369007224', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5215828738369007224' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9631768555552508003', '24194', '刘宇凡', '3bbdd2650aff5c34', '77975c8e', 'Z01A04A04',
  1, 0, 1, '24194', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 400
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24194');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1778776973828971859', '9631768555552508003', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9631768555552508003' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6896511322995659363', '24201', '吴家豪', '16c6ff801b1d492b', '1c66bcab', 'Z01A04A04',
  1, 0, 1, '24201', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 410
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24201');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5068610486860004680', '6896511322995659363', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6896511322995659363' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2401024612569035551', '24664', '何琳', '1cb9d19c93ef1993', 'f4fe8e62', 'Z01A04A04',
  1, 0, 1, '24664', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 420
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24664');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2729960742912531682', '2401024612569035551', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2401024612569035551' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5105967600806721640', '24683', '周浩', 'f71e18be715e41af', '87fbe8dc', 'Z01A04A04',
  1, 0, 1, '24683', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 430
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24683');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4371603667162626670', '5105967600806721640', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5105967600806721640' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6868347854130154935', '24686', '龚晓阳', 'ef256876ba1e3987', 'd47fc97c', 'Z01A04A04',
  1, 0, 1, '24686', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 440
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24686');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2009844667286296299', '6868347854130154935', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6868347854130154935' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5758102172947552842', '24950', '刘奎煌', '36b1b47e538f228f', 'ee95b810', 'Z01A04A04',
  1, 0, 1, '24950', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 450
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24950');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9288815495051463148', '5758102172947552842', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5758102172947552842' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8370982648489673204', '24952', '杨瑞', '4cc4c9f382366e89', '9cbb916a', 'Z01A04A04',
  1, 0, 1, '24952', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 460
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24952');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1388881273380022158', '8370982648489673204', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8370982648489673204' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1000867294742759019', '24978', '李旭', '78887cc59a9e50bd', 'f4d67764', 'Z01A04A04',
  1, 0, 1, '24978', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 470
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24978');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3757474715162666859', '1000867294742759019', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1000867294742759019' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3084647478865934811', '25079', '卢宇坤', 'af2a163a5ae80cd6', 'b2bece42', 'Z01A04A04',
  1, 0, 1, '25079', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 480
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25079');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9266416936653844096', '3084647478865934811', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3084647478865934811' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5131492785320524327', '25932', '刘善潮', '29c9124ece07c7e9', '89543b78', 'Z01A04A04',
  1, 0, 1, '25932', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 490
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25932');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5335160107777931301', '5131492785320524327', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5131492785320524327' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9896483171391150693', '25975', '谭文林', 'e8e02aebee844445', '8965fa7b', 'Z01A04A04',
  1, 0, 1, '25975', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 500
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25975');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2663945886147621055', '9896483171391150693', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9896483171391150693' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6827374993148246592', '25979', '邓文培', '8e92b808d6c21788', 'd0de48f6', 'Z01A04A04',
  1, 0, 1, '25979', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 510
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25979');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1128726249435167839', '6827374993148246592', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6827374993148246592' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8926071505881825785', '26021', '刘江', 'de36fc2a40b9ae7f', '524358a8', 'Z01A04A04',
  1, 0, 1, '26021', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 520
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26021');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1179950372215242301', '8926071505881825785', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8926071505881825785' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9389276413482373574', '26042', '刘金丰', '5c1b1dcc471e13be', 'd531ea12', 'Z01A04A04',
  1, 0, 1, '26042', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 530
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26042');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6181416756829243748', '9389276413482373574', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9389276413482373574' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4643230431117895850', '26094', '周子云', '2b50ee62177e119b', 'daaa5f6e', 'Z01A04A04',
  1, 0, 1, '26094', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 540
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26094');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8736029374577982489', '4643230431117895850', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4643230431117895850' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2347702148980006154', '26117', '林子杰', '9d59388406710574', '4d6cce81', 'Z01A04A04',
  1, 0, 1, '26117', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 550
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26117');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5502314492585854452', '2347702148980006154', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2347702148980006154' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1484956490212646751', '26577', '吴国龙', '429105ce250979b1', '331905f2', 'Z01A04A04',
  1, 0, 1, '26577', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 560
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26577');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3765899237699962818', '1484956490212646751', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1484956490212646751' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7395062499476259762', '26843', '李坷', '14239f382bcddad8', '360db31d', 'Z01A04A04',
  1, 0, 1, '26843', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 570
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26843');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4496133436625238669', '7395062499476259762', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7395062499476259762' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4563472069647116886', '26966', '韦德庭', 'bae8e3b6ae9c4302', '913933bc', 'Z01A04A04',
  1, 0, 1, '26966', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 580
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26966');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3546510208003212563', '4563472069647116886', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4563472069647116886' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4016839017056177278', '26967', '唐弟明', 'c2d596b5750c5450', '83828011', 'Z01A04A04',
  1, 0, 1, '26967', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 590
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26967');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7725277989880045074', '4016839017056177278', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4016839017056177278' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7927714785360972883', '26976', '黄斯悦', 'e29ce50438f53c35', '5a20dd78', 'Z01A04A04',
  1, 0, 1, '26976', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 600
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26976');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6325450981051522714', '7927714785360972883', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7927714785360972883' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3104861708708387298', '26996', '邹凤鸣', '1a0a3315df949b4e', '6e3b5fc5', 'Z01A04A04',
  1, 0, 1, '26996', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 610
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26996');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1442399578311564653', '3104861708708387298', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3104861708708387298' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3501712774867778424', '27035', '童帝文', 'a0db51c22e4ea863', '02058f18', 'Z01A04A04',
  1, 0, 1, '27035', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 620
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27035');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2168569549714734660', '3501712774867778424', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3501712774867778424' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4298621701633115400', '27036', '蒋昊', '8ac3843c234c6e3e', '4940379a', 'Z01A04A04',
  1, 0, 1, '27036', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 630
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27036');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3242611405005953484', '4298621701633115400', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4298621701633115400' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9427467519056991137', '27063', '李显明', '168cd9b4d82838b4', '9f87f448', 'Z01A04A04',
  1, 0, 1, '27063', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 640
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27063');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1811168753625715111', '9427467519056991137', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9427467519056991137' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3428199621607965262', '27071', '刘锐', '5ba575d7b457885e', '737f7c1b', 'Z01A04A04',
  1, 0, 1, '27071', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 650
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27071');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1896921522143220845', '3428199621607965262', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3428199621607965262' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2163070242605526411', '27081', '姜智久', '0d518076fcd3db32', '060e755d', 'Z01A04A04',
  1, 0, 1, '27081', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 660
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27081');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2562095560723898611', '2163070242605526411', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2163070242605526411' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9158320438731617966', '27082', '龚潇羽', '0b30a3fca405d1c0', '60fecc44', 'Z01A04A04',
  1, 0, 1, '27082', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 670
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27082');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5433484758338578572', '9158320438731617966', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9158320438731617966' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5024483627460600160', '27250', '张阿福', '1e37c403956d435c', 'f4ea4494', 'Z01A04A04',
  1, 0, 1, '27250', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 680
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27250');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8771826627200322942', '5024483627460600160', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5024483627460600160' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1685631125381937437', '27251', '徐荣', '8d232633f56898a1', '26ce9a24', 'Z01A04A04',
  1, 0, 1, '27251', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 690
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27251');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1109177314817265411', '1685631125381937437', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1685631125381937437' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5457674864962883925', '27401', '石才礼', '3b0270891fdb0e52', 'b6ef0525', 'Z01A04A04',
  1, 0, 1, '27401', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 700
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27401');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2691816748294503926', '5457674864962883925', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5457674864962883925' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2415836216850747729', '27406', '袁德钱', '63ead94fd58508b0', 'f3285cba', 'Z01A04A04',
  1, 0, 1, '27406', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 710
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27406');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3111567084932473877', '2415836216850747729', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2415836216850747729' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7815393199575150552', '27446', '马进', '5d66f8f28b6ff079', '03f68d61', 'Z01A04A04',
  1, 0, 1, '27446', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 720
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27446');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7375052164981954810', '7815393199575150552', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7815393199575150552' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3420114578497682509', '27456', '文滨', '8b6f603ff0733ded', 'c43ed96a', 'Z01A04A04',
  1, 0, 1, '27456', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 730
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27456');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3481455855852228812', '3420114578497682509', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3420114578497682509' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2216039751863075274', '27458', '刘健', 'd9b3965fad09b70f', '7363b7e5', 'Z01A04A04',
  1, 0, 1, '27458', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 740
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27458');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6906364060451892860', '2216039751863075274', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2216039751863075274' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7960487823016363525', '27459', '徐浩', 'a5b58cd2f1d16072', '9a190eb9', 'Z01A04A04',
  1, 0, 1, '27459', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 750
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27459');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3510489311555015802', '7960487823016363525', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7960487823016363525' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4734820660543062180', '27485', '吴家豪', '7991cf47376e636a', '649a736b', 'Z01A04A04',
  1, 0, 1, '27485', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 760
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27485');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3507504107950641626', '4734820660543062180', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4734820660543062180' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2973087854014014738', '27503', '张哲', '4a33d0106d3dba7e', 'ae180261', 'Z01A04A04',
  1, 0, 1, '27503', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 770
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27503');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2069270130150670586', '2973087854014014738', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2973087854014014738' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1019467329600248087', '27525', '吴建华', 'fd98609aa7a44a14', '53a0e3f8', 'Z01A04A04',
  1, 0, 1, '27525', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 780
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27525');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5542341800842425006', '1019467329600248087', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1019467329600248087' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2527435803023515888', '27545', '洪集兴', '4fee76c90aae1ba3', '14a7d6c4', 'Z01A04A04',
  1, 0, 1, '27545', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 790
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27545');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9684160868297307458', '2527435803023515888', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2527435803023515888' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9066530910589711329', '27614', '李张力', 'c347e3470e3ced2d', 'd4850482', 'Z01A04A04',
  1, 0, 1, '27614', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 800
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27614');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8240372277729704323', '9066530910589711329', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9066530910589711329' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3494374231350017292', '27761', '马国豪', '91cb541da75699b5', '1632d78a', 'Z01A04A04',
  1, 0, 1, '27761', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 810
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27761');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1127722344852102875', '3494374231350017292', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3494374231350017292' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7262782303704829048', '27766', '徐昨晗', '9afda8019fb8f733', '8234ab56', 'Z01A04A04',
  1, 0, 1, '27766', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 820
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27766');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4134326951301887672', '7262782303704829048', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7262782303704829048' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7123574698472464293', '27803', '李家乐', 'a3c4b23c6b8fd186', '2c34e491', 'Z01A04A04',
  1, 0, 1, '27803', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 830
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27803');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1349765271991447597', '7123574698472464293', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7123574698472464293' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5048017024057252846', '27820', '韩逸峰', '33873a2bc295a08a', 'bc21d4bc', 'Z01A04A04',
  1, 0, 1, '27820', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 840
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27820');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9316689215777278438', '5048017024057252846', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5048017024057252846' AND `dep_id` = '8460269186886607626'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1982978377748324917', '27842', '方鑫坤', '8d996c15eb09c06a', 'ae01f283', 'Z01A04A04',
  1, 0, 1, '27842', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 850
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27842');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2357430139808913662', '1982978377748324917', '8460269186886607626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1982978377748324917' AND `dep_id` = '8460269186886607626'
);


-- 组别：车床组 (Z01A04A05)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8980910099120824347', '03727', '黎建举', 'e55e5f14019a5b90', '786fec81', 'Z01A04A05',
  1, 0, 1, '03727', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03727');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7110624875631765766', '8980910099120824347', '5113500673432871674'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8980910099120824347' AND `dep_id` = '5113500673432871674'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8260533266213917302', '09122', '林榆', '416bc93aba73ec46', 'c28611ad', 'Z01A04A05',
  1, 0, 1, '09122', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09122');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6397427372770901406', '8260533266213917302', '5113500673432871674'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8260533266213917302' AND `dep_id` = '5113500673432871674'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6533959004393962819', '10518', '方勇', '7e9e4d0f42951771', 'bc83e144', 'Z01A04A05',
  1, 0, 1, '10518', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10518');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6974343088731242307', '6533959004393962819', '5113500673432871674'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6533959004393962819' AND `dep_id` = '5113500673432871674'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2465242560261421396', '13709', '金永佳', '64b179b0328c329a', '31016321', 'Z01A04A05',
  1, 0, 1, '13709', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13709');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6539826008472747442', '2465242560261421396', '5113500673432871674'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2465242560261421396' AND `dep_id` = '5113500673432871674'
);


-- 组别：快走丝组 (Z01A04A06)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9655180225459522503', '11537', '卿勇军', 'ce669ae21fb7524b', '94d7ee24', 'Z01A04A06',
  1, 0, 1, '11537', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11537');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3890519246227767288', '9655180225459522503', '1322000867748989711'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9655180225459522503' AND `dep_id` = '1322000867748989711'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8130215984668826154', '24493', '张晶', '81f435e1b1952aa9', '3af77dfc', 'Z01A04A06',
  1, 0, 1, '24493', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24493');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3691256776391228710', '8130215984668826154', '1322000867748989711'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8130215984668826154' AND `dep_id` = '1322000867748989711'
);

