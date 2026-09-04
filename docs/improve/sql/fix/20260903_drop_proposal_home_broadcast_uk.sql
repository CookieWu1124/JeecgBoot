-- -----------------------------------------------------------------------------
-- 去掉 proposal_home_broadcast.tenant_id 唯一键
-- 原因：保存策略为「旧 Y→N 再插新 Y」，软删行仍占 tenant_id，再保存会 Duplicate entry
-- 目标库：inside_dev（手工执行，幂等）
-- -----------------------------------------------------------------------------

SET @db := DATABASE();

SELECT COUNT(*) INTO @uk_exists
FROM information_schema.statistics
WHERE table_schema = @db
  AND table_name = 'proposal_home_broadcast'
  AND index_name = 'uk_proposal_home_broadcast_tenant';

SET @sql := IF(
  @uk_exists > 0,
  'ALTER TABLE `proposal_home_broadcast` DROP INDEX `uk_proposal_home_broadcast_tenant`',
  'SELECT ''uk_proposal_home_broadcast_tenant already dropped'' AS info'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
