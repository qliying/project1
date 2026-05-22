# Prometheus运维监控项目
基于 **Prometheus + AlertManager + Node Exporter** 搭建云服务器全方位监控告警平台，实现服务器指标采集、异常自动邮件告警、服务一键运维。

## 一、项目脚本（自动化运维）
- monitor_start.sh：一键启动Prometheus、AlertManager、Node Exporter全套监控服务
- monitor_stop.sh：一键停止所有监控服务
- monitor_status.sh：快速查看监控服务运行状态
- monitor_log.sh：实时查看监控系统运行日志

## 二、核心配置文件
1. prometheus.yml
   配置监控采集规则，每15秒采集服务器CPU、内存、磁盘指标，对接Node Exporter监控客户端，关联告警规则文件。

2. alert_rules.yml
   生产级告警规则：
   - CPU使用率＞80% 触发严重告警
   - 内存使用率＞85%（排除缓存，真实可用内存不足）触发告警
   - 磁盘使用率＞90% 触发磁盘空间告警

3. alertmanager.yml
   配置QQ邮箱告警推送，异常触发后自动发送邮件通知，故障恢复后推送恢复通知。

4. prometheus.service
   系统服务自启配置，实现服务器开机自动启动Prometheus监控服务，保证监控7×24小时在线。

## 三、部署环境
CentOS Linux 7/8 云服务器
