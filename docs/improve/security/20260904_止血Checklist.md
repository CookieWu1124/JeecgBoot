# 止血 Checklist · 对照 SEC-20260904 + application-docker.yml

> 配套：[20260904_JeecgBoot安全评估.md](./20260904_JeecgBoot安全评估.md)  
> 外部配置模板：[../deploy/application-docker.yml.template](../deploy/application-docker.yml.template)  
> 部署手册：[../公司DEV环境-后端Docker部署手册.md](../公司DEV环境-后端Docker部署手册.md)  
> 目标：阶段 1（约 24h）把 Critical/High 主杀伤链掐断；**能只改服务器 yml 的优先不改代码**。

## 0. 怎么用

1. 服务器已有 `/opt/spex-dev/config/application-docker.yml`：按本文与模板合并「安全覆盖」段后重启容器。
2. 尚无外部配置：从模板复制 → 填业务占位符 → **保留安全段** → 挂载后启动。
3. 每项打勾后，在评估报告对应 Finding 把 `状态` 改为 `mitigating` / `verified`。
4. `BASE` 示例：`http://<<APP_HOST>>:8080/jeecg-boot`（按实际改）。

| 能力 | 仅外部 yml | 需改代码/发版 | 需 DBA/安全组 |
|------|:----------:|:-------------:|:-------------:|
| C1 Druid | 是 | 否 | 否 |
| H2 Knife4j | 是 | 否 | 否 |
| C3 Actuator 收敛 | 部分 | Shiro anon 收口需发版 | 否 |
| H1 MySQL 公网 | JDBC 建议项 | 否 | **是（主）** |
| C2 CORS | **否** | **是** | 否 |

---

## 1. 配置侧（复制即用）

### 1.1 SEC-20260904-C1 · 关停/加固 Druid

**落点**：外部 yml 覆盖 jar 内 `application-docker.yml` 的默认 `admin/123456`。

- [ ] 在服务器 `application-docker.yml` 写入（模板已含同段）：

```yaml
spring:
  datasource:
    druid:
      stat-view-servlet:
        # DEV 对局域网暴露时：优先直接关掉监控页
        enabled: false
        # 若必须保留监控，改为 enabled: true，并填强口令 + allow
        # login-username: <<DRUID_USER>>
        # login-password: <<DRUID_PWD>>   # ≥16 位，勿用 admin/123456
        # allow: 127.0.0.1,192.168.0.0/16
        reset-enable: false
```

- [ ] `docker compose restart`（或等价重启）使配置生效  
- [ ] **复测**（应失败 / 非 200 业务数据）：

```bash
curl -s -o /dev/null -w "%{http_code}\n" -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "loginUsername=admin&loginPassword=123456" \
  "$BASE/druid/submitLogin"

curl -s -o /dev/null -w "%{http_code}\n" "$BASE/druid/datasource.json"
# 期望：404/401/403，或登录页在但默认口令无效且 datasource 不可匿名读
```

**状态跟踪**：C1 → `mitigating` → 复测通过后 `verified`

---

### 1.2 SEC-20260904-H2 · 关闭 Knife4j / OpenAPI

**落点**：外部 yml（覆盖 jar 内 `knife4j.production: false`）。

- [ ] 设置：

```yaml
knife4j:
  enable: true
  production: true    # true = 生产屏蔽文档（含 UI）
  basic:
    enable: false
```

- [ ] 重启后复测：

```bash
curl -s -o /dev/null -w "%{http_code}\n" "$BASE/doc.html"
curl -s -o /dev/null -w "%{http_code}\n" "$BASE/v3/api-docs"
# 期望：404 或无接口清单正文
```

> 仅本机联调、且确认端口不对公网/公司外网开放时，可临时 `production: false`，但 checklist 默认按「DEV 也可被扫」处理。

**状态跟踪**：H2

---

### 1.3 SEC-20260904-C3 · Actuator 收敛（yml 部分）

**落点**：外部 yml；jar 内已有 `management` 段时可覆盖。

- [ ] 写入：

```yaml
management:
  endpoints:
    web:
      exposure:
        include: health,info
      base-path: /internal-actuator
  endpoint:
    health:
      show-details: never
    env:
      enabled: false
    heapdump:
      enabled: false
    threaddump:
      enabled: false
    mappings:
      enabled: false
```

- [ ] 复测旧路径：

```bash
curl -s -o /dev/null -w "%{http_code}\n" "$BASE/actuator/env"
# 期望：401/404（勿再匿名读到环境明细）
```

**说明**：`/druid/**`、`/doc.html`、`/v3/**` 在 `ShiroConfig` 里硬编码 `anon`，**仅靠 yml 无法取消匿名**。关 Druid + `knife4j.production=true` 已切断主面；彻底收白名单见 §2.2。

**状态跟踪**：C3（yml 完成后可标 `mitigating`；Shiro 发版后 `verified`）

---

### 1.4 SEC-20260904-H1 · JDBC 与库面（配置 + 运维）

**配置侧（模板已改示例注释）**

- [ ] `url` 优先用**内网 IP/主机名**，不要用已确认的公网 `47.107.78.177`（若仍指向公网，在迁移前也必须先做安全组收口）
- [ ] `username` 不用 `root`，改为应用专用账号（最小权限）
- [ ] 查询参数建议：`useSSL=true`（库支持时）；去掉或慎用 `allowPublicKeyRetrieval=true`
- [ ] 密码仅写在服务器 yml，**勿提交 Git**

**运维 / DBA（主动作）**

- [ ] 阿里云/防火墙：**拒绝公网访问 3306**（仅应用机安全组 / VPC 内网）
- [ ] 确认 `bind-address` / 云侧「仅内网」
- [ ] 轮换曾可能泄露环境下的 DB 密码（Druid 已暴露过连接信息）

**复测**

```text
从办公网/公网对 47.107.78.177:3306 探测 → 超时或拒绝
应用容器内用新 JDBC 仍可连库、提案接口正常
```

**状态跟踪**：H1

---

## 2. 代码侧（需发版，yml 做不到）

### 2.1 SEC-20260904-C2 · CORS 白名单

**落点**：`jeecg-boot-base-core/.../WebMvcConfiguration.java`  
当前：`addAllowedOriginPattern("*")` + `setAllowCredentials(true)`（单体必加载，见 `CorsFilterCondition`）。

- [ ] 改为业务域白名单，例如：

```java
corsConfiguration.setAllowCredentials(true);
corsConfiguration.setAllowedOriginPatterns(List.of(
    "http://localhost:*",
    "http://127.0.0.1:*",
    "http://<<管理端域名或IP>>:*",
    "https://<<正式域名>>"
));
```

- [ ] 或：管理端/小程序全部走同源 Nginx 反代后，评估关闭该 `CorsFilter`
- [ ] 发版后复测：

```bash
curl -sI -H "Origin: https://evil.com" "$BASE/sys/login" | findstr /i "access-control"
# 期望：无 Access-Control-Allow-Origin: https://evil.com
```

**状态跟踪**：C2（发版前保持 open）

---

### 2.2 SEC-20260904-C3 补完 · Shiro anon 收口（可选，阶段 2）

**落点**：`ShiroConfig.java` 中 `/druid/**`、`/doc.html`、`/swagger**/**`、`/v3/**`、`/webjars/**`。

- [ ] DEV/生产：在关监控与 `production: true` 之后，评估去掉或改为仅内网可达（网关/防火墙）
- [ ] 勿轻易把 `/sys/common/static/**` 整段删掉（上传预览依赖）；目录列举问题见 M1（nginx）

---

## 3. 一键勾选总表（阶段 1）

| # | Finding | 动作 | Owner | 完成 |
|---|---------|------|-------|------|
| 1 | C1 | 外部 yml：`stat-view-servlet.enabled: false`（或强口令+allow） | 后端/运维 | [ ] |
| 2 | H2 | 外部 yml：`knife4j.production: true` | 后端/运维 | [ ] |
| 3 | C3 | 外部 yml：Actuator exposure / base-path | 后端 | [ ] |
| 4 | H1 | 安全组关公网 3306 + JDBC 改内网/专用账号 | DBA | [ ] |
| 5 | C2 | 改 `WebMvcConfiguration` CORS 后发版 | 后端 | [ ] |
| 6 | — | 按 §1 复测命令跑通并更新评估报告状态 | 后端 | [ ] |

阶段 2（不挡止血）：H3 依赖树、M2 登录限流、M1 上传目录、L1 安全头 — 见评估报告 §5。

---

## 4. 回滚

| 项 | 回滚 |
|----|------|
| Druid `enabled: false` | 改回 `true` 并设强口令（勿回 `123456`）后重启 |
| `knife4j.production: true` | 改 `false` 后重启（仅内网调试时） |
| Actuator `base-path` | 改回 `/actuator` 或删覆盖段后重启 |
| JDBC / 账号 | 保留旧连接串备份；先验证新串再切 |
| CORS 代码 | Git 回退该提交并发版 |

---

## 5. 给 Cursor

- 外部可覆盖项只改：`docs/improve/deploy/application-docker.yml.template` 与服务器挂载文件。
- CORS / Shiro：改 `jeecg-boot` 源码并发版，不要幻想只靠 yml。
- 勾选完成后同步：`20260904_JeecgBoot安全评估.md` frontmatter `status` 与各 Finding「状态」行。
