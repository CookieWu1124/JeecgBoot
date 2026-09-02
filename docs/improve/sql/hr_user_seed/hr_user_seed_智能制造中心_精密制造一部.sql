-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 精密制造一部
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
  '8144348671534281162', '9372856559755238914', '精密制造一部', 1, '2', 'DEPT', 'Z01A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '8911327140218612971', '8144348671534281162', '车床组', 1, '2', 'GROUP', 'Z01A01A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9590095517304296114', '8144348671534281162', '铣床组', 2, '2', 'GROUP', 'Z01A01A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01A02');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '2647529905710335310', '8144348671534281162', 'ACNC组', 3, '2', 'GROUP', 'Z01A01A03',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01A03');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9818109943841671569', '8144348671534281162', '钳工组', 4, '2', 'GROUP', 'Z01A01A04',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01A04');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '7555745269009703128', '8144348671534281162', 'NC车组', 5, '2', 'GROUP', 'Z01A01A05',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01A05');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9762036247575086793', '8144348671534281162', '慢走丝组', 6, '2', 'GROUP', 'Z01A01A06',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01A06');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '3136468428221880417', '8144348671534281162', '磨床组', 7, '2', 'GROUP', 'Z01A01A07',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01A07');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '5481933028124165001', '8144348671534281162', 'ICNC6组', 8, '2', 'GROUP', 'Z01A01A08',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01A08');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '7069757031299782892', '8144348671534281162', '快走丝组', 9, '2', 'GROUP', 'Z01A01A09',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01A09');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '8450948211545741294', '8144348671534281162', '管理组', 10, '2', 'GROUP', 'Z01A01A10',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A01A10');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 精密制造一部
-- -----------------------------------------------------------------------------


-- 组别：车床组 (Z01A01A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8301426287015815792', '01003', '崔伟明', '88f2a1c1367b104a', 'fd99e467', 'Z01A01A01',
  1, 0, 1, '01003', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01003');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3662161000898976929', '8301426287015815792', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8301426287015815792' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4934387279067620756', '00562', '颜华林', '271f32758e7de052', '9acecf72', 'Z01A01A01',
  1, 0, 1, '00562', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '00562');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7486704462879937809', '4934387279067620756', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4934387279067620756' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4287940310084617959', '02223', '邱武顺', '9ab1b9db538ef79f', 'c6dcc5ef', 'Z01A01A01',
  1, 0, 1, '02223', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02223');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7428543745287583158', '4287940310084617959', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4287940310084617959' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9561598027232798544', '02834', '王华', '83fe71a751585fbc', '14923260', 'Z01A01A01',
  1, 0, 1, '02834', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02834');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8308645236403574067', '9561598027232798544', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9561598027232798544' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7485969110054550199', '03515', '罗强光', '96be4b78c425af4c', '08469752', 'Z01A01A01',
  1, 0, 1, '03515', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03515');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3241065398178023504', '7485969110054550199', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7485969110054550199' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2456622507917221314', '03944', '周冲', '9c5a81ffb78be8af', 'c1c39d8c', 'Z01A01A01',
  1, 0, 1, '03944', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03944');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5980585194833922764', '2456622507917221314', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2456622507917221314' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6750777403512176765', '04588', '欧尚德', '97740f16b728c149', 'f55e9877', 'Z01A01A01',
  1, 0, 1, '04588', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04588');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3384232918425262203', '6750777403512176765', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6750777403512176765' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3292292578048789027', '07605', '陈海涛', '21b00a269539e9bc', '8098e0b5', 'Z01A01A01',
  1, 0, 1, '07605', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07605');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6756582399924574497', '3292292578048789027', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3292292578048789027' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5151106823973178753', '09597', '戴云保', 'c74e51c699b31a4a', 'c49b19e7', 'Z01A01A01',
  1, 0, 1, '09597', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09597');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7739541984076121250', '5151106823973178753', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5151106823973178753' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6811851459069193425', '10475', '王培', '32e5596211667719', 'c766c532', 'Z01A01A01',
  1, 0, 1, '10475', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10475');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6545176813100244090', '6811851459069193425', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6811851459069193425' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7027919243407511697', '10627', '陈盼', 'eb275be22bdff909', '9f6d0684', 'Z01A01A01',
  1, 0, 1, '10627', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10627');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3013526213472966178', '7027919243407511697', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7027919243407511697' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9283432742283449401', '13181', '蔡健', 'bd4b4785ab51a516', '4a76cd66', 'Z01A01A01',
  1, 0, 1, '13181', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13181');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1529802561745291309', '9283432742283449401', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9283432742283449401' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3776879707806334106', '23484', '赵伟康', '7205dea3f1f228da', '8773e399', 'Z01A01A01',
  1, 0, 1, '23484', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23484');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3395089767680917902', '3776879707806334106', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3776879707806334106' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3244313844328022862', '23507', '刘述正', '662f1306952f34c1', '2f1bba9c', 'Z01A01A01',
  1, 0, 1, '23507', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23507');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2987405799110376528', '3244313844328022862', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3244313844328022862' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6831522559485468276', '24770', '毛文凯', 'd80092ae7753f329', 'fc914d7a', 'Z01A01A01',
  1, 0, 1, '24770', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24770');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6060946353550225847', '6831522559485468276', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6831522559485468276' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6871063262439854437', '24781', '李定安', 'dfe9f300eb89ae52', 'bb10ff2a', 'Z01A01A01',
  1, 0, 1, '24781', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24781');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1335966327558841212', '6871063262439854437', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6871063262439854437' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5127754461047555177', '26943', '袁强', 'dfb9b9158821c39d', 'cd0e070a', 'Z01A01A01',
  1, 0, 1, '26943', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26943');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1191446430052156351', '5127754461047555177', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5127754461047555177' AND `dep_id` = '8911327140218612971'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3904449608543475926', '27402', '杨再林', '142f53b87f8fa093', '895b9cfa', 'Z01A01A01',
  1, 0, 1, '27402', 'admin', NOW(), 'admin', NOW(), 1, 0, '车工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27402');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5778715857026935570', '3904449608543475926', '8911327140218612971'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3904449608543475926' AND `dep_id` = '8911327140218612971'
);


-- 组别：铣床组 (Z01A01A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1602157754629526433', '01086', '刘川平', '7d8982f5948fae6e', 'e9ab1f0f', 'Z01A01A02',
  1, 0, 1, '01086', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01086');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7473824972138103691', '1602157754629526433', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1602157754629526433' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1411492371006615763', '00995', '赵紫明', 'b2e2305b22a027e6', 'b01f08fc', 'Z01A01A02',
  1, 0, 1, '00995', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '00995');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5500133425120311056', '1411492371006615763', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1411492371006615763' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6057024886765479989', '01868', '郑兆恒', 'bccedbd175288a3d', 'dc7a1fd7', 'Z01A01A02',
  1, 0, 1, '01868', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01868');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7889741214167242920', '6057024886765479989', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6057024886765479989' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4493578165303523636', '02756', '章让谋', '5de8276dbf8b5cb3', 'f79e3ab2', 'Z01A01A02',
  1, 0, 1, '02756', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02756');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5936996750137778756', '4493578165303523636', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4493578165303523636' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7917653049719402055', '03361', '马彬彬', 'b6750eb0264d1c8d', '1a981897', 'Z01A01A02',
  1, 0, 1, '03361', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03361');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9977213801888021740', '7917653049719402055', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7917653049719402055' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1274675248159996815', '04873', '张磊', '1d2d4872d523a3ff', '24f39170', 'Z01A01A02',
  1, 0, 1, '04873', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04873');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5294596311305690090', '1274675248159996815', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1274675248159996815' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6066887762460220217', '04903', '周明栋', 'cae167d4aefc97d2', '9b1e25d2', 'Z01A01A02',
  1, 0, 1, '04903', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04903');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8224892026385811241', '6066887762460220217', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6066887762460220217' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4720575295489807952', '06121', '张雷', '807b2127b780edd1', 'dddec26b', 'Z01A01A02',
  1, 0, 1, '06121', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06121');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7362917396884660347', '4720575295489807952', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4720575295489807952' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7881313324810228250', '06660', '庞杰太', 'd83ee46346269e8c', 'f13a8ff4', 'Z01A01A02',
  1, 0, 1, '06660', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06660');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8623346208253938572', '7881313324810228250', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7881313324810228250' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6979046604870691364', '07385', '王云飞', '76918581965a4624', 'f7b6c22f', 'Z01A01A02',
  1, 0, 1, '07385', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07385');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1767549853646275289', '6979046604870691364', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6979046604870691364' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6812834118405243840', '07417', '倪礼治', 'e570fc43946d1877', 'e3b439d3', 'Z01A01A02',
  1, 0, 1, '07417', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07417');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4825255049536909322', '6812834118405243840', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6812834118405243840' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3250686008861008562', '08009', '李康柳', '992d835d0a1a1a70', '054a5628', 'Z01A01A02',
  1, 0, 1, '08009', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08009');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2467901492138518271', '3250686008861008562', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3250686008861008562' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7986199341860386636', '10566', '钟观培', 'a318571ba30ce1c8', 'deb3e100', 'Z01A01A02',
  1, 0, 1, '10566', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10566');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7028091682769342001', '7986199341860386636', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7986199341860386636' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9336568579571251265', '10567', '钟伟明', '88369238b0b4aa59', 'b35ed131', 'Z01A01A02',
  1, 0, 1, '10567', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10567');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8033075229836163109', '9336568579571251265', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9336568579571251265' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8837035383810334313', '10604', '钟志华', '0264935e3adda8be', '1b2ef538', 'Z01A01A02',
  1, 0, 1, '10604', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10604');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4852312529504123540', '8837035383810334313', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8837035383810334313' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4553613893642886881', '12236', '和斌', '5a90c0f1a80d6040', 'e36f2020', 'Z01A01A02',
  1, 0, 1, '12236', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12236');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9542622233838755025', '4553613893642886881', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4553613893642886881' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9784986090498895410', '12718', '金良亮', 'bcd8f51f0099d70c', '18ca4514', 'Z01A01A02',
  1, 0, 1, '12718', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12718');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7715422432134753648', '9784986090498895410', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9784986090498895410' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6394084681852092146', '14506', '李平', '2477e6806e811ef2', '197876d1', 'Z01A01A02',
  1, 0, 1, '14506', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14506');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9498944228863285253', '6394084681852092146', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6394084681852092146' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1817798975875101640', '14765', '余东', '0d05e414a4bd7cb2', '78797dbe', 'Z01A01A02',
  1, 0, 1, '14765', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14765');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9144010057765155522', '1817798975875101640', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1817798975875101640' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8065893984047058931', '15198', '黄健', 'ba3e73cda165e6ae', '38e59067', 'Z01A01A02',
  1, 0, 1, '15198', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15198');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3101185520246635568', '8065893984047058931', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8065893984047058931' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1023924102243333362', '15371', '何杲逊', 'ece30f60e3d24c9f', 'aaf89724', 'Z01A01A02',
  1, 0, 1, '15371', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15371');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3742928523171101920', '1023924102243333362', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1023924102243333362' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7902062679664499851', '16879', '唐浩明', '80ea05ee4aef0565', 'd07b03aa', 'Z01A01A02',
  1, 0, 1, '16879', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16879');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7827977768236865370', '7902062679664499851', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7902062679664499851' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3582571336127723843', '17292', '赖石林', 'bdfb2a9e34ff96a1', 'a132bdd1', 'Z01A01A02',
  1, 0, 1, '17292', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17292');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5526958802518443499', '3582571336127723843', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3582571336127723843' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1918109063483628004', '24892', '黎小建', '4cfbb19ddde8418e', 'ddecaa8f', 'Z01A01A02',
  1, 0, 1, '24892', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24892');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5049026993099895979', '1918109063483628004', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1918109063483628004' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8915831043248680611', '26001', '王彬', 'b07432808eaf07d2', '76f1174f', 'Z01A01A02',
  1, 0, 1, '26001', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26001');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2582433033880090869', '8915831043248680611', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8915831043248680611' AND `dep_id` = '9590095517304296114'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6759859798649255216', '27582', '胡世辉', 'ad604d50fb65e806', 'd926cd54', 'Z01A01A02',
  1, 0, 1, '27582', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27582');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1157992232449331845', '6759859798649255216', '9590095517304296114'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6759859798649255216' AND `dep_id` = '9590095517304296114'
);


-- 组别：ACNC组 (Z01A01A03)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6709821196565610141', '01412', '文太刚', 'fc4e7ecdac90a9ae', '4313f47e', 'Z01A01A03',
  1, 0, 1, '01412', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01412');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1342448554010114565', '6709821196565610141', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6709821196565610141' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8017870906973952902', '01665', '曾昭炉', '726ae42a1b21e72b', 'c1adebab', 'Z01A01A03',
  1, 0, 1, '01665', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01665');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4580590278921167255', '8017870906973952902', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8017870906973952902' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1883787238257212382', '01763', '刘鹤丹', '2cc821a5d7a55c36', 'e3458533', 'Z01A01A03',
  1, 0, 1, '01763', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣副主管', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01763');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7956586387607726241', '1883787238257212382', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1883787238257212382' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2909175895279680855', '01858', '秦伯燕', 'cc778025a0956333', '2997815e', 'Z01A01A03',
  1, 0, 1, '01858', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01858');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9490488024738805545', '2909175895279680855', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2909175895279680855' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7002509725978892653', '02071', '吴林', 'c3517e870d5b70b7', 'e01e3f48', 'Z01A01A03',
  1, 0, 1, '02071', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02071');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1424105230859758306', '7002509725978892653', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7002509725978892653' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4911971953553835890', '01974', '王健', 'b82297bee63f3c95', '6fdd9360', 'Z01A01A03',
  1, 0, 1, '01974', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01974');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5175474548422269918', '4911971953553835890', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4911971953553835890' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8194738864924655336', '02966', '刘剑军', 'bda6fad22fe4db03', '0aef0b02', 'Z01A01A03',
  1, 0, 1, '02966', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02966');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3112173817729198776', '8194738864924655336', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8194738864924655336' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4194189183831310517', '03094', '霍坤峰', '7cad61223e92b195', 'addc21a9', 'Z01A01A03',
  1, 0, 1, '03094', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03094');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5998540194498923182', '4194189183831310517', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4194189183831310517' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6215511682458599115', '03150', '李武', '423fb0d173c14df8', '68b18b2d', 'Z01A01A03',
  1, 0, 1, '03150', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣主管', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03150');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4630577449584977969', '6215511682458599115', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6215511682458599115' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9402916813519739289', '03755', '宁子贤', '06b0a5ea1fa963bc', '5869a580', 'Z01A01A03',
  1, 0, 1, '03755', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03755');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5479888322011989849', '9402916813519739289', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9402916813519739289' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2901130693605282343', '04091', '陈俊平', 'f1b62f500c282e99', '4c76d673', 'Z01A01A03',
  1, 0, 1, '04091', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04091');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2428663635265943546', '2901130693605282343', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2901130693605282343' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5612668094222430599', '05022', '成文发', '01bbec411633248e', '7a547f86', 'Z01A01A03',
  1, 0, 1, '05022', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05022');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1933656522388124503', '5612668094222430599', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5612668094222430599' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9892569139214271014', '07313', '施国锐', 'e95f706a78f09c20', '9478cfe3', 'Z01A01A03',
  1, 0, 1, '07313', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07313');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2902136576663853245', '9892569139214271014', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9892569139214271014' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8111811905897641588', '07504', '黄利清', '9621aefbccefa67e', 'a7130c30', 'Z01A01A03',
  1, 0, 1, '07504', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07504');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7392716750308532750', '8111811905897641588', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8111811905897641588' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2877314085027468207', '07924', '贺忠明', 'e9d864ae4aed54a4', 'b5bbb65d', 'Z01A01A03',
  1, 0, 1, '07924', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07924');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2481150632471808881', '2877314085027468207', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2877314085027468207' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2966375197804039030', '07933', '胡胜钱', '7a66d5c1731d51c8', '858e2700', 'Z01A01A03',
  1, 0, 1, '07933', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07933');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9996702461431382803', '2966375197804039030', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2966375197804039030' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7016392515080953753', '07983', '宁福强', 'aafcb1dd31cac818', 'd5966063', 'Z01A01A03',
  1, 0, 1, '07983', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07983');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6621266362033198905', '7016392515080953753', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7016392515080953753' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9114967316201904402', '09139', '喻先中', '21e588625673fd94', '025d665f', 'Z01A01A03',
  1, 0, 1, '09139', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09139');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2080450952237837893', '9114967316201904402', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9114967316201904402' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9625199893820039272', '09323', '吴美强', '036159af937a3dd7', '8cd43c0e', 'Z01A01A03',
  1, 0, 1, '09323', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09323');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9146381612797090532', '9625199893820039272', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9625199893820039272' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3734274914361829358', '09561', '单益平', 'a04a162d41da9e3d', '9aebb1d9', 'Z01A01A03',
  1, 0, 1, '09561', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09561');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1204850368175587641', '3734274914361829358', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3734274914361829358' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4513000499066600902', '10388', '杨涛', 'ad1c7a11187cab7d', '1c816223', 'Z01A01A03',
  1, 0, 1, '10388', 'admin', NOW(), 'admin', NOW(), 1, 0, '铣工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10388');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6846304989811286879', '4513000499066600902', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4513000499066600902' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4292854642273949208', '11246', '林盛龙', '5c012a624f982e21', '1198eeb0', 'Z01A01A03',
  1, 0, 1, '11246', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11246');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2539181278846964632', '4292854642273949208', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4292854642273949208' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7597308894141947427', '11262', '林全琪', 'd68d4a2dbb2333cb', '3d4803fd', 'Z01A01A03',
  1, 0, 1, '11262', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11262');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7152859513011910966', '7597308894141947427', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7597308894141947427' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2655722334335828359', '12578', '罗朝纲', 'd5c3f36d9c7e7ba1', '494afcdf', 'Z01A01A03',
  1, 0, 1, '12578', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12578');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3152347353979137219', '2655722334335828359', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2655722334335828359' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9827080540812626843', '12691', '谢彬彬', '125285e3133182f7', 'eeae7c8c', 'Z01A01A03',
  1, 0, 1, '12691', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12691');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5756471088674624176', '9827080540812626843', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9827080540812626843' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5601313562716829148', '13222', '黄庆锋', '457ae393f41258ab', '7f90313e', 'Z01A01A03',
  1, 0, 1, '13222', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13222');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3768431745653448092', '5601313562716829148', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5601313562716829148' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6528552547803273653', '13864', '陈林平', '6225be0f2dfb3be1', '5100261a', 'Z01A01A03',
  1, 0, 1, '13864', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13864');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4504064510346611169', '6528552547803273653', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6528552547803273653' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8062951373899968747', '13886', '欧阳雄', '0323b2867d53abb1', '1b9d6bd5', 'Z01A01A03',
  1, 0, 1, '13886', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13886');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5376293613697478053', '8062951373899968747', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8062951373899968747' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5441240009076752590', '13925', '刘建兵', 'f9104ef062b62778', '11ce4bbc', 'Z01A01A03',
  1, 0, 1, '13925', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13925');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1127673361253207800', '5441240009076752590', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5441240009076752590' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6672819044638782407', '14202', '廖嘉宾', '6597d44d6fa0cd33', 'f3c49216', 'Z01A01A03',
  1, 0, 1, '14202', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14202');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7739693100192897135', '6672819044638782407', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6672819044638782407' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2106784453162191732', '14230', '颜以日', 'c99b01cf4c80b968', '4328df0b', 'Z01A01A03',
  1, 0, 1, '14230', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14230');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5928893033433830351', '2106784453162191732', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2106784453162191732' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9896710414628875871', '14663', '何铭节', 'e0ffd9b26d9844ec', '05918e87', 'Z01A01A03',
  1, 0, 1, '14663', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14663');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7779432625703762026', '9896710414628875871', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9896710414628875871' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9497800417492696077', '15192', '邓小孟', '828a5b82054fcb05', '8ac1e644', 'Z01A01A03',
  1, 0, 1, '15192', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15192');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4199045259075130323', '9497800417492696077', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9497800417492696077' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5789365423686881925', '15193', '叶俊成', '8e28538ff090cb59', '6f859f0b', 'Z01A01A03',
  1, 0, 1, '15193', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15193');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1442237063476787798', '5789365423686881925', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5789365423686881925' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5210491228780830986', '15423', '黄颖聪', '420f5310ab5f953f', 'c4d6940c', 'Z01A01A03',
  1, 0, 1, '15423', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15423');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7589594578348347367', '5210491228780830986', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5210491228780830986' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3706646068746517078', '15467', '余子华', '2d379aa61835e3fa', 'ce835d43', 'Z01A01A03',
  1, 0, 1, '15467', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15467');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8743221342926552885', '3706646068746517078', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3706646068746517078' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8887988708590902311', '15737', '刘孙伟', '41cb58a016897814', '24c45773', 'Z01A01A03',
  1, 0, 1, '15737', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15737');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5795216236900117000', '8887988708590902311', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8887988708590902311' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1055775211510427111', '17258', '邓文', 'a503acc942286d55', '17b6b08e', 'Z01A01A03',
  1, 0, 1, '17258', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 380
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17258');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4890019918668059029', '1055775211510427111', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1055775211510427111' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1003135268353601526', '20995', '胡民', '67cfadfa52c37648', 'ae32cfc7', 'Z01A01A03',
  1, 0, 1, '20995', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 390
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '20995');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1085750332379907195', '1003135268353601526', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1003135268353601526' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8466430250289912367', '21414', '莫少雄', 'a931efbe71172b7d', 'be585767', 'Z01A01A03',
  1, 0, 1, '21414', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 400
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '21414');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1359377065771009003', '8466430250289912367', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8466430250289912367' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1487368650426447076', '22455', '黄业强', '64f01bc7e5571a7a', 'ff0b0573', 'Z01A01A03',
  1, 0, 1, '22455', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 410
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22455');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1058347964210873762', '1487368650426447076', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1487368650426447076' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2385118609060531397', '22465', '熊宇琪', '2546ac684d656c3d', 'f5ff3398', 'Z01A01A03',
  1, 0, 1, '22465', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 420
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22465');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2003908202406766557', '2385118609060531397', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2385118609060531397' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9418250419702510795', '22488', '许锐斌', 'af7c8eb5c76e6f39', 'a20589b3', 'Z01A01A03',
  1, 0, 1, '22488', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 430
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22488');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1311760727014956538', '9418250419702510795', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9418250419702510795' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5787569774786650860', '22505', '李敖', 'cf60bf862ad38456', '6c5496a2', 'Z01A01A03',
  1, 0, 1, '22505', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 440
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22505');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7219481023965752236', '5787569774786650860', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5787569774786650860' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6354804851681311335', '22716', '曾宪权', 'bbf8f349db7c2268', 'c37a8fc6', 'Z01A01A03',
  1, 0, 1, '22716', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 450
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22716');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6511972660039083680', '6354804851681311335', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6354804851681311335' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7887800308882857567', '23298', '林达军', '0e19c1ed87f6efca', '67aa1f21', 'Z01A01A03',
  1, 0, 1, '23298', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 460
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23298');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8871821991868859293', '7887800308882857567', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7887800308882857567' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8198228591951292591', '23317', '刘文琦', '4182f24b807f7c57', '9249b3f6', 'Z01A01A03',
  1, 0, 1, '23317', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 470
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23317');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7323102104756148113', '8198228591951292591', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8198228591951292591' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4389006944815669143', '23405', '李文杰', '96f4136bc5b37ee6', 'dd5a95e4', 'Z01A01A03',
  1, 0, 1, '23405', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 480
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23405');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5094547023933248113', '4389006944815669143', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4389006944815669143' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3699513770671545436', '23439', '韩涛', '0d6988eae0aaddaa', '8e6589a3', 'Z01A01A03',
  1, 0, 1, '23439', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 490
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23439');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1035494336410183162', '3699513770671545436', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3699513770671545436' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6899244534790016341', '23452', '赖伟成', 'e579cfc105c2993b', 'ebf299bd', 'Z01A01A03',
  1, 0, 1, '23452', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 500
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23452');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5691712902310330065', '6899244534790016341', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6899244534790016341' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9207330093791728437', '23453', '邹思龙', '465468eefcf39d97', '7c421e01', 'Z01A01A03',
  1, 0, 1, '23453', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 510
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23453');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6994018791078556530', '9207330093791728437', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9207330093791728437' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8546915869280419505', '23549', '何理', '91ea8b764c0e254b', '6644f76a', 'Z01A01A03',
  1, 0, 1, '23549', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 520
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23549');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2852950774218046977', '8546915869280419505', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8546915869280419505' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3240519406304205050', '23654', '吴江', '2bf5d00b118aeb00', 'b5db17f4', 'Z01A01A03',
  1, 0, 1, '23654', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 530
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23654');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7906953381399119024', '3240519406304205050', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3240519406304205050' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1074226125338147647', '24390', '陈建豪', 'da8c588c8f65413a', '69f86b28', 'Z01A01A03',
  1, 0, 1, '24390', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 540
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24390');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9984300803221086448', '1074226125338147647', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1074226125338147647' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9804400632899774349', '24754', '江磊', '99da0adddc88bb5b', 'b423a193', 'Z01A01A03',
  1, 0, 1, '24754', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 550
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24754');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8059030932094623738', '9804400632899774349', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9804400632899774349' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4027796162872758019', '24953', '陈才斌', 'b0c301b2e57463ca', '385ec0a4', 'Z01A01A03',
  1, 0, 1, '24953', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 560
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24953');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4376350371757350130', '4027796162872758019', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4027796162872758019' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5532116876092591389', '25076', '何立强', '6861d0026d3f1188', 'fb1aa6e3', 'Z01A01A03',
  1, 0, 1, '25076', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 570
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25076');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3860879664939847136', '5532116876092591389', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5532116876092591389' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7567678684701641589', '25318', '马琛', '46af38fcaff6a3b5', '56c66885', 'Z01A01A03',
  1, 0, 1, '25318', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 580
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25318');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1372102532051146415', '7567678684701641589', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7567678684701641589' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9160360484702939601', '25530', '蔡君旺', '09fdd27c7de6a2c3', '1e642ebc', 'Z01A01A03',
  1, 0, 1, '25530', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 590
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25530');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4064455325868995816', '9160360484702939601', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9160360484702939601' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2906890903099098811', '25995', '邓朝安', '3f7c903d2c1384e9', '243a3cad', 'Z01A01A03',
  1, 0, 1, '25995', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 600
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25995');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1322933716213990610', '2906890903099098811', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2906890903099098811' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7633283620601845736', '26032', '董洋钦', '7735eb1af6d74795', '011c8c6f', 'Z01A01A03',
  1, 0, 1, '26032', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 610
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26032');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9861885911360481231', '7633283620601845736', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7633283620601845736' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4883008161143163449', '26049', '梁杰', '0e54a2331b5c7123', 'b8f123b6', 'Z01A01A03',
  1, 0, 1, '26049', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 620
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26049');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6140084420996229139', '4883008161143163449', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4883008161143163449' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7558870541567867595', '26146', '肖峻甲', 'd19e11169ca35edf', '008065c8', 'Z01A01A03',
  1, 0, 1, '26146', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 630
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26146');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9243249162451295858', '7558870541567867595', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7558870541567867595' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9009687843502249728', '26716', '王中亮', '9528a16e6dc8dffe', 'd6c47cdb', 'Z01A01A03',
  1, 0, 1, '26716', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 640
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26716');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2419165768116618637', '9009687843502249728', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9009687843502249728' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1133729152924179213', '26717', '彭幼灵', '6eb6c75a8ecb20f2', '891b2f34', 'Z01A01A03',
  1, 0, 1, '26717', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 650
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26717');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3026540043902146126', '1133729152924179213', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1133729152924179213' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6077587883441302071', '26919', '何友军', 'c55cfc6084e1c777', 'f7085551', 'Z01A01A03',
  1, 0, 1, '26919', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 660
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26919');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3679550926317178596', '6077587883441302071', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6077587883441302071' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3246110568501743102', '26970', '陈炯辉', 'a4feb895373504c5', '1bfc029e', 'Z01A01A03',
  1, 0, 1, '26970', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 670
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26970');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1832348094641797657', '3246110568501743102', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3246110568501743102' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3717043198454969308', '27005', '陆太辉', '23fc111b57f5f9e1', 'eed2d20b', 'Z01A01A03',
  1, 0, 1, '27005', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 680
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27005');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3372596237384365836', '3717043198454969308', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3717043198454969308' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9189583597135792616', '27030', '袁钱', 'fc1b89ceeb66a066', 'ba5119d9', 'Z01A01A03',
  1, 0, 1, '27030', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 690
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27030');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7840202620444705186', '9189583597135792616', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9189583597135792616' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1657998128300389817', '27031', '田佳奇', 'e46edebee4cf8499', '361c1b83', 'Z01A01A03',
  1, 0, 1, '27031', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 700
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27031');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1653751104785130099', '1657998128300389817', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1657998128300389817' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9699852220184916961', '27033', '田清涛', 'a1ee21d55633e9c2', 'ff7cc13d', 'Z01A01A03',
  1, 0, 1, '27033', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 710
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27033');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7994718527293211720', '9699852220184916961', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9699852220184916961' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4816632465717769907', '27034', '王林', 'd80b417faec0a2e8', '4d9e0c6d', 'Z01A01A03',
  1, 0, 1, '27034', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 720
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27034');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1330474912595469790', '4816632465717769907', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4816632465717769907' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9744922520715145656', '27139', '陈绍基', 'f9696cae00192bf1', 'b0506542', 'Z01A01A03',
  1, 0, 1, '27139', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 730
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27139');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4831162755174738573', '9744922520715145656', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9744922520715145656' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5996800635065656308', '27240', '徐世博', '818154a11ed00828', '3567e29e', 'Z01A01A03',
  1, 0, 1, '27240', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 740
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27240');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8745004678599351459', '5996800635065656308', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5996800635065656308' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2580459821394614065', '27460', '张怡俊', '7ecffaf0db16afa2', '9770da70', 'Z01A01A03',
  1, 0, 1, '27460', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 750
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27460');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3153182377774444440', '2580459821394614065', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2580459821394614065' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5113001911821821140', '27474', '彭木林', '033fb684ca84cd83', '4511832d', 'Z01A01A03',
  1, 0, 1, '27474', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 760
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27474');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8645999812300182418', '5113001911821821140', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5113001911821821140' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2006613506216362795', '27508', '邱鸿祥', '5369a79a339cc454', '1bf21ba0', 'Z01A01A03',
  1, 0, 1, '27508', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 770
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27508');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6690646284088045579', '2006613506216362795', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2006613506216362795' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4204135433092070203', '27531', '吴奕辰', 'c815ccbddc758ca3', 'a6a59064', 'Z01A01A03',
  1, 0, 1, '27531', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 780
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27531');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6148068558796346941', '4204135433092070203', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4204135433092070203' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4588422761388318146', '27572', '王磊', '2b71e7f54b0bf272', 'e37e7463', 'Z01A01A03',
  1, 0, 1, '27572', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 790
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27572');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2649993436044690561', '4588422761388318146', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4588422761388318146' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3137598398175096939', '27574', '邓海龙', 'b54e7116f5c431fe', 'd87979fc', 'Z01A01A03',
  1, 0, 1, '27574', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 800
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27574');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3286784575329133321', '3137598398175096939', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3137598398175096939' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9142944706350695555', '27575', '何圣智', '1216ef471940e737', 'e3be246f', 'Z01A01A03',
  1, 0, 1, '27575', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习铣工', 810
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27575');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3280529790804026704', '9142944706350695555', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9142944706350695555' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4367018473146897653', '27596', '姚志良', '9e4d55941869066d', '4436eda3', 'Z01A01A03',
  1, 0, 1, '27596', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 820
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27596');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2165794090935371370', '4367018473146897653', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4367018473146897653' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3153239632211157745', '27598', '蔡尚宪', '9ff662a492c14e4e', '9eaabb9e', 'Z01A01A03',
  1, 0, 1, '27598', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 830
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27598');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8626000876690338101', '3153239632211157745', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3153239632211157745' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1379129016911899503', '27607', '钟腾', 'c91ab0f3bc6d689c', 'cf6c3b21', 'Z01A01A03',
  1, 0, 1, '27607', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 840
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27607');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3857185945940332639', '1379129016911899503', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1379129016911899503' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3013203597145024490', '27612', '陈明', '1ef3b6a8cb64a17e', '5296882e', 'Z01A01A03',
  1, 0, 1, '27612', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 850
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27612');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7346375337517901576', '3013203597145024490', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3013203597145024490' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5372888773535680577', '27648', '何旭', 'ed21fedd8cb9b802', '95723825', 'Z01A01A03',
  1, 0, 1, '27648', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 860
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27648');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1082066678291278855', '5372888773535680577', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5372888773535680577' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2910274224840241048', '27664', '曾德毅', '9b046583f9f792cd', '32674c31', 'Z01A01A03',
  1, 0, 1, '27664', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 870
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27664');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4624001724553471124', '2910274224840241048', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2910274224840241048' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5547284152044152263', '27670', '王嘉煜', '714b753381dfd912', '2fa66f8d', 'Z01A01A03',
  1, 0, 1, '27670', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 880
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27670');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3423183079292490122', '5547284152044152263', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5547284152044152263' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1170979924500295110', '27676', '林日富', 'cf80bdacf3436c35', '3edef044', 'Z01A01A03',
  1, 0, 1, '27676', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 890
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27676');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3126245246892486548', '1170979924500295110', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1170979924500295110' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8660278561817702669', '27688', '夏朝林', 'e18418778cd207ac', 'bbf19a5c', 'Z01A01A03',
  1, 0, 1, '27688', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 900
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27688');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4436326996249554077', '8660278561817702669', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8660278561817702669' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4029930790927313533', '27690', '刘玉翔', 'ee65e223026beb8b', '655cbfa6', 'Z01A01A03',
  1, 0, 1, '27690', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 910
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27690');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8236925530064119432', '4029930790927313533', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4029930790927313533' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2222753236331392061', '27692', '张立扬', '4dee70fe305f686a', '89472110', 'Z01A01A03',
  1, 0, 1, '27692', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 920
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27692');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1245763622144497843', '2222753236331392061', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2222753236331392061' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7429869813750016525', '27699', '何钰强', '4d7337f151204445', '20476465', 'Z01A01A03',
  1, 0, 1, '27699', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 930
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27699');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3974308043090724565', '7429869813750016525', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7429869813750016525' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6883214939556312226', '27717', '周林根', '5cb4c29a82f22456', 'effbc95e', 'Z01A01A03',
  1, 0, 1, '27717', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 940
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27717');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1873544866081945056', '6883214939556312226', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6883214939556312226' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6958890541047320146', '27784', '李诗文', '4d4bf400922558eb', '59159088', 'Z01A01A03',
  1, 0, 1, '27784', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 950
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27784');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2365544125944499661', '6958890541047320146', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6958890541047320146' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3161412130637044771', '27787', '陈嘉豪', 'd1f144a2b0dbb423', 'b109aff5', 'Z01A01A03',
  1, 0, 1, '27787', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 960
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27787');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2850563598447800681', '3161412130637044771', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3161412130637044771' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8592477062702672641', '27789', '李可', 'b513bee9dc1aeba9', '42b0e3f0', 'Z01A01A03',
  1, 0, 1, '27789', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 970
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27789');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4183309683200773836', '8592477062702672641', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8592477062702672641' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8935096547894903820', '27823', '杨绍军', '4da42f6d2fde62c6', 'a4c46918', 'Z01A01A03',
  1, 0, 1, '27823', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 980
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27823');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7611116030623330603', '8935096547894903820', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8935096547894903820' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9148772337306319768', '27831', '喻胤涛', '5e39c84b97f1185d', 'c102b743', 'Z01A01A03',
  1, 0, 1, '27831', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 990
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27831');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4003410746187374935', '9148772337306319768', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9148772337306319768' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7747735954188931967', '27840', '谢广成', '539e407a38e6d470', '2066b9ef', 'Z01A01A03',
  1, 0, 1, '27840', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 1000
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27840');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3940866127688318402', '7747735954188931967', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7747735954188931967' AND `dep_id` = '2647529905710335310'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1926754209791494457', '27856', '韦永锋', '7868773c298413f6', '5aba5c7f', 'Z01A01A03',
  1, 0, 1, '27856', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 1010
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27856');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1189127805842036060', '1926754209791494457', '2647529905710335310'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1926754209791494457' AND `dep_id` = '2647529905710335310'
);


-- 组别：钳工组 (Z01A01A04)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9674752554644559514', '01437', '翟玉英', '6b1911526e362739', '44d204d7', 'Z01A01A04',
  1, 0, 1, '01437', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01437');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1074861824042057045', '9674752554644559514', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9674752554644559514' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5640873236261170044', '00901', '李远国', 'e216289634cb9cfc', 'c531db1e', 'Z01A01A04',
  1, 0, 1, '00901', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '00901');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5276306710555607819', '5640873236261170044', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5640873236261170044' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2638400317399930227', '02020', '常马仁', '69a301e198ccc902', '5b21732c', 'Z01A01A04',
  1, 0, 1, '02020', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02020');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8895148857681157295', '2638400317399930227', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2638400317399930227' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1402518538820170066', '02296', '谢小羽', 'f98ab197bf869be9', '4e0b89eb', 'Z01A01A04',
  1, 0, 1, '02296', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02296');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8420807950663687582', '1402518538820170066', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1402518538820170066' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5291957174671895914', '02387', '赵红梅', '707f6f16a5672633', '67e5b97f', 'Z01A01A04',
  1, 0, 1, '02387', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02387');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9098233025044417179', '5291957174671895914', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5291957174671895914' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5947385813273559142', '02720', '欧日胜', '98fcc4cd47ac2a4e', '03c59de1', 'Z01A01A04',
  1, 0, 1, '02720', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02720');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8562434964287106734', '5947385813273559142', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5947385813273559142' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1774525464375482514', '06789', '黎安妮', '51d3a5330653d6ff', 'f28e2e6c', 'Z01A01A04',
  1, 0, 1, '06789', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06789');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9234316294575885906', '1774525464375482514', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1774525464375482514' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8677906267944988654', '08574', '万春和', '11dc1ce486691ad3', 'de8df6a9', 'Z01A01A04',
  1, 0, 1, '08574', 'admin', NOW(), 'admin', NOW(), 1, 0, '焊工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08574');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4724495589823916108', '8677906267944988654', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8677906267944988654' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3490332266534226190', '08847', '陈丽超', '03e0c38355527532', '7d3d74a7', 'Z01A01A04',
  1, 0, 1, '08847', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08847');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7388454678115820769', '3490332266534226190', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3490332266534226190' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9345067023521330313', '10508', '陈方琼', 'a383bedd9186f1bb', '322bf0b5', 'Z01A01A04',
  1, 0, 1, '10508', 'admin', NOW(), 'admin', NOW(), 1, 0, '清洗工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10508');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1081652126022909000', '9345067023521330313', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9345067023521330313' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9032834623369399612', '10545', '王仕将', 'a24688135e8e1456', '1b44d8d0', 'Z01A01A04',
  1, 0, 1, '10545', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10545');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3003497353752086169', '9032834623369399612', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9032834623369399612' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4052323010987199449', '10653', '韦德龙', '7b76710a5da72f27', '58ed1b64', 'Z01A01A04',
  1, 0, 1, '10653', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10653');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3099694665116224759', '4052323010987199449', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4052323010987199449' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6926693261481920628', '11229', '李兴望', '4466edb17ee7a69b', '37b1dc09', 'Z01A01A04',
  1, 0, 1, '11229', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11229');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6923165884413477943', '6926693261481920628', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6926693261481920628' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8881536720829157948', '11375', '刘贵国', '4de39a95edea0eea', '717dba7a', 'Z01A01A04',
  1, 0, 1, '11375', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11375');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4943727171957713825', '8881536720829157948', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8881536720829157948' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5100680115153274299', '13298', '王小双', '7ca45ca52167d2fe', '43b32706', 'Z01A01A04',
  1, 0, 1, '13298', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13298');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5102418357637544590', '5100680115153274299', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5100680115153274299' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1304209408049070257', '13299', '王大双', '5d63d6a9e7ffa4b0', '846228b0', 'Z01A01A04',
  1, 0, 1, '13299', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13299');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3858961441589133380', '1304209408049070257', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1304209408049070257' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8827174013726512888', '15085', '唐弋凯', '1f766953e5acda8e', '11d5beb9', 'Z01A01A04',
  1, 0, 1, '15085', 'admin', NOW(), 'admin', NOW(), 1, 0, '钳工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15085');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2685888278080655606', '8827174013726512888', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8827174013726512888' AND `dep_id` = '9818109943841671569'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3509787971924570997', '27853', '张永炘', '479932ca329a27da', '36e9faac', 'Z01A01A04',
  1, 0, 1, '27853', 'admin', NOW(), 'admin', NOW(), 1, 0, '披锋工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27853');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2911190909937921957', '3509787971924570997', '9818109943841671569'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3509787971924570997' AND `dep_id` = '9818109943841671569'
);


-- 组别：NC车组 (Z01A01A05)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4619156350107778562', '01559', '李勇', '31ee6e97aa00b2f7', 'ea2b660c', 'Z01A01A05',
  1, 0, 1, '01559', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01559');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7731993860582114133', '4619156350107778562', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4619156350107778562' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7925500920142697987', '03487', '严辉', '4c644640a53733d1', '0dd1d56b', 'Z01A01A05',
  1, 0, 1, '03487', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03487');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2388865816240601455', '7925500920142697987', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7925500920142697987' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6339015062016786957', '05323', '姚俊峰', '548a230574ae1530', '84515dbe', 'Z01A01A05',
  1, 0, 1, '05323', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05323');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8995410936767902008', '6339015062016786957', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6339015062016786957' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1453080966800096935', '05449', '徐威力', '3b83ebb5d294e4f0', '3cc1712d', 'Z01A01A05',
  1, 0, 1, '05449', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05449');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4823577825412955018', '1453080966800096935', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1453080966800096935' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2603668269487787977', '09939', '孙林松', 'fc189610d01fb638', 'fc85a066', 'Z01A01A05',
  1, 0, 1, '09939', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09939');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8468685660941902495', '2603668269487787977', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2603668269487787977' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5718062816750797142', '09981', '王威', '063e6fba62aa3dcd', 'ca6cf977', 'Z01A01A05',
  1, 0, 1, '09981', 'admin', NOW(), 'admin', NOW(), 1, 0, '编程工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09981');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6745713844132403541', '5718062816750797142', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5718062816750797142' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7250331758928960129', '10240', '胡全', '7e6035d4f4137f7a', '5bbf7622', 'Z01A01A05',
  1, 0, 1, '10240', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10240');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6407018589164469642', '7250331758928960129', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7250331758928960129' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3864588922808569619', '10607', '高博', '989872061e8231e4', 'fadbc3b2', 'Z01A01A05',
  1, 0, 1, '10607', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10607');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3435190868659038550', '3864588922808569619', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3864588922808569619' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9821504407981733904', '11508', '黄金巩', '226fd2073f9c47e1', '5ef10933', 'Z01A01A05',
  1, 0, 1, '11508', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11508');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8319448747210389161', '9821504407981733904', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9821504407981733904' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7557323367113185980', '11544', '曾庆波', 'e7feb00baeffeff9', '05f2f26a', 'Z01A01A05',
  1, 0, 1, '11544', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11544');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4214082499705135354', '7557323367113185980', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7557323367113185980' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1158198400559610108', '12254', '赖和银', '29d6544ccc75dcaf', '37edfa96', 'Z01A01A05',
  1, 0, 1, '12254', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12254');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4947249943958833285', '1158198400559610108', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1158198400559610108' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2841403029213943116', '13773', '曾浩然', 'e806798783e0060a', 'e47a98cb', 'Z01A01A05',
  1, 0, 1, '13773', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13773');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5658881179591260130', '2841403029213943116', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2841403029213943116' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9119839579043808603', '13905', '毕映红', '6696e184a034422b', 'c17d2fc2', 'Z01A01A05',
  1, 0, 1, '13905', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13905');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6813594650567799462', '9119839579043808603', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9119839579043808603' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4428129717856037553', '13956', '陈吉清', 'f5d0823fec8c17dc', 'ce86ea32', 'Z01A01A05',
  1, 0, 1, '13956', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13956');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3272237672331674255', '4428129717856037553', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4428129717856037553' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2755373091397697720', '13957', '鲁红杰', '9f5caa6e297f01bc', 'c46f006e', 'Z01A01A05',
  1, 0, 1, '13957', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13957');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8945288702191112955', '2755373091397697720', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2755373091397697720' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7826923248634969401', '14660', '张磊磊', '4f552da36d7cfde1', '4086428a', 'Z01A01A05',
  1, 0, 1, '14660', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14660');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8477466610418299672', '7826923248634969401', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7826923248634969401' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2931546120449634328', '14784', '石习江', '73af112b2b6c65b0', 'e1fc0350', 'Z01A01A05',
  1, 0, 1, '14784', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14784');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5887391590255055084', '2931546120449634328', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2931546120449634328' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2119470979381552666', '14945', '林家轩', '6ffce4396286a80a', '84372fc2', 'Z01A01A05',
  1, 0, 1, '14945', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14945');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2638115206321392818', '2119470979381552666', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2119470979381552666' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4393732119720415787', '15304', '邓庭辉', 'e1de3564f0a87b9e', 'e5056873', 'Z01A01A05',
  1, 0, 1, '15304', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15304');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5226597220765166210', '4393732119720415787', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4393732119720415787' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2922524607979327310', '15458', '李文海', 'd9e965c82a50ccc6', '25c7dcad', 'Z01A01A05',
  1, 0, 1, '15458', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15458');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2065881952089057760', '2922524607979327310', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2922524607979327310' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4149037224869229389', '15606', '雷孟珂', '38384feddee11779', '4682d297', 'Z01A01A05',
  1, 0, 1, '15606', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15606');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5274754512453541116', '4149037224869229389', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4149037224869229389' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7580290030419847725', '17030', '李晨辉', 'd593a4a537f6ea35', '35f67831', 'Z01A01A05',
  1, 0, 1, '17030', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17030');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8113900684627272909', '7580290030419847725', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7580290030419847725' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8024570235915002467', '17202', '黄永远', 'ecb1e9ac60be048b', '93db8e97', 'Z01A01A05',
  1, 0, 1, '17202', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17202');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3324654198725531563', '8024570235915002467', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8024570235915002467' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9577243675802469210', '23175', '王豪', '444f6e819a682d60', '13775ea5', 'Z01A01A05',
  1, 0, 1, '23175', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23175');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2102756804059579962', '9577243675802469210', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9577243675802469210' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5776719582154382809', '23234', '张嘉浩', 'e2f701f0adc77a22', '013ae8e3', 'Z01A01A05',
  1, 0, 1, '23234', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23234');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1976071144642663164', '5776719582154382809', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5776719582154382809' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5928877534197698475', '23422', '冯程辉', '72a8e44e4300be42', 'c117357f', 'Z01A01A05',
  1, 0, 1, '23422', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23422');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3755867331158568764', '5928877534197698475', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5928877534197698475' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6652945517250662485', '23558', '邓汝全', '2eebdb8b2b909ec6', 'f1a516c3', 'Z01A01A05',
  1, 0, 1, '23558', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23558');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1316725883461532683', '6652945517250662485', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6652945517250662485' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6063495591457300338', '24089', '袁晓斌', '64fddcfbab710c6b', 'de5ab779', 'Z01A01A05',
  1, 0, 1, '24089', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24089');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3332706673866545400', '6063495591457300338', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6063495591457300338' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9306977280119568072', '24337', '张宇菲', 'fc56a6c168e22288', 'a6513a90', 'Z01A01A05',
  1, 0, 1, '24337', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24337');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6120013303856272025', '9306977280119568072', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9306977280119568072' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7479507458210236399', '24406', '李家劲', '3de67e162a9d6ea4', '03b54860', 'Z01A01A05',
  1, 0, 1, '24406', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24406');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4829713770292321281', '7479507458210236399', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7479507458210236399' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4809888131848931860', '24678', '何明准', 'a0c5769bd61e7712', '361c9a3e', 'Z01A01A05',
  1, 0, 1, '24678', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24678');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7818621526480430048', '4809888131848931860', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4809888131848931860' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3622643349682232588', '25920', '范斌', 'f11c57c1b067b4c8', 'f4bf2c25', 'Z01A01A05',
  1, 0, 1, '25920', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25920');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1001509774020088627', '3622643349682232588', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3622643349682232588' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6431612053196026799', '25928', '张语童', '0542c0f714157f1a', 'bb2e329a', 'Z01A01A05',
  1, 0, 1, '25928', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习NC车工', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25928');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8909209481628346615', '6431612053196026799', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6431612053196026799' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3628437326451681102', '25994', '张嘉磊', 'fcce52b14dc52bff', '2d60ed40', 'Z01A01A05',
  1, 0, 1, '25994', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习NC车工', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25994');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1461031645375432073', '3628437326451681102', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3628437326451681102' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3883656182789239756', '26020', '杜正宁', '278b8750525f7813', '98f3fd7d', 'Z01A01A05',
  1, 0, 1, '26020', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26020');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5986036485229801072', '3883656182789239756', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3883656182789239756' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3377200508331919314', '26119', '聂潜', '973df1ae365d7cc3', '205d8dd1', 'Z01A01A05',
  1, 0, 1, '26119', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26119');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3339526591017841170', '3377200508331919314', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3377200508331919314' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1228317464830274807', '26243', '徐涛', 'b6ffcd5f2fad556d', 'e1571e1c', 'Z01A01A05',
  1, 0, 1, '26243', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习NC车工', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26243');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1964628583176805165', '1228317464830274807', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1228317464830274807' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6031565043331011710', '26305', '蔡学锷', 'ca1925a6a4c4a62d', 'ac433902', 'Z01A01A05',
  1, 0, 1, '26305', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 380
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26305');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9479728411624178995', '6031565043331011710', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6031565043331011710' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3950548571232220137', '26979', '吕义仁', '41adc22e45c32dd4', 'cf2a7b51', 'Z01A01A05',
  1, 0, 1, '26979', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 390
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26979');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8392146509410128453', '3950548571232220137', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3950548571232220137' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8446004135334152354', '27008', '贺洪威', '97fc72514f68f527', 'd5c7b285', 'Z01A01A05',
  1, 0, 1, '27008', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 400
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27008');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3401725837748282557', '8446004135334152354', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8446004135334152354' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2957963902285597766', '27043', '刘永洁', '60c615a2571346a6', 'dab248a6', 'Z01A01A05',
  1, 0, 1, '27043', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 410
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27043');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3518963968212451224', '2957963902285597766', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2957963902285597766' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9959784023867098711', '27044', '宋亮亮', '7a54524df6abeb4e', '75e2334f', 'Z01A01A05',
  1, 0, 1, '27044', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 420
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27044');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3267104402017305225', '9959784023867098711', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9959784023867098711' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2152504193756099743', '27045', '李铭', '545c9dad79a8213f', '64036e30', 'Z01A01A05',
  1, 0, 1, '27045', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 430
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27045');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9124515499609831541', '2152504193756099743', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2152504193756099743' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5377164094173518410', '27046', '杨添', 'e9bda8a412c0c29f', '3def1f54', 'Z01A01A05',
  1, 0, 1, '27046', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 440
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27046');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7855873470480906051', '5377164094173518410', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5377164094173518410' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2051244167430729555', '27155', '黄植树', 'a403a741b29e95a9', '569b28e9', 'Z01A01A05',
  1, 0, 1, '27155', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC车工', 450
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27155');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9715978509131930339', '2051244167430729555', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2051244167430729555' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8368296840119259822', '27469', '张海翔', 'c46e62dab4446e77', '1e237776', 'Z01A01A05',
  1, 0, 1, '27469', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 460
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27469');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8331883433946538145', '8368296840119259822', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8368296840119259822' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3561728985099436278', '27470', '吴健壮', 'efc458b8ea2a6b20', '2b2f310d', 'Z01A01A05',
  1, 0, 1, '27470', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 470
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27470');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6808631102090270756', '3561728985099436278', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3561728985099436278' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2213034740592852846', '27471', '胡盛康', 'd95f34f838b95e43', 'a5d9cef0', 'Z01A01A05',
  1, 0, 1, '27471', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 480
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27471');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3740285991179934222', '2213034740592852846', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2213034740592852846' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3422563130235002230', '27472', '李剑', '436b9558fc0583ea', 'd5712732', 'Z01A01A05',
  1, 0, 1, '27472', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 490
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27472');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6562715513349688017', '3422563130235002230', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3422563130235002230' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9821764156921179511', '27473', '徐富强', 'd9125840ff9cbf8b', '5c355c57', 'Z01A01A05',
  1, 0, 1, '27473', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 500
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27473');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5282337847752035247', '9821764156921179511', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9821764156921179511' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4399105997087059075', '27475', '李斌', '06186c11123e5195', '122d9fe9', 'Z01A01A05',
  1, 0, 1, '27475', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 510
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27475');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6566582027403672348', '4399105997087059075', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4399105997087059075' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5536902761560255644', '27476', '周资荣', 'be6cfa1885413f40', '70a13ad0', 'Z01A01A05',
  1, 0, 1, '27476', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 520
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27476');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8064046972378764676', '5536902761560255644', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5536902761560255644' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4175932695737921149', '27477', '胡航', '881f647199dd58fa', '1792d76f', 'Z01A01A05',
  1, 0, 1, '27477', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 530
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27477');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9299236175833833674', '4175932695737921149', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4175932695737921149' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9267882869607359151', '27479', '向安桦', '5ba9392d84e14b9c', '49f11a30', 'Z01A01A05',
  1, 0, 1, '27479', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 540
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27479');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9184002034209619721', '9267882869607359151', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9267882869607359151' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9341220685742494848', '27480', '欧阳灿', '5cc097fc1bfdbb8e', '1d3e976f', 'Z01A01A05',
  1, 0, 1, '27480', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 550
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27480');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2629668740057152861', '9341220685742494848', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9341220685742494848' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4751420096215172115', '27481', '姚富源', 'dc067dffc7393eeb', '5cc03232', 'Z01A01A05',
  1, 0, 1, '27481', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 560
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27481');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2323575485858575321', '4751420096215172115', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4751420096215172115' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7398310013640827135', '27482', '雷文涛', 'c9d96de605b85cd7', '4c7277fd', 'Z01A01A05',
  1, 0, 1, '27482', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 570
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27482');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6816613249067334279', '7398310013640827135', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7398310013640827135' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2774799837306547213', '27483', '郭晋章', 'e0e95672f370fce6', 'd644bd03', 'Z01A01A05',
  1, 0, 1, '27483', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 580
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27483');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1201252892573200175', '2774799837306547213', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2774799837306547213' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8160866503871158583', '27581', '陈裕家', 'f6d41b2ce23c68fd', '7f0bf4e5', 'Z01A01A05',
  1, 0, 1, '27581', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习NC车工', 590
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27581');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4509351902565984675', '8160866503871158583', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8160866503871158583' AND `dep_id` = '7555745269009703128'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4527709248488283715', '27708', '黎祖添', '9d80b36650edc799', '52207e78', 'Z01A01A05',
  1, 0, 1, '27708', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习NC车工', 600
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27708');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5108988125744892078', '4527709248488283715', '7555745269009703128'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4527709248488283715' AND `dep_id` = '7555745269009703128'
);


-- 组别：慢走丝组 (Z01A01A06)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8971664613155952219', '01926', '沈建伟', 'ed92f7884055d4df', 'd885afe9', 'Z01A01A06',
  1, 0, 1, '01926', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01926');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3115553401420368412', '8971664613155952219', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8971664613155952219' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8191764288424946507', '02708', '谌胜平', '15cbd3302dd377e2', '3db2033f', 'Z01A01A06',
  1, 0, 1, '02708', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02708');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8002873439083929140', '8191764288424946507', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8191764288424946507' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6158350512181340298', '03433', '曾庆当', 'ae7dd9e2bfc2f0bc', '5191f880', 'Z01A01A06',
  1, 0, 1, '03433', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03433');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3115283070898104987', '6158350512181340298', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6158350512181340298' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7042900985674730948', '08219', '吴碧海', 'b48e4997a0c35851', '8d7b6f48', 'Z01A01A06',
  1, 0, 1, '08219', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08219');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8862307754209561179', '7042900985674730948', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7042900985674730948' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9906562968032517182', '11185', '黄迈湧', '167f8afdeefa4486', '6a53cb65', 'Z01A01A06',
  1, 0, 1, '11185', 'admin', NOW(), 'admin', NOW(), 1, 0, '火花机', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11185');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5559349748588468089', '9906562968032517182', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9906562968032517182' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2060822486913658643', '11362', '周曲波', 'c929d28f006cc694', 'ee66d551', 'Z01A01A06',
  1, 0, 1, '11362', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11362');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6867208866387137469', '2060822486913658643', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2060822486913658643' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8769773799421642192', '11741', '蔡运强', '08d08fd142f1189c', 'b436e12c', 'Z01A01A06',
  1, 0, 1, '11741', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11741');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5111647928875626926', '8769773799421642192', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8769773799421642192' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4749663733376104372', '13415', '魏明刚', '2fe4eea3f1e582f2', '2c5ee874', 'Z01A01A06',
  1, 0, 1, '13415', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13415');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1875763714878325602', '4749663733376104372', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4749663733376104372' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5918261278299191394', '14906', '钟海东', 'e2213192e9353307', '1c3c7d23', 'Z01A01A06',
  1, 0, 1, '14906', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14906');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3763047730505681343', '5918261278299191394', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5918261278299191394' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5071398281762738373', '15340', '周迪', 'd26f4c9acca8b016', '41ab90cb', 'Z01A01A06',
  1, 0, 1, '15340', 'admin', NOW(), 'admin', NOW(), 1, 0, '火花机', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15340');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1405006240347213837', '5071398281762738373', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5071398281762738373' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7047197372504182798', '15597', '陈君豪', 'f10fd581909c75d9', '7df1ad18', 'Z01A01A06',
  1, 0, 1, '15597', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '15597');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9384966164773355308', '7047197372504182798', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7047197372504182798' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1883042085246341975', '17111', '曾丘霆', '224ed2d6b3dc0e8b', '55957826', 'Z01A01A06',
  1, 0, 1, '17111', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17111');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9000527796703220090', '1883042085246341975', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1883042085246341975' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7107141287746960859', '17345', '陈蔚鸿', 'e4f583eb2b052459', '27bf3e21', 'Z01A01A06',
  1, 0, 1, '17345', 'admin', NOW(), 'admin', NOW(), 1, 0, '火花机', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17345');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5952960809222229160', '7107141287746960859', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7107141287746960859' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2193121929438474822', '18508', '张豫', '0bc0a937557d82aa', '05746b0b', 'Z01A01A06',
  1, 0, 1, '18508', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18508');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9578150751632588621', '2193121929438474822', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2193121929438474822' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5297901210006278634', '22682', '陶颜', 'a4378b291897e3b7', 'bc31306f', 'Z01A01A06',
  1, 0, 1, '22682', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22682');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9901939952993041837', '5297901210006278634', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5297901210006278634' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4324957261006886669', '26029', '唐广', '9073243af7bb5588', '9e20bee2', 'Z01A01A06',
  1, 0, 1, '26029', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26029');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8985860549822370313', '4324957261006886669', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4324957261006886669' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1819571526248058397', '26039', '林元啟', 'be27e0854ad5b7c1', '7f934a64', 'Z01A01A06',
  1, 0, 1, '26039', 'admin', NOW(), 'admin', NOW(), 1, 0, '火花机', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26039');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7823382072735586140', '1819571526248058397', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1819571526248058397' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6747695052910785720', '26161', '廖宗城', '1e5da995ebc6c34a', '95cf8084', 'Z01A01A06',
  1, 0, 1, '26161', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26161');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5119929613645688342', '6747695052910785720', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6747695052910785720' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2839004544487922052', '26177', '汪岩森', 'e94db02302b35680', 'aabbf611', 'Z01A01A06',
  1, 0, 1, '26177', 'admin', NOW(), 'admin', NOW(), 1, 0, '慢走丝', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26177');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9667135681989649233', '2839004544487922052', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2839004544487922052' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2823225474565823599', '26226', '杨志方', 'fa98b36893578c9f', 'b1940823', 'Z01A01A06',
  1, 0, 1, '26226', 'admin', NOW(), 'admin', NOW(), 1, 0, '火花机', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26226');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9621711033781710905', '2823225474565823599', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2823225474565823599' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8153223377250925534', '27037', '杨桢宁', '895c3643e6fea94b', '425c637f', 'Z01A01A06',
  1, 0, 1, '27037', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27037');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8318893457598372144', '8153223377250925534', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8153223377250925534' AND `dep_id` = '9762036247575086793'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5540880997352729253', '27875', '周千睿', '9e39cceccd0b054d', 'd503f8f0', 'Z01A01A06',
  1, 0, 1, '27875', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习慢走丝', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27875');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4222485758561779577', '5540880997352729253', '9762036247575086793'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5540880997352729253' AND `dep_id` = '9762036247575086793'
);


-- 组别：磨床组 (Z01A01A07)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2381042674828784101', '02740', '张桃', 'df46f4da0f8a28f9', '146641a8', 'Z01A01A07',
  1, 0, 1, '02740', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02740');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3663980367306984790', '2381042674828784101', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2381042674828784101' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4179449438687087530', '03088', '郭志军', '2a34fec102c190c2', 'df6c2054', 'Z01A01A07',
  1, 0, 1, '03088', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03088');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1324802384342481860', '4179449438687087530', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4179449438687087530' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1827276241258132751', '03638', '胡真', 'c7a129e75ac7f9b7', '51d96db3', 'Z01A01A07',
  1, 0, 1, '03638', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03638');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9588089053177617558', '1827276241258132751', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1827276241258132751' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5692780186871584335', '03848', '杨滨', '2214e4cea74ed254', '27963a6c', 'Z01A01A07',
  1, 0, 1, '03848', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03848');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9357068008604466584', '5692780186871584335', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5692780186871584335' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3851289837513306408', '03942', '郑宝', '2330349379ba43bb', 'c72e1c40', 'Z01A01A07',
  1, 0, 1, '03942', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03942');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3313971266766467893', '3851289837513306408', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3851289837513306408' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9443564692470892377', '04070', '毛辉', '43108ee03be1f5ca', 'efc1dde2', 'Z01A01A07',
  1, 0, 1, '04070', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04070');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4956228576979225814', '9443564692470892377', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9443564692470892377' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8463424625068245676', '05154', '吴云云', '7894f67c250d8197', 'f324190c', 'Z01A01A07',
  1, 0, 1, '05154', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05154');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1410154741021096278', '8463424625068245676', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8463424625068245676' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4598190985076511853', '06199', '韩浩', 'd08b0dd13380a13d', '5a085f9a', 'Z01A01A07',
  1, 0, 1, '06199', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06199');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1032525326087395278', '4598190985076511853', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4598190985076511853' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4895887490009507548', '08888', '韦宏', '08e598518bd7506d', 'de6b282b', 'Z01A01A07',
  1, 0, 1, '08888', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08888');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6191386359271540593', '4895887490009507548', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4895887490009507548' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7910276636590609831', '10163', '张万全', '1b1778e5969db3a1', '22facd8b', 'Z01A01A07',
  1, 0, 1, '10163', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10163');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5397610147438551435', '7910276636590609831', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7910276636590609831' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3884572765815218697', '10451', '袁海军', '3e1eb67e4a33abb2', '6749cb5a', 'Z01A01A07',
  1, 0, 1, '10451', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10451');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1514908453076521180', '3884572765815218697', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3884572765815218697' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9584724943153502955', '10658', '蔡坚', 'a3b7ea6cd8cae211', '36c77ba8', 'Z01A01A07',
  1, 0, 1, '10658', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10658');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1901570908205508644', '9584724943153502955', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9584724943153502955' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5456436231035085275', '11261', '林万真', '3cde4a7d4cb1d6c8', '4ede8ab7', 'Z01A01A07',
  1, 0, 1, '11261', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11261');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1504392276543971699', '5456436231035085275', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5456436231035085275' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6466436823493743647', '11545', '李广庞', '85be25d3f293c4a3', '07528d48', 'Z01A01A07',
  1, 0, 1, '11545', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11545');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3905361118401403505', '6466436823493743647', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6466436823493743647' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5809186763559195181', '11555', '宁斌', '91dae1e8fe0e2cf8', '99944353', 'Z01A01A07',
  1, 0, 1, '11555', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11555');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8569978692166915257', '5809186763559195181', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5809186763559195181' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1455282256234691021', '11558', '欧阳宜萍', 'cfcda99650f53f6a', '9fbd3dac', 'Z01A01A07',
  1, 0, 1, '11558', 'admin', NOW(), 'admin', NOW(), 1, 0, '主管', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11558');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4028979775507802257', '1455282256234691021', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1455282256234691021' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4388110435912522615', '11703', '欧阳高鹏', 'dfac45a649f5847b', '9e3592b2', 'Z01A01A07',
  1, 0, 1, '11703', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11703');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9007997031315119878', '4388110435912522615', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4388110435912522615' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8327871692696519902', '12283', '陈天俊', '7a41dd511c224254', '44c13c30', 'Z01A01A07',
  1, 0, 1, '12283', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12283');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5324638667768890335', '8327871692696519902', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8327871692696519902' AND `dep_id` = '3136468428221880417'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7016484653731013176', '13439', '潘国星', '5ed10495a315b45c', '7c851aa5', 'Z01A01A07',
  1, 0, 1, '13439', 'admin', NOW(), 'admin', NOW(), 1, 0, '磨工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13439');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8426570434294700426', '7016484653731013176', '3136468428221880417'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7016484653731013176' AND `dep_id` = '3136468428221880417'
);


-- 组别：ICNC6组 (Z01A01A08)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6152868657992759173', '03114', '张力文', '39c86fb3032c8b6e', '46585c4f', 'Z01A01A08',
  1, 0, 1, '03114', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03114');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1049467200025705716', '6152868657992759173', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6152868657992759173' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2350761775592739597', '03384', '李欣', '22335a1994c9fc6f', '430e83ad', 'Z01A01A08',
  1, 0, 1, '03384', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03384');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1796978322964595594', '2350761775592739597', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2350761775592739597' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5596130758255502763', '06749', '刘玉清', 'f3c0773115a1389d', '0824b292', 'Z01A01A08',
  1, 0, 1, '06749', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06749');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7348898068152558637', '5596130758255502763', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5596130758255502763' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9368993608485302626', '06935', '杨滇', 'a5d2b2ecdf258b9b', '84c9333c', 'Z01A01A08',
  1, 0, 1, '06935', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06935');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2713330181570858747', '9368993608485302626', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9368993608485302626' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9163650662024458442', '07602', '曾圣锋', '3fa52ad74fc1dfa7', 'fc070d68', 'Z01A01A08',
  1, 0, 1, '07602', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07602');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4156584796711382048', '9163650662024458442', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9163650662024458442' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4460134279630233113', '07994', '李瑞林', 'fde7e2b26ce09380', '6c39a1a6', 'Z01A01A08',
  1, 0, 1, '07994', 'admin', NOW(), 'admin', NOW(), 1, 0, '副主管', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07994');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4592024573449614395', '4460134279630233113', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4460134279630233113' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6645576004789371445', '08140', '吴贵平', '30f993f39b0a5834', '2c4f4ccd', 'Z01A01A08',
  1, 0, 1, '08140', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08140');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2021723131550971175', '6645576004789371445', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6645576004789371445' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7352909395852075139', '08387', '李家辉', '5997c2d9fb671612', '00438c9f', 'Z01A01A08',
  1, 0, 1, '08387', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '08387');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6316890391973497362', '7352909395852075139', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7352909395852075139' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1771460508297063763', '09957', '农建平', '8fd4fecc10e99b33', '1759e90c', 'Z01A01A08',
  1, 0, 1, '09957', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09957');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3627206064882469236', '1771460508297063763', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1771460508297063763' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7508165587583463516', '10688', '蒋楚杰', 'ead2c054be672235', 'b9989664', 'Z01A01A08',
  1, 0, 1, '10688', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10688');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7378475609887194491', '7508165587583463516', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7508165587583463516' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6281260195735136389', '10767', '谢磊', 'efd48256b732172b', '03e08a4c', 'Z01A01A08',
  1, 0, 1, '10767', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10767');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1216188164738516180', '6281260195735136389', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6281260195735136389' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2057481380153816986', '10891', '钟梁', '04bfe47f8eae180e', '3d5ad3f4', 'Z01A01A08',
  1, 0, 1, '10891', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10891');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9304724998842073076', '2057481380153816986', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2057481380153816986' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8809314953777539471', '12737', '刘志祥', '869a2459183f1f56', 'ce7d7b30', 'Z01A01A08',
  1, 0, 1, '12737', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12737');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4464411556161083194', '8809314953777539471', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8809314953777539471' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4715302149690291198', '12841', '劳宏仁', '31a9c30940fdc678', '61c07a09', 'Z01A01A08',
  1, 0, 1, '12841', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12841');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4712907838632862988', '4715302149690291198', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4715302149690291198' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1441624452304715142', '13930', '莫九辉', 'ee60edd7caeecf7c', '4f9b2580', 'Z01A01A08',
  1, 0, 1, '13930', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13930');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6743201962980247565', '1441624452304715142', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1441624452304715142' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2636656689197091936', '13952', '王健', '3a118c55df832023', '1023790e', 'Z01A01A08',
  1, 0, 1, '13952', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '13952');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9636370966319762962', '2636656689197091936', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2636656689197091936' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1865284068240815855', '16471', '李中新', '751fba852a349024', 'cbaaa131', 'Z01A01A08',
  1, 0, 1, '16471', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16471');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3680854518881450730', '1865284068240815855', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1865284068240815855' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9560738025451362043', '17320', '许思博', 'ffdc8598493d0ae0', 'ef82e2bf', 'Z01A01A08',
  1, 0, 1, '17320', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17320');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6071403653940894530', '9560738025451362043', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9560738025451362043' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8973642512840685365', '17566', '江世龙', '52ea4d0cdb7bb33e', 'a45258e5', 'Z01A01A08',
  1, 0, 1, '17566', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17566');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3039040296636773747', '8973642512840685365', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8973642512840685365' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1797415421843378867', '17593', '李巨泉', '6f22e3bb181089fb', 'f64306f8', 'Z01A01A08',
  1, 0, 1, '17593', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '17593');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1422284282174404730', '1797415421843378867', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1797415421843378867' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7957566617573810170', '18080', '李平文', '781f676ba029f41b', '58d54cff', 'Z01A01A08',
  1, 0, 1, '18080', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18080');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6896861099586257318', '7957566617573810170', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7957566617573810170' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8516530237595749233', '18849', '黄钰闵', 'b0bcc1b7ab2ba430', '88a75544', 'Z01A01A08',
  1, 0, 1, '18849', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18849');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2949302270494954875', '8516530237595749233', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8516530237595749233' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4921319399784322297', '18938', '梁杰初', 'a9714a9af315e183', 'a862bed7', 'Z01A01A08',
  1, 0, 1, '18938', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '18938');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4309439598552133675', '4921319399784322297', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4921319399784322297' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2696580589319992011', '24333', '冯文杰', '21e8c66667576ba6', 'f2000645', 'Z01A01A08',
  1, 0, 1, '24333', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24333');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3348106484539676299', '2696580589319992011', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2696580589319992011' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2533364533586061150', '24334', '周慧东', 'cd2904c025be85c0', 'dc1461ce', 'Z01A01A08',
  1, 0, 1, '24334', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24334');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2346750819862225146', '2533364533586061150', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2533364533586061150' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7088009263315046474', '24342', '何旭辉', '724444985db9131e', 'be1e5261', 'Z01A01A08',
  1, 0, 1, '24342', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24342');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2111916726646507408', '7088009263315046474', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7088009263315046474' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4552502265962423183', '24360', '蔡志勇', '81935ffa59771c5a', '995e03fc', 'Z01A01A08',
  1, 0, 1, '24360', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24360');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8847244581030486305', '4552502265962423183', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4552502265962423183' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6830177164537591814', '24375', '刘春裕', '96939658a868eb22', '3c00516e', 'Z01A01A08',
  1, 0, 1, '24375', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24375');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2369949375602774242', '6830177164537591814', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6830177164537591814' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6484730570193868607', '24380', '卢贤奇', '236419863f30f9b7', '34f22b5f', 'Z01A01A08',
  1, 0, 1, '24380', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24380');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9165943434099635533', '6484730570193868607', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6484730570193868607' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5729207577244615801', '24418', '李少帅', '361ecc83aafd229c', '95ff2f56', 'Z01A01A08',
  1, 0, 1, '24418', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24418');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8152350205544477952', '5729207577244615801', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5729207577244615801' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3812714932871323628', '24530', '彭瑜勇', '3b2cd579039b9fc7', '76e0900a', 'Z01A01A08',
  1, 0, 1, '24530', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24530');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9895398522376017180', '3812714932871323628', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3812714932871323628' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1435527557773448713', '24677', '聂俊宇', 'ebc254e1aa8c249c', '0771f619', 'Z01A01A08',
  1, 0, 1, '24677', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24677');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6903181838254624888', '1435527557773448713', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1435527557773448713' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6752068588830794417', '24771', '欧杰', '28d466fc47f62df0', 'ee33a12e', 'Z01A01A08',
  1, 0, 1, '24771', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24771');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8686702092445304005', '6752068588830794417', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6752068588830794417' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3307677748749555650', '24878', '李铖仁', '83215f0d7a366f55', '6ed0bfe2', 'Z01A01A08',
  1, 0, 1, '24878', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24878');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6493684597274836562', '3307677748749555650', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3307677748749555650' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6719657563149757349', '24941', '孙圳', '206c2649092e2f46', '1affe3cb', 'Z01A01A08',
  1, 0, 1, '24941', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24941');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2136483722412080493', '6719657563149757349', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6719657563149757349' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1861308331700912329', '25566', '谢泽园', '843142d0228b40ac', 'c19e1786', 'Z01A01A08',
  1, 0, 1, '25566', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25566');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4151684920202798331', '1861308331700912329', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1861308331700912329' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2614854917366584037', '25628', '李阳', 'a2eab003e2a60dbc', '6e9b7cae', 'Z01A01A08',
  1, 0, 1, '25628', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25628');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3632737000853073970', '2614854917366584037', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2614854917366584037' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6615499090821677986', '25946', '谭伟强', 'aa85a675046dd9d1', '3e37bd03', 'Z01A01A08',
  1, 0, 1, '25946', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 380
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25946');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5944470388225616115', '6615499090821677986', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6615499090821677986' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7864433525248941515', '25996', '黄辉平', '83fb806f4f6f7581', '09cfeeb9', 'Z01A01A08',
  1, 0, 1, '25996', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 390
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25996');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2215261822014004449', '7864433525248941515', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7864433525248941515' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2515226393948293195', '26018', '桂赛', '74c807bc77c447be', '1d5e5bb8', 'Z01A01A08',
  1, 0, 1, '26018', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 400
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26018');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3789167240652587363', '2515226393948293195', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2515226393948293195' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3424554098568888278', '26034', '桂健', 'fdc79b98814f2b37', 'c0523245', 'Z01A01A08',
  1, 0, 1, '26034', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 410
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26034');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8626759402739434345', '3424554098568888278', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3424554098568888278' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8231887165127422236', '26088', '钟子豪', '54352c2a4dccc44d', '79133358', 'Z01A01A08',
  1, 0, 1, '26088', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 420
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26088');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2883784548975092190', '8231887165127422236', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8231887165127422236' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7198029032468125090', '26091', '刘子聪', '23ded197b40617bf', '3442356d', 'Z01A01A08',
  1, 0, 1, '26091', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 430
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26091');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9507440380546981178', '7198029032468125090', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7198029032468125090' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8154452122499276324', '26360', '邹仕亚', 'ca70a97e8eec1a34', 'ad034a46', 'Z01A01A08',
  1, 0, 1, '26360', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 440
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26360');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8841712012386367012', '8154452122499276324', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8154452122499276324' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4337241508442847566', '26969', '杜子安', 'fa12bcce9f40f7a4', '2cfa6117', 'Z01A01A08',
  1, 0, 1, '26969', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 450
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26969');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7930690076351399935', '4337241508442847566', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4337241508442847566' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4644139687082258458', '26977', '雷良友', '6daf1573ef3ee509', 'b2a55589', 'Z01A01A08',
  1, 0, 1, '26977', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 460
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26977');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3788379072279886092', '4644139687082258458', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4644139687082258458' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5638639925805608804', '26984', '张原纶', '34fab207f9bef14e', '790830d7', 'Z01A01A08',
  1, 0, 1, '26984', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 470
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26984');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6169743719011666440', '5638639925805608804', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5638639925805608804' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9024897765414041054', '27041', '仇峰', '6fcc19e332b56f5f', 'c90aacb0', 'Z01A01A08',
  1, 0, 1, '27041', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 480
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27041');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7700073664605606427', '9024897765414041054', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9024897765414041054' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8646463597110827040', '27042', '阮圣', 'c531640d056b79ae', '04ee23c2', 'Z01A01A08',
  1, 0, 1, '27042', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 490
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27042');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7638705528185635101', '8646463597110827040', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8646463597110827040' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5266073275442354019', '27154', '周汪洋', '62125092893b82bc', '7924e405', 'Z01A01A08',
  1, 0, 1, '27154', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 500
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27154');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5140399946922787861', '5266073275442354019', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5266073275442354019' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8779608149560798320', '27198', '陈海强', 'b64aa520064dd0a7', 'b116fc60', 'Z01A01A08',
  1, 0, 1, '27198', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 510
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27198');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9920239776802194847', '8779608149560798320', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8779608149560798320' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4438568250070476943', '27245', '韦梓冠', '74e37b1db0a2f91f', 'f25017cc', 'Z01A01A08',
  1, 0, 1, '27245', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 520
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27245');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2713742796411682189', '4438568250070476943', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4438568250070476943' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4181915339157321814', '27308', '农新平', 'd2cbb48bc87be243', '64516041', 'Z01A01A08',
  1, 0, 1, '27308', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 530
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27308');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3673523048999636960', '4181915339157321814', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4181915339157321814' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5324067491548545536', '27395', '王宇峻', 'f5f952b9958bb052', '6154a7cd', 'Z01A01A08',
  1, 0, 1, '27395', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 540
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27395');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3151434156978516082', '5324067491548545536', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5324067491548545536' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3615363761294170492', '27462', '刘小龙', '61a79c06cf70e78a', '0c090d88', 'Z01A01A08',
  1, 0, 1, '27462', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 550
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27462');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5461694262311374159', '3615363761294170492', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3615363761294170492' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9492583198852811604', '27463', '周嘉辉', 'b810af0988647b87', '6943bcd1', 'Z01A01A08',
  1, 0, 1, '27463', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 560
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27463');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1880763271628044230', '9492583198852811604', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9492583198852811604' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6976099124358046452', '27464', '李辉', '295d7a00aa18f9f3', '0d31305c', 'Z01A01A08',
  1, 0, 1, '27464', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 570
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27464');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9929673354208501710', '6976099124358046452', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6976099124358046452' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5825803353407017258', '27490', '徐阳', '2203f138858db8c3', 'a50af768', 'Z01A01A08',
  1, 0, 1, '27490', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 580
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27490');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9748817884396965374', '5825803353407017258', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5825803353407017258' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4540885842478977035', '27492', '朱嘉诚', '0e866dfd46360540', '360a4933', 'Z01A01A08',
  1, 0, 1, '27492', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 590
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27492');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6409364162195609068', '4540885842478977035', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4540885842478977035' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2861511736194385080', '27532', '陈腾鑫', '50d7276e04a508a0', 'f3937f69', 'Z01A01A08',
  1, 0, 1, '27532', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 600
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27532');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4462174046708921276', '2861511736194385080', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2861511736194385080' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4231018245659683348', '27573', '刘俊杰', '32562a4eb060bd2e', 'f769a99c', 'Z01A01A08',
  1, 0, 1, '27573', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 610
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27573');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9738097665104181381', '4231018245659683348', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4231018245659683348' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3792877500136938530', '27812', '王稣亮', '3cdb938ab86f7893', '9efbd276', 'Z01A01A08',
  1, 0, 1, '27812', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 620
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27812');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3044128754299613242', '3792877500136938530', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3792877500136938530' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9267158969330153737', '27825', '钟玉森', '33bcdee361888c7a', '8c2909eb', 'Z01A01A08',
  1, 0, 1, '27825', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 630
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27825');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9517725102509899523', '9267158969330153737', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9267158969330153737' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9310531480940034677', '27878', '李威', 'a67c55301b2142fe', '03e10d3d', 'Z01A01A08',
  1, 0, 1, '27878', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 640
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27878');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8445996507684840030', '9310531480940034677', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9310531480940034677' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6878312489652624583', '27879', '李昭雄', '14ff1354e8d4ff6f', '4bd6d52e', 'Z01A01A08',
  1, 0, 1, '27879', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习CNC铣工', 650
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27879');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6316068400111444555', '6878312489652624583', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6878312489652624583' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5737465979542437283', '27880', '安才华', '4adf3d5f6f103e02', '5abbb1df', 'Z01A01A08',
  1, 0, 1, '27880', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 660
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27880');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4073596872365063290', '5737465979542437283', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5737465979542437283' AND `dep_id` = '5481933028124165001'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8700227112055033578', '27887', '陈文凯', '76c5ca5042e0d34c', '2d99b0f7', 'Z01A01A08',
  1, 0, 1, '27887', 'admin', NOW(), 'admin', NOW(), 1, 0, 'CNC铣工', 670
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27887');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1368838314434499638', '8700227112055033578', '5481933028124165001'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8700227112055033578' AND `dep_id` = '5481933028124165001'
);


-- 组别：快走丝组 (Z01A01A09)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3882449581569797170', '03287', '胡轮丁', '48cee6147a1d774e', 'c526ddd9', 'Z01A01A09',
  1, 0, 1, '03287', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03287');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7370048984346579042', '3882449581569797170', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3882449581569797170' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1301611692151542832', '04733', '李福彦', '224b94bae0bbff2e', '753984f2', 'Z01A01A09',
  1, 0, 1, '04733', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04733');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2135607736827233712', '1301611692151542832', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1301611692151542832' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1377997602331096640', '07592', '潘忠文', 'af980a063c766012', 'c4678f31', 'Z01A01A09',
  1, 0, 1, '07592', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07592');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8661647281295818469', '1377997602331096640', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1377997602331096640' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1444714743188671374', '07864', '肖吉辉', 'd79257ae709aa728', '6c0cc435', 'Z01A01A09',
  1, 0, 1, '07864', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07864');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6241496133020035649', '1444714743188671374', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1444714743188671374' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5591298046047580750', '12710', '覃高俊', '8fba2d9bb99869ec', 'b73df3fc', 'Z01A01A09',
  1, 0, 1, '12710', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12710');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7851929961089618689', '5591298046047580750', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5591298046047580750' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7449119838165904942', '14081', '熊向文', 'e14b1ea926c7357c', '275fad4e', 'Z01A01A09',
  1, 0, 1, '14081', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14081');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9355490980257113343', '7449119838165904942', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7449119838165904942' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8036210519183874458', '25908', '郑小斌', 'c5073ae575b4c75a', '3186eafd', 'Z01A01A09',
  1, 0, 1, '25908', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25908');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5574321343137851623', '8036210519183874458', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8036210519183874458' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8582890767314171320', '26090', '余彬彬', '43e7d9b88ee26f71', 'e1b4bb4a', 'Z01A01A09',
  1, 0, 1, '26090', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26090');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9505502226120923033', '8582890767314171320', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8582890767314171320' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8818950271578881554', '26672', '黎栋', '33261e836692ca4a', 'ebd0d3d6', 'Z01A01A09',
  1, 0, 1, '26672', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26672');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2741901707402928603', '8818950271578881554', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8818950271578881554' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6846582589464891534', '26947', '包志伟', 'c839e27d4e9aa9d6', '6cd780d4', 'Z01A01A09',
  1, 0, 1, '26947', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26947');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7176714428004113025', '6846582589464891534', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6846582589464891534' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4495378646344829167', '26952', '黄家荣', '07939091751667c8', 'db645d06', 'Z01A01A09',
  1, 0, 1, '26952', 'admin', NOW(), 'admin', NOW(), 1, 0, '快走丝', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26952');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5304484818930419753', '4495378646344829167', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4495378646344829167' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9370399112519133505', '27398', '都文轩', '14306920981762f6', 'a6124c05', 'Z01A01A09',
  1, 0, 1, '27398', 'admin', NOW(), 'admin', NOW(), 1, 0, '见习中走丝', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27398');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6692486148920954273', '9370399112519133505', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9370399112519133505' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3009128915294760028', '27561', '邓爱平', 'ec64b68178fb517e', '99d3d478', 'Z01A01A09',
  1, 0, 1, '27561', 'admin', NOW(), 'admin', NOW(), 1, 0, '中走丝', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27561');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9554346707253075452', '3009128915294760028', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3009128915294760028' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3363422870375598124', '27804', '程开建', '5f6c734c6a6467dd', 'e6f956cf', 'Z01A01A09',
  1, 0, 1, '27804', 'admin', NOW(), 'admin', NOW(), 1, 0, '中走丝', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27804');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5304503197474791344', '3363422870375598124', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3363422870375598124' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1405122744608958191', '27889', '龚斌', 'c0ba518f287aebbe', '69020807', 'Z01A01A09',
  1, 0, 1, '27889', 'admin', NOW(), 'admin', NOW(), 1, 0, '中走丝', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27889');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4038494441471640194', '1405122744608958191', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1405122744608958191' AND `dep_id` = '7069757031299782892'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1351007037939263511', '27890', '周旭', 'c4cbd322935c0e1a', 'ba69970d', 'Z01A01A09',
  1, 0, 1, '27890', 'admin', NOW(), 'admin', NOW(), 1, 0, '中走丝', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27890');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1983977893357687433', '1351007037939263511', '7069757031299782892'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1351007037939263511' AND `dep_id` = '7069757031299782892'
);


-- 组别：管理组 (Z01A01A10)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7442059579153585588', '03801', '蒋光勇', '04cf57c4eb35bb48', '7affbdcd', 'Z01A01A10',
  1, 0, 1, '03801', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级经理', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03801');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1515752186978760955', '7442059579153585588', '8450948211545741294'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7442059579153585588' AND `dep_id` = '8450948211545741294'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3917301852458339989', '24861', '张旭明', '792321f330b9b8fa', '4127b730', 'Z01A01A10',
  1, 0, 1, '24861', 'admin', NOW(), 'admin', NOW(), 1, 0, '副经理', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24861');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3762195179380261139', '3917301852458339989', '8450948211545741294'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3917301852458339989' AND `dep_id` = '8450948211545741294'
);

