#!/bin/bash

#****************************************************
# health_check.sh
# What it does: Full server health report
# + disk space alert built in
# How to run: ./scripts/health_check.sh
# With custom threshold: ./scripts/health_check.sh 90

# ******************************************************
set -euo pipefail
# Accept optional threshold argument, default is 80%  THRESHOLD=${1:-80}
# This function prints a timestamped message
log() {
echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}
log "****************************************"
log " SERVER HEALTH REPORT"
log " Host: $(hostname)"
log "*****************************************"
log "--- DISK USAGE ---"
df -h /
# Check disk percentage and show alert
DISK_PCT=$(df / | awk 'NR==2{print $5}' | tr -d '%')
if [ "$DISK_PCT" -ge 95 ]; then
log "DISK ALERT: CRITICAL - ${DISK_PCT}% used!"
elif [ "$DISK_PCT" -ge "$THRESHOLD" ]; then
log "DISK ALERT: WARNING - ${DISK_PCT}% used"
else
log "DISK STATUS: OK - ${DISK_PCT}% used"
fi
log "--- MEMORY USAGE ---"
free -h
log "--- CPU LOAD ---"
uptime
log "--- TOP 10 PROCESSES BY CPU ---"
ps aux --sort=-%cpu | head -11
log "*****************************************"
log " Health check complete"
log "******************************************"
