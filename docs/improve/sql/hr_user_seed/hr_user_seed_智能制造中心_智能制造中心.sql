-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 智能制造中心
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
  '7453473417342132295', '9372856559755238914', '智能制造中心', 3, '2', 'DEPT', 'Z01A03',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A03');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '5714553943480242792', '7453473417342132295', 'IPQC组', 1, '2', 'GROUP', 'Z01A03A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A03A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '8053825757986788459', '7453473417342132295', '生产跟单组', 2, '2', 'GROUP', 'Z01A03A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A03A02');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '2421966490176631632', '7453473417342132295', '越南分厂运营组', 3, '2', 'GROUP', 'Z01A03A03',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A03A03');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '2982471186682688671', '7453473417342132295', '快速响应交付组-HSD组', 4, '2', 'GROUP', 'Z01A03A04',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A03A04');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9396431614252783986', '7453473417342132295', '文职组', 5, '2', 'GROUP', 'Z01A03A05',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A03A05');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '6280959200664887698', '7453473417342132295', '转序组', 6, '2', 'GROUP', 'Z01A03A06',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A03A06');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 智能制造中心
-- -----------------------------------------------------------------------------


-- 组别：IPQC组 (Z01A03A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3043135050397208363', '01122', '钟长兵', 'e8ecc3ace15d1550', 'c8c32f8a', 'Z01A03A01',
  1, 0, 1, '01122', 'admin', NOW(), 'admin', NOW(), 1, 0, '主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01122');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9235151867637376505', '3043135050397208363', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3043135050397208363' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2852848742429696369', '02907', '闫中奎', 'b1b44cc4767955ba', '8203ce65', 'Z01A03A01',
  1, 0, 1, '02907', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02907');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9469174538117315705', '2852848742429696369', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2852848742429696369' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2435022357965993660', '03956', '郑晓平', 'a4fe3c6a187aa640', 'e153aa84', 'Z01A03A01',
  1, 0, 1, '03956', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03956');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9104631868701855283', '2435022357965993660', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2435022357965993660' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1503057533074798448', '05448', '彭小波', 'febd4c22605020ee', 'a7ef7fe9', 'Z01A03A01',
  1, 0, 1, '05448', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05448');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8478984135215157010', '1503057533074798448', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1503057533074798448' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4279879727873679885', '05943', '蒋海军', 'f6d2a66a27529303', '7357d05b', 'Z01A03A01',
  1, 0, 1, '05943', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05943');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8218315195517541811', '4279879727873679885', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4279879727873679885' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3854587650049049920', '06606', '魏星', '94cdb48a37a0fb2b', '3332aa60', 'Z01A03A01',
  1, 0, 1, '06606', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06606');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7085938083942671682', '3854587650049049920', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3854587650049049920' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9386410288678051410', '06644', '杨荣贵', '74514a69aeee3bb5', '2395fddd', 'Z01A03A01',
  1, 0, 1, '06644', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06644');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8898481299348837141', '9386410288678051410', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9386410288678051410' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3268143049627321181', '06960', '董林', '789103244937888b', '48e360c7', 'Z01A03A01',
  1, 0, 1, '06960', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06960');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2088795205395154327', '3268143049627321181', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3268143049627321181' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3274348353970845758', '11501', '范玉文', 'b389f8f9a5bd786e', '535587dc', 'Z01A03A01',
  1, 0, 1, '11501', 'admin', NOW(), 'admin', NOW(), 1, 0, '文员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11501');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3591019344849006712', '3274348353970845758', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3274348353970845758' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3651758288793896146', '12264', '胡水根', 'be927253b0cc94ee', '5e57ebf8', 'Z01A03A01',
  1, 0, 1, '12264', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12264');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4125637846766031805', '3651758288793896146', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3651758288793896146' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9055449295813314474', '14350', '张晓峰', '8965bb5f276ca80c', '404419ea', 'Z01A03A01',
  1, 0, 1, '14350', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14350');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2599849575302932161', '9055449295813314474', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9055449295813314474' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4212864461284080734', '14799', '廖云强', '380a13eee93f691e', 'bf1ffa0f', 'Z01A03A01',
  1, 0, 1, '14799', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14799');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8116517469246763530', '4212864461284080734', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4212864461284080734' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4666426467106550341', '14863', '潘立清', '6cb202835e040819', '52a1169c', 'Z01A03A01',
  1, 0, 1, '14863', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14863');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8300352169291972410', '4666426467106550341', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4666426467106550341' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3370001329751356997', '14974', '邓沛轩', 'f19b130e33ddc1cd', 'e7c625a5', 'Z01A03A01',
  1, 0, 1, '14974', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14974');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1776010483260394307', '3370001329751356997', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3370001329751356997' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1868808068463790306', '15419', '范桂浩', '2d34e0c9b37ff0d6', '8aeb97af', 'Z01A03A01',
  1, 0, 1, '15419', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15419');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9632195316422531061', '1868808068463790306', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1868808068463790306' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6984075586462369936', '17957', '李箭', '0c10fc51253257a3', 'eacc1242', 'Z01A03A01',
  1, 0, 1, '17957', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17957');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1558068971459134444', '6984075586462369936', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6984075586462369936' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8459770336231491620', '18046', '熊维祥', 'aa18e190214eb46a', '97b867c4', 'Z01A03A01',
  1, 0, 1, '18046', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18046');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4562827836389006804', '8459770336231491620', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8459770336231491620' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6678485408743297279', '18073', '曾一宏', '880e3d7ce73fd65d', '503fedab', 'Z01A03A01',
  1, 0, 1, '18073', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18073');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8445127040293571565', '6678485408743297279', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6678485408743297279' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1165490770461750844', '18126', '赵新强', 'e3cf8c91dc773b29', 'c62ca9f6', 'Z01A03A01',
  1, 0, 1, '18126', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18126');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9100984099179188684', '1165490770461750844', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1165490770461750844' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8915046478917984967', '18503', '邹杨', '456a5d4bad8ef81e', '27a14743', 'Z01A03A01',
  1, 0, 1, '18503', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18503');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5524974962949025115', '8915046478917984967', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8915046478917984967' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8356000909314094423', '19454', '李义强', '957e83e1de0d36e2', 'a5da7b5b', 'Z01A03A01',
  1, 0, 1, '19454', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19454');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2984553223203791252', '8356000909314094423', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8356000909314094423' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6123186798843448400', '20648', '贾云龙', '3c19a42863dd479a', '9671a2a2', 'Z01A03A01',
  1, 0, 1, '20648', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20648');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2806718748495665459', '6123186798843448400', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6123186798843448400' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9211236159817601001', '21344', '张林晓', '6ed2708e939cf510', '76ac5642', 'Z01A03A01',
  1, 0, 1, '21344', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21344');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3039293724662259210', '9211236159817601001', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9211236159817601001' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9448392145440640371', '22456', '胡锦成', 'c8a3db61b2531eac', '8fd3c15e', 'Z01A03A01',
  1, 0, 1, '22456', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22456');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1673553823953204371', '9448392145440640371', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9448392145440640371' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7274370399825581618', '22487', '付韶坤', '4e975ee3788562fa', '6129d448', 'Z01A03A01',
  1, 0, 1, '22487', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22487');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2247260165264310767', '7274370399825581618', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7274370399825581618' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1071253474120237293', '22502', '匡向杰', 'f3e56b9159696396', 'b09395a0', 'Z01A03A01',
  1, 0, 1, '22502', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22502');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2369517874371053838', '1071253474120237293', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1071253474120237293' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7457025038921350451', '22609', '欧阳金涛', '080f908fc000599a', '3ff2b5c1', 'Z01A03A01',
  1, 0, 1, '22609', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22609');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1002075144695025006', '7457025038921350451', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7457025038921350451' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3020081201248657558', '22705', '谢腾', '63f2bfcf2b826c87', 'a2c93c12', 'Z01A03A01',
  1, 0, 1, '22705', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22705');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5105121428823847998', '3020081201248657558', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3020081201248657558' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9146960209608567472', '24306', '古金城', '44e12c10d5bf0f2f', 'd0a01be5', 'Z01A03A01',
  1, 0, 1, '24306', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24306');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3017160412949460998', '9146960209608567472', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9146960209608567472' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9116819092250111673', '24492', '徐超超', 'ded408323978ae07', 'bcd42a93', 'Z01A03A01',
  1, 0, 1, '24492', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24492');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5242443279265898877', '9116819092250111673', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9116819092250111673' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8644847365089593506', '24916', '罗文平', 'c93211c75d0771b1', '9e754c9f', 'Z01A03A01',
  1, 0, 1, '24916', 'admin', NOW(), 'admin', NOW(), 1, 0, '文员', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24916');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1192758260068557066', '8644847365089593506', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8644847365089593506' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8338476094344237638', '25940', '黄世坤', '7708ba663ab27f7e', '087f6f62', 'Z01A03A01',
  1, 0, 1, '25940', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习检验员', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25940');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8592830109480039300', '8338476094344237638', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8338476094344237638' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3300138452027583629', '27156', '宋智威', '1c541de88cb56d71', 'adb9ed22', 'Z01A03A01',
  1, 0, 1, '27156', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27156');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8165598898228356848', '3300138452027583629', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3300138452027583629' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2250115364415973779', '27355', '蔡骏', 'fc6f117041a1beb0', '6f92e3ff', 'Z01A03A01',
  1, 0, 1, '27355', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27355');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7150222508402857646', '2250115364415973779', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2250115364415973779' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9873907889025773123', '27356', '柳瑞涵', '16ab04a8f310da8f', 'c8820c49', 'Z01A03A01',
  1, 0, 1, '27356', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27356');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2856491257743531682', '9873907889025773123', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9873907889025773123' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5150866224387055586', '27357', '陈佳旭', '7030dd3a13e65e20', 'c50bbd31', 'Z01A03A01',
  1, 0, 1, '27357', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27357');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5332480835134188873', '5150866224387055586', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5150866224387055586' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9319830759658900421', '27358', '张志明', 'dffb93aafd846340', 'f7afe49c', 'Z01A03A01',
  1, 0, 1, '27358', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27358');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8518991006914467223', '9319830759658900421', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9319830759658900421' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7823355660889822828', '27359', '张运繁', '1efc11fd157754e6', '3331b47e', 'Z01A03A01',
  1, 0, 1, '27359', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 380
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27359');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1606684172780962339', '7823355660889822828', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7823355660889822828' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7472840026469514922', '27360', '王振州', '79db0b714a7bda23', '439dd16a', 'Z01A03A01',
  1, 0, 1, '27360', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 390
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27360');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4953571329315248284', '7472840026469514922', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7472840026469514922' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7043462740793926210', '27381', '胡文凯', '09e6d006349ca972', '6b8f424c', 'Z01A03A01',
  1, 0, 1, '27381', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 400
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27381');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7038133125252552524', '7043462740793926210', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7043462740793926210' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8660929998163555395', '27466', '仇宇攀', '8069cce03ab85c23', 'a5a326ce', 'Z01A03A01',
  1, 0, 1, '27466', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 410
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27466');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6671232163835197392', '8660929998163555395', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8660929998163555395' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9781462645180689863', '27467', '陈俊', 'f0e8178069775e5d', '5929d3a0', 'Z01A03A01',
  1, 0, 1, '27467', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 420
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27467');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2141345783613069677', '9781462645180689863', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9781462645180689863' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7328778895822591506', '27493', '黄嘉愉', '8e34a9f89162754c', 'bd2ff916', 'Z01A03A01',
  1, 0, 1, '27493', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 430
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27493');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7739814966291045901', '7328778895822591506', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7328778895822591506' AND `dep_id` = '5714553943480242792'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4753978794204347934', '27494', '李思濡', '756f30de1bb27a15', '78a13ff6', 'Z01A03A01',
  1, 0, 1, '27494', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 440
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27494');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1036140211580494082', '4753978794204347934', '5714553943480242792'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4753978794204347934' AND `dep_id` = '5714553943480242792'
);


-- 组别：生产跟单组 (Z01A03A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9001128569762677419', '00093', '李勇', '0c826391ac8fd00c', 'f551b2eb', 'Z01A03A02',
  1, 0, 1, '00093', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '00093');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6749429878910256706', '9001128569762677419', '8053825757986788459'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9001128569762677419' AND `dep_id` = '8053825757986788459'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1743178290673504606', '02401', '张雄武', 'ae1df500fa4dd3f9', '3a7b94eb', 'Z01A03A02',
  1, 0, 1, '02401', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02401');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2055180955015845369', '1743178290673504606', '8053825757986788459'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1743178290673504606' AND `dep_id` = '8053825757986788459'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3642702109973435748', '03879', '梁锋', '0f64451f111f3eaf', 'b93c003e', 'Z01A03A02',
  1, 0, 1, '03879', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03879');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9041104021937001558', '3642702109973435748', '8053825757986788459'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3642702109973435748' AND `dep_id` = '8053825757986788459'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6063463781269779416', '08964', '刘东海', '5036b2dbb6dccd2c', '3e9754b0', 'Z01A03A02',
  1, 0, 1, '08964', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08964');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2329869023662979287', '6063463781269779416', '8053825757986788459'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6063463781269779416' AND `dep_id` = '8053825757986788459'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1813108722646458189', '09956', '袁松昌', 'd39c88f2e038ee2b', '951c72f8', 'Z01A03A02',
  1, 0, 1, '09956', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09956');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9754351202934184533', '1813108722646458189', '8053825757986788459'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1813108722646458189' AND `dep_id` = '8053825757986788459'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5737962515951140588', '10255', '张梓萱', '0d47b6e701b72733', '58a2ff1c', 'Z01A03A02',
  1, 0, 1, '10255', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10255');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6284630468903454879', '5737962515951140588', '8053825757986788459'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5737962515951140588' AND `dep_id` = '8053825757986788459'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4850767204150208814', '12229', '叶凤', 'ef14c69fde79e70d', '84dfd65f', 'Z01A03A02',
  1, 0, 1, '12229', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12229');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9451849890896818434', '4850767204150208814', '8053825757986788459'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4850767204150208814' AND `dep_id` = '8053825757986788459'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2766842092011019790', '21532', '李本安', '4dd98302cc81e649', 'a44e365d', 'Z01A03A02',
  1, 0, 1, '21532', 'admin', NOW(), 'admin', NOW(), 1, 0, '跟单员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21532');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2462967098769094317', '2766842092011019790', '8053825757986788459'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2766842092011019790' AND `dep_id` = '8053825757986788459'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5696795033822366557', '25611', '马佳榮', '1625e813cf771afa', '9f6bafc1', 'Z01A03A02',
  1, 0, 1, '25611', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25611');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8200762978269372732', '5696795033822366557', '8053825757986788459'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5696795033822366557' AND `dep_id` = '8053825757986788459'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8158141884649767900', '25615', '梁一飞', 'cae30fa443c54f74', '77016c5c', 'Z01A03A02',
  1, 0, 1, '25615', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25615');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2554645058520435248', '8158141884649767900', '8053825757986788459'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8158141884649767900' AND `dep_id` = '8053825757986788459'
);


-- 组别：越南分厂运营组 (Z01A03A03)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9207932645160992677', '03279', '宁胜', 'dbdf4b0b8d84038c', '4f704b6f', 'Z01A03A03',
  1, 0, 1, '03279', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03279');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7441475689639779501', '9207932645160992677', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9207932645160992677' AND `dep_id` = '2421966490176631632'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5979272544528542140', '03387', '于君', '6bfb0690ab7e14ce', '54891301', 'Z01A03A03',
  1, 0, 1, '03387', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03387');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1058158502020934263', '5979272544528542140', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5979272544528542140' AND `dep_id` = '2421966490176631632'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7952177856161523655', '04465', '梁光德', 'c6ad6244d08b23ab', '6a01dcb4', 'Z01A03A03',
  1, 0, 1, '04465', 'admin', NOW(), 'admin', NOW(), 1, 0, '技术审核员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04465');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3993679901972072735', '7952177856161523655', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7952177856161523655' AND `dep_id` = '2421966490176631632'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6822842210695394187', '09079', '李旭阳', 'a2dcab5ceae5a4e5', '1fabd388', 'Z01A03A03',
  1, 0, 1, '09079', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09079');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6649969933600073054', '6822842210695394187', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6822842210695394187' AND `dep_id` = '2421966490176631632'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3879305564256275109', '10970', '石习全', '73502dc7bfc98ee0', '8333b7cd', 'Z01A03A03',
  1, 0, 1, '10970', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10970');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2422675797384498872', '3879305564256275109', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3879305564256275109' AND `dep_id` = '2421966490176631632'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9045974923693041112', '15522', '蒋明晖', '57ae2a62ca59f819', '8ebdb6ba', 'Z01A03A03',
  1, 0, 1, '15522', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15522');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1641878759205789169', '9045974923693041112', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9045974923693041112' AND `dep_id` = '2421966490176631632'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7738588462151447236', '15783', '陈康佳', '400937422b885725', '5300f019', 'Z01A03A03',
  1, 0, 1, '15783', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15783');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8604011417926205511', '7738588462151447236', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7738588462151447236' AND `dep_id` = '2421966490176631632'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9577856073446604251', '17549', '李钰龙', '3908ad6ebaa9b9bd', '7484dc04', 'Z01A03A03',
  1, 0, 1, '17549', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17549');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4978522023581179196', '9577856073446604251', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9577856073446604251' AND `dep_id` = '2421966490176631632'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5892339884218848720', '22684', '周忠雄', 'f94dbb60e240c9c8', '0ec868bb', 'Z01A03A03',
  1, 0, 1, '22684', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22684');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1361363311638862769', '5892339884218848720', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5892339884218848720' AND `dep_id` = '2421966490176631632'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4417370709170350139', '24772', '王正晴', '4a2ba8107867026f', '980f50bf', 'Z01A03A03',
  1, 0, 1, '24772', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24772');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1671929085859534954', '4417370709170350139', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4417370709170350139' AND `dep_id` = '2421966490176631632'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4780226921984752289', '26137', '方景春', '20f6d19b349f40a1', 'd65e240d', 'Z01A03A03',
  1, 0, 1, '26137', 'admin', NOW(), 'admin', NOW(), 1, 0, '生产总监', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26137');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4767069333816271800', '4780226921984752289', '2421966490176631632'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4780226921984752289' AND `dep_id` = '2421966490176631632'
);


-- 组别：快速响应交付组-HSD组 (Z01A03A04)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3419703866035411995', '03435', '陈凌云', 'd75c42843b4c1dc9', '11b1ccfc', 'Z01A03A04',
  1, 0, 1, '03435', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03435');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3993633258390387076', '3419703866035411995', '2982471186682688671'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3419703866035411995' AND `dep_id` = '2982471186682688671'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8283975135095632733', '06112', '李刚', '728f0c45b2caf580', '113c5b08', 'Z01A03A04',
  1, 0, 1, '06112', 'admin', NOW(), 'admin', NOW(), 1, 0, '生产跟单', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06112');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5849842143791206649', '8283975135095632733', '2982471186682688671'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8283975135095632733' AND `dep_id` = '2982471186682688671'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4080849671216808707', '16967', '付澳华', '86ce20dc1dc5e67d', 'a2a7ebe5', 'Z01A03A04',
  1, 0, 1, '16967', 'admin', NOW(), 'admin', NOW(), 1, 0, '工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16967');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4652530139261025294', '4080849671216808707', '2982471186682688671'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4080849671216808707' AND `dep_id` = '2982471186682688671'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7615525900774099593', '24515', '吴荣', '1466c502e6dc6422', '08598010', 'Z01A03A04',
  1, 0, 1, '24515', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24515');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7576594730112712439', '7615525900774099593', '2982471186682688671'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7615525900774099593' AND `dep_id` = '2982471186682688671'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9839957285534193338', '25607', '李殷丞', '4db7d3893f6e3757', '9e54e64f', 'Z01A03A04',
  1, 0, 1, '25607', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25607');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7973891159383833617', '9839957285534193338', '2982471186682688671'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9839957285534193338' AND `dep_id` = '2982471186682688671'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4227458421652785335', '25612', '朱志坤', '554ba2f0ab6ea086', '9c978bee', 'Z01A03A04',
  1, 0, 1, '25612', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25612');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1880181494446368115', '4227458421652785335', '2982471186682688671'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4227458421652785335' AND `dep_id` = '2982471186682688671'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5340471040003358715', '26160', '彭浩洋', '91908e50bcd6f05b', '941e1ea1', 'Z01A03A04',
  1, 0, 1, '26160', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26160');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9252266506343588486', '5340471040003358715', '2982471186682688671'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5340471040003358715' AND `dep_id` = '2982471186682688671'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3067536033827894995', '27713', '蒋琳', '8dd0b40dee567ae4', '4b6947f3', 'Z01A03A04',
  1, 0, 1, '27713', 'admin', NOW(), 'admin', NOW(), 1, 0, '排产计划员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27713');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6774510595006746501', '3067536033827894995', '2982471186682688671'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3067536033827894995' AND `dep_id` = '2982471186682688671'
);


-- 组别：文职组 (Z01A03A05)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9129313319793348422', '08256', '吴林叶', '854bc1276044d1d9', 'b91f08a2', 'Z01A03A05',
  1, 0, 1, '08256', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08256');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2471232195480381757', '9129313319793348422', '9396431614252783986'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9129313319793348422' AND `dep_id` = '9396431614252783986'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2727544029656196041', '13835', '李丽萍', '048e0dc31d92f580', '3289ddd7', 'Z01A03A05',
  1, 0, 1, '13835', 'admin', NOW(), 'admin', NOW(), 1, 0, '文员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13835');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3142564050071162047', '2727544029656196041', '9396431614252783986'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2727544029656196041' AND `dep_id` = '9396431614252783986'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5377303683089471294', '14617', '陈灵', 'a29a8d9462a62e47', '7d4ef7b1', 'Z01A03A05',
  1, 0, 1, '14617', 'admin', NOW(), 'admin', NOW(), 1, 0, '文员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14617');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8578976787409016594', '5377303683089471294', '9396431614252783986'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5377303683089471294' AND `dep_id` = '9396431614252783986'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3375613839413751159', '25345', '徐国梁', '99e099c379f5fd54', '6998fefc', 'Z01A03A05',
  1, 0, 1, '25345', 'admin', NOW(), 'admin', NOW(), 1, 0, '副总', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25345');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9986184149897809202', '3375613839413751159', '9396431614252783986'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3375613839413751159' AND `dep_id` = '9396431614252783986'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7451532808156006168', '26948', '陆红连', '02cd6380f1071acc', '5a9d2bf7', 'Z01A03A05',
  1, 0, 1, '26948', 'admin', NOW(), 'admin', NOW(), 1, 0, '文员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26948');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4933007582254194924', '7451532808156006168', '9396431614252783986'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7451532808156006168' AND `dep_id` = '9396431614252783986'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3107063469530883082', '27113', '刘琴', '3fc3ceed66bd8866', 'dad92b0d', 'Z01A03A05',
  1, 0, 1, '27113', 'admin', NOW(), 'admin', NOW(), 1, 0, '生产工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27113');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4507246592157259835', '3107063469530883082', '9396431614252783986'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3107063469530883082' AND `dep_id` = '9396431614252783986'
);


-- 组别：转序组 (Z01A03A06)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8932328196855577884', '17413', '喻少锋', 'ac2c84a3cf7bae64', '1f518648', 'Z01A03A06',
  1, 0, 1, '17413', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17413');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1557185962324999793', '8932328196855577884', '6280959200664887698'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8932328196855577884' AND `dep_id` = '6280959200664887698'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8184606425100755966', '18074', '邓永明', 'a6806151c868b59f', '34caa87c', 'Z01A03A06',
  1, 0, 1, '18074', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18074');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6972675360181998846', '8184606425100755966', '6280959200664887698'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8184606425100755966' AND `dep_id` = '6280959200664887698'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1593602152951922816', '22334', '李江华', 'ab80e78b693b8fbd', '54a66601', 'Z01A03A06',
  1, 0, 1, '22334', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22334');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3303179304489344660', '1593602152951922816', '6280959200664887698'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1593602152951922816' AND `dep_id` = '6280959200664887698'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3785206108122555339', '23400', '周磊', '8944f66bf2d974da', '4b4a0bf4', 'Z01A03A06',
  1, 0, 1, '23400', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23400');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2471157170634520976', '3785206108122555339', '6280959200664887698'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3785206108122555339' AND `dep_id` = '6280959200664887698'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7028359256187870052', '24050', '廖志强', '47ee63e3c77eaa56', '8c4b8bdb', 'Z01A03A06',
  1, 0, 1, '24050', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24050');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8102412301138030073', '7028359256187870052', '6280959200664887698'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7028359256187870052' AND `dep_id` = '6280959200664887698'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3147195472293185886', '25297', '孔令枝', '3439bfe8162d5fe2', '0b70e0a0', 'Z01A03A06',
  1, 0, 1, '25297', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25297');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7557683162575248003', '3147195472293185886', '6280959200664887698'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3147195472293185886' AND `dep_id` = '6280959200664887698'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8749008442373724602', '26083', '夏威', 'b6ce665edf096b02', '0c207832', 'Z01A03A06',
  1, 0, 1, '26083', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26083');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3509485903259460078', '8749008442373724602', '6280959200664887698'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8749008442373724602' AND `dep_id` = '6280959200664887698'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2034583517710832483', '26111', '叶城冬', '0db467c2ababf080', '8b5e9092', 'Z01A03A06',
  1, 0, 1, '26111', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26111');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2465705582256317956', '2034583517710832483', '6280959200664887698'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2034583517710832483' AND `dep_id` = '6280959200664887698'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1223778930636409336', '26222', '白方刚', 'b742416ef756be68', '2233fb3a', 'Z01A03A06',
  1, 0, 1, '26222', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26222');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5189148481318527849', '1223778930636409336', '6280959200664887698'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1223778930636409336' AND `dep_id` = '6280959200664887698'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4082563522716427592', '26491', '席彬彬', '5a2af075b6de0c3c', '8cbf3c5c', 'Z01A03A06',
  1, 0, 1, '26491', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26491');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1979523198883432809', '4082563522716427592', '6280959200664887698'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4082563522716427592' AND `dep_id` = '6280959200664887698'
);

