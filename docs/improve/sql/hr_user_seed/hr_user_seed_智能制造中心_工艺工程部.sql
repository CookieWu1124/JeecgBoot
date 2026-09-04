-- =============================================================================
-- HR 员工种子 — 智能制造中心 / 工艺工程部
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
  '9777480764943044420', '9372856559755238914', '工艺工程部', 9, '2', 'DEPT', 'Z01A09',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A09');

INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '9867480657585845358', '9777480764943044420', '工艺工程部', 1, '2', 'GROUP', 'Z01A09A01',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = 'Z01A09A01');


-- -----------------------------------------------------------------------------
-- 用户
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- 部门：智能制造中心 / 工艺工程部
-- -----------------------------------------------------------------------------


-- 组别：工艺工程部 (Z01A09A01)
INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3115866103284597815', '01707', '王华安', '6e0d5ce5fb8912ed', '3e3f5892', 'Z01A09A01',
  1, 0, 1, '01707', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级工艺工程师', 10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '01707');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3583428398778614609', '3115866103284597815', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3115866103284597815' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7618314102341316561', '02274', '黄学斌', '0439fd7eab800df4', '5565fb81', 'Z01A09A01',
  1, 0, 1, '02274', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级工艺工程师', 20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02274');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5554002770748082881', '7618314102341316561', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7618314102341316561' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4136536640502704557', '02928', '黄律安', '1bf79e0e1f3d0655', 'bfd48766', 'Z01A09A01',
  1, 0, 1, '02928', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '02928');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8123696091029428441', '4136536640502704557', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4136536640502704557' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3724619253414096107', '03190', '曾毅', '877041ecf6c41360', 'b073bb3f', 'Z01A09A01',
  1, 0, 1, '03190', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工艺工程师', 40
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03190');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5301517394572442454', '3724619253414096107', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3724619253414096107' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2913354352183011651', '03718', '吴海强', 'ec86ed3004915d70', 'd3a79949', 'Z01A09A01',
  1, 0, 1, '03718', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 50
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '03718');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7021515116095166070', '2913354352183011651', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2913354352183011651' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5333778899496021184', '04224', '熊晓伟', 'e72cb5df944f32f0', '4b0a6681', 'Z01A09A01',
  1, 0, 1, '04224', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 60
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '04224');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1309695988639091033', '5333778899496021184', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5333778899496021184' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6303163600701356437', '05427', '肖磊', 'ffbd8ca43479212a', 'd89c6067', 'Z01A09A01',
  1, 0, 1, '05427', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级工艺工程师', 70
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '05427');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1396696232019710061', '6303163600701356437', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6303163600701356437' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8317147928660953323', '06184', '李兵', 'a78f825bba39cfae', '9f2593d6', 'Z01A09A01',
  1, 0, 1, '06184', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级工艺工程师', 80
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '06184');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5275992528997421100', '8317147928660953323', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8317147928660953323' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3031794641121996642', '07514', '田小强', 'efc9dba2611e2f8a', 'a792b08f', 'Z01A09A01',
  1, 0, 1, '07514', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 90
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '07514');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6686423854880934216', '3031794641121996642', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3031794641121996642' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1261182631867165437', '09067', '帅金良', '896499ccaaf22f1c', '1598b3f1', 'Z01A09A01',
  1, 0, 1, '09067', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级经理', 100
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09067');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6694003735640144359', '1261182631867165437', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1261182631867165437' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7818861331688900603', '09623', '蒋朝晖', '74ecaefaa0660ccb', '1befb400', 'Z01A09A01',
  1, 0, 1, '09623', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺技术员', 110
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09623');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7212672192135718938', '7818861331688900603', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7818861331688900603' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7432496209937688317', '09870', '陈永丰', '0ce99558922dc16f', '93650b47', 'Z01A09A01',
  1, 0, 1, '09870', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 120
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '09870');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2841808450349167854', '7432496209937688317', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7432496209937688317' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1288224486737456501', '10787', '杨义', '2d733042e0010a9b', '259d43d8', 'Z01A09A01',
  1, 0, 1, '10787', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 130
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '10787');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1357479202445514391', '1288224486737456501', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1288224486737456501' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2871947529578221448', '11221', '温远振', '186d99a7c3e56337', '2d02cfc7', 'Z01A09A01',
  1, 0, 1, '11221', 'admin', NOW(), 'admin', NOW(), 1, 0, '表面处理工程师', 140
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11221');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9738985717450890568', '2871947529578221448', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2871947529578221448' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1958339684265502333', '11584', '李小平', '02630e255527d08c', '08538cf2', 'Z01A09A01',
  1, 0, 1, '11584', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级工艺工程师', 150
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '11584');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6609459415780741012', '1958339684265502333', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1958339684265502333' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1005599019210087498', '12924', '陈志仁', '54bda7c5892a1094', '5c35dcf2', 'Z01A09A01',
  1, 0, 1, '12924', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 160
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '12924');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9206754708689886258', '1005599019210087498', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1005599019210087498' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1200730590782971924', '14782', '刘军勇', '9fad63f193447b13', '7a5cfa51', 'Z01A09A01',
  1, 0, 1, '14782', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级工艺工程师', 170
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '14782');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4417194293050785590', '1200730590782971924', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1200730590782971924' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3078884577642829578', '16347', '黄镇平', '27ebf9d491e85989', '314cf184', 'Z01A09A01',
  1, 0, 1, '16347', 'admin', NOW(), 'admin', NOW(), 1, 0, '绘图员', 180
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16347');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '3057496498149259233', '3078884577642829578', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3078884577642829578' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6237672511555082853', '16606', '龙晓东', '229eecf00033f4ab', 'fc3405ab', 'Z01A09A01',
  1, 0, 1, '16606', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 190
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16606');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2089392396091708356', '6237672511555082853', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6237672511555082853' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4434334081443070120', '16932', '刘思康', '05f0bb4095660503', 'a60df601', 'Z01A09A01',
  1, 0, 1, '16932', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 200
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '16932');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1577868210458925475', '4434334081443070120', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4434334081443070120' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7198907611848914075', '22365', '韩国宏', 'bf8acc59299cf333', '132afd55', 'Z01A09A01',
  1, 0, 1, '22365', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工艺工程师', 210
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22365');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7054116540104081229', '7198907611848914075', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7198907611848914075' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '7792384779144968599', '22401', '石青源', '332c1d925313b0d3', '591788d0', 'Z01A09A01',
  1, 0, 1, '22401', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工艺工程师', 220
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '22401');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '2200270819006120875', '7792384779144968599', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '7792384779144968599' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9949709567446762552', '23294', '如仙古丽·亚森', 'e766baa180fb6718', '98fdac94', 'Z01A09A01',
  1, 0, 1, '23294', 'admin', NOW(), 'admin', NOW(), 1, 0, '文员', 230
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23294');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8885266092922599112', '9949709567446762552', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9949709567446762552' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1391277901600338452', '23797', '余敏', '251c002f7c706782', 'c15db794', 'Z01A09A01',
  1, 0, 1, '23797', 'admin', NOW(), 'admin', NOW(), 1, 0, '热处理工', 240
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '23797');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4702819247515119398', '1391277901600338452', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1391277901600338452' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1187653171127474535', '24435', '王少洋', 'f2234d239354b314', 'fc7cdff4', 'Z01A09A01',
  1, 0, 1, '24435', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 250
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24435');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5645987975037990876', '1187653171127474535', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1187653171127474535' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5721200949018201466', '24529', '李兵', '6d3c1fb2279b26dd', '428ac49c', 'Z01A09A01',
  1, 0, 1, '24529', 'admin', NOW(), 'admin', NOW(), 1, 0, '高级工艺工程师', 260
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24529');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4164602299415683427', '5721200949018201466', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5721200949018201466' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '8159351744172000105', '24635', '李皓', '5645bee7fe37de94', '2e3a7f7e', 'Z01A09A01',
  1, 0, 1, '24635', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 270
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24635');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6869886061133748752', '8159351744172000105', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '8159351744172000105' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4082477968977624295', '24901', '莫广升', '97b13dd5192a3668', '7e7ff508', 'Z01A09A01',
  1, 0, 1, '24901', 'admin', NOW(), 'admin', NOW(), 1, 0, '热处理工', 280
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24901');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4325799594180721664', '4082477968977624295', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4082477968977624295' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '9848654687424700167', '24912', '王林兴', 'ec90e7a85b297805', '8e9918f8', 'Z01A09A01',
  1, 0, 1, '24912', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 290
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24912');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1175165307692134470', '9848654687424700167', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '9848654687424700167' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '1935020043732780926', '24987', '李孙福', '710516dd2f8dd79b', '82e42500', 'Z01A09A01',
  1, 0, 1, '24987', 'admin', NOW(), 'admin', NOW(), 1, 0, '夹具设计工程师', 300
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '24987');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '1027010248931119681', '1935020043732780926', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '1935020043732780926' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5281228014767697753', '25347', '蒋聪', '7d86b0cf6887b9e0', '74bfea11', 'Z01A09A01',
  1, 0, 1, '25347', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 310
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25347');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4330282880837357149', '5281228014767697753', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5281228014767697753' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6120290095841133632', '25930', '曹础坚', 'b149b080589ab114', '25165e01', 'Z01A09A01',
  1, 0, 1, '25930', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 320
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '25930');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5846896607324830200', '6120290095841133632', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6120290095841133632' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3579148681717594381', '26401', '刘俊伟', 'e6cd45465b65e483', 'd6947362', 'Z01A09A01',
  1, 0, 1, '26401', 'admin', NOW(), 'admin', NOW(), 1, 0, '热处理工', 330
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '26401');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8912885376843246821', '3579148681717594381', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3579148681717594381' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '5602656988455999297', '27258', '黄容淼', 'c0418fd09c9a5731', '0db3945f', 'Z01A09A01',
  1, 0, 1, '27258', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工艺工程师', 340
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27258');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7773137778485625383', '5602656988455999297', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '5602656988455999297' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2411456459711557201', '27275', '何家荣', 'f4f6551aba664e56', '96b040da', 'Z01A09A01',
  1, 0, 1, '27275', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工艺工程师', 350
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27275');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '7882341139531465331', '2411456459711557201', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2411456459711557201' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '6055029483213383694', '27307', '吴志翔', 'bb8e865ab6428624', '002b4608', 'Z01A09A01',
  1, 0, 1, '27307', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工艺工程师', 360
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27307');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '4812210098175263065', '6055029483213383694', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '6055029483213383694' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2221938047895752109', '27418', '黎波', 'de5cbbcc556ff737', '7bd395a5', 'Z01A09A01',
  1, 0, 1, '27418', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工艺工程师', 370
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27418');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '5171167060819251809', '2221938047895752109', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2221938047895752109' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '4360551554455356990', '27440', '黄佳丽', '0529d9586b946ce2', 'ef9f456d', 'Z01A09A01',
  1, 0, 1, '27440', 'admin', NOW(), 'admin', NOW(), 1, 0, '助理工艺工程师', 380
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27440');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '8238652033756996528', '4360551554455356990', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '4360551554455356990' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '2849158606950399511', '27709', '许宁', '5567749992ca2cfc', '2ae663c1', 'Z01A09A01',
  1, 0, 1, '27709', 'admin', NOW(), 'admin', NOW(), 1, 0, '夹具设计工程师', 390
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27709');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '9165996520172849142', '2849158606950399511', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '2849158606950399511' AND `dep_id` = '9867480657585845358'
);

INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '3564985621861996074', '27716', '颜中兴', '58156445d3f85dff', '2d42806d', 'Z01A09A01',
  1, 0, 1, '27716', 'admin', NOW(), 'admin', NOW(), 1, 0, '工艺工程师', 400
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '27716');

INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '6025817012858943757', '3564985621861996074', '9867480657585845358'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '3564985621861996074' AND `dep_id` = '9867480657585845358'
);

