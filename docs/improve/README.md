# 提案改善系统 — 资料目录

> 本目录集中存放提案改善业务的规划文档、原型、样例数据与 SQL 脚本，供开发与 Cursor AI 编码参考。

## 目录结构

```text
docs/improve/
├── README.md                      # 本文件（入口索引）
├── 提案改善系统-实施规划.md         # 主规划文档（V1.8，PRD + 技术方案 + 分阶段计划）
├── 移动端本地联调指南.md            # 后端开发者移动端/H5/Apifox 联调教程
├── 微信开发者工具-小程序联调教程.md  # 从安装开发者工具到测通微信授权登录（0-1）
├── 微信授权登录-生命周期脉络.md      # 从注册微信到 bind 的通俗时间线（复习用）
├── 微信小程序登录-其他模块接入.md    # 公共 /sys/wxMini 如何给其他业务复用
├── assets/                        # 归档图、示意图（非代码生成物）
│   └── wechat-login/             # 登录绑定流程图（产品参考，波哥 spexSys 资料）
├── api/                           # 对外/跨端接口对接文档
│   ├── 提案小程序-接口对接清单.md   # 申请段：发给 App 前端同事的接口清单
│   └── 提案管理端-接口对接清单.md   # 申请段：发给 Vue3 管理端同事的接口清单
├── progress/                      # 四段业务开发进度追踪（状态/API/页面/验收）
│   ├── README.md                  # 进度索引
│   ├── 01_application_DEV_PROGRESS.md
│   ├── 02_task_assignment_DEV_PROGRESS.md
│   ├── 03_plan_DEV_PROGRESS.md
│   └── 04_report_DEV_PROGRESS.md
├── prototype/
│   ├── improveSys.html            # 小程序端交互原型（V4.3）
│   └── index.html                 # 管理端原型（仅关注「提案改善」菜单）
├── data/
│   ├── README.md                  # HR 导入字段说明与映射规则
│   ├── HR字段落库映射.md           # Excel 18 列 ↔ sys_depart/sys_user 完整映射（归档）
│   └── 员工列表20260822.xls       # HR 人员结构表（真实数据，注意隐私）
└── sql/
    └── proposal_init.sql          # Phase 1 数据库初始化（手工执行，不用 Flyway）
```

## 发给前端同事（对接包）

两份清单互相独立，按端各发一份即可；不必把整个 `docs/improve` 打包。

| 同事 | 必发 | 按需附上 |
|------|------|----------|
| spex-app / 小程序 | `api/提案小程序-接口对接清单.md` | `微信开发者工具-小程序联调教程.md`（要测微信授权时） |
| jeecgboot-vue3 管理端 | `api/提案管理端-接口对接清单.md` | — |
| 其它业务复用同一套微信登录 | `微信小程序登录-其他模块接入.md` | 小程序清单 §3 A1a/A1b；产品流程图见 `assets/wechat-login/` |

---

## 阅读顺序（建议）

1. **实施规划** → `提案改善系统-实施规划.md`：业务规则、状态机、角色矩阵、API、分阶段计划
2. **分段进度** → `progress/README.md`：按申请单/任务分配/计划书/报告书追踪开发
3. **小程序接口对接** → `api/提案小程序-接口对接清单.md`：**发给 App 前端同事**的申请段接口清单（字段/示例/账号）
4. **管理端接口对接** → `api/提案管理端-接口对接清单.md`：**发给 Vue3 同事**的提案管理 + 五 Tab 配置清单
5. **移动端联调** → `移动端本地联调指南.md`：Apifox / **spex-app H5**；微信授权登录见下一篇
6. **微信开发者工具** → `微信开发者工具-小程序联调教程.md`：从安装软件到测通「工号+微信授权」
7. **微信登录脉络** → `微信授权登录-生命周期脉络.md`：手机绑号 → 开发者工具 → jsCode/phoneCode → 进系统
8. **登录绑定流程图（产品参考）** → `assets/wechat-login/登录绑定流程图.png`：波哥 spexSys 原图；与方案 A 差异见同目录 README
9. **其他模块接入微信登录** → `微信小程序登录-其他模块接入.md`：同一 AppID 只改前端；新 AppID 才扩配置
10. **小程序原型** → `prototype/improveSys.html`：23 页页面结构与字段
11. **管理端原型** → `prototype/index.html`：提案管理 + 提案配置（忽略其他菜单）
12. **人员导入** → `data/README.md` + `data/员工列表20260822.xls`：组织树与用户字段映射
13. **建表脚本** → `sql/proposal_init.sql`：提案业务表 + `sys_role` 初始化

## 关键约定

| 项 | 说明 |
|----|------|
| 登录 | 管理端 `POST /sys/login`；小程序工号+密码 `POST /sys/mLogin`，工号+微信授权 `POST /sys/wxMini/*`；`username = workNo` |
| 用户/组织 | 复用 Jeecg `sys_user` / `sys_depart`；业务名册用配置表 |
| API 路径 | 共用 `/proposal/**` · 管理端 `/proposal/admin/**` · 小程序聚合 `/proposal/app/**` |
| App 对接清单 | `api/提案小程序-接口对接清单.md`（申请段 + 工号密码/微信授权登录） |
| 管理端对接清单 | `api/提案管理端-接口对接清单.md`（列表/详情 + 五 Tab + 解绑微信） |
| 委员会 | 动态名册；审核全员；评分看 `scoreEnabled` 开关 |
| 配置 vs 角色 | 方案③：名册管业务；`sys_role` 粗权限可选；不加 `role_id` |
| 部门负责人 | 按改善部门配置 |
| SQL 执行 | **手工执行** `sql/proposal_init.sql`（V1.2）；字典见 `sql/proposal_tables.md` |
| 原型版本 | 小程序 V4.3；管理端见 `index.html` |

## 相关代码路径

| 模块 | 路径 |
|------|------|
| 后端（Phase 1 脚手架） | `jeecg-boot/jeecg-boot-module/jeecg-module-spex-inside/`（业务包 `org.jeecg.modules.proposal`） |
| 管理端 | `jeecgboot-vue3/` |
| 小程序端 | `spex-app/`（unibest；申请段接口已接真，见 `api/提案小程序-接口对接清单.md`） |
| Jeecg 基础库 SQL | `jeecg-boot/db/jeecgboot-mysql-5.7.sql` |

## 原型访问

- **小程序**：用浏览器打开 `prototype/improveSys.html`
- **管理端**：用浏览器打开 `prototype/index.html`，进入「提案改善」
- **内网演示**（可选）：http://192.168.123.92:9999/improveSys.html
