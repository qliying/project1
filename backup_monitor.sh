#!/bin/bash
# 监控配置定时备份脚本
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/opt/monitor/backup"
mkdir -p $BACKUP_DIR
# 备份所有yml配置+服务文件+脚本
cp /opt/monitor/*.yml /opt/monitor/*.service /opt/monitor/*.sh $BACKUP_DIR/monitor_backup_$DATE.tar.gz
echo "✅ 监控配置已备份至 $BACKUP_DIR/monitor_backup_$DATE.tar.gz"
