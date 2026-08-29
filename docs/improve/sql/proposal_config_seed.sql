-- =============================================================================
-- 提案改善 — 联调配置种子（部门负责人 / 委员会 / 批准人）
-- 数据来源：inside_dev 管理端实配（2026-08-28 导出对齐）
-- 前置：已执行 proposal_init.sql、proposal_spex_user_seed.sql
-- 特性：幂等（WHERE NOT EXISTS），可重复执行；主键/人员/席位与开发库一致便于迁移
-- -----------------------------------------------------------------------------
-- 约定（与 inside_dev 一致）：
--   部门负责人：
--     MES开发          → 曾金   600013（tenant_id=''）
--     自动线开发部      → 汪秦军 600084（tenant_id='1000'）
--     电气控制          → 张小朋 600088（tenant_id='1000'）
--   批准人：汪秦军 600084（tenant_id='1000'）
--   委员会（全局跨部门，5 席均参与评分）：
--     席位1 曾金   600013（MES）
--     席位2 陈泽波 600026（MES）
--     席位3 刘恋   600051（电气）
--     席位4 张小朋 600088（电气）
--     席位5 吴浪   600099（MES）
--   提案人联调建议：贺志龙 600081 等非委员账号（吴浪已在委员会，勿互斥测）
-- =============================================================================

-- 1) 改善部门负责人
INSERT INTO `proposal_dept_leader` (
  `id`, `dept_id`, `leader_user_id`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093230938443452417',
  'spexdeptgroupmes0000000000001',
  'spexuser600013000000000000001',
  '管理员', '2026-08-28 14:55:21', '管理员', '2026-08-28 15:22:09', '', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_dept_leader`
  WHERE `dept_id` = 'spexdeptgroupmes0000000000001' AND `tenant_id` = ''
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `id` = 'spexuser600013000000000000001')
AND EXISTS (SELECT 1 FROM `sys_depart` WHERE `id` = 'spexdeptgroupmes0000000000001');

INSERT INTO `proposal_dept_leader` (
  `id`, `dept_id`, `leader_user_id`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093235821527683074',
  'spexdeptdept00000000000000001',
  'spexuser600084000000000000001',
  '管理员', '2026-08-28 15:14:45', '管理员', '2026-08-28 15:14:44', '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_dept_leader`
  WHERE `dept_id` = 'spexdeptdept00000000000000001' AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `id` = 'spexuser600084000000000000001')
AND EXISTS (SELECT 1 FROM `sys_depart` WHERE `id` = 'spexdeptdept00000000000000001');

INSERT INTO `proposal_dept_leader` (
  `id`, `dept_id`, `leader_user_id`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093242996387995649',
  'spexdeptgroupelc0000000000001',
  'spexuser600088000000000000001',
  '管理员', '2026-08-28 15:43:16', '管理员', '2026-08-28 15:43:15', '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_dept_leader`
  WHERE `dept_id` = 'spexdeptgroupelc0000000000001' AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `id` = 'spexuser600088000000000000001')
AND EXISTS (SELECT 1 FROM `sys_depart` WHERE `id` = 'spexdeptgroupelc0000000000001');

-- 2) 批准人：汪秦军
INSERT INTO `proposal_approver` (
  `id`, `user_id`, `approver_status`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093245634517131265',
  'spexuser600084000000000000001',
  'active',
  '管理员', '2026-08-28 15:53:45', '管理员', '2026-08-28 15:53:44', '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_approver`
  WHERE `user_id` = 'spexuser600084000000000000001' AND `tenant_id` = '1000' AND `active` = 'Y'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `id` = 'spexuser600084000000000000001');

-- 3) 委员会成员（5 席，均参与评分）
INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093246396064325634',
  'spexuser600013000000000000001',
  1, 1, 'active', 0,
  '管理员', '2026-08-28 15:56:46', '管理员', '2026-08-28 15:56:46', '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = 'spexuser600013000000000000001' AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `id` = 'spexuser600013000000000000001');

INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093253983954526210',
  'spexuser600026000000000000001',
  1, 2, 'active', 0,
  '管理员', '2026-08-28 16:26:55', '管理员', '2026-08-28 16:26:55', '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = 'spexuser600026000000000000001' AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `id` = 'spexuser600026000000000000001');

INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093254103479607297',
  'spexuser600051000000000000001',
  1, 3, 'active', 0,
  '管理员', '2026-08-28 16:27:24', '管理员', '2026-08-28 16:27:23', '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = 'spexuser600051000000000000001' AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `id` = 'spexuser600051000000000000001');

INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093261056981327874',
  'spexuser600088000000000000001',
  1, 4, 'active', 0,
  '管理员', '2026-08-28 16:55:02', '管理员', '2026-08-28 16:55:01', '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = 'spexuser600088000000000000001' AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `id` = 'spexuser600088000000000000001');

INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '2093261511924899842',
  'spexuser600099000000000000001',
  1, 5, 'active', 0,
  '管理员', '2026-08-28 16:56:50', '管理员', '2026-08-28 16:56:50', '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = 'spexuser600099000000000000001' AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `id` = 'spexuser600099000000000000001');
