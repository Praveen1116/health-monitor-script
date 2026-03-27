#!/bin/bash

LOG_FILE="/var/log/health_monitor.log"
SERVICE_FILE="services.txt"
DRY_RUN=false

if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "Running in DRY RUN mode"
fi

if [[ ! -f "$SERVICE_FILE" || ! -s "$SERVICE_FILE" ]]; then
    echo "Error: services.txt missing or empty"
    exit 1
fi

TOTAL=0
HEALTHY=0
RECOVERED=0
FAILED=0

while read -r SERVICE; do
    ((TOTAL++))

    STATUS=$(systemctl is-active "$SERVICE" 2>/dev/null)

    if [[ "$STATUS" == "active" ]]; then
        ((HEALTHY++))
        echo "$SERVICE is running"
    else
        echo "$SERVICE is NOT running"

        if [[ "$DRY_RUN" == false ]]; then
            sudo systemctl restart "$SERVICE"
            sleep 5
            NEW_STATUS=$(systemctl is-active "$SERVICE" 2>/dev/null)
        else
            NEW_STATUS="inactive"
        fi

        TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

        if [[ "$NEW_STATUS" == "active" ]]; then
            ((RECOVERED++))
            echo "$SERVICE recovered"
            echo "$TIMESTAMP [INFO] $SERVICE RECOVERED" | sudo tee -a "$LOG_FILE" > /dev/null
        else
            ((FAILED++))
            echo "$SERVICE failed"
            echo "$TIMESTAMP [ERROR] $SERVICE FAILED" | sudo tee -a "$LOG_FILE" > /dev/null
        fi
    fi

done < "$SERVICE_FILE"

echo "---------------------------"
echo "Total Checked : $TOTAL"
echo "Healthy       : $HEALTHY"
echo "Recovered     : $RECOVERED"
echo "Failed        : $FAILED"
