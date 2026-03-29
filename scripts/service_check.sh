#!/bin/bash
# ================================================
# service_check.sh
# What it does: Checks if system services are running
# How to run: ./scripts/service_check.sh
# ================================================
set -euo pipefail
# This is a Bash array — a list of services to check
SERVICES=("ssh" "cron" "ufw" "rsyslog")
# We use this to track if everything is OK
ALL_OK=true
echo "[$(date '+%T')] Service Status Report — $(hostname)"
echo "============================================"
# Loop through each service in the array
for SVC in "${SERVICES[@]}"; do
# systemctl is-active checks if a service is running
# --quiet means it does not print anything itself
if systemctl is-active --quiet "$SVC" 2>/dev/null; then
printf " %-20s [ UP ] OK\n" "$SVC"
else
printf " %-20s [ DOWN ] NEEDS ATTENTION\n" "$SVC"
ALL_OK=false
fi
done
echo "============================================"
# Print overall summary
if [ "$ALL_OK" = true ]; then
echo " Overall: ALL SERVICES RUNNING NORMALLY"
else
echo " Overall: ONE OR MORE SERVICES ARE DOWN"
exit 1
fi

