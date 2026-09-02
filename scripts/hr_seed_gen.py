#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Generate HR user seed SQL from 员工列表20260822.xls"""
from __future__ import annotations

import hashlib
import os
import re
import subprocess
import sys
from collections import OrderedDict, defaultdict
from pathlib import Path

import xlrd

ROOT = Path(__file__).resolve().parents[1]
EXCEL = ROOT / "docs/improve/data/员工列表20260822.xls"
SQL_DIR = ROOT / "docs/improve/sql"
SCRIPTS_DIR = ROOT / "scripts"
JAVA_CP = ROOT / "jeecg-boot/jeecg-boot-base-core/target/classes"

CENTER_PREFIX = {
    "斯派科": "S01",
    "智能制造中心": "Z01",
}

# proposal_config_seed: work_no -> (role config)
CONFIG_DEPT_LEADERS = [
    # (dept org_code path via center/dept/group, leader work_no, tenant_id)
    ("斯派科", "自动线开发部", "MES开发", "600013", ""),
    ("斯派科", "自动线开发部", None, "600084", "1000"),  # dept level - 汪秦军 org at dept
    ("斯派科", "自动线开发部", "电气控制", "600088", "1000"),
]
CONFIG_APPROVER = ("600084", "1000")
CONFIG_COMMITTEE = [
    ("600013", 1),
    ("600026", 2),
    ("600051", 3),
    ("600088", 4),
    ("600099", 5),
]

CONFIG_ROW_IDS = {
    "dept_leader": [
        "2093230938443452417",
        "2093235821527683074",
        "2093242996387995649",
    ],
    "approver": "2093245634517131265",
    "committee": [
        "2093246396064325634",
        "2093253983954526210",
        "2093254103479607297",
        "2093261056981327874",
        "2093261511924899842",
    ],
}


def make_id(kind: str, key: str) -> str:
    """Deterministic 19-digit numeric ID (Jeecg ASSIGN_ID style)."""
    h = hashlib.sha256(f"hr-seed-v1:{kind}:{key}".encode("utf-8")).digest()
    n = int.from_bytes(h[:8], "big") % 9_000_000_000_000_000_000
    return str(1_000_000_000_000_000_000 + n)


def safe_filename(center: str, dept: str) -> str:
    name = f"hr_user_seed_{center}_{dept}.sql"
    for ch in '<>:"/\\|?*':
        name = name.replace(ch, "_")
    return name


def sql_escape(s: str) -> str:
    return s.replace("\\", "\\\\").replace("'", "''")


def level_code(index: int) -> str:
    """Jeecg org_code segment: letter A-Z + 2-digit number 01-99."""
    letter = chr(ord("A") + (index - 1) // 99)
    num = ((index - 1) % 99) + 1
    return f"{letter}{num:02d}"


class PasswordCache:
    def __init__(self) -> None:
        self._cache: dict[tuple[str, str, str], str] = {}
        self._helper = SCRIPTS_DIR / "HrPasswordGen.java"
        self._compiled = False

    def encrypt(self, username: str, password: str, salt: str) -> str:
        key = (username, password, salt)
        if key not in self._cache:
            raise KeyError(f"Password not preloaded: {username}")
        return self._cache[key]

    def preload(self, items: list[tuple[str, str, str]]) -> None:
        if not items:
            return
        self._ensure_helper()
        classes = str(JAVA_CP)
        work = str(SCRIPTS_DIR)
        if not self._compiled:
            subprocess.run(
                ["javac", "-cp", classes, str(self._helper)],
                check=True,
                capture_output=True,
            )
            self._compiled = True
        payload = "\n".join("\t".join(x) for x in items) + "\n"
        out = subprocess.run(
            ["java", "-cp", f"{classes}{os.pathsep}{work}", "HrPasswordGen"],
            input=payload,
            check=True,
            capture_output=True,
            text=True,
        )
        hashes = [line.strip() for line in out.stdout.splitlines() if line.strip()]
        if len(hashes) != len(items):
            raise RuntimeError(f"Password batch mismatch: {len(hashes)} != {len(items)}")
        for item, digest in zip(items, hashes):
            self._cache[item] = digest

    def _ensure_helper(self) -> None:
        if self._helper.exists():
            return
        self._helper.write_text(
            """import org.jeecg.common.util.PasswordUtil;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class HrPasswordGen {
  public static void main(String[] args) throws Exception {
    if (args.length == 3) {
      System.out.print(PasswordUtil.encrypt(args[0], args[1], args[2]));
      return;
    }
    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in, "UTF-8"));
    String line;
    while ((line = reader.readLine()) != null) {
      if (line.isEmpty()) continue;
      String[] parts = line.split("\\t", 3);
      System.out.println(PasswordUtil.encrypt(parts[0], parts[1], parts[2]));
    }
  }
}
""",
            encoding="utf-8",
        )


def read_rows() -> list[dict]:
    wb = xlrd.open_workbook(str(EXCEL))
    sh = wb.sheet_by_index(0)
    rows = []
    for r in range(1, sh.nrows):
        def cell(c: int) -> str:
            v = sh.cell_value(r, c)
            if isinstance(v, float) and v == int(v):
                v = int(v)
            return str(v).strip()

        rows.append(
            {
                "work_no": cell(0),
                "realname": cell(1),
                "center": cell(2),
                "dept": cell(3),
                "group": cell(4),
                "position": cell(14),
            }
        )
    return rows


def build_org_tree(rows: list[dict]):
    centers: OrderedDict[str, OrderedDict[str, OrderedDict[str, list]]] = OrderedDict()
    for row in rows:
        c, d, g = row["center"], row["dept"], row["group"]
        centers.setdefault(c, OrderedDict())
        centers[c].setdefault(d, OrderedDict())
        centers[c][d].setdefault(g, [])
        centers[c][d][g].append(row)
    return centers


def assign_org_codes(centers) -> tuple[dict, dict, dict]:
    """Return center_meta, path->org_code, path->depart_id."""
    center_meta: dict[str, dict] = {}
    path_code: dict[tuple, str] = {}
    path_id: dict[tuple, str] = {}

    for center, depts in centers.items():
        prefix = CENTER_PREFIX[center]
        center_key = (center,)
        center_code = prefix
        center_id = make_id("depart", f"center:{center}")
        center_meta[center] = {
            "id": center_id,
            "org_code": center_code,
            "name": center,
            "org_type": "CENTER",
            "parent_id": None,
            "org_category": "1",
            "iz_leaf": 0,
            "depart_order": 90 if center == "斯派科" else 80,
        }
        path_code[center_key] = center_code
        path_id[center_key] = center_id

        for di, (dept, groups) in enumerate(depts.items(), start=1):
            dept_seg = level_code(di)
            dept_code = center_code + dept_seg
            dept_key = (center, dept)
            dept_id = make_id("depart", f"dept:{center}:{dept}")
            path_code[dept_key] = dept_code
            path_id[dept_key] = dept_id
            center_meta.setdefault("_depts", {})[dept_key] = {
                "id": dept_id,
                "org_code": dept_code,
                "name": dept,
                "org_type": "DEPT",
                "parent_id": center_id,
                "org_category": "2",
                "iz_leaf": 0,
                "depart_order": di,
            }

            for gi, (group, users) in enumerate(groups.items(), start=1):
                group_seg = level_code(gi)
                group_code = dept_code + group_seg
                group_key = (center, dept, group)
                group_id = make_id("depart", f"group:{center}:{dept}:{group}")
                path_code[group_key] = group_code
                path_id[group_key] = group_id
                center_meta.setdefault("_groups", {})[group_key] = {
                    "id": group_id,
                    "org_code": group_code,
                    "name": group,
                    "org_type": "GROUP",
                    "parent_id": dept_id,
                    "org_category": "2",
                    "iz_leaf": 1,
                    "depart_order": gi,
                    "users": users,
                }
    return center_meta, path_code, path_id


def emit_depart_insert(meta: dict) -> str:
    parent = "NULL" if meta["parent_id"] is None else f"'{meta['parent_id']}'"
    return f"""INSERT INTO `sys_depart` (
  `id`, `parent_id`, `depart_name`, `depart_order`, `org_category`, `org_type`, `org_code`,
  `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `iz_leaf`
)
SELECT
  '{meta["id"]}', {parent}, '{sql_escape(meta["name"])}', {meta["depart_order"]}, '{meta["org_category"]}', '{meta["org_type"]}', '{meta["org_code"]}',
  '1', '0', 'admin', NOW(), 'admin', NOW(), 0, {meta["iz_leaf"]}
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = '{meta["org_code"]}');

"""


def emit_user_insert(row: dict, user_id: str, org_code: str, pwd: PasswordCache, sort_no: int) -> str:
    username = row["work_no"]
    salt = hashlib.md5(f"hr-salt:{username}".encode()).hexdigest()[:8]
    password = pwd.encrypt(username, "123456", salt)
    user_identity = 2 if row.get("_dept_level") else 1
    return f"""INSERT INTO `sys_user` (
  `id`, `username`, `realname`, `password`, `salt`, `org_code`, `status`, `del_flag`,
  `activiti_sync`, `work_no`, `create_by`, `create_time`, `update_by`, `update_time`,
  `user_identity`, `login_tenant_id`, `position_type`, `sort`
)
SELECT
  '{user_id}', '{sql_escape(username)}', '{sql_escape(row["realname"])}', '{password}', '{salt}', '{org_code}',
  1, 0, 1, '{sql_escape(username)}', 'admin', NOW(), 'admin', NOW(), {user_identity}, 0, '{sql_escape(row["position"])}', {sort_no}
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '{sql_escape(username)}');

"""


def emit_user_depart(user_id: str, dep_id: str) -> str:
    rel_id = make_id("user_depart", f"{user_id}:{dep_id}")
    return f"""INSERT INTO `sys_user_depart` (`ID`, `user_id`, `dep_id`)
SELECT '{rel_id}', '{user_id}', '{dep_id}'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `sys_user_depart` WHERE `user_id` = '{user_id}' AND `dep_id` = '{dep_id}'
);

"""


def build_section_header(title: str) -> str:
    return f"\n-- {'-' * 77}\n-- {title}\n-- {'-' * 77}\n\n"


def generate_org_and_users_for_dept(
    center: str,
    dept: str,
    groups: OrderedDict,
    path_id: dict,
    path_code: dict,
    pwd: PasswordCache,
) -> list[str]:
    lines: list[str] = []
    center_meta_key = (center,)
    dept_key = (center, dept)

    # center node only in all file / first dept file - handled externally
    lines.append(build_section_header(f"部门：{center} / {dept}"))

    for group, users in groups.items():
        group_key = (center, dept, group)
        gcode = path_code[group_key]
        gid = path_id[group_key]
        lines.append(f"\n-- 组别：{group} ({gcode})\n")
        for i, row in enumerate(users, start=1):
            uid = make_id("user", row["work_no"])
            sort_no = i * 10
            lines.append(emit_user_insert(row, uid, gcode, pwd, sort_no))
            lines.append(emit_user_depart(uid, gid))
    return lines


def generate_purge_sql() -> str:
    return """-- =============================================================================
-- HR 全量重导 — 清理脚本（先执行，再 hr_user_seed_all.sql + proposal_config_seed.sql）
-- 目标库：inside_dev
-- 清理：旧 spex* 样例、S01/Z01 组织树、关联用户、微信绑定、proposal 业务/配置测试数据
-- =============================================================================

SET FOREIGN_KEY_CHECKS = 0;

-- proposal 业务子表（先子后父）
DELETE FROM `proposal_committee_review`;
DELETE FROM `proposal_approval`;
DELETE FROM `proposal_status_log`;
DELETE FROM `proposal_attachment`;
DELETE FROM `proposal_application`;
DELETE FROM `proposal`;

-- proposal 配置（联调名册，config seed 会重建）
DELETE FROM `proposal_dept_leader`;
DELETE FROM `proposal_committee_member`;
DELETE FROM `proposal_approver`;

-- 微信第三方绑定（样例/HR 导入用户）
DELETE sta FROM `sys_third_account` sta
INNER JOIN `sys_user` u ON u.id = sta.sys_user_id
WHERE u.id LIKE 'spexuser%'
   OR u.org_code LIKE 'S01%'
   OR u.org_code LIKE 'Z01%'
   OR u.username REGEXP '^600[0-9]{3}$';

-- 用户-部门关联
DELETE sud FROM `sys_user_depart` sud
INNER JOIN `sys_user` u ON u.id = sud.user_id
WHERE u.id LIKE 'spexuser%'
   OR u.org_code LIKE 'S01%'
   OR u.org_code LIKE 'Z01%'
   OR u.username REGEXP '^600[0-9]{3}$';

DELETE sud FROM `sys_user_depart` sud
INNER JOIN `sys_depart` d ON d.id = sud.dep_id
WHERE d.id LIKE 'spexdept%'
   OR d.org_code LIKE 'S01%'
   OR d.org_code LIKE 'Z01%';

-- 用户
DELETE FROM `sys_user`
WHERE id LIKE 'spexuser%'
   OR org_code LIKE 'S01%'
   OR org_code LIKE 'Z01%'
   OR username REGEXP '^600[0-9]{3}$';

-- 部门（先子后父：按 org_code 长度降序）
DELETE FROM `sys_depart`
WHERE id LIKE 'spexdept%'
   OR org_code LIKE 'S01%'
   OR org_code LIKE 'Z01%';

SET FOREIGN_KEY_CHECKS = 1;
"""


def resolve_org_code(path_code: dict, center: str, dept: str, group: str | None) -> str:
    if group:
        return path_code[(center, dept, group)]
    return path_code[(center, dept)]


def generate_config_seed(path_code: dict) -> str:
    lines = [
        """-- =============================================================================
-- 提案改善 — 联调配置种子（部门负责人 / 委员会 / 批准人）
-- 数据来源：inside_dev 管理端实配（2026-08-28 导出对齐）
-- 前置：已执行 proposal_init.sql、hr_user_seed_all.sql
-- 特性：幂等（WHERE NOT EXISTS）；人员/部门通过 work_no、org_code 子查询解析 ID
-- -----------------------------------------------------------------------------
-- 约定：
""",
    ]
    for item in CONFIG_DEPT_LEADERS:
        center, dept, group, work_no, tenant = item
        tenant_label = tenant if tenant else "''"
        if group:
            lines.append(f"--   部门负责人 {center}/{dept}/{group} → {work_no} (tenant={tenant_label})\n")
        else:
            lines.append(f"--   部门负责人 {center}/{dept} → {work_no} (tenant={tenant_label})\n")
    lines.append(f"--   批准人：{CONFIG_APPROVER[0]}\n")
    lines.append("--   委员会 5 席：" + ", ".join(w for w, _ in CONFIG_COMMITTEE) + "\n")
    lines.append("-- =============================================================================\n\n")

    for i, (center, dept, group, work_no, tenant) in enumerate(CONFIG_DEPT_LEADERS):
        org_code = resolve_org_code(path_code, center, dept, group)
        tid = f"'{tenant}'" if tenant else "''"
        row_id = CONFIG_ROW_IDS["dept_leader"][i]
        tenant_cond = f"`tenant_id` = {tid}"
        lines.append(f"""-- 部门负责人：{center} / {dept}{f' / {group}' if group else ''} → {work_no}
INSERT INTO `proposal_dept_leader` (
  `id`, `dept_id`, `leader_user_id`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '{row_id}',
  (SELECT `id` FROM `sys_depart` WHERE `org_code` = '{org_code}' LIMIT 1),
  (SELECT `id` FROM `sys_user` WHERE `username` = '{work_no}' LIMIT 1),
  '管理员', NOW(), '管理员', NOW(), {tid}, 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_dept_leader`
  WHERE `dept_id` = (SELECT `id` FROM `sys_depart` WHERE `org_code` = '{org_code}' LIMIT 1)
    AND {tenant_cond}
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '{work_no}')
AND EXISTS (SELECT 1 FROM `sys_depart` WHERE `org_code` = '{org_code}');

""")

    work_no, tenant = CONFIG_APPROVER
    lines.append(f"""-- 批准人：{work_no}
INSERT INTO `proposal_approver` (
  `id`, `user_id`, `approver_status`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '{CONFIG_ROW_IDS["approver"]}',
  (SELECT `id` FROM `sys_user` WHERE `username` = '{work_no}' LIMIT 1),
  'active',
  '管理员', NOW(), '管理员', NOW(), '{tenant}', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_approver`
  WHERE `user_id` = (SELECT `id` FROM `sys_user` WHERE `username` = '{work_no}' LIMIT 1)
    AND `tenant_id` = '{tenant}' AND `active` = 'Y'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '{work_no}');

""")

    lines.append("\n-- 委员会成员（5 席，均参与评分）\n")
    for i, (work_no, seat) in enumerate(CONFIG_COMMITTEE):
        row_id = CONFIG_ROW_IDS["committee"][i]
        lines.append(f"""INSERT INTO `proposal_committee_member` (
  `id`, `user_id`, `score_enabled`, `seat_no`, `member_status`, `sort_no`,
  `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`, `active`
)
SELECT
  '{row_id}',
  (SELECT `id` FROM `sys_user` WHERE `username` = '{work_no}' LIMIT 1),
  1, {seat}, 'active', 0,
  '管理员', NOW(), '管理员', NOW(), '1000', 'Y'
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM `proposal_committee_member`
  WHERE `user_id` = (SELECT `id` FROM `sys_user` WHERE `username` = '{work_no}' LIMIT 1)
    AND `tenant_id` = '1000'
)
AND EXISTS (SELECT 1 FROM `sys_user` WHERE `username` = '{work_no}');

""")

    return "".join(lines)


def main() -> int:
    if not EXCEL.exists():
        print(f"Excel not found: {EXCEL}", file=sys.stderr)
        return 1
    if not JAVA_CP.exists():
        print(f"Compile jeecg-boot-base-core first: {JAVA_CP}", file=sys.stderr)
        return 1

    print("Reading Excel...")
    rows = read_rows()
    print(f"  {len(rows)} employees")

    centers = build_org_tree(rows)
    _, path_code, path_id = assign_org_codes(centers)

    print("Generating password hashes (Java PasswordUtil batch)...")
    pwd = PasswordCache()
    pwd_items = []
    for row in rows:
        username = row["work_no"]
        salt = hashlib.md5(f"hr-salt:{username}".encode()).hexdigest()[:8]
        pwd_items.append((username, "123456", salt))
    pwd.preload(pwd_items)

    SQL_DIR.mkdir(parents=True, exist_ok=True)
    split_dir = SQL_DIR / "hr_user_seed"
    split_dir.mkdir(exist_ok=True)

    # purge
    purge_path = SQL_DIR / "hr_user_purge.sql"
    purge_path.write_text(generate_purge_sql(), encoding="utf-8")
    print(f"Wrote {purge_path}")

    # config seed
    config_path = SQL_DIR / "proposal_config_seed.sql"
    config_path.write_text(generate_config_seed(path_code), encoding="utf-8")
    print(f"Wrote {config_path}")

    # all file
    all_lines = [
        """-- =============================================================================
-- HR 员工全量种子 — 全部 1355 人 + 组织树（2 中心 / 17 部门 / 83 组别）
-- 来源：docs/improve/data/员工列表20260822.xls
-- 目标库：inside_dev
-- 约定：username=work_no；初始密码 123456（Jeecg PasswordUtil）；org_code 斯派科 S01* / 智能制造中心 Z01*
-- 特性：幂等（WHERE NOT EXISTS）；ID 为 19 位数字（确定性生成）
-- 前置：建议先执行 hr_user_purge.sql
-- =============================================================================
""",
        build_section_header("一、组织树 sys_depart"),
    ]

    for center, depts in centers.items():
        cmeta = {
            "id": path_id[(center,)],
            "org_code": path_code[(center,)],
            "name": center,
            "org_type": "CENTER",
            "parent_id": None,
            "org_category": "1",
            "iz_leaf": 0,
            "depart_order": 90 if center == "斯派科" else 80,
        }
        all_lines.append(f"\n-- 中心：{center} ({cmeta['org_code']})\n")
        all_lines.append(emit_depart_insert(cmeta))
        for di, (dept, groups) in enumerate(depts.items(), start=1):
            dept_key = (center, dept)
            dmeta = {
                "id": path_id[dept_key],
                "org_code": path_code[dept_key],
                "name": dept,
                "org_type": "DEPT",
                "parent_id": path_id[(center,)],
                "org_category": "2",
                "iz_leaf": 0,
                "depart_order": di,
            }
            all_lines.append(f"\n-- 部门：{dept} ({dmeta['org_code']})\n")
            all_lines.append(emit_depart_insert(dmeta))
            for gi, (group, _) in enumerate(groups.items(), start=1):
                group_key = (center, dept, group)
                gmeta = {
                    "id": path_id[group_key],
                    "org_code": path_code[group_key],
                    "name": group,
                    "org_type": "GROUP",
                    "parent_id": path_id[dept_key],
                    "org_category": "2",
                    "iz_leaf": 1,
                    "depart_order": gi,
                }
                all_lines.append(f"\n-- 组别：{group} ({gmeta['org_code']})\n")
                all_lines.append(emit_depart_insert(gmeta))

    all_lines.append(build_section_header("二、用户 sys_user + sys_user_depart"))
    for center, depts in centers.items():
        for dept, groups in depts.items():
            all_lines.extend(generate_org_and_users_for_dept(center, dept, groups, path_id, path_code, pwd))

    all_path = SQL_DIR / "hr_user_seed_all.sql"
    all_path.write_text("".join(all_lines), encoding="utf-8")
    print(f"Wrote {all_path} ({all_path.stat().st_size // 1024} KB)")

    # split files by center+dept
    for center, depts in centers.items():
        for dept, groups in depts.items():
            fname = safe_filename(center, dept)
            part_lines = [
                f"""-- =============================================================================
-- HR 员工种子 — {center} / {dept}
-- 来源：docs/improve/data/员工列表20260822.xls（按中心+部门拆分）
-- 全量见 hr_user_seed_all.sql；幂等可重复执行
-- =============================================================================
""",
            ]
            # include org nodes for this branch
            part_lines.append(build_section_header("组织树（本部门分支）"))
            cmeta = {
                "id": path_id[(center,)],
                "org_code": path_code[(center,)],
                "name": center,
                "org_type": "CENTER",
                "parent_id": None,
                "org_category": "1",
                "iz_leaf": 0,
                "depart_order": 90 if center == "斯派科" else 80,
            }
            part_lines.append(emit_depart_insert(cmeta))
            dept_key = (center, dept)
            dmeta = {
                "id": path_id[dept_key],
                "org_code": path_code[dept_key],
                "name": dept,
                "org_type": "DEPT",
                "parent_id": path_id[(center,)],
                "org_category": "2",
                "iz_leaf": 0,
                "depart_order": list(depts.keys()).index(dept) + 1,
            }
            part_lines.append(emit_depart_insert(dmeta))
            for gi, (group, _) in enumerate(groups.items(), start=1):
                group_key = (center, dept, group)
                gmeta = {
                    "id": path_id[group_key],
                    "org_code": path_code[group_key],
                    "name": group,
                    "org_type": "GROUP",
                    "parent_id": path_id[dept_key],
                    "org_category": "2",
                    "iz_leaf": 1,
                    "depart_order": gi,
                }
                part_lines.append(emit_depart_insert(gmeta))

            part_lines.append(build_section_header("用户"))
            part_lines.extend(generate_org_and_users_for_dept(center, dept, groups, path_id, path_code, pwd))

            out = split_dir / fname
            out.write_text("".join(part_lines), encoding="utf-8")
            print(f"Wrote {out.name}")

    # stats
    dept_count = sum(len(depts) for depts in centers.values())
    group_count = sum(len(groups) for depts in centers.values() for groups in depts.values())
    print(f"\nDone: {len(centers)} centers, {dept_count} depts, {group_count} groups, {len(rows)} users")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
