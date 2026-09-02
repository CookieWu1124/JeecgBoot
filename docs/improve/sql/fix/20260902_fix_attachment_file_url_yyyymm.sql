-- -----------------------------------------------------------------------------
-- 提案附件历史路径补年月层：proposal/xxx → proposal/202609/xxx
-- 目标库：inside_dev（手工执行）
-- 幂等：已含 proposal/yyyyMM/ 的路径不改；可重复执行
-- 约定：biz = proposal/${yyyyMM}，本批历史统一归入 202609
-- -----------------------------------------------------------------------------

-- 1) 先看将要改动的行（执行 UPDATE 前核对）
SELECT
  id,
  proposal_id,
  file_name,
  file_url AS file_url_before,
  CONCAT('proposal/202609/', SUBSTRING_INDEX(REPLACE(file_url, '\\', '/'), '/', -1)) AS file_url_after
FROM `proposal_attachment`
WHERE `active` = 'Y'
  AND REPLACE(`file_url`, '\\', '/') REGEXP '^proposal/[^/]+$'
ORDER BY create_time;

-- 2) 正式修正（仅一层 proposal/文件名，不含年月）
UPDATE `proposal_attachment`
SET `file_url` = CONCAT(
       'proposal/202609/',
       SUBSTRING_INDEX(REPLACE(`file_url`, '\\', '/'), '/', -1)
     ),
    `update_time` = NOW()
WHERE `active` = 'Y'
  AND REPLACE(`file_url`, '\\', '/') REGEXP '^proposal/[^/]+$';

-- 3) 回查：不应再有「仅一层 proposal/文件名」的有效行
SELECT id, proposal_id, file_name, file_url
FROM `proposal_attachment`
WHERE `active` = 'Y'
  AND REPLACE(`file_url`, '\\', '/') REGEXP '^proposal/[^/]+$';
