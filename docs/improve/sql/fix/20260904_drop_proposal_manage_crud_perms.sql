-- -----------------------------------------------------------------------------
-- 提案管理仅查询+详情：删除误留的添加/编辑/删除按钮权限
-- 目标库：inside_dev（手工执行，幂等）
-- 固定 id：2094103000000000004/5/6；perms：proposal:manage:add|edit|delete
-- -----------------------------------------------------------------------------

DELETE FROM `sys_role_permission`
WHERE `permission_id` IN (
  '2094103000000000004',
  '2094103000000000005',
  '2094103000000000006'
)
OR `permission_id` IN (
  SELECT `id` FROM (
    SELECT `id` FROM `sys_permission`
    WHERE `perms` IN (
      'proposal:manage:add',
      'proposal:manage:edit',
      'proposal:manage:delete'
    )
  ) t
);

DELETE FROM `sys_permission`
WHERE `id` IN (
  '2094103000000000004',
  '2094103000000000005',
  '2094103000000000006'
)
OR `perms` IN (
  'proposal:manage:add',
  'proposal:manage:edit',
  'proposal:manage:delete'
);
