# Prometheus运维监控项目
基于Prometheus+AlertManager+NodeExporter搭建服务器监控告警平台
## 项目脚本
- monitor_start.sh：一键启动全套监控服务
- monitor_stop.sh：一键停止监控
- monitor_status.sh：查看运行状态
- monitor_log.sh：查看监控日志
## 配置说明
使用Prometheus配置采集服务器CPU/内存/磁盘指标，配置告警规则，异常邮件告警
