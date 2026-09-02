-- =============================================================================
-- 增量：提案模块 pr0p0sa* 字母自定义 id → JeecgBoot 19 位数字雪花 id
-- 库：已跑过旧版 proposal_init / proposal_menu 的环境（inside_dev 已执行）
-- 新环境：直接用已修正的 proposal_init.sql / proposal_menu.sql，无需本脚本
-- 幂等：按旧 id WHERE 更新；可重复执行
-- =============================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------------------------------
-- 1) 引用列先改
-- -----------------------------------------------------------------------------

-- sys_role_permission.permission_id（提案菜单/按钮）
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000001' WHERE `permission_id` = 'pr0p0sa3001menu000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000002' WHERE `permission_id` = 'pr0p0sa3002manage00000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000003' WHERE `permission_id` = 'pr0p0sa3003config000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000004' WHERE `permission_id` = 'pr0p0sa3004mgadd0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000005' WHERE `permission_id` = 'pr0p0sa3005mgedt0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000006' WHERE `permission_id` = 'pr0p0sa3006mgdel0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000007' WHERE `permission_id` = 'pr0p0sa3007cfdls0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000008' WHERE `permission_id` = 'pr0p0sa3008cfdld0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000009' WHERE `permission_id` = 'pr0p0sa3009cfcms0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000010' WHERE `permission_id` = 'pr0p0sa3010cfcmd0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000011' WHERE `permission_id` = 'pr0p0sa3011cfaps0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000012' WHERE `permission_id` = 'pr0p0sa3012cfapd0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000013' WHERE `permission_id` = 'pr0p0sa3013cfsds0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000014' WHERE `permission_id` = 'pr0p0sa3014cfsdd0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000015' WHERE `permission_id` = 'pr0p0sa3015cftys0000000000000001';
UPDATE `sys_role_permission` SET `permission_id` = '2094103000000000016' WHERE `permission_id` = 'pr0p0sa3016cftyd0000000000000001';

-- sys_role_permission.role_id / sys_user_role.role_id（提案角色）
UPDATE `sys_role_permission` SET `role_id` = '2094101000000000001' WHERE `role_id` = 'pr0p0sa1001committee000000000001';
UPDATE `sys_role_permission` SET `role_id` = '2094101000000000002' WHERE `role_id` = 'pr0p0sa1002approver000000000001';
UPDATE `sys_role_permission` SET `role_id` = '2094101000000000003' WHERE `role_id` = 'pr0p0sa1003deptleader00000000001';
UPDATE `sys_role_permission` SET `role_id` = '2094101000000000005' WHERE `role_id` = 'pr0p0sa1005admin0000000000000001';
UPDATE `sys_user_role` SET `role_id` = '2094101000000000001' WHERE `role_id` = 'pr0p0sa1001committee000000000001';
UPDATE `sys_user_role` SET `role_id` = '2094101000000000002' WHERE `role_id` = 'pr0p0sa1002approver000000000001';
UPDATE `sys_user_role` SET `role_id` = '2094101000000000003' WHERE `role_id` = 'pr0p0sa1003deptleader00000000001';
UPDATE `sys_user_role` SET `role_id` = '2094101000000000005' WHERE `role_id` = 'pr0p0sa1005admin0000000000000001';

-- sys_permission.parent_id
UPDATE `sys_permission` SET `parent_id` = '2094103000000000001' WHERE `parent_id` = 'pr0p0sa3001menu000000000000001';
UPDATE `sys_permission` SET `parent_id` = '2094103000000000002' WHERE `parent_id` = 'pr0p0sa3002manage00000000000001';
UPDATE `sys_permission` SET `parent_id` = '2094103000000000003' WHERE `parent_id` = 'pr0p0sa3003config000000000000001';

-- -----------------------------------------------------------------------------
-- 2) 主键
-- -----------------------------------------------------------------------------

UPDATE `sys_role` SET `id` = '2094101000000000001' WHERE `id` = 'pr0p0sa1001committee000000000001';
UPDATE `sys_role` SET `id` = '2094101000000000002' WHERE `id` = 'pr0p0sa1002approver000000000001';
UPDATE `sys_role` SET `id` = '2094101000000000003' WHERE `id` = 'pr0p0sa1003deptleader00000000001';
UPDATE `sys_role` SET `id` = '2094101000000000005' WHERE `id` = 'pr0p0sa1005admin0000000000000001';

UPDATE `proposal_score_dimension` SET `id` = '2094102000000000001' WHERE `id` = 'pr0p0sa2001tangible000000000001';
UPDATE `proposal_score_dimension` SET `id` = '2094102000000000002' WHERE `id` = 'pr0p0sa2002intangible00000000001';
UPDATE `proposal_score_dimension` SET `id` = '2094102000000000003' WHERE `id` = 'pr0p0sa2003difficulty00000000001';
UPDATE `proposal_score_dimension` SET `id` = '2094102000000000004' WHERE `id` = 'pr0p0sa2004thinking0000000000001';
UPDATE `proposal_score_dimension` SET `id` = '2094102000000000005' WHERE `id` = 'pr0p0sa2005spread000000000000001';
UPDATE `proposal_score_dimension` SET `id` = '2094102000000000006' WHERE `id` = 'pr0p0sa2006innovation000000000001';

UPDATE `proposal_improvement_type` SET `id` = '2094102100000000001' WHERE `id` = 'pr0p0sa2101safety00000000000001';
UPDATE `proposal_improvement_type` SET `id` = '2094102100000000002' WHERE `id` = 'pr0p0sa2102quality0000000000001';
UPDATE `proposal_improvement_type` SET `id` = '2094102100000000003' WHERE `id` = 'pr0p0sa2103efficiency0000000001';
UPDATE `proposal_improvement_type` SET `id` = '2094102100000000004' WHERE `id` = 'pr0p0sa2104delivery000000000001';
UPDATE `proposal_improvement_type` SET `id` = '2094102100000000005' WHERE `id` = 'pr0p0sa2105cost0000000000000001';

UPDATE `sys_permission` SET `id` = '2094103000000000001' WHERE `id` = 'pr0p0sa3001menu000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000002' WHERE `id` = 'pr0p0sa3002manage00000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000003' WHERE `id` = 'pr0p0sa3003config000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000004' WHERE `id` = 'pr0p0sa3004mgadd0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000005' WHERE `id` = 'pr0p0sa3005mgedt0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000006' WHERE `id` = 'pr0p0sa3006mgdel0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000007' WHERE `id` = 'pr0p0sa3007cfdls0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000008' WHERE `id` = 'pr0p0sa3008cfdld0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000009' WHERE `id` = 'pr0p0sa3009cfcms0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000010' WHERE `id` = 'pr0p0sa3010cfcmd0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000011' WHERE `id` = 'pr0p0sa3011cfaps0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000012' WHERE `id` = 'pr0p0sa3012cfapd0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000013' WHERE `id` = 'pr0p0sa3013cfsds0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000014' WHERE `id` = 'pr0p0sa3014cfsdd0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000015' WHERE `id` = 'pr0p0sa3015cftys0000000000000001';
UPDATE `sys_permission` SET `id` = '2094103000000000016' WHERE `id` = 'pr0p0sa3016cftyd0000000000000001';

SET FOREIGN_KEY_CHECKS = 1;
