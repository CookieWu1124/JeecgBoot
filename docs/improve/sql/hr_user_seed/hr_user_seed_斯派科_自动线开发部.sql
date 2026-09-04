-- =============================================================================
-- HR 员工种子 — 斯派科 / 自动线开发部
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
  '4903143322060904589', '4711055619678925456', '自动线开发部', 1, '2', 'DEPT', 'S01A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '4466515476478537401', '4903143322060904589', 'MES开发', 1, '2', 'GROUP', 'S01A01A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01A01');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '8606057906024241205', '4903143322060904589', '机械设计', 2, '2', 'GROUP', 'S01A01A02',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01A02');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '1170226073400411347', '4903143322060904589', '电气控制', 3, '2', 'GROUP', 'S01A01A03',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01A03');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '3896550949662337687', '4903143322060904589', '自动线开发部', 4, '2', 'GROUP', 'S01A01A04',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'S01A01A04');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：斯派科 / 自动线开发部
-- -----------------------------------------------------------------------------


-- 组别：MES开发 (S01A01A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8257136702766543954', '600013', '曾金', 'b29583d5f2ea2208', 'fa285c3b', 'S01A01A01',
  1, 0, 1, '600013', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级主管', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600013');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9174670928287961832', '8257136702766543954', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8257136702766543954' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6418151684503491683', '600026', '陈泽波', 'e00a29ffe7fbdf29', 'ff08f6c6', 'S01A01A01',
  1, 0, 1, '600026', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级MES开发工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600026');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4346788112858963981', '6418151684503491683', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6418151684503491683' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4370147561536834614', '600064', '杨奋', '03e6bf1d0660c4f6', 'db55c65e', 'S01A01A01',
  1, 0, 1, '600064', 'admin', NOW(), 'admin', NOW(), 1, 0, 'JAVA开发工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600064');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8304359057659689106', '4370147561536834614', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4370147561536834614' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5473839403978700019', '600065', '罗韦升', '6c2fad04835b0d91', '4fd745f9', 'S01A01A01',
  1, 0, 1, '600065', 'admin', NOW(), 'admin', NOW(), 1, 0, 'JAVA开发工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600065');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4570854222555491802', '5473839403978700019', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5473839403978700019' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1868826802789039513', '600069', '郑健辉', 'b40456abf53f9dc2', '3d364693', 'S01A01A01',
  1, 0, 1, '600069', 'admin', NOW(), 'admin', NOW(), 1, 0, 'MES开发工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600069');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7838199200385872032', '1868826802789039513', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1868826802789039513' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6226345226171716319', '600081', '贺志龙', '3a9adea74cbe8c79', 'd6e11223', 'S01A01A01',
  1, 0, 1, '600081', 'admin', NOW(), 'admin', NOW(), 1, 0, 'MES开发工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600081');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1355640115546322066', '6226345226171716319', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6226345226171716319' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7365249555217706900', '600089', '黄金杏', 'ae90e38193bd40d3', 'ba594972', 'S01A01A01',
  1, 0, 1, '600089', 'admin', NOW(), 'admin', NOW(), 1, 0, '前端工程师', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600089');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7125502477272075690', '7365249555217706900', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7365249555217706900' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9639638561159344932', '600090', '钟绍京', '2d7c3c26701e2208', 'be53f5f3', 'S01A01A01',
  1, 0, 1, '600090', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级软件工程师', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600090');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5396855757060458304', '9639638561159344932', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9639638561159344932' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5550721122278408930', '600096', '王辉', 'b4011cae9122b90e', '8e9335f0', 'S01A01A01',
  1, 0, 1, '600096', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级产品设计工程师', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600096');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7670848992954238174', '5550721122278408930', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5550721122278408930' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4044613531034576710', '600098', '李逸夫', 'ca08c7ea34871b96', '226f8910', 'S01A01A01',
  1, 0, 1, '600098', 'admin', NOW(), 'admin', NOW(), 1, 0, 'JAVA开发工程师', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600098');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8518035336970264172', '4044613531034576710', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4044613531034576710' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4161764525785232406', '600099', '吴浪', 'ef91f195dfa3a028', 'a7b4ddb3', 'S01A01A01',
  1, 0, 1, '600099', 'admin', NOW(), 'admin', NOW(), 1, 0, 'JAVA开发工程师', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600099');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1519019822872050788', '4161764525785232406', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4161764525785232406' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2146809448592750605', '600104', '钟俊华', '0de323eed425c376', 'c1842267', 'S01A01A01',
  1, 0, 1, '600104', 'admin', NOW(), 'admin', NOW(), 1, 0, '前端工程师', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600104');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4212219715972575385', '2146809448592750605', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2146809448592750605' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7397521048947971672', '600114', '袁路杨', '09617678445aff8f', '580ef83d', 'S01A01A01',
  1, 0, 1, '600114', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理前端工程师', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600114');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5728484285468658143', '7397521048947971672', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7397521048947971672' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9390597476789742954', '600116', '陈艳', 'ed57e2eb284dba9e', '34bee9ca', 'S01A01A01',
  1, 0, 1, '600116', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600116');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8325366419476285938', '9390597476789742954', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9390597476789742954' AND `dep_id` = '4466515476478537401'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2513938085893968538', '600117', '田枫', '7ddfcf874da1d6d5', '1c407ac0', 'S01A01A01',
  1, 0, 1, '600117', 'admin', NOW(), 'admin', NOW(), 1, 0, '实习生', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600117');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9916137099539801372', '2513938085893968538', '4466515476478537401'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2513938085893968538' AND `dep_id` = '4466515476478537401'
);


-- 组别：机械设计 (S01A01A02)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5255746008342767726', '600031', '郑小亮', '18cab77fcc5d1c36', '33941e06', 'S01A01A02',
  1, 0, 1, '600031', 'admin', NOW(), 'admin', NOW(), 1, 0, '机械工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600031');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9095410653520839918', '5255746008342767726', '8606057906024241205'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5255746008342767726' AND `dep_id` = '8606057906024241205'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7702646653649328065', '600036', '姜川', 'd2572aad7c87d499', '305d5028', 'S01A01A02',
  1, 0, 1, '600036', 'admin', NOW(), 'admin', NOW(), 1, 0, '机械工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600036');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2729102834228613654', '7702646653649328065', '8606057906024241205'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7702646653649328065' AND `dep_id` = '8606057906024241205'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5745892957046184667', '600054', '农忙业', '9730697d97dd4056', 'da200252', 'S01A01A02',
  1, 0, 1, '600054', 'admin', NOW(), 'admin', NOW(), 1, 0, '机械工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600054');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6512388544325680986', '5745892957046184667', '8606057906024241205'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5745892957046184667' AND `dep_id` = '8606057906024241205'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7305540115968858103', '600082', '郑西亮', '2aaa2d0eaf4bdfe2', 'a3df0833', 'S01A01A02',
  1, 0, 1, '600082', 'admin', NOW(), 'admin', NOW(), 1, 0, '机械工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600082');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1804731641902329356', '7305540115968858103', '8606057906024241205'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7305540115968858103' AND `dep_id` = '8606057906024241205'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2863638309953583823', '600085', '涂玉平', 'dd70b54cf14d5c0c', 'def32acf', 'S01A01A02',
  1, 0, 1, '600085', 'admin', NOW(), 'admin', NOW(), 1, 0, '机械工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600085');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2618385893943394247', '2863638309953583823', '8606057906024241205'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2863638309953583823' AND `dep_id` = '8606057906024241205'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4101418365454726353', '600105', '薛宝献', 'd94f2ef53b84643f', '81bd342c', 'S01A01A02',
  1, 0, 1, '600105', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级机械工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600105');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5558516114561236662', '4101418365454726353', '8606057906024241205'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4101418365454726353' AND `dep_id` = '8606057906024241205'
);


-- 组别：电气控制 (S01A01A03)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1599431100155229793', '600048', '莫际威', '0f7e4631d71bfaa5', '27d139a1', 'S01A01A03',
  1, 0, 1, '600048', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级软件工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600048');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6758844216884724566', '1599431100155229793', '1170226073400411347'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1599431100155229793' AND `dep_id` = '1170226073400411347'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5570858574554261787', '600051', '刘恋', 'c31694acb6446415', 'da3ab942', 'S01A01A03',
  1, 0, 1, '600051', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600051');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7729962861771848236', '5570858574554261787', '1170226073400411347'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5570858574554261787' AND `dep_id` = '1170226073400411347'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4238237560103936002', '600086', '谢杨锋', '41c9b069e40becc5', 'a1358e15', 'S01A01A03',
  1, 0, 1, '600086', 'admin', NOW(), 'admin', NOW(), 1, 0, '电气工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600086');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1828917914969694727', '4238237560103936002', '1170226073400411347'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4238237560103936002' AND `dep_id` = '1170226073400411347'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9520400105840116299', '600087', '温达威', 'dfb7504c9815c6d3', 'c132705b', 'S01A01A03',
  1, 0, 1, '600087', 'admin', NOW(), 'admin', NOW(), 1, 0, '软件工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600087');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5387004520112292304', '9520400105840116299', '1170226073400411347'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9520400105840116299' AND `dep_id` = '1170226073400411347'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4958620882465838297', '600088', '张小朋', '560f814530fed0a4', '965b93ae', 'S01A01A03',
  1, 0, 1, '600088', 'admin', NOW(), 'admin', NOW(), 1, 0, '主任工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600088');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2097985675321740283', '4958620882465838297', '1170226073400411347'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4958620882465838297' AND `dep_id` = '1170226073400411347'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3680277045015502848', '600101', '吴勇', 'baccc6c5d27b891c', '0103262c', 'S01A01A03',
  1, 0, 1, '600101', 'admin', NOW(), 'admin', NOW(), 1, 0, '机器人工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600101');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6876623663894337603', '3680277045015502848', '1170226073400411347'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3680277045015502848' AND `dep_id` = '1170226073400411347'
);


-- 组别：自动线开发部 (S01A01A04)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5806523750686508829', '600084', '汪秦军', '2453358a5476435b', 'caaad15f', 'S01A01A04',
  1, 0, 1, '600084', 'admin', NOW(), 'admin', NOW(), 1, 0, '副经理', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600084');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5262480390237367426', '5806523750686508829', '3896550949662337687'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5806523750686508829' AND `dep_id` = '3896550949662337687'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6000739198039453667', '600109', '刘静', 'b3416a4eb0f93f43', 'e26c8121', 'S01A01A04',
  1, 0, 1, '600109', 'admin', NOW(), 'admin', NOW(), 1, 0, '文员', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '600109');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2485079311767683716', '6000739198039453667', '3896550949662337687'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6000739198039453667' AND `dep_id` = '3896550949662337687'
);

