-- =============================================================================
-- 提案改善 — 斯派科样例人员种子（手工执行）
-- 来源：docs/improve/data/员工列表20260822.xls（中心=斯派科，抽样 12 人）
-- 目标库：inside_dev
-- 约定：username = work_no；初始密码均为 123456（Jeecg PasswordUtil / PBEWithMD5AndDES）
-- 特性：幂等（WHERE NOT EXISTS），可重复执行
-- 说明：
--   1. 仅补联调样例，非正式全量 HR 导入
--   2. 组织：斯派科(CENTER) → 自动线开发部(DEPT) → MES开发 / 电气控制(GROUP)
--   3. org_code 必须符合 Jeecg 优编码：每级固定 3 位，如 S01 / S01A01 / S01A01A01（长度须被 3 整除）
--   4. 执行后请在管理端「提案配置」中把用户挂到委员会/部门负责人/批准人
--   5. 若已执行过旧版 SPX* 编码，请先跑 fix/20260828_fix_spex_org_code.sql
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 一、组织树 sys_depart
-- -----------------------------------------------------------------------------

-- 中心：斯派科
INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  'spexdeptcenter000000000000001', NULL, '斯派科', 90, '1', 'CENTER', 'S01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01');

-- 部门：自动线开发部
INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  'spexdeptdept00000000000000001', 'spexdeptcenter000000000000001', '自动线开发部', 1, '2', 'DEPT', 'S01A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01');

-- 组别：MES开发
INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  'spexdeptgroupmes0000000000001', 'spexdeptdept00000000000000001', 'MES开发', 1, '2', 'GROUP', 'S01A01A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01A01');

-- 组别：电气控制
INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  'spexdeptgroupelc0000000000001', 'spexdeptdept00000000000000001', '电气控制', 2, '2', 'GROUP', 'S01A01A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01A02');

-- -----------------------------------------------------------------------------
-- 二、用户 sys_user（username = work_no，密码 123456）
-- 密码哈希已用 Jeecg PasswordUtil.encrypt(username, '123456', salt) 预计算
-- -----------------------------------------------------------------------------

-- 600013 曾金（高级主管，MES开发）— 可作部门负责人候选人
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600013000000000000001', '600013', '曾金', 'd52640e60501036e', 'SpxSalt01', 'S01A01A01',
  1, 0, 1, '600013', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600013');

-- 600026 陈泽波
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600026000000000000001', '600026', '陈泽波', 'f353a2d79891feb8', 'SpxSalt02', 'S01A01A01',
  1, 0, 1, '600026', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级MES开发工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600026');

-- 600064 杨奋
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600064000000000000001', '600064', '杨奋', '4a97727b7ae93811', 'SpxSalt03', 'S01A01A01',
  1, 0, 1, '600064', 'admin', NOW(), 'admin', NOW(), 1, 0, 'JAVA开发工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600064');

-- 600065 罗韦升
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600065000000000000001', '600065', '罗韦升', 'f0f4b6685b62d5aa', 'SpxSalt04', 'S01A01A01',
  1, 0, 1, '600065', 'admin', NOW(), 'admin', NOW(), 1, 0, 'JAVA开发工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600065');

-- 600069 郑健辉
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600069000000000000001', '600069', '郑健辉', '2163cf2f5481c11f', 'SpxSalt05', 'S01A01A01',
  1, 0, 1, '600069', 'admin', NOW(), 'admin', NOW(), 1, 0, 'MES开发工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600069');

-- 600081 贺志龙
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600081000000000000001', '600081', '贺志龙', 'e8d624dba4d64faf', 'SpxSalt06', 'S01A01A01',
  1, 0, 1, '600081', 'admin', NOW(), 'admin', NOW(), 1, 0, 'MES开发工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600081');

-- 600084 汪秦军（副经理，挂在部门节点，可作批准人/负责人候选人）
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600084000000000000001', '600084', '汪秦军', 'ad89931296d8fc02', 'SpxSalt07', 'S01A01',
  1, 0, 1, '600084', 'admin', NOW(), 'admin', NOW(), 2, 0, '副经理', 5
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600084');

-- 600088 张小朋（电气控制）
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600088000000000000001', '600088', '张小朋', '0b49d37642cb19c0', 'SpxSalt0C', 'S01A01A02',
  1, 0, 1, '600088', 'admin', NOW(), 'admin', NOW(), 1, 0, '主任工程师', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600088');

-- 600089 黄金杏
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600089000000000000001', '600089', '黄金杏', 'a9b4fdd85f623627', 'SpxSalt08', 'S01A01A01',
  1, 0, 1, '600089', 'admin', NOW(), 'admin', NOW(), 1, 0, '前端工程师', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600089');

-- 600090 钟绍京
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600090000000000000001', '600090', '钟绍京', '9cc79b1272c5c922', 'SpxSalt09', 'S01A01A01',
  1, 0, 1, '600090', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级软件工程师', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600090');

-- 600098 李逸夫
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600098000000000000001', '600098', '李逸夫', 'cd38456b1e44ca77', 'SpxSalt0A', 'S01A01A01',
  1, 0, 1, '600098', 'admin', NOW(), 'admin', NOW(), 1, 0, 'JAVA开发工程师', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600098');

-- 600099 吴浪
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600099000000000000001', '600099', '吴浪', 'f85b935de66d720e', 'SpxSalt0B', 'S01A01A01',
  1, 0, 1, '600099', 'admin', NOW(), 'admin', NOW(), 1, 0, 'JAVA开发工程师', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600099');

-- ----- 电气控制（S01A01A02）；600088 已在上方 -----
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600048000000000000001', '600048', '莫际威', '6698a53e8ddf3231', 'SpxElc01', 'S01A01A02',
  1, 0, 1, '600048', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级软件工程师', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600048');

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600051000000000000001', '600051', '刘恋', '00ae7def6b17039d', 'SpxElc02', 'S01A01A02',
  1, 0, 1, '600051', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气工程师', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600051');

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600086000000000000001', '600086', '谢杨锋', 'c7b5fd00dfa28da7', 'SpxElc03', 'S01A01A02',
  1, 0, 1, '600086', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气工程师', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600086');

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600087000000000000001', '600087', '温达威', '82872584985b76bc', 'SpxElc04', 'S01A01A02',
  1, 0, 1, '600087', 'admin', NOW(), 'admin', NOW(), 1, 0, '软件工程师', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600087');

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  'spexuser600101000000000000001', '600101', '吴勇', '29170e0254dece66', 'SpxElc05', 'S01A01A02',
  1, 0, 1, '600101', 'admin', NOW(), 'admin', NOW(), 1, 0, '机器人工程师', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600101');

-- -----------------------------------------------------------------------------
-- 三、用户-部门关联 sys_user_depart（挂到组别；副经理挂部门）
-- -----------------------------------------------------------------------------

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60001300000000000000001', 'spexuser600013000000000000001', 'spexdeptgroupmes0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600013000000000000001' AND `dep_id` = 'spexdeptgroupmes0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60002600000000000000001', 'spexuser600026000000000000001', 'spexdeptgroupmes0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600026000000000000001' AND `dep_id` = 'spexdeptgroupmes0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60006400000000000000001', 'spexuser600064000000000000001', 'spexdeptgroupmes0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600064000000000000001' AND `dep_id` = 'spexdeptgroupmes0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60006500000000000000001', 'spexuser600065000000000000001', 'spexdeptgroupmes0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600065000000000000001' AND `dep_id` = 'spexdeptgroupmes0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60006900000000000000001', 'spexuser600069000000000000001', 'spexdeptgroupmes0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600069000000000000001' AND `dep_id` = 'spexdeptgroupmes0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60008100000000000000001', 'spexuser600081000000000000001', 'spexdeptgroupmes0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600081000000000000001' AND `dep_id` = 'spexdeptgroupmes0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60008400000000000000001', 'spexuser600084000000000000001', 'spexdeptdept00000000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600084000000000000001' AND `dep_id` = 'spexdeptdept00000000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60008800000000000000001', 'spexuser600088000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600088000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60004800000000000000001', 'spexuser600048000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600048000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60005100000000000000001', 'spexuser600051000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600051000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60008600000000000000001', 'spexuser600086000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600086000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60008700000000000000001', 'spexuser600087000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600087000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60010100000000000000001', 'spexuser600101000000000000001', 'spexdeptgroupelc0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600101000000000000001' AND `dep_id` = 'spexdeptgroupelc0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60008900000000000000001', 'spexuser600089000000000000001', 'spexdeptgroupmes0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600089000000000000001' AND `dep_id` = 'spexdeptgroupmes0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60009000000000000000001', 'spexuser600090000000000000001', 'spexdeptgroupmes0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600090000000000000001' AND `dep_id` = 'spexdeptgroupmes0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60009800000000000000001', 'spexuser600098000000000000001', 'spexdeptgroupmes0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600098000000000000001' AND `dep_id` = 'spexdeptgroupmes0000000000001'
);

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT 'spexud60009900000000000000001', 'spexuser600099000000000000001', 'spexdeptgroupmes0000000000001'
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = 'spexuser600099000000000000001' AND `dep_id` = 'spexdeptgroupmes0000000000001'
);

-- =============================================================================
-- 执行后自检（可选）
-- SELECT id, org_code, depart_name, org_type FROM sys_depart WHERE org_code LIKE 'S01%';
-- SELECT username, realname, work_no, org_code, position_type FROM sys_user WHERE username LIKE '6000%';
-- 登录账号 = 工号，密码 = 123456
-- =============================================================================
