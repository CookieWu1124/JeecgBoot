-- =============================================================================
-- 增量：创建委员审核快照表 proposal_committee_review（Phase 2 方案1）
-- 库：inside_dev（已有业务数据，勿整库重跑 proposal_init.sql）
-- 幂等：CREATE TABLE IF NOT EXISTS
-- =============================================================================

CREATE TABLE IF NOT EXISTS `proposal_committee_review` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `proposal_id` varchar(36) NOT NULL COMMENT '提案ID',
  `reviewer_id` varchar(36) NOT NULL COMMENT '委员 sys_user.id（提交时名册快照）',
  `conclusion` varchar(16) DEFAULT NULL COMMENT '审核结论 ADOPT/REJECT；未审为空',
  `plan_required` tinyint(1) DEFAULT NULL COMMENT '是否形成计划书建议（参考）0否1是',
  `award_suggestion` decimal(10,2) DEFAULT NULL COMMENT '建议奖励金额',
  `comment` text COMMENT '综合评价',
  `review_time` datetime DEFAULT NULL COMMENT '提交审核时间；未审为空',
  `create_no` varchar(50) DEFAULT NULL COMMENT '创建人工号',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_no` varchar(50) DEFAULT NULL COMMENT '更新人工号',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `sys_org_code` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `sys_org_name` varchar(300) DEFAULT NULL COMMENT '机构名称',
  `tenant_id` varchar(36) NOT NULL DEFAULT '' COMMENT '租户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` varchar(4) DEFAULT 'Y' COMMENT '是否有效(逻辑删除取反)：N-否，Y-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_proposal_committee_review` (`proposal_id`, `reviewer_id`, `tenant_id`),
  KEY `idx_proposal_committee_review_reviewer` (`reviewer_id`),
  KEY `idx_proposal_committee_review_pending` (`proposal_id`, `conclusion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='委员审核记录（申请阶段快照）';

-- 可选：为在途 PENDING_REVIEW 且尚无快照的提案补种（应用层 ensureReviewSnapshot 也会做）
-- 对提案 202608290001（贺志龙联调单）按当前在任委员插入未审行：
INSERT INTO `proposal_committee_review` (
  `id`, `proposal_id`, `reviewer_id`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  REPLACE(UUID(), '-', ''),
  p.`id`,
  m.`user_id`,
  'system', NOW(), 'system', NOW(), IFNULL(p.`tenant_id`, ''), 'Y'
FROM `proposal` p
INNER JOIN `proposal_committee_member` m ON m.`member_status` = 'active' AND m.`active` = 'Y'
WHERE p.`proposal_no` = '202608290001'
  AND p.`status` = 'PENDING_REVIEW'
  AND NOT EXISTS (
    SELECT 1 FROM `proposal_committee_review` r
    WHERE r.`proposal_id` = p.`id` AND r.`reviewer_id` = m.`user_id` AND r.`active` = 'Y'
  );
