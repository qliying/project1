#!/bin/bash
echo "===== 监控系统服务状态 ====="
systemctl status node_exporter --no-pager
echo "----------------------------"
systemctl status prometheus --no-pager
echo "----------------------------"
systemctl status alertmanager --no-pager
echo "===== 端口监听状态 ====="
netstat -tlnp | grep -E "9100|9090|3000|9093"
echo "===== 告警状态 ====="
curl -s http://localhost:9090/api/v1/alerts | jq
