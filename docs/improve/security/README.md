# 安全评估归档

> 本目录存放提案改善 / JeecgBoot 相关环境的安全评估与加固记录，供开发与 Cursor 后续检索、复测对照。

## 文件

| 文件 | 说明 |
|------|------|
| [20260904_JeecgBoot安全评估.md](./20260904_JeecgBoot安全评估.md) | MOM 测试环境（JeecgBoot 3.9.3）只读探测结果；Finding ID 前缀 `SEC-20260904-*` |
| [20260904_止血Checklist.md](./20260904_止血Checklist.md) | 阶段 1 逐项落地：外部 yml / 代码 / DBA；对照 `deploy/application-docker.yml.template` |

## 约定

- **一篇环境一次主报告**：文件名 `YYYYMMDD_<主题>.md`；正文带 YAML frontmatter（`id` / `status` / `findings`）。
- **Finding 稳定 ID**：`SEC-YYYYMMDD-C1` / `H1` / `M1` / `L1`…，复测与聊天引用用 ID，勿只靠章节标题。
- **状态字段**：`open` → `mitigating` → `verified` / `accepted`；改状态时同步 frontmatter 与各 Finding 的「状态」行。
- **敏感信息**：报告可能含内网地址、默认口令、库名；仅限私有仓库，勿外传。
- **与部署文档关系**：止血项常落在 `application.yml` / 安全组；部署步骤见 [`../公司DEV环境-后端Docker部署手册.md`](../公司DEV环境-后端Docker部署手册.md)。

## 给 Cursor AI

检索时优先：`docs/improve/security/**` + frontmatter `tags` / Finding ID；勿再依赖外部 `.workbuddy` 路径或飞秋 Recv 原件。
