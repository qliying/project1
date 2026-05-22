#!/bin/bash
echo "==================== 启动监控服务 ===================="
systemctl start node_exporter
systemctl start prometheus
systemctl start alertmanager
echo "节点采集服务：$(systemctl is-active node_exporter)"
echo "普罗米修斯服务：$(systemctl is-active prometheus)"
echo "告警邮件服务：$(systemctl is-active alertmanager)"
echo "======================================================"
echo "监控系统已全部启动完成！"
