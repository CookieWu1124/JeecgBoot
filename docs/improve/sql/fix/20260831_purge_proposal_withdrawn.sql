-- =============================================================================
-- 增量：去掉 WITHDRAWN。开发库可清脏数据。
-- 库：inside_dev
-- 1) 删除已撤回提案及子表
-- 2) 删除 action=WITHDRAW 或 from/to 为 WITHDRAWN 的流转
-- =============================================================================

SET NAMES utf8mb4;

DELETE a
FROM `proposal_attachment` a
INNER JOIN `proposal` p ON a.`proposal_id` = p.`id`
WHERE p.`status` = 'WITHDRAWN';

DELETE a
FROM `proposal_application` a
INNER JOIN `proposal` p ON a.`proposal_id` = p.`id`
WHERE p.`status` = 'WITHDRAWN';

DELETE l
FROM `proposal_status_log` l
INNER JOIN `proposal` p ON l.`proposal_id` = p.`id`
WHERE p.`status` = 'WITHDRAWN';

DELETE r
FROM `proposal_committee_review` r
INNER JOIN `proposal` p ON r.`proposal_id` = p.`id`
WHERE p.`status` = 'WITHDRAWN';

DELETE a
FROM `proposal_approval` a
INNER JOIN `proposal` p ON a.`proposal_id` = p.`id`
WHERE p.`status` = 'WITHDRAWN';

DELETE FROM `proposal`
WHERE `status` = 'WITHDRAWN';

DELETE FROM `proposal_status_log`
WHERE `action` = 'WITHDRAW'
   OR `from_status` = 'WITHDRAWN'
   OR `to_status` = 'WITHDRAWN';
