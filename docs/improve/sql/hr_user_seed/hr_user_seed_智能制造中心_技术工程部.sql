-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 技术工程部
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
  '3456007881059337586', '9372856559755238914', '技术工程部', 6, '2', 'DEPT', 'Z01A06',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A06');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '6085912608364391690', '3456007881059337586', '绘图组', 1, '2', 'GROUP', 'Z01A06A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A06A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '7532313085858778276', '3456007881059337586', 'ICNC技术工程组', 2, '2', 'GROUP', 'Z01A06A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A06A02');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '7141719091673772285', '3456007881059337586', '技术辅助组', 3, '2', 'GROUP', 'Z01A06A03',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A06A03');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4494491922542094746', '3456007881059337586', 'CNC技术工程组', 4, '2', 'GROUP', 'Z01A06A04',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A06A04');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 技术工程部
-- -----------------------------------------------------------------------------


-- 组别：绘图组 (Z01A06A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7347868691047033799', '01529', '陈锦均', 'f24deea30c74dd61', 'b7930e32', 'Z01A06A01',
  1, 0, 1, '01529', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01529');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9192031004680824268', '7347868691047033799', '6085912608364391690'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7347868691047033799' AND `dep_id` = '6085912608364391690'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9359433343791950537', '13783', '朱琦', '5390153bf48829ac', '5afba8fe', 'Z01A06A01',
  1, 0, 1, '13783', 'admin', NOW(), 'admin', NOW(), 1, 0, '绘图员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13783');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4580865422775466144', '9359433343791950537', '6085912608364391690'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9359433343791950537' AND `dep_id` = '6085912608364391690'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9972646477611937371', '16166', '蒋聪敏', '310096b41951419b', '5edd3ef0', 'Z01A06A01',
  1, 0, 1, '16166', 'admin', NOW(), 'admin', NOW(), 1, 0, '绘图员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16166');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5306357278301356139', '9972646477611937371', '6085912608364391690'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9972646477611937371' AND `dep_id` = '6085912608364391690'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9909504576869566359', '16381', '李慧琪', 'c7b04314926421bd', '92fd55f7', 'Z01A06A01',
  1, 0, 1, '16381', 'admin', NOW(), 'admin', NOW(), 1, 0, '绘图员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16381');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9947260779733566352', '9909504576869566359', '6085912608364391690'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9909504576869566359' AND `dep_id` = '6085912608364391690'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2598299032559786913', '21229', '莫玉莹', '314e6e7fefec34cd', 'd3b57374', 'Z01A06A01',
  1, 0, 1, '21229', 'admin', NOW(), 'admin', NOW(), 1, 0, '绘图员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21229');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7661994699912790642', '2598299032559786913', '6085912608364391690'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2598299032559786913' AND `dep_id` = '6085912608364391690'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5762878489208454714', '22491', '李宏珍', '6ef404dae8cacafc', 'fd3dba0f', 'Z01A06A01',
  1, 0, 1, '22491', 'admin', NOW(), 'admin', NOW(), 1, 0, '绘图员', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22491');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3491800508439188611', '5762878489208454714', '6085912608364391690'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5762878489208454714' AND `dep_id` = '6085912608364391690'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1526377600989745271', '22496', '周贵萍', '52437fc444f7078b', '66f8b397', 'Z01A06A01',
  1, 0, 1, '22496', 'admin', NOW(), 'admin', NOW(), 1, 0, '绘图员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22496');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8774578806881344716', '1526377600989745271', '6085912608364391690'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1526377600989745271' AND `dep_id` = '6085912608364391690'
);


-- 组别：ICNC技术工程组 (Z01A06A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5019236028398004399', '01759', '谭顺武', '88e2ef8903116cba', 'dc210d91', 'Z01A06A02',
  1, 0, 1, '01759', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级编程工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01759');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6764029544983282966', '5019236028398004399', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5019236028398004399' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2867403751428374196', '02050', '李景洋', '9c8ae5c7db91133d', 'f9f248aa', 'Z01A06A02',
  1, 0, 1, '02050', 'admin', NOW(), 'admin', NOW(), 1, 0, '副经理', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02050');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1178696509663461543', '2867403751428374196', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2867403751428374196' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2158571031758456119', '02264', '彭志兵', '698886bb57bd33a5', '2079c552', 'Z01A06A02',
  1, 0, 1, '02264', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02264');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3178609499884849937', '2158571031758456119', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2158571031758456119' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9944648252630872195', '02976', '付代平', 'd35101f9ac0a9d26', '50e16dcc', 'Z01A06A02',
  1, 0, 1, '02976', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02976');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1807589446917501816', '9944648252630872195', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9944648252630872195' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4893564946062272770', '03267', '义志平', '852efbb08adf56bf', '2bfe4c33', 'Z01A06A02',
  1, 0, 1, '03267', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级编程工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03267');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7333931084765766405', '4893564946062272770', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4893564946062272770' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3467994870300506598', '03474', '吴美鹏', '1c72352e02fbad01', 'dc03da73', 'Z01A06A02',
  1, 0, 1, '03474', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03474');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1051489855167028313', '3467994870300506598', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3467994870300506598' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9271618071137836339', '04890', '莫奕成', '50897af6dc537502', '3f59814b', 'Z01A06A02',
  1, 0, 1, '04890', 'admin', NOW(), 'admin', NOW(), 1, 0, '技术审核员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04890');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3821067100908370388', '9271618071137836339', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9271618071137836339' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6790211006859658571', '08045', '肖剑锋', 'f9252bd980acd939', '6fa8d3c8', 'Z01A06A02',
  1, 0, 1, '08045', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级编程工程师', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08045');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1097352335971647936', '6790211006859658571', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6790211006859658571' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1431473760744389385', '14249', '熊爱军', '92410cfbfd0ffe38', 'c1826200', 'Z01A06A02',
  1, 0, 1, '14249', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14249');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3019313801282916127', '1431473760744389385', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1431473760744389385' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4968263610069590397', '15133', '曹亚伟', 'b771d83a312b02aa', 'd3cbcfda', 'Z01A06A02',
  1, 0, 1, '15133', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15133');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8283761025063103412', '4968263610069590397', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4968263610069590397' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8405115260750363725', '16683', '吴彬', '0a73a0509ee9fbe2', '89f6251a', 'Z01A06A02',
  1, 0, 1, '16683', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16683');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3541474092159526080', '8405115260750363725', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8405115260750363725' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8150744626013959203', '19676', '蔡洪华', 'd267dfcf5a632b05', '7f574245', 'Z01A06A02',
  1, 0, 1, '19676', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '19676');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4093594688911930166', '8150744626013959203', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8150744626013959203' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3913321486457230288', '22603', '李家均', 'be547569d9b53aff', '73508353', 'Z01A06A02',
  1, 0, 1, '22603', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22603');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8081895541104766110', '3913321486457230288', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3913321486457230288' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8427089390531066164', '22678', '梁国志', '24d921f3f3b35a82', '2b287723', 'Z01A06A02',
  1, 0, 1, '22678', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22678');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2240001908501977270', '8427089390531066164', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8427089390531066164' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5928210808154867286', '24352', '姚佳华', '83f7f10b93948728', 'f5a75974', 'Z01A06A02',
  1, 0, 1, '24352', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24352');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4389525096252146236', '5928210808154867286', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5928210808154867286' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9798273167136706407', '24798', '任良果', '66f9169db8780a70', '4a71f955', 'Z01A06A02',
  1, 0, 1, '24798', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24798');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1163004108663032666', '9798273167136706407', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9798273167136706407' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1622857978748480574', '24864', '杨金国', 'b0f0828ec1f88506', 'aeffb57d', 'Z01A06A02',
  1, 0, 1, '24864', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24864');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6196756192725501666', '1622857978748480574', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1622857978748480574' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1078536373770119923', '25578', '张钞胜', '4effd7502b1cb2c9', 'c2b71427', 'Z01A06A02',
  1, 0, 1, '25578', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25578');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1777344646802425008', '1078536373770119923', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1078536373770119923' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8105750142361122434', '26063', '李文兵', '1a049a79c5b8136a', '0352a122', 'Z01A06A02',
  1, 0, 1, '26063', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26063');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3709649391298982894', '8105750142361122434', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8105750142361122434' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5187303928698018107', '26120', '王亮', 'c8dccda04578fcf9', 'caf7598b', 'Z01A06A02',
  1, 0, 1, '26120', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26120');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8645653568289992487', '5187303928698018107', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5187303928698018107' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7891060608916292128', '26407', '何坤', '0420b389bc3fb327', '1868cb25', 'Z01A06A02',
  1, 0, 1, '26407', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26407');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1443093846378461925', '7891060608916292128', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7891060608916292128' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3501479236626268608', '26998', '郑人英', '75e54ed3f26782cc', 'b642cb77', 'Z01A06A02',
  1, 0, 1, '26998', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26998');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4592387316340217678', '3501479236626268608', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3501479236626268608' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6014737199526792737', '26999', '谭文晓', '9cd234c2df42c95c', 'be0ccba0', 'Z01A06A02',
  1, 0, 1, '26999', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26999');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8972577825590267903', '6014737199526792737', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6014737199526792737' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5716358262159475616', '27066', '童宗港', '4c1fd459e14ac19e', 'f6a898c7', 'Z01A06A02',
  1, 0, 1, '27066', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27066');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5332157002863345542', '5716358262159475616', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5716358262159475616' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7787634257030077452', '27100', '刘李明', '6fc479bef9601905', '78304d51', 'Z01A06A02',
  1, 0, 1, '27100', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27100');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7778225196508303580', '7787634257030077452', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7787634257030077452' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9301524259570610908', '27351', '邱伟', '5c533fac36165769', 'b92dd273', 'Z01A06A02',
  1, 0, 1, '27351', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27351');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5585624546850748269', '9301524259570610908', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9301524259570610908' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6097770114363799932', '27396', '陈千里', '4208d0cd0e0b4cf1', 'a2fcf178', 'Z01A06A02',
  1, 0, 1, '27396', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27396');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8769613121451631854', '6097770114363799932', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6097770114363799932' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2152989989801247395', '27400', '陆豪', '95b7f3ec1417bcee', 'dca2c95e', 'Z01A06A02',
  1, 0, 1, '27400', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27400');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2392942290519076436', '2152989989801247395', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2152989989801247395' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5120721066696118745', '27420', '王泽同', '7c9cfcb04d657b63', '39d3fb71', 'Z01A06A02',
  1, 0, 1, '27420', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27420');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9998837139520161354', '5120721066696118745', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5120721066696118745' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4207403482459577220', '27430', '李晟', '403360ac28a13b8f', '35f49663', 'Z01A06A02',
  1, 0, 1, '27430', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27430');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2772448623040558931', '4207403482459577220', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4207403482459577220' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7057922251828950266', '27543', '肖爱平', '00d15816dce29fb5', 'b722c25d', 'Z01A06A02',
  1, 0, 1, '27543', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27543');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6507131819821161434', '7057922251828950266', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7057922251828950266' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2220282104764023006', '27601', '冯赣辉', 'bb2b948118345d60', '8ed5867a', 'Z01A06A02',
  1, 0, 1, '27601', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27601');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3538549168897707584', '2220282104764023006', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2220282104764023006' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5422592558189800577', '27603', '周孝志', '81b7269d3875960c', '6d612210', 'Z01A06A02',
  1, 0, 1, '27603', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27603');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7806525359608999950', '5422592558189800577', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5422592558189800577' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5213795110756278686', '27682', '周土胜', '45b538bc186adc68', '6c3fb97d', 'Z01A06A02',
  1, 0, 1, '27682', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27682');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8840806682698567174', '5213795110756278686', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5213795110756278686' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7352235496831751200', '27778', '冯锟', 'c9789226d397c118', 'f9cabcc5', 'Z01A06A02',
  1, 0, 1, '27778', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27778');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9965312977133268802', '7352235496831751200', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7352235496831751200' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2651674173082183276', '27834', '蓝斌', '33dfc9ee3b987d22', '08781222', 'Z01A06A02',
  1, 0, 1, '27834', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27834');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6852877085671724719', '2651674173082183276', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2651674173082183276' AND `dep_id` = '7532313085858778276'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1236114456881652980', '27841', '梁成炜', '56f0b9040d71aace', 'ec6c46cf', 'Z01A06A02',
  1, 0, 1, '27841', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27841');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9325696919772655303', '1236114456881652980', '7532313085858778276'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1236114456881652980' AND `dep_id` = '7532313085858778276'
);


-- 组别：技术辅助组 (Z01A06A03)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7260264642650043828', '02315', '文敏', 'dc022834f83d9e96', '1dabca98', 'Z01A06A03',
  1, 0, 1, '02315', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02315');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3019163577739328111', '7260264642650043828', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7260264642650043828' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2323815596938346439', '08564', '于志愿', '2682e288143f4541', '0893841b', 'Z01A06A03',
  1, 0, 1, '08564', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08564');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5560970554995079551', '2323815596938346439', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2323815596938346439' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5634370562573462310', '10592', '朱啟佑', '0b86aa9830c662e5', '903e619b', 'Z01A06A03',
  1, 0, 1, '10592', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10592');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3554503749328749696', '5634370562573462310', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5634370562573462310' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7861157696243110928', '10979', '周国华', 'd98a49a1f70f5a27', 'b170458a', 'Z01A06A03',
  1, 0, 1, '10979', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10979');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8951220005817478367', '7861157696243110928', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7861157696243110928' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1510704361981702129', '12490', '李宗贵', 'fd8b765a4d827fed', '40f11c56', 'Z01A06A03',
  1, 0, 1, '12490', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12490');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9183344055767613871', '1510704361981702129', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1510704361981702129' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4047073139731141043', '13173', '李海锋', '530956220c30efae', '50d69e65', 'Z01A06A03',
  1, 0, 1, '13173', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13173');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5083797268547133401', '4047073139731141043', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4047073139731141043' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7828839327936713069', '13721', '刘建辉', '6754793587869b0b', 'aa363aa8', 'Z01A06A03',
  1, 0, 1, '13721', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13721');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4779708326199256010', '7828839327936713069', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7828839327936713069' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5390685784500562857', '13770', '李龙', '00a167ca341796e4', '595486cf', 'Z01A06A03',
  1, 0, 1, '13770', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13770');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8826319205488413906', '5390685784500562857', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5390685784500562857' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4765982830992564751', '13880', '张志青', 'c6bdabb0b7d6dc82', '42974128', 'Z01A06A03',
  1, 0, 1, '13880', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13880');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7616255653011363726', '4765982830992564751', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4765982830992564751' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4734733733487196705', '15107', '李家敏', '44bd6def33e404f4', '2cbe16a3', 'Z01A06A03',
  1, 0, 1, '15107', 'admin', NOW(), 'admin', NOW(), 1, 0, '仓管', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15107');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5071013302232045977', '4734733733487196705', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4734733733487196705' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9523856208756205421', '16825', '段涛杰', '49ab529cd20545ee', 'af068613', 'Z01A06A03',
  1, 0, 1, '16825', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16825');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6012780395994801655', '9523856208756205421', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9523856208756205421' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6338069517818176237', '17208', '黄宁', 'd1341af0713009ea', '0e684566', 'Z01A06A03',
  1, 0, 1, '17208', 'admin', NOW(), 'admin', NOW(), 1, 0, '装配工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17208');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3508907033620493299', '6338069517818176237', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6338069517818176237' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7576440067769225022', '17275', '张丹华', '5cdc7e5532b07147', '1db8e827', 'Z01A06A03',
  1, 0, 1, '17275', 'admin', NOW(), 'admin', NOW(), 1, 0, '装配工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17275');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7230204976279144768', '7576440067769225022', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7576440067769225022' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5872773080852116445', '20590', '祝彪', 'fcea0fbca62ddd4e', '5b6858d1', 'Z01A06A03',
  1, 0, 1, '20590', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20590');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3741445280697833472', '5872773080852116445', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5872773080852116445' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2457411213573918779', '21127', '吴强', '55f6b4e202cd067d', 'e74bc4b1', 'Z01A06A03',
  1, 0, 1, '21127', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21127');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6512029514308995150', '2457411213573918779', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2457411213573918779' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4381226844608462822', '21129', '冯证霖', '4dda8df27b81e947', 'dfb7aea5', 'Z01A06A03',
  1, 0, 1, '21129', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21129');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1425616558584679997', '4381226844608462822', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4381226844608462822' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5487560547832795879', '21739', '韦政濠', '870f7a26b317c417', 'a9ec8742', 'Z01A06A03',
  1, 0, 1, '21739', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21739');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8329806063596884799', '5487560547832795879', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5487560547832795879' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2284585823897034862', '26043', '蔡宝全', 'a4c1a386c48a6127', '861646a0', 'Z01A06A03',
  1, 0, 1, '26043', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26043');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1650204120958330500', '2284585823897034862', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2284585823897034862' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2065576181260735585', '26055', '陈昶辉', '05b1349d5b197b77', 'c0f0a0e5', 'Z01A06A03',
  1, 0, 1, '26055', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26055');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5922881348710555264', '2065576181260735585', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2065576181260735585' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2291306700032398722', '26126', '马少帅', '3e5d6ff8e015a5e5', '4ebd47a7', 'Z01A06A03',
  1, 0, 1, '26126', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26126');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1814803158734016680', '2291306700032398722', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2291306700032398722' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7657885025652938674', '26127', '康治荣', '49cfce1abd6837f2', '36ce1387', 'Z01A06A03',
  1, 0, 1, '26127', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26127');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7766047857589031255', '7657885025652938674', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7657885025652938674' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8881171192058282200', '26180', '宁佐北', '5ecd7347cd6577fa', '056da866', 'Z01A06A03',
  1, 0, 1, '26180', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26180');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9864490818279777921', '8881171192058282200', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8881171192058282200' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1573339279478570642', '27193', '苑志富', 'bd8b4f016eba8d49', '8646bb38', 'Z01A06A03',
  1, 0, 1, '27193', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27193');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2963918185206785542', '1573339279478570642', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1573339279478570642' AND `dep_id` = '7141719091673772285'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8303695426901599754', '27810', '阮曼辉', 'd5765f7924067aa1', '6f904d18', 'Z01A06A03',
  1, 0, 1, '27810', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC装刀员', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27810');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4470497747229931930', '8303695426901599754', '7141719091673772285'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8303695426901599754' AND `dep_id` = '7141719091673772285'
);


-- 组别：CNC技术工程组 (Z01A06A04)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9184898306417964973', '02993', '崔卫海', '10db4b849354c088', 'f4a8179e', 'Z01A06A04',
  1, 0, 1, '02993', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02993');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9054146033524816124', '9184898306417964973', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9184898306417964973' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4533197600349597001', '05153', '陈辉', 'c731e4b732a726c5', 'c9fd7ea6', 'Z01A06A04',
  1, 0, 1, '05153', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级编程工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05153');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6797587064741269823', '4533197600349597001', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4533197600349597001' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6302338088810720453', '06384', '李凡', '4c86ed5b334942ac', 'f1c37656', 'Z01A06A04',
  1, 0, 1, '06384', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06384');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7278026950234456200', '6302338088810720453', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6302338088810720453' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2022000408708714974', '07539', '余恒', 'e59d4cb53907de5e', 'c947bb04', 'Z01A06A04',
  1, 0, 1, '07539', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07539');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4605071027482424253', '2022000408708714974', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2022000408708714974' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4815740652962013136', '08501', '刘俊勇', '58bed59a3d81ff0d', 'e85fe09b', 'Z01A06A04',
  1, 0, 1, '08501', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08501');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8091030873465665471', '4815740652962013136', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4815740652962013136' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4094153822055512807', '09707', '刘江炎', 'e60cd6d2f6dfcca4', '91339f31', 'Z01A06A04',
  1, 0, 1, '09707', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09707');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9362752800201309725', '4094153822055512807', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4094153822055512807' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7805800173969978326', '10201', '朱向培', '3ac4637793393886', '84354601', 'Z01A06A04',
  1, 0, 1, '10201', 'admin', NOW(), 'admin', NOW(), 1, 0, '技术审核员', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10201');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1330722122051925874', '7805800173969978326', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7805800173969978326' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1268236370540859798', '16965', '王群元', 'b113986387034213', '5bb438a9', 'Z01A06A04',
  1, 0, 1, '16965', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16965');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4242996256882156338', '1268236370540859798', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1268236370540859798' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9067443164413872604', '17609', '邓文涛', '7f1b1f5788c9d59a', 'dfd4840c', 'Z01A06A04',
  1, 0, 1, '17609', 'admin', NOW(), 'admin', NOW(), 1, 0, '技术审核员', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17609');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3273552079078463695', '9067443164413872604', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9067443164413872604' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5980146759378353562', '22290', '宁昊', 'd688d45d4aca7ff6', '40c515af', 'Z01A06A04',
  1, 0, 1, '22290', 'admin', NOW(), 'admin', NOW(), 1, 0, '技术审核员', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22290');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5241165862086284286', '5980146759378353562', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5980146759378353562' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9874740607903354212', '22292', '陈沙', '6c3ea7cd1c84a29a', 'ea1cda32', 'Z01A06A04',
  1, 0, 1, '22292', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22292');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1907721216098420752', '9874740607903354212', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9874740607903354212' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3870732063162264359', '22329', '张浩', '4feb04d1f5ad4bad', '334f724f', 'Z01A06A04',
  1, 0, 1, '22329', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22329');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9896973302834074194', '3870732063162264359', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3870732063162264359' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9527482471976237938', '22634', '黄朝辉', '3be1a5af8eb5cd6e', 'd1b9801c', 'Z01A06A04',
  1, 0, 1, '22634', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22634');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6636843527461878581', '9527482471976237938', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9527482471976237938' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7167135379434788013', '24681', '张小军', '4abef8ff8052bbe1', '1c1706bc', 'Z01A06A04',
  1, 0, 1, '24681', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24681');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1177155631549733170', '7167135379434788013', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7167135379434788013' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1964608126583323831', '26182', '蒲曾桥', '3942510f4e4ace09', '88a1cb08', 'Z01A06A04',
  1, 0, 1, '26182', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26182');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2073586470088901688', '1964608126583323831', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1964608126583323831' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5876678956545717831', '26219', '汪葵', '604e47e281d9843a', '54abdf5c', 'Z01A06A04',
  1, 0, 1, '26219', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26219');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1469786431041410736', '5876678956545717831', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5876678956545717831' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7176450970969681242', '26249', '于真剑', '1b2a501fa42b6c0f', '6352c8a1', 'Z01A06A04',
  1, 0, 1, '26249', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26249');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6476440754032600378', '7176450970969681242', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7176450970969681242' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1995037216466178544', '26250', '陈文敏', '7380f5b031275266', '6a24a5b3', 'Z01A06A04',
  1, 0, 1, '26250', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26250');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9748745801006509254', '1995037216466178544', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1995037216466178544' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4457407338594104863', '26624', '陈掌', '7348457f3c1662dc', '3a68812b', 'Z01A06A04',
  1, 0, 1, '26624', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26624');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3854275283751114067', '4457407338594104863', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4457407338594104863' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8032260854381301226', '27058', '彭真', 'dd3c231cb80a0062', 'd0093de0', 'Z01A06A04',
  1, 0, 1, '27058', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27058');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1283988114557001867', '8032260854381301226', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8032260854381301226' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1162144134866280233', '27088', '胡文俊', '53c803804fe90607', '522a6a6a', 'Z01A06A04',
  1, 0, 1, '27088', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27088');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4853459394606905475', '1162144134866280233', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1162144134866280233' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4654634049520635873', '27129', '游贵伟', 'cb710fd1751421c8', '73c485a8', 'Z01A06A04',
  1, 0, 1, '27129', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27129');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6039434874529183793', '4654634049520635873', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4654634049520635873' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8934855604881065042', '27153', '罗松平', '2cfb48dd44f527b6', '75a3e2a3', 'Z01A06A04',
  1, 0, 1, '27153', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27153');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3089617443847798579', '8934855604881065042', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8934855604881065042' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7072797052165628922', '27397', '苏运顺', '4d26c43b8b148726', 'bf6b60d8', 'Z01A06A04',
  1, 0, 1, '27397', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27397');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7923572572129246101', '7072797052165628922', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7072797052165628922' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8744241617983924229', '27421', '卢奥', '65f35576307f68b8', '7c304cc8', 'Z01A06A04',
  1, 0, 1, '27421', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理编程工程师', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27421');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1409082128558676946', '8744241617983924229', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8744241617983924229' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7244345774744614735', '27437', '罗圣明', '265b4e27f1bda492', 'bcdb6c6a', 'Z01A06A04',
  1, 0, 1, '27437', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27437');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7626214801699341783', '7244345774744614735', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7244345774744614735' AND `dep_id` = '4494491922542094746'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1489703235496182663', '27845', '雷民', '5b83678f40337b72', '1373aee6', 'Z01A06A04',
  1, 0, 1, '27845', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27845');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1838000781979965305', '1489703235496182663', '4494491922542094746'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1489703235496182663' AND `dep_id` = '4494491922542094746'
);

