#!/bin/sh

# Logs to journalctl. Watch with e.g. journalctl -t SNAP_NAME -f
log()
{
    logger -t ${SNAP_NAME} "$1"
}

restart_lighthouse()
{
    lighthouse_status="$(snapctl services lighthouse)"
    current_status=$(echo "$lighthouse_status" | awk 'NR==2 {print $3}')
    if [ "$current_status" = "active" ]; then
        snapctl restart lighthouse
    fi
}
