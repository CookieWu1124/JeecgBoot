# 提案改善 · 公司 DEV 环境后端部署手册

> 适用场景：**单体 `jeecg-system-start` JAR → 服务器 Docker**；MySQL 在**另一台机器**；Redis 与后端**同机 Docker**。  
> 打包产物：`jeecg-system-start-3.9.3.jar`（内含 `jeecg-module-spex-inside` 提案模块）。  
> 日期口径：2026-09。

---

## 0. 目标架构

```text
                    ┌──────────────── 应用服务器（Docker Host） ────────────────┐
                    │  docker network: jeecg_boot                               │
  浏览器/小程序 ──► │  ┌─────────────────────┐    ┌──────────────────────┐     │
  Nginx/直连 :8080  │  │ jeecg-boot-system   │───►│ jeecg-boot-redis     │     │
                    │  │ (JAR, profile=docker)│    │ hostname: jeecg-boot- │     │
                    │  │ 上传目录 volume      │    │ redis:6379           │     │
                    │  └──────────┬──────────┘    └──────────────────────┘     │
                    └─────────────┼────────────────────────────────────────────┘
                                  │ JDBC（宿主机出网 / 内网）
                                  ▼
                    ┌──────────────── 数据库机器 ────────────────┐
                    │  MySQL（你已拿到连接串）                     │
                    │  库名建议：inside_dev（或公司约定）          │
                    └────────────────────────────────────────────┘
```

| 组件 | 位置 | 说明 |
|------|------|------|
| 后端 JAR | 本机 Docker 容器 | 镜像基于 `jeecg-system-start/Dockerfile` |
| Redis | **同一 Docker Compose** | 容器名/主机名建议 `jeecg-boot-redis` |
| MySQL | **另一台机器** | Compose **不要**再起 `jeecg-boot-mysql` |
| 上传文件 | 宿主机目录挂进容器 | `jeecg.path.upload` 必须可写且持久化 |

---

## 1. 部署前清单（Checklist）

### 1.1 物料

- [ ] 本仓库分支可编译（建议 `v3.9.3-spex-inside`）
- [ ] JDK 17 + Maven 3.8+（本机打包）
- [ ] 应用服务器已装 Docker / Docker Compose
- [ ] 已拿到 **MySQL 连接串**（host、port、库名、用户、密码）
- [ ] 应用服务器 → 数据库机器：**3306 网络可达**（安全组/防火墙放行）
- [ ] 微信小程序 AppID / AppSecret（若 DEV 要测微信登录；与本地一致或换成公司测试号）
- [ ] DEV 对外访问地址（IP 或域名，含端口），供管理端/小程序改 baseURL

### 1.2 数据库（在 DB 机器上执行）

按 [`sql/README.md`](./sql/README.md) 顺序，至少：

| 顺序 | 脚本 | 是否必做 |
|------|------|----------|
| 1 | Jeecg 基础库 `jeecg-boot/db/jeecgboot-mysql-5.7.sql`（库尚未初始化时） | ✅ 空库必做 |
| 2 | `docs/improve/sql/proposal_init.sql` | ✅ |
| 3 | `docs/improve/sql/proposal_menu.sql` | ✅ |
| 4 | `docs/improve/sql/fix/*.sql` 中尚未打过的增量（如标语表、未读表等） | ✅ 按环境缺啥补啥 |
| 5 | `hr_user_seed_*` / `proposal_config_seed.sql` | ⭕ 联调需要人员与名册时 |

> **Flyway 保持关闭**，脚本一律手工执行，勿指望容器启动自动建提案表。

### 1.3 配置（见第 3 节）

- [ ] 数据源指向公司 DB 连接串
- [ ] Redis `host` 指向同 Compose 内 Redis 主机名
- [ ] 上传目录改为容器内路径，并挂 volume
- [ ] `domainUrl` / 微信配置按 DEV 环境填写
- [ ] 敏感信息放**服务器外部配置**，不要把公司密码提交进 Git

---

## 2. 需要改的配置项（对照本仓库）

启动模块配置目录：

`jeecg-boot/jeecg-module-system/jeecg-system-start/src/main/resources/`

| 文件 | 用途 |
|------|------|
| `application.yml` | `spring.profiles.active=@profile.name@`（打包时由 Maven profile 写入） |
| `application-docker.yml` | **Docker 打包默认读此文件**（`-Pdocker`） |
| `application-dev.yml` | 本地开发用；**不要直接把本地 IP/密码打进公司镜像** |

### 推荐做法（优先）

**不要改仓库里的 yml 再打包**，而是：

1. 本机用 `-Pdocker` 打出通用 JAR/镜像  
2. 在服务器挂载目录 `config/application-docker.yml`（或 `application.yml`）覆盖数据源/Redis/上传/微信等  

Compose 已预留：

```yaml
volumes:
  - ./config:/jeecg-boot/config
```

Spring Boot 会加载工作目录下 `./config/` 中的同名配置（与 jar 内合并，**外部优先**）。

### 必改项一览

| 配置键 | 当前 docker 默认（仓库内） | 公司 DEV 应改为 |
|--------|---------------------------|-----------------|
| `spring.datasource.dynamic.datasource.master.url` | `jdbc:mysql://jeecg-boot-mysql:3306/jeecg-boot?...` | 你的**外置库**连接串（host 用 IP/域名，**不要**再写 `jeecg-boot-mysql`） |
| `...master.username` / `password` | `root` / `root` | 公司库账号密码 |
| `spring.data.redis.host` | `jeecg-boot-redis` | 保持同 Compose 服务名即可（同网络） |
| `spring.data.redis.port` | `6379` | 一般不变 |
| `spring.data.redis.password` | 空 | 若 Redis 设了密码则填写 |
| `spring.data.redis.database` | `0` | 按需；避免与其它系统抢同一 DB |
| `jeecg.path.upload` | `/home/spex/upFiles` | 容器内路径，如 `/jeecg-boot/upFiles`，并挂宿主机目录 |
| `jeecg.uploadType` | `local` | DEV 继续 `local` 即可 |
| `jeecg.domainUrl.pc` | `http://localhost:3100` | 管理端实际访问地址 |
| `jeecg.domainUrl.app` | `http://localhost:8051` | 小程序/H5 实际地址（若有） |
| `jeecg.wx-mini.app-id` / `app-secret` | docker 配置里可能缺失 | **补上**（可从 `application-dev.yml` 的 `jeecg.wx-mini` 对齐，或公司测试号） |
| `spring.flyway.enabled` | docker 文件里曾为 true，但另有 exclude | **显式设为 `false`**，与现网手工 SQL 一致 |

### 可选 / 注意项

| 项 | 说明 |
|----|------|
| `server.port` / `context-path` | 默认 `8080`、`/jeecg-boot`；改端口需同步映射与前端 baseURL |
| AI / OSS / 短信 | DEV 不测可保持 `??`；不影响提案主链路 |
| `jeecg-boot-pgvector` | 提案申请段不依赖；Compose 可不启 |
| Dockerfile `CMD sleep 60` | 原为等同 Compose 内 MySQL；外置库时可改为 `sleep 10` 或去掉，缩短启动 |

### 外部覆盖示例（服务器 `config/application-docker.yml` 片段）

> **完整可复制模板**（含全部必改占位符）：[`deploy/application-docker.yml.template`](./deploy/application-docker.yml.template)  
> 复制到服务器后改名为 `application-docker.yml`，替换所有 `<<...>>` 即可。

```yaml
spring:
  flyway:
    enabled: false
  datasource:
    dynamic:
      datasource:
        master:
          url: jdbc:mysql://<DB_HOST>:<PORT>/<DB_NAME>?characterEncoding=UTF-8&useUnicode=true&useSSL=false&tinyInt1isBit=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Shanghai
          username: <USER>
          password: <PASSWORD>
          driver-class-name: com.mysql.cj.jdbc.Driver
  data:
    redis:
      database: 0
      host: jeecg-boot-redis
      port: 6379
      password:   # 有密码再填

jeecg:
  path:
    upload: /jeecg-boot/upFiles
    webapp: /jeecg-boot/webapp
  domainUrl:
    pc: http://<DEV_HOST_OR_DOMAIN>:3100
    app: http://<DEV_HOST_OR_DOMAIN>
  wx-mini:
    app-id: <APPID>
    app-secret: '<SECRET>'
```

把完整连接串贴进 `url` 即可（你已拿到的那串，补齐 `serverTimezone` 等参数更稳妥）。

---

## 3. 推荐 Compose（仅 Redis + 后端，无 MySQL）

在应用服务器准备目录，例如 `/opt/spex-dev/`：

```text
/opt/spex-dev/
├── docker-compose.yml
├── config/
│   └── application-docker.yml    # 外部覆盖（含 DB/Redis/上传/微信）
├── upFiles/                      # 上传持久化
└── jars/                         # 可选：仅放 jar 时用自定义 Dockerfile
```

### 3.1 `docker-compose.yml` 示例

基于仓库 `jeecg-boot/docker-compose.yml` 裁剪（去掉 mysql / pgvector）：

```yaml
version: '2'
services:
  jeecg-boot-redis:
    image: registry.cn-hangzhou.aliyuncs.com/jeecgdocker/redis:5.0
    restart: always
    hostname: jeecg-boot-redis
    container_name: jeecg-boot-redis
    networks:
      - jeecg-boot

  jeecg-boot-system:
    build:
      context: ./jeecg-system-start   # 内含 Dockerfile + target/*.jar
    restart: on-failure
    depends_on:
      - jeecg-boot-redis
    container_name: jeecg-boot-system
    hostname: jeecg-boot-system
    ports:
      - "8080:8080"
    networks:
      - jeecg-boot
    volumes:
      - ./config:/jeecg-boot/config
      - ./upFiles:/jeecg-boot/upFiles

networks:
  jeecg-boot:
    name: jeecg_boot
```

> 若公司要求 Redis 也设密码：Compose 加 `command: redis-server --requirepass xxx`，并在 yml 填同一密码。

### 3.2 可选：缩短启动等待

仓库 Dockerfile 末尾类似：

```dockerfile
CMD sleep 60 && exec java -Djava.security.egd=file:/dev/./urandom -jar jeecg-system-start-3.9.3.jar
```

外置 DB 时建议改为 `sleep 5` 或直接 `exec java ...`（在服务器侧 Dockerfile 改，或构建前改再 build）。

---

## 4. 打包与发布步骤

### 步骤 A — 本机打 Docker 用 JAR

在仓库根或 `jeecg-boot` 下（与团队习惯一致）：

```bash
cd jeecg-boot
mvn clean package -Pdocker -DskipTests
```

产物：

```text
jeecg-module-system/jeecg-system-start/target/jeecg-system-start-3.9.3.jar
```

确认 `jeecg-system-start/pom.xml` 已依赖 `jeecg-module-spex-inside`（当前仓库已接好）。

### 步骤 B — 传到应用服务器

将以下内容拷到服务器构建上下文（示例）：

```text
jeecg-system-start/
├── Dockerfile          # 来自仓库同路径
└── target/
    └── jeecg-system-start-3.9.3.jar
```

以及第 3 节的 `docker-compose.yml`、`config/application-docker.yml`、空目录 `upFiles/`。

### 步骤 C — 数据库就绪

在 **DB 机器**用客户端执行第 1.2 节脚本；用同一连接串从**应用服务器**测连通：

```bash
# 在应用服务器上（有 mysql 客户端时）
mysql -h <DB_HOST> -P <PORT> -u <USER> -p -e "SELECT 1"
```

### 步骤 D — 启动

```bash
cd /opt/spex-dev
docker compose up -d --build
docker compose logs -f jeecg-boot-system
```

关注日志：

- 数据源连接成功  
- Redis 连接成功  
- 无 Flyway 清库/报错  
- Tomcat 启动在 `8080`，context `/jeecg-boot`

### 步骤 E — 冒烟验证

| 检查 | 命令/操作 |
|------|-----------|
| 健康/文档 | 浏览器打开 `http://<应用机>:8080/jeecg-boot/doc.html` |
| 管理端登录 | `POST /jeecg-boot/sys/login` |
| 提案接口 | `GET /jeecg-boot/proposal/app/home`（需登录 Token） |
| 标语 | 管理端改首页标语 → 小程序首页是否更新 |
| 上传 | 提案附图上传后文件是否落在宿主机 `upFiles/` |

### 步骤 F — 前端指向

| 端 | 改什么 |
|----|--------|
| `jeecgboot-vue3` | `.env.development` / 部署环境的 API 基址 → `http://<应用机>:8080/jeecg-boot` |
| `spex-app` | 请求 baseURL 指向同一后端；微信合法域名/业务域名在公众平台配置为 DEV 可访问地址 |

---

## 5. 与仓库现成文件的关系

| 仓库路径 | 用法 |
|----------|------|
| `jeecg-boot/jeecg-module-system/jeecg-system-start/Dockerfile` | 官方镜像构建（Java 17） |
| `jeecg-boot/docker-compose.yml` | 本地全家桶参考；公司 DEV 请去掉 mysql，DB 改外置 |
| `application-docker.yml` | 打进 jar 的默认 docker 配置；**用服务器 `config/` 覆盖** |
| `docs/improve/sql/*` | DEV 库初始化与增量 |
| `docs/improve/移动端本地联调指南.md` | 联调路径说明（本地）；上 DEV 后仅改 baseURL |

---

## 6. 常见问题

| 现象 | 可能原因 | 处理 |
|------|----------|------|
| 起不来 / 连不上库 | 应用机访问不了 DB；账号只允许 localhost | 放行安全组；用户 `%` 或应用机 IP |
| Redis 超时 | host 写成 `127.0.0.1` | 容器内应写 **`jeecg-boot-redis`**（服务名） |
| 上传后重启文件丢 | 未挂 volume | 挂载 `./upFiles:/jeecg-boot/upFiles` 且 yml 路径一致 |
| 提案表不存在 | 只启了 Jeecg 基础库 | 执行 `proposal_init.sql` 及 fix |
| 微信取号 40001 | AppSecret/AppID 与环境不一致；Redis token 脏 | 核对 `wx-mini`；必要时清 Redis 相关 key |
| 菜单没有「提案改善」 | 未跑 `proposal_menu.sql` | 执行菜单脚本后重新登录 |
| 配置改了不生效 | 只改了 jar 内 yml 未重建；或外部文件名/profile 不对 | 确认 `-Pdocker` 且外部文件覆盖 `application-docker.yml`；`docker compose up -d --build` |

---

## 7. 回滚与升级

1. **升级**：替换 jar → `docker compose up -d --build`；先执行新的 `sql/fix/*.sql` 再发版。  
2. **回滚**：保留上一版 jar 与镜像 tag；DB 脚本尽量幂等，破坏性变更单独评估。  
3. **配置**：`config/application-docker.yml` 与 `upFiles` 与镜像分离，升级 jar 不丢配置与附件。

---

## 8. 安全提醒

- 公司 DB 密码、微信 AppSecret **只放服务器 `config/`**，勿提交 Git、勿发群聊明文长期留存。  
- DEV 若对公网开放 8080，建议前置 Nginx + IP 限制或 VPN。  
- `application-dev.yml` 中的现网/联调账号仅作本地开发参考，发布以公司运维下发的连接串为准。
