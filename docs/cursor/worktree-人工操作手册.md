# Git Worktree / 双分支操作手册（提案改善 · spex-inside）

> **读者**：项目维护者（人工查阅）。  
> **Agent 约定**：同步/cherry-pick 时以 `.cursor/rules/improve/dual-branch-cherry-pick.mdc`（`alwaysApply`）为准；细节步骤见本文。Cursor Agent 业务真相源仍为 `docs/improve/` 与 `.cursor/rules/improve/` 其它规则。**本文档不参与公司库真相源**，勿把本文或整份 `docs/` cherry-pick 进公司分支。

---

## 1. 为什么拆成「个人开发」与「公司 work」

公司 GitLab 面向同事协作与发版，应保持精简：**只放后台业务代码**（及公司已有的 sale、环境配置）。  
个人侧需要完整上下文：需求/原型、SQL 种子、Cursor 规则、管理端 vue3、小程序 spex-app、部署手册等——这些**只留在个人开发分支**，避免污染公司库。

对照采购/项目管理（`My-JeecgBoot`）的 worktree 习惯：同一套 Git 历史、多目录多分支协作；本仓库的差异是 **公司分支更「瘦」**——前端与文档默认不同步。

---

## 2. 目录与分支约定

| 角色 | 建议目录 | 分支 | Remote | 放什么 |
|------|----------|------|--------|--------|
| **个人开发（主）** | `C:\workspace\IDEA\spex-inside` | `v3.9.3-spex-inside`（或后续个人主分支） | 个人 GitHub（`CookieWu1124`） | 后端业务 + **vue3 + spex-app + docs + SQL 种子 + Cursor 规则/约束 + 原型/需求** |
| **公司协作** | `C:\workspace\IDEA\spex-inside-work` | **`miniapp-dev`**（与同事同一分支，勿再平行维护 `v3.9.3-spex-inside-work`） | **`gitlab`** = 公司 GitLab；可选 `github` 镜像同名 `miniapp-dev` | **仅后台业务相关代码**；保留同事 `sale` 与公司 `application-*.yml` |

当前双 remote 示例（公司 work 目录）：

```text
gitlab   http://192.168.123.92/java/spex-inside.git
github   https://github.com/CookieWu1124/JeecgBoot.git
```

> 若两目录尚不是同一 `.git` 的 worktree，可先「双克隆 + 后端 cherry-pick」；理顺后可用 `git worktree add` 挂公司分支，规则不变。

---

## 3. 黄金规则

1. **禁止**在公司 work 目录对个人分支执行 `git merge`（整分支合并），易把前端/文档/规则一并带入。  
2. 个人侧每完成一块**应进公司**的后台能力并 commit 后，**尽快**到公司 work **cherry-pick**（或只检出/应用后端文件），不要攒很多天。  
3. Commit 说明建议加前缀，便于筛选：  
   - **`[base]`**：纯后端业务，**应**同步到公司 **`miniapp-dev`**  
   - **`[personal]`** / 不写 base：文档、前端、规则、种子、原型等，**不要**进公司库  
4. 公司 **`miniapp-dev` 禁止提交**：`spex-app/`、`jeecgboot-vue3/`、`docs/`、`.cursor/`、`AGENTS.md`（若公司仓原本没有）、各类仅个人使用的 SQL 种子/原型。  
5. **不要**再开长期分支 `v3.9.3-spex-inside-work` 再往 `miniapp-dev` 合并——直接在 `miniapp-dev` 上 pick/提交后端，减少一次合并冲突面。

---

## 4. 什么可以 / 不可以同步到公司 work

### 4.1 ✅ 可以 cherry-pick（后台业务）

| 类型 | 示例路径 |
|------|----------|
| 微信小程序登录后端 | `.../system/controller/WxMiniLoginController.java`、`WxMiniAuthServiceImpl`、`WxMiniLoginDTO`、`IWxMiniAuthService` |
| Shiro / Swagger 匿名放行 | `ShiroConfig.java` 中 `/sys/wxMini/*` → `anon`；`Swagger3Config` 对应路径 |
| 提案后端模块 | `jeecg-module-spex-inside/.../proposal/**`（**勿覆盖**同事的 `sale/**`） |
| 系统选人等必要后端补丁 | 如 `SysUserController` / `SysDepartController` 上与提案对接相关的 **Knife4j 注解或 API 行为**（合并时保留公司侧其它改动） |
| 启动模块对 spex 的依赖 | `jeecg-system-start/pom.xml` 中已有 `jeecg-module-spex-inside` 时，仅合业务需要的最小 diff |

### 4.2 ❌ 禁止带入公司 work

| 类型 | 示例 |
|------|------|
| 小程序前端 | 整棵 `spex-app/` |
| 管理端前端 | 整棵 `jeecgboot-vue3/`（含 `views/mes/proposal`） |
| 文档 / 手册 | `docs/**`（含 `docs/improve`、本 worktree 手册、接口清单、联调教程） |
| SQL 种子与 fix 脚本（个人侧维护） | `docs/improve/sql/**`（公司库变更走同事约定的发版流程，不把个人 docs 树推进 GitLab） |
| Cursor / Agent | `.cursor/**`、`AGENTS.md`、skills、本手册 |
| 原型 / 需求附件 | `docs/improve/assets/**`、原型 HTML 等 |
| 环境与密钥 | **不要**用个人 `application-*.yml` 覆盖公司文件（含 **`jeecg.uploadType` / `jeecg.minio.*`**：个人公网 MinIO ≠ 公司内网 MinIO）；公司 Docker 用外置 `config/` 或同事已有配置 |

### 4.3 公司 work 必须保留（冲突时优先留公司侧）

- `org.jeecg.modules.sale/**`（销售模块）  
- 公司环境 `application-dev.yml` / `application-docker.yml` / `application-prod.yml`  
- 公司侧已有的 `JeecgController` / `JwtUtil` / `Firewall` / `pagehelper` 等与 sale 相关的框架补丁与 pom 依赖  

---

## 5. 推荐日常流程（个人 → 公司）

### 5.1 个人目录开发

```powershell
cd C:\workspace\IDEA\spex-inside
# ... 改后端业务 ...
git add <仅后端相关路径>
git commit -m "feat(proposal): [base] ..."
git push   # 推个人 GitHub
```

前端 / 文档 / 规则单独 commit，**不要**标 `[base]`：

```powershell
git commit -m "docs(improve): [personal] 更新接口对接清单"
git commit -m "feat(app): [personal] 小程序登录页文案"
```

### 5.2 同步到公司 work（只带后端）

```powershell
cd C:\workspace\IDEA\spex-inside-work
git fetch gitlab
git checkout miniapp-dev
git pull gitlab miniapp-dev

# 方式 A：若两端已是同一仓库 worktree / 能拿到个人分支 commit
git cherry-pick <个人侧带 [base] 的 hash>
# 冲突 → 保留 sale 与公司 yml → git add → git cherry-pick --continue

# 方式 B：历史不同源时，按文件拷贝/打补丁（推荐核对清单）
# 仅复制 §4.1 路径；禁止复制 §4.2

git push gitlab miniapp-dev
# 可选镜像到个人 GitHub
git push github miniapp-dev
```

### 5.3 验收（公司 `miniapp-dev`）

```powershell
# 不应存在
Test-Path spex-app; Test-Path jeecgboot-vue3; Test-Path docs

# 应存在（示例）
Test-Path jeecg-boot\jeecg-module-system\jeecg-system-biz\src\main\java\org\jeecg\modules\system\controller\WxMiniLoginController.java
Select-String -Path jeecg-boot\jeecg-boot-base-core\src\main\java\org\jeecg\config\shiro\ShiroConfig.java -Pattern "wxMini"
Test-Path jeecg-boot\jeecg-boot-module\jeecg-module-spex-inside\src\main\java\org\jeecg\modules\sale
```

冒烟：公司环境打包部署后，无 Token 调 `/sys/wxMini/silentLogin` 不应再返回 `token为空！`；sale 接口不受影响。

---

## 6. 发版与配置（提醒）

- 公司发版：**只提交/合并公司 work 上的后端**；前端由个人仓或独立前端工程构建后部署。  
- `jeecg.wx-mini`、数据源、Redis、**上传方式（local/minio）与 MinIO 地址账号**：写在**公司外置配置**或公司已有 yml，**不要**从个人分支覆盖。  
  个人 `47.107.x` MinIO 与公司 `192.168.x` MinIO 彼此独立，cherry-pick **跳过** `application-*.yml`。  
- 提案相关 SQL：在个人 `docs/improve/sql` 维护清单；在公司库执行时按运维流程跑，**不必**把 docs 树推进 GitLab。

---

## 7. 旧目录清理

| 路径 | 建议 |
|------|------|
| `C:\workspace_spex_work\inside` | 确认 `spex-inside-work` 可用后可删除 |
| `C:\workspace\IDEA\spex-inside` | **保留**为个人开发主目录 |
| `C:\workspace\IDEA\spex-inside-work` | **保留**为公司 work 目录 |

---

## 8. 修订记录

| 日期 | 说明 |
|------|------|
| 2026-09-04 | 初版：个人主 / 公司仅后端；禁止 docs、vue3、spex-app、规则、种子进入公司库；对照采购 worktree 习惯 |
| 2026-09-04 | 公司协作分支改为与同事共用的 **`miniapp-dev`**；废弃长期平行分支 `v3.9.3-spex-inside-work` |
