# 公司 DEV 部署配置样例

| 文件 | 说明 |
|------|------|
| [`application-docker.yml.template`](./application-docker.yml.template) | 服务器 `config/application-docker.yml` 覆盖模板（占位符，无真实密钥） |

完整步骤见：[公司DEV环境-后端Docker部署手册.md](../公司DEV环境-后端Docker部署手册.md)

```bash
# 在应用服务器
mkdir -p /opt/spex-dev/config /opt/spex-dev/upFiles
cp application-docker.yml.template /opt/spex-dev/config/application-docker.yml
# 编辑占位符后：
# docker compose up -d --build
```
