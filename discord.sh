#!/bin/bash

# -------------------------
# Configuration
# -------------------------
DEVICE="/dev/ttyACM0"                      # Serial device
WEBHOOK_URL="https://discord.com/api/webhooks/XXXX/YYYY"  # Replace with your Discord webhook
BAUD=115200                                # Must match ESP32 baud
SLEEP=60                                   # Time between readings (seconds)

# -------------------------
# Setup serial port
# -------------------------
stty -F "$DEVICE" $BAUD raw -echo

# -------------------------
# Main loop
# -------------------------
while true; do
    if read -r line < "$DEVICE"; then
        # Extract Moisture % from Serial output
        # Example Serial output: "Raw ADC: 1234  |  Moisture %: 45"
        MOISTURE=$(echo "$line" | awk -F'[:|]' '{gsub(/ /,"",$5); print $5}')
        
        # Safety check: ensure we got a number
        if [[ "$MOISTURE" =~ ^[0-9]+$ ]]; then
            # Send to Discord
            curl -s -H "Content-Type: application/json" \
                 -d "{\"content\": \"🌱 Soil moisture: **$MOISTURE%**\"}" \
                 "$WEBHOOK_URL" >/dev/null
            echo "$(date '+%Y-%m-%d %H:%M:%S') Sent moisture: $MOISTURE%"
        fi
    fi

    sleep $SLEEP
done
