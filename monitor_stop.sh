#!/bin/bash
echo "==================== 停止监控服务 ===================="
systemctl stop node_exporter
systemctl stop prometheus
systemctl stop alertmanager
echo "节点采集服务：$(systemctl is-active node_exporter)"
echo "普罗米修斯服务：$(systemctl is-active prometheus)"
echo "告警邮件服务：$(systemctl is-active alertmanager)"
echo "======================================================"
echo "监控系统已全部关闭！告警邮件已停止发送！"
