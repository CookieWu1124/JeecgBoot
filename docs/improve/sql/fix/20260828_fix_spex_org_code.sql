-- =============================================================================
-- 修复：斯派科样例部门 org_code 不符合 Jeecg 优编码规则
-- 现象：/sys/sysDepart/queryByIds →「编码长度必须能被固定位数整除」
-- 原因：原编码 SPX(3)/SPX01(5)/SPX01A01(8) 非 3 的倍数；Jeecg 要求每级固定 3 位
-- 目标：S01 / S01A01 / S01A01A01 / S01A01A02（长度 3/6/9/9）
-- 库：inside_dev（已执行过旧种子的环境请手工执行本脚本）
-- =============================================================================

-- 1) 先改子节点，再改父节点（避免唯一索引冲突时的中间态）
UPDATE `sys_depart` SET `org_code` = 'S01A01A01' WHERE `id` = 'spexdeptgroupmes0000000000001' AND `org_code` = 'SPX01A01';
UPDATE `sys_depart` SET `org_code` = 'S01A01A02' WHERE `id` = 'spexdeptgroupelc0000000000001' AND `org_code` = 'SPX01A02';
UPDATE `sys_depart` SET `org_code` = 'S01A01'     WHERE `id` = 'spexdeptdept00000000000000001' AND `org_code` = 'SPX01';
UPDATE `sys_depart` SET `org_code` = 'S01'        WHERE `id` = 'spexdeptcenter000000000000001' AND `org_code` = 'SPX';

-- 2) 同步用户会话机构编码
UPDATE `sys_user` SET `org_code` = 'S01A01A01' WHERE `org_code` = 'SPX01A01';
UPDATE `sys_user` SET `org_code` = 'S01A01A02' WHERE `org_code` = 'SPX01A02';
UPDATE `sys_user` SET `org_code` = 'S01A01'     WHERE `org_code` = 'SPX01';
UPDATE `sys_user` SET `org_code` = 'S01'        WHERE `org_code` = 'SPX';

-- 自检
-- SELECT id, org_code, depart_name FROM sys_depart WHERE id LIKE 'spexdept%';
-- SELECT username, org_code FROM sys_user WHERE username LIKE '6000%';
