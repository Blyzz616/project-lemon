#!/bin/bash

# -------------------------
# Configuration
# -------------------------
DEVICE="/dev/ttyACM0"                      # Serial device
WEBHOOK_URL="https://discord.com/api/webhooks/XXXX/YYYY"  # Replace with your Discord webhook
BAUD=115200
READ_TIMEOUT=5

# Configure serial port
stty -F "$DEVICE" $BAUD raw -echo

# Read a single line with timeout
START=$(date +%s)
LINE=""

while true; do
    if read LINE < "$DEVICE"; then
        break
    fi
    (( $(date +%s) - START >= READ_TIMEOUT )) && break
done

# Exit silently if no data
[[ -z "$LINE" ]] && exit 1

# Extract moisture value
if [[ "$LINE" =~ Moisture\ %:\ ([0-9]+) ]]; then
    MOISTURE="${BASH_REMATCH[1]}"
else
    exit 1
fi

# Send to Discord
HTTP_CODE=$(curl -s -o /tmp/discord_resp.txt -w "%{http_code}" \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"🌱 Soil moisture: **$MOISTURE%**\"}" \
    "$WEBHOOK_URL")

# Discord returns 204 on success
[[ "$HTTP_CODE" == "204" ]] || exit 1
