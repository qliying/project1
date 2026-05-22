# 监控系统故障排查手册
## 1. 网页无法访问
- 检查阿里云安全组放行：9090/9100/9093/3000
- 关闭系统防火墙：systemctl stop firewalld
- 检查服务状态：systemctl status prometheus/node_exporter/alertmanager/grafana

## 2. 收不到告警邮件
- QQ邮箱POP3/SMTP已开启
- 授权码正确、465端口放行
- 检查alertmanager.yml缩进格式

## 3. 指标不采集
- Node‑Exporter端口正常：http://IP:9100/metrics
- prometheus.yml targets配置正确
- 重启prometheus服务

## 4. 告警不触发
- 告警规则expr语法正确
- 持续时间for≥1m
- 查看prometheus告警面板
