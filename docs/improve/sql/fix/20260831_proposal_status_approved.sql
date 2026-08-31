-- =============================================================================
-- 增量：申请段批准后停在 APPROVED，不再写成 PENDING_ASSIGN
-- 库：inside_dev（阶段 2 未做，现网「待指派」均是申请批准结果）
-- 幂等：按 status 覆盖
-- =============================================================================

SET NAMES utf8mb4;

UPDATE `proposal`
SET `status` = 'APPROVED'
WHERE `status` = 'PENDING_ASSIGN';
