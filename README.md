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

## 四、可视化访问地址（公网可测）
- Prometheus 指标查询后台：http://101.133.232.244:9090
- Grafana 监控可视化大屏：http://101.133.232.244:3000（默认账号/密码：admin/admin）
- Alertmanager 告警管理后台：http://101.133.232.244:9093

### Grafana 使用说明：
- 首次访问显示 Grafana 欢迎页为正常状态，左侧 Dashboards 菜单中可选择「Node Exporter Dashboard 20240520」查看服务器实时监控大屏；
- 监控大屏包含 CPU 使用率、内存使用率、磁盘使用率、网络 IO、系统负载等核心指标，数据每 15 秒刷新一次（与 Prometheus 采集频率一致）。

### Alertmanager 状态说明：
当前 Alertmanager 显示 No alert groups found 属于**正常健康状态**，代表服务器 CPU、内存、磁盘均在安全阈值内，未触发任何告警。
如需测试告警，可使用 stress 工具压测，1 分钟后即可收到邮件告警与页面告警信息。

## 五、完整部署步骤

### 1. 系统初始化（关闭防火墙 + 依赖安装）
systemctl stop firewalld
systemctl disable firewalld
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
yum install wget vim net-tools -y
mkdir -p /opt/monitor && cd /opt/monitor

### 2. 安装 Node Exporter（指标采集 9100）
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
tar -zxvf node_exporter-1.8.2.linux-amd64.tar.gz
mv node_exporter-1.8.2.linux-amd64 node_exporter

### 3. 安装 Prometheus（监控存储 9090）
wget https://github.com/prometheus/prometheus/releases/download/v2.53.0/prometheus-2.53.0.linux-amd64.tar.gz
tar -zxvf prometheus-2.53.0.linux-amd64.tar.gz
mv prometheus-2.53.0.linux-amd64 prometheus

### 4. 安装 Alertmanager（邮件告警 9093）
wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz
tar -zxvf alertmanager-0.27.0.linux-amd64.tar.gz
mv alertmanager-0.27.0.linux-amd64 alertmanager

### 5. 安装 Grafana（可视化大屏 3000）
yum install fontconfig -y
rpm -ivh --nodeps grafana-10.4.0-1.x86_64.rpm

### 6. 启动所有服务
systemctl start node_exporter
systemctl start prometheus
systemctl start alertmanager
systemctl start grafana-server

### 7. 访问可视化页面
- Prometheus：http://101.133.232.244:9090
- Grafana：http://101.133.232.244:3000
- Alertmanager：http://101.133.232.244:9093
