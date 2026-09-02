-- =============================================================================
-- HR 全量重导 — 清理脚本（先执行，再 hr_user_seed_all.sql + proposal_config_seed.sql）
-- 目标库：inside_dev
-- 清理：旧 spex* 样例、S01/Z01 组织树、关联用户、微信绑定、proposal 业务/配置测试数据
-- =============================================================================

SET FOREIGN_KEY_CHECKS = 0;

-- proposal 业务子表（先子后父）
DELETE FROM `proposal_committee_review`;
DELETE FROM `proposal_approval`;
DELETE FROM `proposal_status_log_read`;
DELETE FROM `proposal_status_log`;
DELETE FROM `proposal_attachment`;
DELETE FROM `proposal_application`;
DELETE FROM `proposal`;

-- proposal 配置（联调名册，config seed 会重建）
DELETE FROM `proposal_dept_leader`;
DELETE FROM `proposal_committee_member`;
DELETE FROM `proposal_approver`;

-- 微信第三方绑定（样例/HR 导入用户）
DELETE sta FROM `sys_third_account` sta
INNER JOIN `sys_user` u ON u.id = sta.sys_user_id
WHERE u.id LIKE 'spexuser%'
   OR u.org_code LIKE 'S01%'
   OR u.org_code LIKE 'Z01%'
   OR u.username REGEXP '^600[0-9]{3}$';

-- 用户-部门关联
DELETE sud FROM `sys_user_depart` sud
INNER JOIN `sys_user` u ON u.id = sud.user_id
WHERE u.id LIKE 'spexuser%'
   OR u.org_code LIKE 'S01%'
   OR u.org_code LIKE 'Z01%'
   OR u.username REGEXP '^600[0-9]{3}$';

DELETE sud FROM `sys_user_depart` sud
INNER JOIN `sys_depart` d ON d.id = sud.dep_id
WHERE d.id LIKE 'spexdept%'
   OR d.org_code LIKE 'S01%'
   OR d.org_code LIKE 'Z01%';

-- 用户
DELETE FROM `sys_user`
WHERE id LIKE 'spexuser%'
   OR org_code LIKE 'S01%'
   OR org_code LIKE 'Z01%'
   OR username REGEXP '^600[0-9]{3}$';

-- 部门（先子后父：按 org_code 长度降序）
DELETE FROM `sys_depart`
WHERE id LIKE 'spexdept%'
   OR org_code LIKE 'S01%'
   OR org_code LIKE 'Z01%';

SET FOREIGN_KEY_CHECKS = 1;
