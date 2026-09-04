-- =============================================================================
-- 增量：去掉 DRAFT。开发库可清脏数据。
-- 库：inside_dev
-- 1) 删除仍停在草稿的提案及子表
-- 2) 已提交单据的流转：from_status=DRAFT 改为 NULL（发起即审核中，无上一态）
-- 3) 删除 to_status=DRAFT 的异常留痕
-- =============================================================================

SET NAMES utf8mb4;

DELETE a
FROM `proposal_attachment` a
INNER JOIN `proposal` p ON a.`proposal_id` = p.`id`
WHERE p.`status` = 'DRAFT';

DELETE a
FROM `proposal_application` a
INNER JOIN `proposal` p ON a.`proposal_id` = p.`id`
WHERE p.`status` = 'DRAFT';

DELETE l
FROM `proposal_status_log` l
INNER JOIN `proposal` p ON l.`proposal_id` = p.`id`
WHERE p.`status` = 'DRAFT';

DELETE r
FROM `proposal_committee_review` r
INNER JOIN `proposal` p ON r.`proposal_id` = p.`id`
WHERE p.`status` = 'DRAFT';

DELETE FROM `proposal`
WHERE `status` = 'DRAFT';

UPDATE `proposal_status_log`
SET `from_status` = NULL
WHERE `from_status` = 'DRAFT';

DELETE FROM `proposal_status_log`
WHERE `to_status` = 'DRAFT';
