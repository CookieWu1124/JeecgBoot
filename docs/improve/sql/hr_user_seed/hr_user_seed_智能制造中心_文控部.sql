-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 文控部
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
  '8950868361588807239', '9372856559755238914', '文控部', 11, '2', 'DEPT', 'Z01A11',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A11');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '7384705063183505618', '8950868361588807239', 'QS组', 1, '2', 'GROUP', 'Z01A11A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A11A01');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 文控部
-- -----------------------------------------------------------------------------


-- 组别：QS组 (Z01A11A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4923923997407614063', '07931', '陈乾', 'f8206d4e5b1b27b5', 'e4f6da3d', 'Z01A11A01',
  1, 0, 1, '07931', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级文控师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07931');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7235853553825942664', '4923923997407614063', '7384705063183505618'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4923923997407614063' AND `dep_id` = '7384705063183505618'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9374302774609802843', '24667', '黎颖瑶', '0b64ff2e3799db79', 'bb000b91', 'Z01A11A01',
  1, 0, 1, '24667', 'admin', NOW(), 'admin', NOW(), 1, 0, '体系工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24667');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5766498036569827837', '9374302774609802843', '7384705063183505618'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9374302774609802843' AND `dep_id` = '7384705063183505618'
);

