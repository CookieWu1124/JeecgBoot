-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 品质部
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
  '8727143357308078996', '9372856559755238914', '品质部', 8, '2', 'DEPT', 'Z01A08',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9384413706957252961', '8727143357308078996', '辅助组-资料', 1, '2', 'GROUP', 'Z01A08A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4602980429320652455', '8727143357308078996', '辅助组-包装', 2, '2', 'GROUP', 'Z01A08A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A02');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '5713827661362745483', '8727143357308078996', '检验组-常规行业', 3, '2', 'GROUP', 'Z01A08A03',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A03');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '3810253234211310878', '8727143357308078996', 'QE组-OQC', 4, '2', 'GROUP', 'Z01A08A04',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A04');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4905152767961402508', '8727143357308078996', '检验组-特殊行业', 5, '2', 'GROUP', 'Z01A08A05',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A05');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4829128077562225069', '8727143357308078996', '检验组-零件', 6, '2', 'GROUP', 'Z01A08A06',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A06');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '5187038958499069095', '8727143357308078996', 'QE组-MRB', 7, '2', 'GROUP', 'Z01A08A07',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A07');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '1728427914229007476', '8727143357308078996', 'QE组-CQE', 8, '2', 'GROUP', 'Z01A08A08',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A08');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '1255506178065101225', '8727143357308078996', '检验组-治具', 9, '2', 'GROUP', 'Z01A08A09',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A09');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '7134411926374921080', '8727143357308078996', '计量组', 10, '2', 'GROUP', 'Z01A08A10',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A10');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '6042100785171074994', '8727143357308078996', '辅助组-刻字', 11, '2', 'GROUP', 'Z01A08A11',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A11');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '5992607380670182968', '8727143357308078996', 'SQE组-原材料', 12, '2', 'GROUP', 'Z01A08A12',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A12');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '5758891713582336731', '8727143357308078996', '检验组-设备', 13, '2', 'GROUP', 'Z01A08A13',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A13');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9161495162454665863', '8727143357308078996', 'SQE组-钣金', 14, '2', 'GROUP', 'Z01A08A14',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A14');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '2707014404555350132', '8727143357308078996', '辅助组-转序', 15, '2', 'GROUP', 'Z01A08A15',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A15');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4895848817891042576', '8727143357308078996', '文员组', 16, '2', 'GROUP', 'Z01A08A16',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A16');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9129356801866450750', '8727143357308078996', 'SQE组-标准件', 17, '2', 'GROUP', 'Z01A08A17',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A17');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '3084369072954855748', '8727143357308078996', '检验组-CMM', 18, '2', 'GROUP', 'Z01A08A18',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A18');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '6936767846049475443', '8727143357308078996', '辅助组-收货', 19, '2', 'GROUP', 'Z01A08A19',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A19');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '3105382374811150586', '8727143357308078996', 'QE组-AQE', 20, '2', 'GROUP', 'Z01A08A20',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A20');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9231715432463217813', '8727143357308078996', 'SQE组-工程', 21, '2', 'GROUP', 'Z01A08A21',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A21');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '2030944852730929372', '8727143357308078996', '模组QC', 22, '2', 'GROUP', 'Z01A08A22',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A22');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4129746369796699498', '8727143357308078996', 'IPQC', 23, '2', 'GROUP', 'Z01A08A23',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A23');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9446824087340309752', '8727143357308078996', 'OQC-外观检验', 24, '2', 'GROUP', 'Z01A08A24',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A24');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '8287248048458101131', '8727143357308078996', 'FQC', 25, '2', 'GROUP', 'Z01A08A25',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A25');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '2535679107032103478', '8727143357308078996', 'CQE', 26, '2', 'GROUP', 'Z01A08A26',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A26');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '5354124934344390562', '8727143357308078996', 'OQC', 27, '2', 'GROUP', 'Z01A08A27',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A27');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '7489199240373524893', '8727143357308078996', '模组QE', 28, '2', 'GROUP', 'Z01A08A28',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A28');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '5698773176694189626', '8727143357308078996', 'MRB', 29, '2', 'GROUP', 'Z01A08A29',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A29');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4887674630390164474', '8727143357308078996', '品质部', 30, '2', 'GROUP', 'Z01A08A30',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A08A30');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 品质部
-- -----------------------------------------------------------------------------


-- 组别：辅助组-资料 (Z01A08A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6273998354652284668', '02017', '欧阳嫦容', 'bd13d18c331d13b5', '2b9e8f4a', 'Z01A08A01',
  1, 0, 1, '02017', 'admin', NOW(), 'admin', NOW(), 1, 0, '资料整理员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02017');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6007987684232154171', '6273998354652284668', '9384413706957252961'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6273998354652284668' AND `dep_id` = '9384413706957252961'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6693985013149584163', '24671', '陈芳', '5c71a50b53451bb7', '1b48f35e', 'Z01A08A01',
  1, 0, 1, '24671', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习检验员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24671');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2500002165999910153', '6693985013149584163', '9384413706957252961'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6693985013149584163' AND `dep_id` = '9384413706957252961'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7813288687855312491', '26833', '邹庭', '0217ab941c2dbda4', '5a264263', 'Z01A08A01',
  1, 0, 1, '26833', 'admin', NOW(), 'admin', NOW(), 1, 0, '资料整理员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26833');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7562870338286599336', '7813288687855312491', '9384413706957252961'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7813288687855312491' AND `dep_id` = '9384413706957252961'
);


-- 组别：辅助组-包装 (Z01A08A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2443272754610078562', '02257', '余超', '3f951570f9893868', '2c009bcc', 'Z01A08A02',
  1, 0, 1, '02257', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02257');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2143640385420400593', '2443272754610078562', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2443272754610078562' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8774837867155216080', '14188', '崔伟廷', '478ad16a4ccb1579', '49e01b9f', 'Z01A08A02',
  1, 0, 1, '14188', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14188');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7291610453141346313', '8774837867155216080', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8774837867155216080' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8661099898258374919', '25987', '李豪光', '9ae0e8de95403c57', '2a73eedb', 'Z01A08A02',
  1, 0, 1, '25987', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25987');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6982956006804519424', '8661099898258374919', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8661099898258374919' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2217032814927820563', '26086', '张潮', '5d8324bce7b44041', '7a0d1cfe', 'Z01A08A02',
  1, 0, 1, '26086', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26086');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8704179617053956993', '2217032814927820563', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2217032814927820563' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2884857095276698278', '26142', '罗新安', '14374af8e8236827', '26a67501', 'Z01A08A02',
  1, 0, 1, '26142', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26142');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3538252686748574418', '2884857095276698278', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2884857095276698278' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2280685932476125147', '26143', '杨理前', '3e836f06f6e9ee34', '1f9ad190', 'Z01A08A02',
  1, 0, 1, '26143', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26143');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1432354328378692564', '2280685932476125147', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2280685932476125147' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3175182511453418072', '26193', '张雷', 'dcde85c744db4a57', '20ea48fc', 'Z01A08A02',
  1, 0, 1, '26193', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26193');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1404138339313377362', '3175182511453418072', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3175182511453418072' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2532824041070628547', '26782', '曾桂莲', 'b1b9fd818c08281a', '52956d76', 'Z01A08A02',
  1, 0, 1, '26782', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26782');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5487707737700789453', '2532824041070628547', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2532824041070628547' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4277611210215060845', '27309', '杨雷', 'f96c1be2127db43f', 'ae6f0302', 'Z01A08A02',
  1, 0, 1, '27309', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27309');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3414296238698086602', '4277611210215060845', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4277611210215060845' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5923683123953103239', '27310', '刘涛', '55b3cb4cf6c8c143', '313a277f', 'Z01A08A02',
  1, 0, 1, '27310', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27310');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6110797361119507598', '5923683123953103239', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5923683123953103239' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1160653574011035232', '27428', '唐熊杰', 'be8f6e1361450871', '3958ace3', 'Z01A08A02',
  1, 0, 1, '27428', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27428');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6421843580232017247', '1160653574011035232', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1160653574011035232' AND `dep_id` = '4602980429320652455'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1182146866877927033', '27771', '陈丁华', 'afd1391b98efa1ed', '95ab160c', 'Z01A08A02',
  1, 0, 1, '27771', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27771');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2874668326141967204', '1182146866877927033', '4602980429320652455'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1182146866877927033' AND `dep_id` = '4602980429320652455'
);


-- 组别：检验组-常规行业 (Z01A08A03)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1269722108591556731', '01650', '李岳梦', '38788edb7c2fc6aa', 'ab245479', 'Z01A08A03',
  1, 0, 1, '01650', 'admin', NOW(), 'admin', NOW(), 1, 0, '经理', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01650');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2185837992823972357', '1269722108591556731', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1269722108591556731' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9343926034033080937', '03872', '苏祖坚', 'd5a999455a47c22b', '9e9596c0', 'Z01A08A03',
  1, 0, 1, '03872', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03872');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1764030849661214208', '9343926034033080937', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9343926034033080937' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3290308934392355232', '07333', '胡熠辉', '180e84547c344e3a', '09b584fe', 'Z01A08A03',
  1, 0, 1, '07333', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07333');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3890766972101155090', '3290308934392355232', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3290308934392355232' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6155815887869519735', '07918', '彭艺宏', '153299673386e1dd', '08caa62a', 'Z01A08A03',
  1, 0, 1, '07918', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07918');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2227617583255997759', '6155815887869519735', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6155815887869519735' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9343363187058363920', '08079', '梁劲', '90d5620e6df47be1', 'b5f4b3be', 'Z01A08A03',
  1, 0, 1, '08079', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08079');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4241329672441302125', '9343363187058363920', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9343363187058363920' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7936417989871701898', '11351', '雷二燕', '1c88d81b3f48c5c5', '128c9367', 'Z01A08A03',
  1, 0, 1, '11351', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11351');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7560999466119677165', '7936417989871701898', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7936417989871701898' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3135662820463121041', '11939', '朱维武', 'da2f07cdcec4db72', 'de0bb5c9', 'Z01A08A03',
  1, 0, 1, '11939', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11939');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2600566200807947654', '3135662820463121041', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3135662820463121041' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5013027366318196613', '12857', '龚晓燕', '6645e5cf688a5788', 'b98f1f64', 'Z01A08A03',
  1, 0, 1, '12857', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12857');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2988783460977412548', '5013027366318196613', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5013027366318196613' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4286679806783651532', '13836', '刘石森', '51aedcd58bc51a2c', 'dedb56b1', 'Z01A08A03',
  1, 0, 1, '13836', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13836');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7879917940570214871', '4286679806783651532', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4286679806783651532' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6985809217291623608', '13937', '马龙佳', '783100a76415610a', '7d45ac9a', 'Z01A08A03',
  1, 0, 1, '13937', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13937');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7870654311538893508', '6985809217291623608', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6985809217291623608' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3869421691401479322', '13963', '谢珍华', '21e15e945b5dbba4', 'e34dede2', 'Z01A08A03',
  1, 0, 1, '13963', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13963');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1197105157264109950', '3869421691401479322', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3869421691401479322' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3940814732796140694', '15314', '张永新', '787ad335c4b91f45', '258795bb', 'Z01A08A03',
  1, 0, 1, '15314', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15314');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5755962317473757115', '3940814732796140694', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3940814732796140694' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5703116969014682260', '15345', '刘水胜', 'b3c9aa01c18f68f9', '9bceed4f', 'Z01A08A03',
  1, 0, 1, '15345', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15345');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6209480367990568126', '5703116969014682260', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5703116969014682260' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5174466701255054741', '15476', '卢罗妹', '90973e05e7363444', '7ef4b7c1', 'Z01A08A03',
  1, 0, 1, '15476', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15476');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2875042850844553288', '5174466701255054741', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5174466701255054741' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2595016915981978920', '15530', '李勇强', 'b0d6807c7af70dcc', 'c5d668cc', 'Z01A08A03',
  1, 0, 1, '15530', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15530');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8482281412608351647', '2595016915981978920', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2595016915981978920' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1210791414604001205', '15816', '张伍福', '306d8c371b8114c5', 'ab5b337a', 'Z01A08A03',
  1, 0, 1, '15816', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15816');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8878752049324425258', '1210791414604001205', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1210791414604001205' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6227815077957831904', '24302', '张国楚', '4d79870381f35e56', '972bbcdf', 'Z01A08A03',
  1, 0, 1, '24302', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24302');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7349944259218621919', '6227815077957831904', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6227815077957831904' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2152032135446786526', '24307', '文城', '98c0ac562df91473', 'e307cfe9', 'Z01A08A03',
  1, 0, 1, '24307', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24307');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5354233995732653247', '2152032135446786526', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2152032135446786526' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5666922085461700926', '24310', '刘艳希', '0fe6247bb95d3cf3', '4e1389e6', 'Z01A08A03',
  1, 0, 1, '24310', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24310');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4566241583539013251', '5666922085461700926', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5666922085461700926' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2148995158897824460', '24321', '李宇佳', 'd35e643580cf8e6f', 'e5a70d19', 'Z01A08A03',
  1, 0, 1, '24321', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24321');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8776676754452907478', '2148995158897824460', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2148995158897824460' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7115496168988084374', '24325', '杨锦中', '2e9340dc7b7b0f7c', 'd36f98f3', 'Z01A08A03',
  1, 0, 1, '24325', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24325');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2967629894541616820', '7115496168988084374', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7115496168988084374' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9710988166101349169', '24327', '冯欢欣', '91223fb9be61aff3', '8fa62e41', 'Z01A08A03',
  1, 0, 1, '24327', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24327');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4985407432286320345', '9710988166101349169', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9710988166101349169' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5449042366579705456', '24641', '唐希萍', '35901fa30773ea32', 'a15f5cd8', 'Z01A08A03',
  1, 0, 1, '24641', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24641');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1704538859671131924', '5449042366579705456', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5449042366579705456' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8946511605912669746', '24648', '黄建', '5f259f3ec895e3fe', '074000c7', 'Z01A08A03',
  1, 0, 1, '24648', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24648');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4935862998793234595', '8946511605912669746', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8946511605912669746' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5363697768698170409', '24743', '罗鑫丽', '5f30288a84baedde', 'e5fb71ef', 'Z01A08A03',
  1, 0, 1, '24743', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习检验员', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24743');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7370101793081510560', '5363697768698170409', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5363697768698170409' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7679717834714956812', '24809', '尹由美', '710cb5babd070368', '4f76031f', 'Z01A08A03',
  1, 0, 1, '24809', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24809');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1770732585039304243', '7679717834714956812', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7679717834714956812' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8661774166977590899', '24956', '李旭彬', 'd2ce588c8db5687f', 'dbf2ace5', 'Z01A08A03',
  1, 0, 1, '24956', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24956');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2049793028982239780', '8661774166977590899', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8661774166977590899' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5475862427976493259', '25524', '徐如意', '9840211939630904', '9976caf3', 'Z01A08A03',
  1, 0, 1, '25524', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25524');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2234893807329197752', '5475862427976493259', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5475862427976493259' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2069564053779822086', '25619', '莫秋玲', 'b0949e54777c364f', '6bdb79b9', 'Z01A08A03',
  1, 0, 1, '25619', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25619');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4146014217293314895', '2069564053779822086', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2069564053779822086' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8129604353674472134', '25620', '徐妹珍', '7a97da80e9aabe26', 'cf6f27c4', 'Z01A08A03',
  1, 0, 1, '25620', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25620');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7013832466513510841', '8129604353674472134', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8129604353674472134' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9884688579845707755', '25881', '傅旭伟', 'e962fff2e2014a51', 'da32a6dd', 'Z01A08A03',
  1, 0, 1, '25881', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25881');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8849661714894645374', '9884688579845707755', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9884688579845707755' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6606164693230289432', '25882', '赵克越', 'ace3da83334b1868', '1344ece0', 'Z01A08A03',
  1, 0, 1, '25882', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25882');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2553306349359985643', '6606164693230289432', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6606164693230289432' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5756072904476452502', '25883', '徐元桐', '49eeb0809883bee9', '1a299676', 'Z01A08A03',
  1, 0, 1, '25883', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25883');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9251872078124750173', '5756072904476452502', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5756072904476452502' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1339280545767434001', '25884', '谢英姿', '65b9c50a6d79e82e', '78138f6b', 'Z01A08A03',
  1, 0, 1, '25884', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25884');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8890125495244589300', '1339280545767434001', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1339280545767434001' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6376809679479081760', '25907', '姚忠良', 'e73cda2df8cbdf44', 'e0bc8e89', 'Z01A08A03',
  1, 0, 1, '25907', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25907');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2054917026502485822', '6376809679479081760', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6376809679479081760' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9790993766280291009', '25944', '王梦瑶', 'dbb73a504cbe0999', '4cac128f', 'Z01A08A03',
  1, 0, 1, '25944', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习检验员', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25944');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7858463172822536112', '9790993766280291009', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9790993766280291009' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1299360600093161318', '25945', '陈梦真', '4425344f3cc26f4b', 'dec7a009', 'Z01A08A03',
  1, 0, 1, '25945', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习检验员', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25945');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2376853327111382529', '1299360600093161318', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1299360600093161318' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6332250389957799158', '25986', '毛珊', 'f89e30369fabaec3', '697bde75', 'Z01A08A03',
  1, 0, 1, '25986', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习检验员', 380
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25986');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4030981997246093226', '6332250389957799158', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6332250389957799158' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6723367559543432782', '26061', '陈子怡', '189b8ac9e9a238a0', '96b7a295', 'Z01A08A03',
  1, 0, 1, '26061', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 390
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26061');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9311277268227485287', '6723367559543432782', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6723367559543432782' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7817488302277734556', '26181', '蔡文标', '1ecab95dcf7a87d1', '7965489a', 'Z01A08A03',
  1, 0, 1, '26181', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 400
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26181');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2991346367662162244', '7817488302277734556', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7817488302277734556' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3478335920627367312', '26251', '罗根贞', 'e5c54e8b2e3b0382', 'cb99d43b', 'Z01A08A03',
  1, 0, 1, '26251', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 410
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26251');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3266126618597376014', '3478335920627367312', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3478335920627367312' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3376910729223793792', '27361', '何靖豪', '76fb63a253f60a36', 'ed99805f', 'Z01A08A03',
  1, 0, 1, '27361', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 420
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27361');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9237311267213805141', '3376910729223793792', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3376910729223793792' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5171456855686132817', '27366', '臧彤彤', '5d54539982ec6272', '81fbe651', 'Z01A08A03',
  1, 0, 1, '27366', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 430
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27366');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4318699641441135588', '5171456855686132817', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5171456855686132817' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7095090352837710609', '27369', '贺锦朝', '24c57f41d7ff65cb', '1b680582', 'Z01A08A03',
  1, 0, 1, '27369', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 440
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27369');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2142899915531395406', '7095090352837710609', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7095090352837710609' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1752857128447858410', '27370', '张涵星', '6713bc81940d2f44', '4f3cb074', 'Z01A08A03',
  1, 0, 1, '27370', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 450
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27370');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4808300531927893325', '1752857128447858410', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1752857128447858410' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2550803612621923353', '27382', '伍佳旺', 'd33caecd39500741', '560ab3d9', 'Z01A08A03',
  1, 0, 1, '27382', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 460
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27382');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4002552021588706411', '2550803612621923353', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2550803612621923353' AND `dep_id` = '5713827661362745483'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1323294692655072632', '27556', '谢颜成', 'c70d382dd6cfe4ab', '8053bf51', 'Z01A08A03',
  1, 0, 1, '27556', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 470
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27556');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1111068702297064758', '1323294692655072632', '5713827661362745483'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1323294692655072632' AND `dep_id` = '5713827661362745483'
);


-- 组别：QE组-OQC (Z01A08A04)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6431826053233026352', '02585', '毛军', '65d1f45cdf391790', '73e70b04', 'Z01A08A04',
  1, 0, 1, '02585', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02585');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4348676531753260038', '6431826053233026352', '3810253234211310878'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6431826053233026352' AND `dep_id` = '3810253234211310878'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1329724781399751542', '06718', '柯建兴', '7bfe37b48de0b809', '8999807e', 'Z01A08A04',
  1, 0, 1, '06718', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06718');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5418262898795164392', '1329724781399751542', '3810253234211310878'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1329724781399751542' AND `dep_id` = '3810253234211310878'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5504085301361683031', '10184', '王萍', 'aa8c23eb247b1008', '086df2eb', 'Z01A08A04',
  1, 0, 1, '10184', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10184');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6134279094585246116', '5504085301361683031', '3810253234211310878'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5504085301361683031' AND `dep_id` = '3810253234211310878'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6461491687989102660', '10469', '卢文莹', 'c2ff17b81e35f3e5', 'db173505', 'Z01A08A04',
  1, 0, 1, '10469', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10469');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9939833939331490535', '6461491687989102660', '3810253234211310878'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6461491687989102660' AND `dep_id` = '3810253234211310878'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9471587696818699043', '24957', '彭辉', '42f865b5ad3fd34f', 'bd8db9b5', 'Z01A08A04',
  1, 0, 1, '24957', 'admin', NOW(), 'admin', NOW(), 1, 0, '主管', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24957');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9570936862651208586', '9471587696818699043', '3810253234211310878'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9471587696818699043' AND `dep_id` = '3810253234211310878'
);


-- 组别：检验组-特殊行业 (Z01A08A05)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9445395522703427460', '02962', '李有烘', 'a583fc8526deb41a', '08320f67', 'Z01A08A05',
  1, 0, 1, '02962', 'admin', NOW(), 'admin', NOW(), 1, 0, '组长', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02962');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4466282984290757253', '9445395522703427460', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9445395522703427460' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1442623772891864962', '03025', '肖成祝', 'd4ce72ee00c35608', '413cd2cf', 'Z01A08A05',
  1, 0, 1, '03025', 'admin', NOW(), 'admin', NOW(), 1, 0, '组长', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03025');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8035165179110817555', '1442623772891864962', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1442623772891864962' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3844553704641785589', '06684', '卿长胜', '90c5a3dac837dcc7', 'da2640a4', 'Z01A08A05',
  1, 0, 1, '06684', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06684');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3812244293428024470', '3844553704641785589', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3844553704641785589' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2994592373660900735', '09617', '黄金乐', '72cd7c45327062bc', '5bcbb951', 'Z01A08A05',
  1, 0, 1, '09617', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09617');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9531986437130386352', '2994592373660900735', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2994592373660900735' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8420299995720685772', '10801', '陈思明', '2b684abb5fdb0559', '5b2afa14', 'Z01A08A05',
  1, 0, 1, '10801', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10801');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5536633918592076412', '8420299995720685772', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8420299995720685772' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9821990952301743670', '10929', '刘许林', 'a9f6b4b7d0924dfb', '0bcb9c53', 'Z01A08A05',
  1, 0, 1, '10929', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10929');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8588171223781540218', '9821990952301743670', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9821990952301743670' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1455992762871322686', '11157', '段龙飞', 'b751fd7154364bc1', 'f340a385', 'Z01A08A05',
  1, 0, 1, '11157', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11157');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7577375682210114113', '1455992762871322686', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1455992762871322686' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6553968534523530998', '11159', '袁周洧', 'dd63047c979ac81f', 'b02608ac', 'Z01A08A05',
  1, 0, 1, '11159', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11159');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9823065048648545996', '6553968534523530998', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6553968534523530998' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6380987975627237057', '13158', '陆崇辉', '3782ff6e3a80d402', '83525ca0', 'Z01A08A05',
  1, 0, 1, '13158', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13158');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7694157909083568426', '6380987975627237057', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6380987975627237057' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9457138225496754723', '15575', '苟云霞', 'fb0c1376ca8a6ce7', '7c190bbf', 'Z01A08A05',
  1, 0, 1, '15575', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15575');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5084440131838554018', '9457138225496754723', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9457138225496754723' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1111746553016317700', '24305', '钟舒平', 'bdb1dac453384444', '2c1ad0a2', 'Z01A08A05',
  1, 0, 1, '24305', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24305');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3303022748635906427', '1111746553016317700', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1111746553016317700' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5205244303394405951', '24308', '罗一鸣', 'ff60869ba2a82b2a', 'b9e7c118', 'Z01A08A05',
  1, 0, 1, '24308', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24308');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8435243430632596852', '5205244303394405951', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5205244303394405951' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7832080424414903370', '24309', '聂宇涵', '52152f7a77614671', '166df774', 'Z01A08A05',
  1, 0, 1, '24309', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24309');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3881335252137343853', '7832080424414903370', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7832080424414903370' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8656221669621991408', '24326', '钟丹', '1d3a67a27cda48e3', '07856317', 'Z01A08A05',
  1, 0, 1, '24326', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24326');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9843595415416314674', '8656221669621991408', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8656221669621991408' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6374872781047260962', '24452', '龙红', '49203a7db73ed230', '7b0a1437', 'Z01A08A05',
  1, 0, 1, '24452', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24452');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2510377030869464493', '6374872781047260962', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6374872781047260962' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9097404143240534205', '25625', '李玲玲', '17f327ff4fbefa16', '6cc01d21', 'Z01A08A05',
  1, 0, 1, '25625', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25625');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9322402699094927212', '9097404143240534205', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9097404143240534205' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5226748425473894874', '26134', '宁淑芳', 'e423aa234789ccce', 'd332f7c3', 'Z01A08A05',
  1, 0, 1, '26134', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26134');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8229699506336255889', '5226748425473894874', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5226748425473894874' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5154752679110342003', '26422', '时玉菊', '506036e16cc39455', '30f283f1', 'Z01A08A05',
  1, 0, 1, '26422', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26422');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1254153364280101617', '5154752679110342003', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5154752679110342003' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1928319925342308138', '27362', '刘海棠', 'd596023aa30f9285', '85551b34', 'Z01A08A05',
  1, 0, 1, '27362', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27362');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4885086668494734890', '1928319925342308138', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1928319925342308138' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3008286347785987485', '27363', '谢涛', 'e5cf9214ec6ddc1b', '9399165b', 'Z01A08A05',
  1, 0, 1, '27363', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27363');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6203103934709896489', '3008286347785987485', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3008286347785987485' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8282960588633985742', '27364', '龚苑盈', '0641931f352290a2', 'bcd5b66f', 'Z01A08A05',
  1, 0, 1, '27364', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27364');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9546780131271215921', '8282960588633985742', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8282960588633985742' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4048718053027439700', '27365', '呙月池', 'c9af58de76a41e14', '5266645d', 'Z01A08A05',
  1, 0, 1, '27365', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27365');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8996670837628501700', '4048718053027439700', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4048718053027439700' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9816734055963815514', '27367', '郭一帆', '477b6fef209ed43f', '1a19aa26', 'Z01A08A05',
  1, 0, 1, '27367', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27367');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5860165167362606963', '9816734055963815514', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9816734055963815514' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3483991081907219783', '27371', '陈剑云', 'fac0b9e037ee5520', '063850c9', 'Z01A08A05',
  1, 0, 1, '27371', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27371');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1762258657623496063', '3483991081907219783', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3483991081907219783' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8724889000554700847', '27372', '梁淇', '7c01f1cf8ab49872', '7167fac0', 'Z01A08A05',
  1, 0, 1, '27372', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27372');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2475875839043233997', '8724889000554700847', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8724889000554700847' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6535653413895298121', '27385', '唐磊', '60a85de7a18ac059', 'a3084a27', 'Z01A08A05',
  1, 0, 1, '27385', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27385');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8680156034866749535', '6535653413895298121', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6535653413895298121' AND `dep_id` = '4905152767961402508'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2250473486274409052', '27560', '许俊伟', '4d985424017c16d9', '4abe9db7', 'Z01A08A05',
  1, 0, 1, '27560', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验主管', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27560');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6470547151343929615', '2250473486274409052', '4905152767961402508'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2250473486274409052' AND `dep_id` = '4905152767961402508'
);


-- 组别：检验组-零件 (Z01A08A06)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7318334393090486086', '02994', '范美兰', 'b6b4dce85adbe2b0', 'fbd21dae', 'Z01A08A06',
  1, 0, 1, '02994', 'admin', NOW(), 'admin', NOW(), 1, 0, '主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02994');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3944066719627435733', '7318334393090486086', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7318334393090486086' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9807961533118496208', '06483', '赵世峰', 'fa31879db395cbd9', 'e60ddea1', 'Z01A08A06',
  1, 0, 1, '06483', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06483');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8669682012397830321', '9807961533118496208', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9807961533118496208' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2929545604332608567', '12646', '范金华', 'a9b7660056eb9364', '73b26c02', 'Z01A08A06',
  1, 0, 1, '12646', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12646');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6064372369688086203', '2929545604332608567', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2929545604332608567' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1741388926318775659', '13081', '丘润达', '6f4b180cc51d1cd8', '846b18bc', 'Z01A08A06',
  1, 0, 1, '13081', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13081');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1376454421405649347', '1741388926318775659', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1741388926318775659' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5474126540933885462', '13163', '邹送榜', 'c8d0d1c44179bbe2', '5d4739a0', 'Z01A08A06',
  1, 0, 1, '13163', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13163');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4724252294789465853', '5474126540933885462', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5474126540933885462' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7234631169555608663', '16658', '陈正午', '7cbddf765ad92cd5', '209e8302', 'Z01A08A06',
  1, 0, 1, '16658', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16658');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2847051603153197747', '7234631169555608663', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7234631169555608663' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8514117458177540567', '16849', '粟深炳', '3bb17135b0239ea2', '8f6a09e3', 'Z01A08A06',
  1, 0, 1, '16849', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16849');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6397307827867419594', '8514117458177540567', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8514117458177540567' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8422968859623129421', '22473', '邓必娇', '2bed03172eec9b95', '1368f906', 'Z01A08A06',
  1, 0, 1, '22473', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22473');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2858368523783697761', '8422968859623129421', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8422968859623129421' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6935997584300144235', '22478', '李东毅', '7b407f4b54cdbb9a', '2bc56fb4', 'Z01A08A06',
  1, 0, 1, '22478', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22478');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2015529255033023515', '6935997584300144235', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6935997584300144235' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9476772954799466622', '22479', '唐威', 'dea960151de78dfc', '89b1eba7', 'Z01A08A06',
  1, 0, 1, '22479', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22479');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9000852423507073641', '9476772954799466622', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9476772954799466622' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8948866239419814886', '22492', '唐淑凤', '32bedcf3674eeaf2', '6d1987eb', 'Z01A08A06',
  1, 0, 1, '22492', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22492');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3875877228945110146', '8948866239419814886', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8948866239419814886' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7936637477887429009', '25618', '匡焱', 'da349f78083235c9', '38917756', 'Z01A08A06',
  1, 0, 1, '25618', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25618');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4519219069675688360', '7936637477887429009', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7936637477887429009' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2867404673517790970', '25957', '江家杰', 'df2b1c260cd37c24', '87e99eba', 'Z01A08A06',
  1, 0, 1, '25957', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25957');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9088134159387239492', '2867404673517790970', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2867404673517790970' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6064324659382461257', '26044', '黄富', '727056f560383363', '139693ee', 'Z01A08A06',
  1, 0, 1, '26044', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习检验员', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26044');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4938444915027637614', '6064324659382461257', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6064324659382461257' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4086766553587870659', '26070', '徐会生', '6c45ded93a15967b', '2b9a7fce', 'Z01A08A06',
  1, 0, 1, '26070', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26070');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9250073991160342336', '4086766553587870659', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4086766553587870659' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7779215992734730563', '26628', '谭明振', '7947909f8c7d117c', 'de236f7c', 'Z01A08A06',
  1, 0, 1, '26628', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26628');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3558501210438651937', '7779215992734730563', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7779215992734730563' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1728682511785702445', '27373', '包米米', '9d59ac6a6c3d7cb3', '1b955adb', 'Z01A08A06',
  1, 0, 1, '27373', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27373');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1720771064978814902', '1728682511785702445', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1728682511785702445' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9247903699026415748', '27374', '李知书', 'a5fc2b5b9cdefd81', 'f22fc8c1', 'Z01A08A06',
  1, 0, 1, '27374', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27374');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7424120434711585802', '9247903699026415748', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9247903699026415748' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5384856553768754226', '27375', '吴丽琼', 'caa74e128bd7b143', '4a6e1ddc', 'Z01A08A06',
  1, 0, 1, '27375', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27375');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3298364272617484861', '5384856553768754226', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5384856553768754226' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7369972108164420823', '27376', '马煜卓', '1abdda2bd4855bd0', 'd17f63f3', 'Z01A08A06',
  1, 0, 1, '27376', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27376');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7038973126977668802', '7369972108164420823', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7369972108164420823' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9250556515858927166', '27377', '向勇', 'c235f60b76811124', '54b03e8b', 'Z01A08A06',
  1, 0, 1, '27377', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27377');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7066336146105591220', '9250556515858927166', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9250556515858927166' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7746830947175611780', '27378', '易健', 'f36462cec5bedfe8', 'b3a7b81b', 'Z01A08A06',
  1, 0, 1, '27378', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27378');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5739715881952444627', '7746830947175611780', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7746830947175611780' AND `dep_id` = '4829128077562225069'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8091529183392334827', '27555', '唐耿国', 'e07d1944abe6cbc5', '3fa61992', 'Z01A08A06',
  1, 0, 1, '27555', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27555');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6594999741537909212', '8091529183392334827', '4829128077562225069'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8091529183392334827' AND `dep_id` = '4829128077562225069'
);


-- 组别：QE组-MRB (Z01A08A07)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9472628413421002992', '03522', '彭清泉', 'd3b7905a500b5ec6', '62e51bf8', 'Z01A08A07',
  1, 0, 1, '03522', 'admin', NOW(), 'admin', NOW(), 1, 0, '主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03522');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7661846000997430539', '9472628413421002992', '5187038958499069095'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9472628413421002992' AND `dep_id` = '5187038958499069095'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3946246900751377017', '07125', '查利斌', 'f93f4bbdc6f62230', '6f1d601d', 'Z01A08A07',
  1, 0, 1, '07125', 'admin', NOW(), 'admin', NOW(), 1, 0, 'MRB工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07125');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8018134707537256503', '3946246900751377017', '5187038958499069095'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3946246900751377017' AND `dep_id` = '5187038958499069095'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3453356511251459835', '08978', '帅桂玲', '9f2f6c361339c5bd', '3146d09a', 'Z01A08A07',
  1, 0, 1, '08978', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08978');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2877125354105834521', '3453356511251459835', '5187038958499069095'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3453356511251459835' AND `dep_id` = '5187038958499069095'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6352066111192216075', '25200', '邓水林', '9f7a2dbd516aa5c7', '09902025', 'Z01A08A07',
  1, 0, 1, '25200', 'admin', NOW(), 'admin', NOW(), 1, 0, 'MRB工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25200');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1726186947070189977', '6352066111192216075', '5187038958499069095'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6352066111192216075' AND `dep_id` = '5187038958499069095'
);


-- 组别：QE组-CQE (Z01A08A08)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5166443172307707166', '03643', '曹运洪', 'e3cee557445c4c68', 'f394b450', 'Z01A08A08',
  1, 0, 1, '03643', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级CQE工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03643');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4894060572071453692', '5166443172307707166', '1728427914229007476'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5166443172307707166' AND `dep_id` = '1728427914229007476'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9206689972991791239', '16839', '张士兴', '83cd6bb7d3ca314f', '8e1a9e95', 'Z01A08A08',
  1, 0, 1, '16839', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CQE工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16839');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4731491863774630772', '9206689972991791239', '1728427914229007476'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9206689972991791239' AND `dep_id` = '1728427914229007476'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2887080362577336226', '22359', '高佳萍', '94f04e2b78e8ad9b', '5a9bbaea', 'Z01A08A08',
  1, 0, 1, '22359', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理QE工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22359');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1189836523009000160', '2887080362577336226', '1728427914229007476'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2887080362577336226' AND `dep_id` = '1728427914229007476'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4886134098519169180', '24416', '韦天鹏', '04a7e25cbf5f47c2', '9085e05f', 'Z01A08A08',
  1, 0, 1, '24416', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CQE工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24416');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7486132125860138223', '4886134098519169180', '1728427914229007476'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4886134098519169180' AND `dep_id` = '1728427914229007476'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7576312635250782084', '24461', '王建文', 'ecc20c801a9e74db', '43986f2f', 'Z01A08A08',
  1, 0, 1, '24461', 'admin', NOW(), 'admin', NOW(), 1, 0, '自动化品质部经理', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24461');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6349057004251910910', '7576312635250782084', '1728427914229007476'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7576312635250782084' AND `dep_id` = '1728427914229007476'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7356918446224802050', '25413', '童昊', 'e4d152dbfe3850a0', '44b0aa2f', 'Z01A08A08',
  1, 0, 1, '25413', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CQE工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25413');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9689006348167317894', '7356918446224802050', '1728427914229007476'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7356918446224802050' AND `dep_id` = '1728427914229007476'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9637837998245973149', '26013', '寻民旺', '3e9c5150ed16f8d5', 'c25fd9f3', 'Z01A08A08',
  1, 0, 1, '26013', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CQE工程师', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26013');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1070008756682605287', '9637837998245973149', '1728427914229007476'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9637837998245973149' AND `dep_id` = '1728427914229007476'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2505225786379905264', '26761', '成慧琳', 'e155cfd58f9b2041', '20f38233', 'Z01A08A08',
  1, 0, 1, '26761', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CQE工程师', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26761');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9052040110627458238', '2505225786379905264', '1728427914229007476'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2505225786379905264' AND `dep_id` = '1728427914229007476'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4356241976393462843', '27435', '袁泽华', 'fe0af9a63fcbbbc3', 'c271f5db', 'Z01A08A08',
  1, 0, 1, '27435', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27435');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4641529773189836239', '4356241976393462843', '1728427914229007476'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4356241976393462843' AND `dep_id` = '1728427914229007476'
);


-- 组别：检验组-治具 (Z01A08A09)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6072080409316564554', '03908', '欧阳和平', 'a7e4e17e58c97c73', '9d022722', 'Z01A08A09',
  1, 0, 1, '03908', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03908');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6235555423140751857', '6072080409316564554', '1255506178065101225'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6072080409316564554' AND `dep_id` = '1255506178065101225'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4394691878399513347', '04730', '谢军', 'a0a49f750aa80cba', '93196a74', 'Z01A08A09',
  1, 0, 1, '04730', 'admin', NOW(), 'admin', NOW(), 1, 0, '组长', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04730');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1206942507643928848', '4394691878399513347', '1255506178065101225'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4394691878399513347' AND `dep_id` = '1255506178065101225'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6558540397027193507', '08362', '张红玲', '85be263e04957fc0', '85ecef3b', 'Z01A08A09',
  1, 0, 1, '08362', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08362');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5387815500981546757', '6558540397027193507', '1255506178065101225'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6558540397027193507' AND `dep_id` = '1255506178065101225'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5327947280069292998', '10796', '周贵帮', '2942f87564d76f59', 'f1b2747e', 'Z01A08A09',
  1, 0, 1, '10796', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10796');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7142878987701288250', '5327947280069292998', '1255506178065101225'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5327947280069292998' AND `dep_id` = '1255506178065101225'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9280601504744877991', '11341', '胡宝林', '6fc0f0546bc1853c', 'c1a5a3d9', 'Z01A08A09',
  1, 0, 1, '11341', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11341');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6358673184707136826', '9280601504744877991', '1255506178065101225'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9280601504744877991' AND `dep_id` = '1255506178065101225'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5731578662253803350', '12353', '梁万益', '6c58fe6d956dda31', '19720a9e', 'Z01A08A09',
  1, 0, 1, '12353', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12353');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6818557875737202777', '5731578662253803350', '1255506178065101225'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5731578662253803350' AND `dep_id` = '1255506178065101225'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9548287339196755315', '21079', '刘卓峰', '25d5d4e8af4f49d7', 'e95d03f5', 'Z01A08A09',
  1, 0, 1, '21079', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21079');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2863575178743041030', '9548287339196755315', '1255506178065101225'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9548287339196755315' AND `dep_id` = '1255506178065101225'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8666926811329137179', '25188', '邓业娟', 'd037981ee70e0cc3', '600693b6', 'Z01A08A09',
  1, 0, 1, '25188', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25188');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6756144951510242434', '8666926811329137179', '1255506178065101225'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8666926811329137179' AND `dep_id` = '1255506178065101225'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6944207589628795888', '25785', '黎梓豪', '8ad23ba3b4b47e3e', '76ca550c', 'Z01A08A09',
  1, 0, 1, '25785', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25785');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5210717903398205048', '6944207589628795888', '1255506178065101225'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6944207589628795888' AND `dep_id` = '1255506178065101225'
);


-- 组别：计量组 (Z01A08A10)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8078561618179367221', '04228', '邓朝军', '954acca58bc5ca29', 'bb01fc76', 'Z01A08A10',
  1, 0, 1, '04228', 'admin', NOW(), 'admin', NOW(), 1, 0, '仪校员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04228');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8342671986549075911', '8078561618179367221', '7134411926374921080'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8078561618179367221' AND `dep_id` = '7134411926374921080'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4676224406797710331', '26005', '刘杰锋', '0c655087936b019e', '04eb6d9b', 'Z01A08A10',
  1, 0, 1, '26005', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习计量员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26005');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4835199993905410026', '4676224406797710331', '7134411926374921080'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4676224406797710331' AND `dep_id` = '7134411926374921080'
);


-- 组别：辅助组-刻字 (Z01A08A11)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1578678395065868269', '06849', '雷士泉', '758fbd8ba83a634a', '08602b87', 'Z01A08A11',
  1, 0, 1, '06849', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06849');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1322717859299813619', '1578678395065868269', '6042100785171074994'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1578678395065868269' AND `dep_id` = '6042100785171074994'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1101357878801856685', '10797', '罗腾香', '40f0366a7c903603', '8a5f0eee', 'Z01A08A11',
  1, 0, 1, '10797', 'admin', NOW(), 'admin', NOW(), 1, 0, '刻字员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10797');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1679319538039337352', '1101357878801856685', '6042100785171074994'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1101357878801856685' AND `dep_id` = '6042100785171074994'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8694590340964381881', '11306', '杨胜玲', '12728c6e29c9a5a1', '2f4e6c4f', 'Z01A08A11',
  1, 0, 1, '11306', 'admin', NOW(), 'admin', NOW(), 1, 0, '刻字员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11306');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9181152267161794440', '8694590340964381881', '6042100785171074994'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8694590340964381881' AND `dep_id` = '6042100785171074994'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6005267777115236941', '14403', '林益兰', 'cbb65f016be2f974', '83a0d2b9', 'Z01A08A11',
  1, 0, 1, '14403', 'admin', NOW(), 'admin', NOW(), 1, 0, '刻字员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14403');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6231035231064262178', '6005267777115236941', '6042100785171074994'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6005267777115236941' AND `dep_id` = '6042100785171074994'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4198266980025683194', '26971', '涂俊', '7dcb704e5dc68623', '29ecaa3e', 'Z01A08A11',
  1, 0, 1, '26971', 'admin', NOW(), 'admin', NOW(), 1, 0, '刻字员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26971');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5441940741133000252', '4198266980025683194', '6042100785171074994'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4198266980025683194' AND `dep_id` = '6042100785171074994'
);


-- 组别：SQE组-原材料 (Z01A08A12)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4124409363779727460', '07055', '王丹', '06d91d0adba09dea', 'e9434e22', 'Z01A08A12',
  1, 0, 1, '07055', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07055');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1349892812160754167', '4124409363779727460', '5992607380670182968'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4124409363779727460' AND `dep_id` = '5992607380670182968'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1175839515723782606', '15499', '王峰', '2fb0a9efdf33480a', 'f765085e', 'Z01A08A12',
  1, 0, 1, '15499', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15499');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5426668393603940499', '1175839515723782606', '5992607380670182968'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1175839515723782606' AND `dep_id` = '5992607380670182968'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1300303401089822927', '16657', '曹天帅', 'dbb6328d37fde05a', '47ed1cb7', 'Z01A08A12',
  1, 0, 1, '16657', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16657');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9631304792818472743', '1300303401089822927', '5992607380670182968'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1300303401089822927' AND `dep_id` = '5992607380670182968'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5505171224239632620', '25652', '王雄发', '5e281471ab1a78a3', '33a59511', 'Z01A08A12',
  1, 0, 1, '25652', 'admin', NOW(), 'admin', NOW(), 1, 0, 'SQE工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25652');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1194567356617046694', '5505171224239632620', '5992607380670182968'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5505171224239632620' AND `dep_id` = '5992607380670182968'
);


-- 组别：检验组-设备 (Z01A08A13)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7961766825018062214', '07115', '王宁', '4e8c81bacf53149a', 'ff788dd8', 'Z01A08A13',
  1, 0, 1, '07115', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07115');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8497271925505120547', '7961766825018062214', '5758891713582336731'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7961766825018062214' AND `dep_id` = '5758891713582336731'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4671687348904383397', '24699', '文燕明', '53a6c62bbfaf02ae', '052a5f15', 'Z01A08A13',
  1, 0, 1, '24699', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24699');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1392576927995337131', '4671687348904383397', '5758891713582336731'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4671687348904383397' AND `dep_id` = '5758891713582336731'
);


-- 组别：SQE组-钣金 (Z01A08A14)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6694803890436918658', '07710', '梁明', '712885df034293dc', '321367eb', 'Z01A08A14',
  1, 0, 1, '07710', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07710');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1418369726664935357', '6694803890436918658', '9161495162454665863'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6694803890436918658' AND `dep_id` = '9161495162454665863'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3876526525462089715', '10282', '朱志刚', '66d7471141046937', '29797f01', 'Z01A08A14',
  1, 0, 1, '10282', 'admin', NOW(), 'admin', NOW(), 1, 0, '钣金QE工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10282');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8853691874914448394', '3876526525462089715', '9161495162454665863'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3876526525462089715' AND `dep_id` = '9161495162454665863'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7385676633171065832', '14447', '兰文兴', 'b9b8467436fbf3cd', '51b521a4', 'Z01A08A14',
  1, 0, 1, '14447', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14447');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4941489029726564997', '7385676633171065832', '9161495162454665863'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7385676633171065832' AND `dep_id` = '9161495162454665863'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7026479622397448394', '16744', '黄常肖', 'f71775cafc6eba2c', '1f0e995f', 'Z01A08A14',
  1, 0, 1, '16744', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16744');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7374714193385746106', '7026479622397448394', '9161495162454665863'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7026479622397448394' AND `dep_id` = '9161495162454665863'
);


-- 组别：辅助组-转序 (Z01A08A15)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2772034528786883614', '08649', '皮秋平', 'a39bf641c6fe107f', '7e8153ec', 'Z01A08A15',
  1, 0, 1, '08649', 'admin', NOW(), 'admin', NOW(), 1, 0, '包装员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08649');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8311848412673689711', '2772034528786883614', '2707014404555350132'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2772034528786883614' AND `dep_id` = '2707014404555350132'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8956060957281111450', '10983', '周志胜', '4f84d29795ca41a3', 'fe4c8929', 'Z01A08A15',
  1, 0, 1, '10983', 'admin', NOW(), 'admin', NOW(), 1, 0, '普工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10983');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5960552824994759195', '8956060957281111450', '2707014404555350132'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8956060957281111450' AND `dep_id` = '2707014404555350132'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8687763525652227712', '23563', '欧丙姣', '519d7f8f54ff901f', 'ef4d8b71', 'Z01A08A15',
  1, 0, 1, '23563', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23563');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3926741610426454230', '8687763525652227712', '2707014404555350132'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8687763525652227712' AND `dep_id` = '2707014404555350132'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7594191847838784074', '24165', '时佳宁', '25c3fe249a96c1d3', '8033fda3', 'Z01A08A15',
  1, 0, 1, '24165', 'admin', NOW(), 'admin', NOW(), 1, 0, '转序', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24165');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7778715541067053868', '7594191847838784074', '2707014404555350132'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7594191847838784074' AND `dep_id` = '2707014404555350132'
);


-- 组别：文员组 (Z01A08A16)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6208663507430061765', '10955', '董烈梅', '5d7823f013fee7cb', '9492655e', 'Z01A08A16',
  1, 0, 1, '10955', 'admin', NOW(), 'admin', NOW(), 1, 0, '文员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10955');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2269127980011856228', '6208663507430061765', '4895848817891042576'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6208663507430061765' AND `dep_id` = '4895848817891042576'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6882560553460204035', '23633', '周敏', '3947d7a045d5bf9a', 'c915b554', 'Z01A08A16',
  1, 0, 1, '23633', 'admin', NOW(), 'admin', NOW(), 1, 0, '文员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23633');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4487636089438297757', '6882560553460204035', '4895848817891042576'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6882560553460204035' AND `dep_id` = '4895848817891042576'
);


-- 组别：SQE组-标准件 (Z01A08A17)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6028059394402867361', '11981', '刘艳英', '5992c3003900420c', '3c013081', 'Z01A08A17',
  1, 0, 1, '11981', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11981');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2364849507873918801', '6028059394402867361', '9129356801866450750'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6028059394402867361' AND `dep_id` = '9129356801866450750'
);


-- 组别：检验组-CMM (Z01A08A18)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7854688156902666198', '13016', '梁潇君', '95415da8ac8e0572', '8fd90da0', 'Z01A08A18',
  1, 0, 1, '13016', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13016');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3633295926778720771', '7854688156902666198', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7854688156902666198' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2731983257450807510', '14881', '陈满', '62f7607dbb16ad21', '414d44eb', 'Z01A08A18',
  1, 0, 1, '14881', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14881');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1780438245337645469', '2731983257450807510', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2731983257450807510' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9082768032220087428', '20767', '王刚', 'c7b8a02c9c2a0914', '0e0aa595', 'Z01A08A18',
  1, 0, 1, '20767', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20767');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7487107560711651384', '9082768032220087428', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9082768032220087428' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3508258212864316281', '21184', '陈世林', '81beb4c476c146ab', 'b8101b8a', 'Z01A08A18',
  1, 0, 1, '21184', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21184');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8461012225227691832', '3508258212864316281', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3508258212864316281' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1173053435094665374', '24329', '何荣彬', '48dd68535964d621', '524e253f', 'Z01A08A18',
  1, 0, 1, '24329', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24329');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6727875950928834866', '1173053435094665374', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1173053435094665374' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2213165194937109901', '24428', '刘嘉', '4964a50679303070', 'd7f1048f', 'Z01A08A18',
  1, 0, 1, '24428', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24428');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9488669017372290405', '2213165194937109901', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2213165194937109901' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4544628638694892599', '24513', '罗日豪', 'b2de88d5c3740ddf', '9976db04', 'Z01A08A18',
  1, 0, 1, '24513', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24513');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8078022478724476235', '4544628638694892599', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4544628638694892599' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6696353550366180533', '24516', '熊于清', '5a231d5faed0cfc5', 'c6cedcc3', 'Z01A08A18',
  1, 0, 1, '24516', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习三坐标测量员', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24516');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2275105314659091148', '6696353550366180533', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6696353550366180533' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1351479502537059199', '24975', '傅嘉靖', 'f1378633990c3f75', '9eb4d1df', 'Z01A08A18',
  1, 0, 1, '24975', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24975');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3249427114860997760', '1351479502537059199', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1351479502537059199' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9213835228534630120', '25126', '朱加友', 'd7d4f3b57a9a954a', '48bc4514', 'Z01A08A18',
  1, 0, 1, '25126', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25126');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8696709534228759435', '9213835228534630120', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9213835228534630120' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4943474958803924967', '25204', '陈磊', '09ef939b65493698', 'd9812d00', 'Z01A08A18',
  1, 0, 1, '25204', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25204');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3548885349156413688', '4943474958803924967', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4943474958803924967' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8462108929227281482', '26060', '罗记诚', '23fec98de60a230e', 'f5a800fa', 'Z01A08A18',
  1, 0, 1, '26060', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26060');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5411977895771272662', '8462108929227281482', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8462108929227281482' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5706971970175835582', '26102', '李一豪', 'd898de0d64294fa1', '6458014e', 'Z01A08A18',
  1, 0, 1, '26102', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26102');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4569923953057961726', '5706971970175835582', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5706971970175835582' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5700661911500820525', '26191', '夏高晏', '48cce13edacad308', '7e9ce79d', 'Z01A08A18',
  1, 0, 1, '26191', 'admin', NOW(), 'admin', NOW(), 1, 0, '测量工程师', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26191');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7273787548849989183', '5700661911500820525', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5700661911500820525' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1112599169421268038', '26227', '邵天良', '573703e0c8399f97', 'f7f382c0', 'Z01A08A18',
  1, 0, 1, '26227', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26227');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9696341300438380312', '1112599169421268038', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1112599169421268038' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1521727282547140885', '26437', '欧卫雄', '2685df77a316d350', '48937454', 'Z01A08A18',
  1, 0, 1, '26437', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26437');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4238726279872482120', '1521727282547140885', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1521727282547140885' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8962088424917455371', '26920', '曾令发', '2bc5c74bc9ad9bcb', '42333600', 'Z01A08A18',
  1, 0, 1, '26920', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26920');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8309689973647576785', '8962088424917455371', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8962088424917455371' AND `dep_id` = '3084369072954855748'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5815185081764923067', '27868', '胡勇', 'ac902e511f61d99f', 'cdc33e34', 'Z01A08A18',
  1, 0, 1, '27868', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CMM测量员', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27868');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5691437361017594950', '5815185081764923067', '3084369072954855748'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5815185081764923067' AND `dep_id` = '3084369072954855748'
);


-- 组别：辅助组-收货 (Z01A08A19)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5661689192195018843', '13950', '李静', '78573b1d75e22226', '2d773b6c', 'Z01A08A19',
  1, 0, 1, '13950', 'admin', NOW(), 'admin', NOW(), 1, 0, '普工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13950');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5519347978969173379', '5661689192195018843', '6936767846049475443'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5661689192195018843' AND `dep_id` = '6936767846049475443'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1880297257757590513', '15479', '何德玉', 'a630ce0965c14fb4', 'c644c61a', 'Z01A08A19',
  1, 0, 1, '15479', 'admin', NOW(), 'admin', NOW(), 1, 0, '普工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15479');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3472917433891081462', '1880297257757590513', '6936767846049475443'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1880297257757590513' AND `dep_id` = '6936767846049475443'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1960395667336047707', '24696', '彭妹', '00aef09cd9463176', '01343294', 'Z01A08A19',
  1, 0, 1, '24696', 'admin', NOW(), 'admin', NOW(), 1, 0, '普工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24696');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4106896670164523288', '1960395667336047707', '6936767846049475443'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1960395667336047707' AND `dep_id` = '6936767846049475443'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7489688351239804661', '24777', '朱桂兰', '6f65de9e56cf5987', '9b2618df', 'Z01A08A19',
  1, 0, 1, '24777', 'admin', NOW(), 'admin', NOW(), 1, 0, '普工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24777');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8495517170213296589', '7489688351239804661', '6936767846049475443'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7489688351239804661' AND `dep_id` = '6936767846049475443'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9069272310306171398', '24784', '高天文', 'aec0b5eebdbe3171', '2e3a6013', 'Z01A08A19',
  1, 0, 1, '24784', 'admin', NOW(), 'admin', NOW(), 1, 0, '普工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24784');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6186078240690634886', '9069272310306171398', '6936767846049475443'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9069272310306171398' AND `dep_id` = '6936767846049475443'
);


-- 组别：QE组-AQE (Z01A08A20)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2734862146130757462', '14059', '袁作维', '1d43a678c1e2c70a', '193eff19', 'Z01A08A20',
  1, 0, 1, '14059', 'admin', NOW(), 'admin', NOW(), 1, 0, '品质工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14059');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1697922857792908337', '2734862146130757462', '3105382374811150586'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2734862146130757462' AND `dep_id` = '3105382374811150586'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4036062829691514349', '27597', '孙文峰', '3ecd163973a4bd84', '65e42ff1', 'Z01A08A20',
  1, 0, 1, '27597', 'admin', NOW(), 'admin', NOW(), 1, 0, '半导体零件品质工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27597');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6294968048700670849', '4036062829691514349', '3105382374811150586'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4036062829691514349' AND `dep_id` = '3105382374811150586'
);


-- 组别：SQE组-工程 (Z01A08A21)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7229870672832897384', '14451', '崔文杰', 'fcb40a7e1af5ac24', 'd712e905', 'Z01A08A21',
  1, 0, 1, '14451', 'admin', NOW(), 'admin', NOW(), 1, 0, 'SQE工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14451');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5490474762279032226', '7229870672832897384', '9231715432463217813'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7229870672832897384' AND `dep_id` = '9231715432463217813'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4230067069644238169', '16754', '陆文豪', '031162e0f2422ab4', 'df61f540', 'Z01A08A21',
  1, 0, 1, '16754', 'admin', NOW(), 'admin', NOW(), 1, 0, 'SQE工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16754');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4704052823169366928', '4230067069644238169', '9231715432463217813'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4230067069644238169' AND `dep_id` = '9231715432463217813'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6430510572296078919', '25078', '韦仕玉', '6e191b13cbdc7f93', '4e6f0a5d', 'Z01A08A21',
  1, 0, 1, '25078', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25078');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7388632034924852781', '6430510572296078919', '9231715432463217813'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6430510572296078919' AND `dep_id` = '9231715432463217813'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9904246412814902530', '25209', '张杰', '7410a19c313c63b5', '311fe992', 'Z01A08A21',
  1, 0, 1, '25209', 'admin', NOW(), 'admin', NOW(), 1, 0, 'SQE工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25209');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6352974614387772459', '9904246412814902530', '9231715432463217813'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9904246412814902530' AND `dep_id` = '9231715432463217813'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6990217357778736908', '25374', '李云鹏', '6f8114126a0018bc', '7befe5d3', 'Z01A08A21',
  1, 0, 1, '25374', 'admin', NOW(), 'admin', NOW(), 1, 0, 'SQE工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25374');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4493894240590249162', '6990217357778736908', '9231715432463217813'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6990217357778736908' AND `dep_id` = '9231715432463217813'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7830292764868667304', '26007', '陈松岳', '8c1c1ea11f6acdaf', '542ce63c', 'Z01A08A21',
  1, 0, 1, '26007', 'admin', NOW(), 'admin', NOW(), 1, 0, 'SQE工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26007');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8031939733063279705', '7830292764868667304', '9231715432463217813'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7830292764868667304' AND `dep_id` = '9231715432463217813'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8131008765878380215', '27267', '覃嘉庆', '2eccf4038b2d5e6b', '6de3b2dd', 'Z01A08A21',
  1, 0, 1, '27267', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理QE工程师', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27267');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6382360428108912489', '8131008765878380215', '9231715432463217813'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8131008765878380215' AND `dep_id` = '9231715432463217813'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6546807626153508581', '27318', '白朋波', '9ba7f46f79763bc9', 'bc1f9bf7', 'Z01A08A21',
  1, 0, 1, '27318', 'admin', NOW(), 'admin', NOW(), 1, 0, 'SQE工程师', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27318');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5020064791727586231', '6546807626153508581', '9231715432463217813'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6546807626153508581' AND `dep_id` = '9231715432463217813'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3816480901332330046', '27429', '丁斯哲', 'ad8b1239c7376282', '63009ae2', 'Z01A08A21',
  1, 0, 1, '27429', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27429');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3408582295404041869', '3816480901332330046', '9231715432463217813'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3816480901332330046' AND `dep_id` = '9231715432463217813'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1036638194819838447', '27432', '林灿炜', '16e8895d0edad728', 'f0026b6f', 'Z01A08A21',
  1, 0, 1, '27432', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27432');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6926317540152941854', '1036638194819838447', '9231715432463217813'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1036638194819838447' AND `dep_id` = '9231715432463217813'
);


-- 组别：模组QC (Z01A08A22)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3177428144094711073', '24879', '李楚湘', '47cbb469be9bdff9', 'e932c7a4', 'Z01A08A22',
  1, 0, 1, '24879', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24879');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7637179524960835349', '3177428144094711073', '2030944852730929372'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3177428144094711073' AND `dep_id` = '2030944852730929372'
);


-- 组别：IPQC (Z01A08A23)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8812436056668308996', '24906', '王艳芬', 'a3a11d82ad912b23', 'dccf288e', 'Z01A08A23',
  1, 0, 1, '24906', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24906');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8127286980924292521', '8812436056668308996', '4129746369796699498'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8812436056668308996' AND `dep_id` = '4129746369796699498'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7405312384580031456', '26033', '肖婷', 'f8ab1971a2b1d197', 'eb0102a5', 'Z01A08A23',
  1, 0, 1, '26033', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26033');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2323293602412855090', '7405312384580031456', '4129746369796699498'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7405312384580031456' AND `dep_id` = '4129746369796699498'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7201948211332768384', '26046', '陈小萍', '1370dffbe64caeee', '86fed342', 'Z01A08A23',
  1, 0, 1, '26046', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26046');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4975922138163903450', '7201948211332768384', '4129746369796699498'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7201948211332768384' AND `dep_id` = '4129746369796699498'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7358417146733946359', '26460', '吕渊泉', '2621163acdbb288b', '8ed403d9', 'Z01A08A23',
  1, 0, 1, '26460', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26460');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7953646984341574644', '7358417146733946359', '4129746369796699498'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7358417146733946359' AND `dep_id` = '4129746369796699498'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4148146233842835453', '26953', '石校庆', '1316090588065004', 'e76eb310', 'Z01A08A23',
  1, 0, 1, '26953', 'admin', NOW(), 'admin', NOW(), 1, 0, 'PQE工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26953');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1705520743917028257', '4148146233842835453', '4129746369796699498'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4148146233842835453' AND `dep_id` = '4129746369796699498'
);


-- 组别：OQC-外观检验 (Z01A08A24)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3621033484300985899', '26324', '张毅东', '8ee0135da4e0d4dd', '8971a166', 'Z01A08A24',
  1, 0, 1, '26324', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26324');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3417957251888303686', '3621033484300985899', '9446824087340309752'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3621033484300985899' AND `dep_id` = '9446824087340309752'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9108260657437050677', '26806', '朱志国', '90b87551a149d795', '7bd3f8d5', 'Z01A08A24',
  1, 0, 1, '26806', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26806');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9827698376982583824', '9108260657437050677', '9446824087340309752'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9108260657437050677' AND `dep_id` = '9446824087340309752'
);


-- 组别：FQC (Z01A08A25)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2234557206246912795', '26941', '刘程欣', '61e35993f75555a0', '485dd5cf', 'Z01A08A25',
  1, 0, 1, '26941', 'admin', NOW(), 'admin', NOW(), 1, 0, '检验员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26941');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5488752653826629229', '2234557206246912795', '8287248048458101131'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2234557206246912795' AND `dep_id` = '8287248048458101131'
);


-- 组别：CQE (Z01A08A26)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9214284286165912867', '26950', '罗新', 'f20e396a04935055', '3d24250a', 'Z01A08A26',
  1, 0, 1, '26950', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CQE工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26950');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8686858466484548063', '9214284286165912867', '2535679107032103478'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9214284286165912867' AND `dep_id` = '2535679107032103478'
);


-- 组别：OQC (Z01A08A27)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5416333649367920721', '27379', '谷洋', 'ff4d239631d451a6', '0f5f37ab', 'Z01A08A27',
  1, 0, 1, '27379', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27379');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2339466743075923705', '5416333649367920721', '5354124934344390562'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5416333649367920721' AND `dep_id` = '5354124934344390562'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5706467761042873191', '27380', '张焰锋', '67712579cfea62e5', 'd164a5ce', 'Z01A08A27',
  1, 0, 1, '27380', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27380');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1918910156486625737', '5706467761042873191', '5354124934344390562'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5706467761042873191' AND `dep_id` = '5354124934344390562'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3616371317436920594', '27383', '阳柳倪', 'ec603b7ebfd030ad', '31b19818', 'Z01A08A27',
  1, 0, 1, '27383', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27383');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3300739617040237742', '3616371317436920594', '5354124934344390562'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3616371317436920594' AND `dep_id` = '5354124934344390562'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4441188642834711376', '27384', '曹琳', 'b31c33d7782372eb', '7e0f8cc2', 'Z01A08A27',
  1, 0, 1, '27384', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27384');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3589834594508088597', '4441188642834711376', '5354124934344390562'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4441188642834711376' AND `dep_id` = '5354124934344390562'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2646595124621311692', '27407', '代雨航', 'ca22b855d3b0d129', '25c12ade', 'Z01A08A27',
  1, 0, 1, '27407', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27407');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5539631344627009087', '2646595124621311692', '5354124934344390562'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2646595124621311692' AND `dep_id` = '5354124934344390562'
);


-- 组别：模组QE (Z01A08A28)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2006414521391267637', '27394', '高祥', '61f0fbc77dc0ba52', '38885b3f', 'Z01A08A28',
  1, 0, 1, '27394', 'admin', NOW(), 'admin', NOW(), 1, 0, '经理', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27394');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1256315393564588041', '2006414521391267637', '7489199240373524893'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2006414521391267637' AND `dep_id` = '7489199240373524893'
);


-- 组别：MRB (Z01A08A29)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2173287164223338051', '27414', '孙凯旋', 'ca8d7978bf3464f3', '0e9e6a05', 'Z01A08A29',
  1, 0, 1, '27414', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27414');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5680192326583864924', '2173287164223338051', '5698773176694189626'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2173287164223338051' AND `dep_id` = '5698773176694189626'
);


-- 组别：品质部 (Z01A08A30)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3474475701172290163', '27773', '蔡泽波', 'd62ff1f50ea50ce6', '7fb70be1', 'Z01A08A30',
  1, 0, 1, '27773', 'admin', NOW(), 'admin', NOW(), 1, 0, '品质总监', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27773');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7304541462914301865', '3474475701172290163', '4887674630390164474'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3474475701172290163' AND `dep_id` = '4887674630390164474'
);

