-- =============================================================================
-- 提案改善 — 联调配置种子（部门负责人 / 委员会 / 批准人）
-- 数据来源：inside_dev 管理端实配（2026-08-28 导出对齐）
-- 前置：已执行 proposal_init.sql、hr_user_seed_all.sql
-- 特性：幂等（WHERE NOT EXISTS）；人员/部门通过 work_no、org_code 子查询解析 ID
-- -----------------------------------------------------------------------------
-- 约定：
--   部门负责人 斯派科/自动线开发部/MES开发 → 600013 (tenant='')
--   部门负责人 斯派科/自动线开发部 → 600084 (tenant=1000)
--   部门负责人 斯派科/自动线开发部/电气控制 → 600088 (tenant=1000)
--   批准人：600084
--   委员会 5 席：600013, 600026, 600051, 600088, 600099
-- =============================================================================

-- 部门负责人：斯派科 / 自动线开发部 / MES开发 → 600013
INSERT INTO `proposal_dept_leader` (
  `id`, `dept_id`, `leader_user_id`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093230938443452417',
  (SELECT `id` FROM `sys_depart` WHERE `org_code` = 'S01A01A01' LIMIT 1),
  (SELECT `id` FROM `sys_user` WHERE `username` = '600013' LIMIT 1),
  '管理员', NOW(), '管理员', NOW(), '', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_dept_leader`
  WHERE `dept_id` = (SELECT `id` FROM `sys_depart` WHERE `org_code` = 'S01A01A01' LIMIT 1)
    AND `tenant_id` = ''
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600013')
AND EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01A01');

-- 部门负责人：斯派科 / 自动线开发部 → 600084
INSERT INTO `proposal_dept_leader` (
  `id`, `dept_id`, `leader_user_id`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093235821527683074',
  (SELECT `id` FROM `sys_depart` WHERE `org_code` = 'S01A01' LIMIT 1),
  (SELECT `id` FROM `sys_user` WHERE `username` = '600084' LIMIT 1),
  '管理员', NOW(), '管理员', NOW(), '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_dept_leader`
  WHERE `dept_id` = (SELECT `id` FROM `sys_depart` WHERE `org_code` = 'S01A01' LIMIT 1)
    AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600084')
AND EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01');

-- 部门负责人：斯派科 / 自动线开发部 / 电气控制 → 600088
INSERT INTO `proposal_dept_leader` (
  `id`, `dept_id`, `leader_user_id`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093242996387995649',
  (SELECT `id` FROM `sys_depart` WHERE `org_code` = 'S01A01A03' LIMIT 1),
  (SELECT `id` FROM `sys_user` WHERE `username` = '600088' LIMIT 1),
  '管理员', NOW(), '管理员', NOW(), '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_dept_leader`
  WHERE `dept_id` = (SELECT `id` FROM `sys_depart` WHERE `org_code` = 'S01A01A03' LIMIT 1)
    AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600088')
AND EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01A03');

-- 批准人：600084
INSERT INTO `proposal_approver` (
  `id`, `user_id`, `approver_status`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093245634517131265',
  (SELECT `id` FROM `sys_user` WHERE `username` = '600084' LIMIT 1),
  'active',
  '管理员', NOW(), '管理员', NOW(), '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_approver`
  WHERE `user_id` = (SELECT `id` FROM `sys_user` WHERE `username` = '600084' LIMIT 1)
    AND `tenant_id` = '1000' AND `active` = 'Y'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600084');


-- 委员会成员（5 席，均参与评分）
INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093246396064325634',
  (SELECT `id` FROM `sys_user` WHERE `username` = '600013' LIMIT 1),
  1, 1, 'active', 0,
  '管理员', NOW(), '管理员', NOW(), '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = (SELECT `id` FROM `sys_user` WHERE `username` = '600013' LIMIT 1)
    AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600013');

INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093253983954526210',
  (SELECT `id` FROM `sys_user` WHERE `username` = '600026' LIMIT 1),
  1, 2, 'active', 0,
  '管理员', NOW(), '管理员', NOW(), '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = (SELECT `id` FROM `sys_user` WHERE `username` = '600026' LIMIT 1)
    AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600026');

INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093254103479607297',
  (SELECT `id` FROM `sys_user` WHERE `username` = '600051' LIMIT 1),
  1, 3, 'active', 0,
  '管理员', NOW(), '管理员', NOW(), '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = (SELECT `id` FROM `sys_user` WHERE `username` = '600051' LIMIT 1)
    AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600051');

INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093261056981327874',
  (SELECT `id` FROM `sys_user` WHERE `username` = '600088' LIMIT 1),
  1, 4, 'active', 0,
  '管理员', NOW(), '管理员', NOW(), '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = (SELECT `id` FROM `sys_user` WHERE `username` = '600088' LIMIT 1)
    AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600088');

INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093261511924899842',
  (SELECT `id` FROM `sys_user` WHERE `username` = '600099' LIMIT 1),
  1, 5, 'active', 0,
  '管理员', NOW(), '管理员', NOW(), '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = (SELECT `id` FROM `sys_user` WHERE `username` = '600099' LIMIT 1)
    AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600099');

