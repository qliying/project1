#!/bin/bash
echo "===== 实时查看监控系统日志 ====="
journalctl -f -u node_exporter -u prometheus -u alertmanager
