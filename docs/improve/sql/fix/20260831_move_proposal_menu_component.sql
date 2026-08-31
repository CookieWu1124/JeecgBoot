-- =============================================================================
-- 增量：管理端页面迁到 views/mes/proposal 后，纠偏 sys_permission.component
-- 库：inside_dev（已有菜单数据，勿整库重跑）
-- 幂等：按固定 id 覆盖；url 仍为 /proposal/**，仅改 component
-- =============================================================================

SET NAMES utf8mb4;

UPDATE `sys_permission`
SET `url` = '/proposal/manage', `component` = 'mes/proposal/manage/index'
WHERE `id` = 'pr0p0sa3002manage00000000000001';

UPDATE `sys_permission`
SET `url` = '/proposal/config', `component` = 'mes/proposal/config/index'
WHERE `id` = 'pr0p0sa3003config000000000000001';
