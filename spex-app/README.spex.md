# spex-app（提案改善 · 移动端）

> 基于 [unibest](https://unibest.tech) 二次开发的干净 uni-app 工程。  
> 已替代原 `jeecg-uniapp/`，作为提案业务移动端主体（旧目录已从仓库移除）。

## 本地启动

```bash
cd spex-app
pnpm i
pnpm run dev
```

浏览器打开控制台给出的地址（默认 `http://localhost:9000`）。

前置：本机 JeecgBoot 已启动（`http://127.0.0.1:8080/jeecg-boot`）。

## 环境

| 变量 | 说明 |
|------|------|
| `VITE_SERVER_BASEURL` | `http://127.0.0.1:8080/jeecg-boot` |
| `VITE_APP_PROXY_ENABLE` | development 下为 `true` |
| `VITE_APP_PROXY_PREFIX` | `/api`（H5 请求 `/api/sys/**` → 后端 `/sys/**`） |

详见 `env/.env`、`env/.env.development`。

## 鉴权

- 登录：`POST /sys/mLogin`（无图形验证码）
- 部门列表：`POST /sys/loginGetUserDeparts`（`source=APP`）
- Token：请求头 `X-Access-Token`

「体验登录」仍为前端假 Token，**不会打到后端**，仅用于看 UI。

## 业务页状态（迁入后）

| 模块 | 状态 |
|------|------|
| 登录 | 已对接 Jeecg 真实接口 |
| 发起 / 列表 / 详情 / 审核 / 批准 / 待办 / 统计 | **仍为 mock**，API 骨架见 `src/api/proposal.ts` |
| 上传 URL | 已指向 `/sys/common/upload`（页面尚未改用） |

确认迁入与登录无误后，再通知接「登录 → 发起 → 列表/详情」真实联调。

## 保留项（暂不砍）

- i18n
- 体验登录
- 统计页 mock

后续可按需精简。
