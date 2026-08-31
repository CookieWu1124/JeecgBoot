/**
 * 选人/选部门弹窗确认结果。
 * 不要取 values[0]：Jeecg 表格 preserveSelectedRowKeys 可能把打开时的旧 id 留在数组前面，
 * 取第一个会把旧用户写回保存字段，接口 200 但人没变。
 */
export function pickSingleSelection(
  options?: { label?: string; value?: unknown }[],
  values?: unknown[],
): { id?: string; label: string } {
  const option = Array.isArray(options) && options.length ? options[options.length - 1] : undefined;
  const fallback = Array.isArray(values) && values.length ? values[values.length - 1] : undefined;
  const raw = option?.value ?? fallback;
  const id = raw == null || raw === '' ? undefined : String(raw);
  const label = option?.label != null && option.label !== '' ? String(option.label) : '';
  return { id, label };
}
