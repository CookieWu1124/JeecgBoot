-- -----------------------------------------------------------------------------
-- 新增提案状态日志已读表 proposal_status_log_read
-- 目标库：inside_dev（手工执行）
-- 幂等：表已存在则跳过
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `proposal_status_log_read` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `user_id` varchar(36) NOT NULL COMMENT '读者 sys_user.id',
  `status_log_id` varchar(36) NOT NULL COMMENT 'proposal_status_log.id',
  `read_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '已读时间',
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
  UNIQUE KEY `uk_proposal_status_log_read` (`user_id`, `status_log_id`, `tenant_id`),
  KEY `idx_proposal_status_log_read_log` (`status_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提案状态日志已读（用户×日志）';
