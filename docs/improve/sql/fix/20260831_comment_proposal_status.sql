-- =============================================================================
-- 增量：proposal.status 列注释标明非字典、由 Java 状态机维护；去掉 DEFAULT 'DRAFT'
-- =============================================================================

SET NAMES utf8mb4;

ALTER TABLE `proposal`
  MODIFY COLUMN `status` varchar(32) NOT NULL
  COMMENT '申请环节码，由 Java ProposalStatusEnum + ProposalStateMachine 维护；禁止用 sys_dict 字典映射，文案走 /proposal/meta/statuses 或行内 statusLabel';

ALTER TABLE `proposal_status_log`
  MODIFY COLUMN `from_status` varchar(32) DEFAULT NULL
  COMMENT '跳转前状态码，同 proposal.status，非字典';

ALTER TABLE `proposal_status_log`
  MODIFY COLUMN `to_status` varchar(32) NOT NULL
  COMMENT '跳转后状态码，同 proposal.status，非字典';

ALTER TABLE `proposal_status_log`
  MODIFY COLUMN `action` varchar(64) DEFAULT NULL
  COMMENT '动作编码，见 Java ProposalAction，非字典';
