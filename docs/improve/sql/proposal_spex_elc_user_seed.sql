-- =============================================================================
-- 提案改善 — 电气控制组别补种（手工执行）
-- 来源：docs/improve/data/员工列表20260822.xls（中心=斯派科，组别=电气控制）
-- 目标库：inside_dev
-- 约定：username = work_no；初始密码 123456；挂到 spexdeptgroupelc（org_code=S01A01A02）
-- 说明：600088 张小朋已在 proposal_spex_user_seed.sql 中，本脚本幂等跳过
-- =============================================================================

-- 600048 莫际威
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600048000000000000001', '600048', '莫际威', '6698a53e8ddf3231', 'SpxElc01', 'S01A01A02',
  1, 0, 1, '600048', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级软件工程师', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600048');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60004800000000000000001', 'spexuser600048000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600048000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

-- 600051 刘恋
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600051000000000000001', '600051', '刘恋', '00ae7def6b17039d', 'SpxElc02', 'S01A01A02',
  1, 0, 1, '600051', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气工程师', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600051');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60005100000000000000001', 'spexuser600051000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600051000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

-- 600086 谢杨锋
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600086000000000000001', '600086', '谢杨锋', 'c7b5fd00dfa28da7', 'SpxElc03', 'S01A01A02',
  1, 0, 1, '600086', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气工程师', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600086');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60008600000000000000001', 'spexuser600086000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600086000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

-- 600087 温达威
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600087000000000000001', '600087', '温达威', '82872584985b76bc', 'SpxElc04', 'S01A01A02',
  1, 0, 1, '600087', 'admin', NOW(), 'admin', NOW(), 1, 0, '软件工程师', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600087');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60008700000000000000001', 'spexuser600087000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600087000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

-- 600101 吴勇
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600101000000000000001', '600101', '吴勇', '29170e0254dece66', 'SpxElc05', 'S01A01A02',
  1, 0, 1, '600101', 'admin', NOW(), 'admin', NOW(), 1, 0, '机器人工程师', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600101');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60010100000000000000001', 'spexuser600101000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600101000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

-- 自检：电气控制组应有 6 人（含原 600088）
-- SELECT u.username, u.realname, u.position_type, d.depart_name
-- FROM sys_user u
-- JOIN sys_user_depart ud ON ud.user_id = u.id
-- JOIN sys_depart d ON d.id = ud.dep_id
-- WHERE d.org_code = 'S01A01A02'
-- ORDER BY u.username;
-- 登录：工号 / 123456
