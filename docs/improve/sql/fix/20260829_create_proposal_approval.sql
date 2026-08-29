-- =============================================================================
-- 增量：创建批准人决策表 proposal_approval（Phase 2 批准人申请决策）
-- 库：inside_dev（已有业务数据，勿整库重跑 proposal_init.sql）
-- 幂等：CREATE TABLE IF NOT EXISTS
-- =============================================================================

CREATE TABLE IF NOT EXISTS `proposal_approval` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `proposal_id` varchar(36) NOT NULL COMMENT '提案ID',
  `approver_id` varchar(36) NOT NULL COMMENT '批准人 sys_user.id',
  `stage` varchar(32) NOT NULL DEFAULT 'APPLICATION' COMMENT '阶段 APPLICATION/PLAN/SIGNOFF',
  `decision` varchar(16) NOT NULL COMMENT 'APPROVE/REJECT',
  `plan_required` tinyint(1) DEFAULT NULL COMMENT '核定是否形成计划书 0否1是（批准时）',
  `award_amount` decimal(10,2) DEFAULT NULL COMMENT '核定提案奖金额（批准时）',
  `comment` text COMMENT '不批准原因或备注',
  `approve_time` datetime DEFAULT NULL COMMENT '决策时间',
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
  UNIQUE KEY `uk_proposal_approval_stage` (`proposal_id`, `stage`, `tenant_id`),
  KEY `idx_proposal_approval_approver` (`approver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='批准人决策记录';
