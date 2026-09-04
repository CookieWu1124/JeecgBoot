-- =============================================================================
-- 增量：去掉申请书通知邮箱 proposal_application.email
-- 库：inside_dev（已有业务数据，勿整库重跑 proposal_init.sql）
-- 幂等：列不存在则跳过
-- =============================================================================

SET NAMES utf8mb4;

SET @col_exists := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'proposal_application'
    AND COLUMN_NAME = 'email'
);

SET @sql := IF(
  @col_exists > 0,
  'ALTER TABLE `proposal_application` DROP COLUMN `email`',
  'SELECT 1'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
