#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""只读评估 hr_user_purge.sql 对 inside_dev 的影响"""
import pymysql

USER_WHERE = """(
  id LIKE 'spexuser%%' OR org_code LIKE 'S01%%' OR org_code LIKE 'Z01%%'
  OR username REGEXP '^600[0-9]{3}$'
)"""
USER_WHERE_U = USER_WHERE.replace("id LIKE", "u.id LIKE").replace(
    "org_code LIKE", "u.org_code LIKE"
).replace("username REGEXP", "u.username REGEXP")
DEPT_WHERE = """(id LIKE 'spexdept%%' OR org_code LIKE 'S01%%' OR org_code LIKE 'Z01%%')"""


def main() -> None:
    conn = pymysql.connect(
        host="47.107.78.177",
        port=3306,
        user="root",
        password="p@ssw0rd#",
        database="inside_dev",
        charset="utf8mb4",
        connect_timeout=15,
    )
    cur = conn.cursor()

    def q(sql: str, args=None):
        cur.execute(sql, args or ())
        return cur.fetchall()

    def section(title: str) -> None:
        print("\n" + "=" * 60)
        print(title)
        print("=" * 60)

    section("1. sys_user 总量与 purge 命中")
    total_users = q("SELECT COUNT(*) FROM sys_user WHERE del_flag=0")[0][0]
    purge_users = q(f"SELECT COUNT(*) FROM sys_user WHERE {USER_WHERE}")[0][0]
    remain_users = q(f"SELECT COUNT(*) FROM sys_user WHERE NOT {USER_WHERE}")[0][0]
    print(f"  有效用户总数: {total_users}")
    print(f"  purge 将删除: {purge_users}")
    print(f"  purge 后保留: {remain_users}")

    section("2. purge 将删除的用户（全部明细）")
    rows = q(
        f"SELECT username, realname, org_code, id FROM sys_user WHERE {USER_WHERE} ORDER BY username"
    )
    for r in rows:
        print(f"    {r[0]:12} {r[1]:12} org_code={r[2] or '(null)':12} id={r[3]}")

    section("3. 平台关键账号是否命中 purge")
    key_users = q(
        "SELECT username, realname, org_code FROM sys_user WHERE username IN ('admin','jeecg','test') OR username LIKE 'admin%%' ORDER BY username LIMIT 20"
    )
    for r in key_users:
        hit = q(
            f"SELECT COUNT(*) FROM sys_user WHERE username=%s AND {USER_WHERE}", (r[0],)
        )[0][0]
        print(
            f"    {r[0]:15} {r[1] or '':12} org_code={r[2] or '(null)':12} purge命中={'是' if hit else '否'}"
        )

    section("4. sys_depart 命中")
    purge_depts = q(f"SELECT COUNT(*) FROM sys_depart WHERE {DEPT_WHERE}")[0][0]
    remain_depts = q(f"SELECT COUNT(*) FROM sys_depart WHERE NOT {DEPT_WHERE}")[0][0]
    print(f"  purge 将删部门: {purge_depts}, 保留: {remain_depts}")
    print("  将删:")
    for r in q(
        f"SELECT org_code, depart_name, org_type FROM sys_depart WHERE {DEPT_WHERE} ORDER BY org_code"
    ):
        print(f"    {r[0]:15} {r[1]:30} {r[2]}")
    print("  保留样例 (Jeecg 默认组织等):")
    for r in q(
        f"SELECT org_code, depart_name, org_type FROM sys_depart WHERE NOT {DEPT_WHERE} ORDER BY org_code LIMIT 15"
    ):
        print(f"    {r[0]:15} {r[1]:30} {r[2]}")

    section("5. sys_third_account 命中")
    n = q(
        f"SELECT COUNT(*) FROM sys_third_account sta INNER JOIN sys_user u ON u.id=sta.sys_user_id WHERE {USER_WHERE_U}"
    )[0][0]
    print(f"  将删第三方绑定: {n}")
    for r in q(
        f"""SELECT u.username, u.realname, sta.third_type, sta.third_user_uuid
        FROM sys_third_account sta INNER JOIN sys_user u ON u.id=sta.sys_user_id
        WHERE {USER_WHERE_U} LIMIT 30"""
    ):
        print(f"    {r[0]} {r[1]} type={r[2]} uuid={r[3]}")

    section("6. proposal 表（purge 全清，与 Jeecg 平台无关）")
    for t in [
        "proposal",
        "proposal_application",
        "proposal_attachment",
        "proposal_status_log",
        "proposal_committee_review",
        "proposal_approval",
        "proposal_dept_leader",
        "proposal_committee_member",
        "proposal_approver",
    ]:
        c = q(f"SELECT COUNT(*) FROM `{t}`")[0][0]
        print(f"  {t}: {c}")

    section("7. 误伤风险：username=600xxx 用户")
    rows = q(
        "SELECT username, realname, org_code, id FROM sys_user WHERE username REGEXP '^600[0-9]{3}$' ORDER BY username"
    )
    print(f"  共 {len(rows)} 个 600xxx 账号（均为 HR 样例/待重导范围）")

    section("8. 误伤风险：org_code 以 S01/Z01 但非 spex 用户")
    rows = q(
        f"SELECT username, realname, org_code FROM sys_user WHERE (org_code LIKE 'S01%%' OR org_code LIKE 'Z01%%') AND id NOT LIKE 'spexuser%%'"
    )
    print(f"  命中: {len(rows)} (重导后由新 seed 覆盖)")

    section("9. purge 未清理但可能留孤儿的数据")
    for label, sql in [
        (
            "sys_user_role（purge 用户关联）",
            f"SELECT COUNT(*) FROM sys_user_role ur JOIN sys_user u ON u.id=ur.user_id WHERE {USER_WHERE_U}",
        ),
        (
            "sys_user_role（purge 部门关联 - 通过 dep）",
            f"SELECT COUNT(*) FROM sys_user_depart sud JOIN sys_depart d ON d.id=sud.dep_id WHERE {DEPT_WHERE.replace('id LIKE', 'd.id LIKE').replace('org_code LIKE', 'd.org_code LIKE')}",
        ),
        (
            "sys_user_tenant（若存在）",
            "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='inside_dev' AND table_name='sys_user_tenant'",
        ),
    ]:
        try:
            print(f"  {label}: {q(sql)[0][0]}")
        except Exception as e:
            print(f"  {label}: 查询失败 {e}")

    section("10. Jeecg 平台表（purge 脚本不涉及）")
    for t in ["sys_role", "sys_permission", "sys_role_permission", "sys_dict", "sys_dict_item"]:
        c = q(f"SELECT COUNT(*) FROM `{t}`")[0][0]
        print(f"  {t}: {c} 行 — 不删")

    section("11. purge 后将保留的用户")
    for r in q(
        f"SELECT username, realname, org_code, id FROM sys_user WHERE NOT {USER_WHERE} ORDER BY username"
    ):
        print(f"    {r[0]:15} {r[1] or '':12} org_code={r[2] or '(null)':12} id={r[3]}")

    section("12. proposal_init 种子表（purge 不删）")
    for t in ["proposal_improvement_type", "proposal_score_dimension"]:
        c = q(f"SELECT COUNT(*) FROM `{t}`")[0][0]
        print(f"  {t}: {c} 行 — 不删")

    if q("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='inside_dev' AND table_name='sys_user_tenant'")[0][0]:
        section("13. sys_user_tenant")
        cur.execute(
            f"""SELECT ut.*, u.username FROM sys_user_tenant ut
            LEFT JOIN sys_user u ON u.id=ut.user_id
            WHERE u.id IS NULL OR {USER_WHERE_U.replace('u.', 'u.')}"""
        )
        # simpler: count tenant rows for purge users
        n = q(
            f"""SELECT COUNT(*) FROM sys_user_tenant ut
            JOIN sys_user u ON u.id=ut.user_id WHERE {USER_WHERE_U}"""
        )[0][0]
        print(f"  purge 用户关联 tenant 行: {n} (purge 脚本未删，可能留孤儿)")

    conn.close()
    print("\n评估完成。")


if __name__ == "__main__":
    main()
