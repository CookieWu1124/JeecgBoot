-- =============================================================================
-- 增量：申请段取消暂存，清理未提交的 DRAFT
-- 后续更完整的清理（含已提交单据日志去草稿）见 20260831_purge_proposal_draft.sql
-- 库：inside_dev
-- 注意：会删除 status='DRAFT' 的提案及其申请书/附件/留痕（无审核快照）
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
