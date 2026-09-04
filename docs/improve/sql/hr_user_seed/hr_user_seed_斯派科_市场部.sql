-- =============================================================================
-- HR 员工种子 — 斯派科 / 市场部
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
  '8275904850021980664', '4711055619678925456', '市场部', 6, '2', 'DEPT', 'S01A06',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A06');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4007311204826269782', '8275904850021980664', '市场策划', 1, '2', 'GROUP', 'S01A06A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A06A01');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：斯派科 / 市场部
-- -----------------------------------------------------------------------------


-- 组别：市场策划 (S01A06A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1057849495172301524', '600108', '陈伟杰', 'bfbd048bf09c9644', '8a1c9c3e', 'S01A06A01',
  1, 0, 1, '600108', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级市场推广专员', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600108');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6037737903284414011', '1057849495172301524', '4007311204826269782'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1057849495172301524' AND `dep_id` = '4007311204826269782'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6665574626048806518', '600115', '陈璐', 'a27f0f51ddb34862', '859c82c5', 'S01A06A01',
  1, 0, 1, '600115', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级销售主管', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600115');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5545747955141753029', '6665574626048806518', '4007311204826269782'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6665574626048806518' AND `dep_id` = '4007311204826269782'
);

