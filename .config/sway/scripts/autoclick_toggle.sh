#!/bin/sh

BACKGROUND_FILE="~/.config/sway/backgrounds/LightWaves-b4b59bda185758ebaa2735e4e9fc78a2f7277c64.webp"
COLOR="auto"
FORCE_COLOR=false
MODE="auto"
FORCE_MODE=false
ENABLE_NIGHTLIGHT=true
AUTOCLICK_ENABLED=false
AUTOCLICK_INTERVAL=1000
KEYBOARD=cs

# Create ~/.config/sway/config.json with values
if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: '$FORCE_MODE', color: "'$COLOR'", force_color: '$FORCE_COLOR', enable_nightlight: '$ENABLE_NIGHTLIGHT', autoclick_enabled: '$AUTOCLICK_ENABLED', autoclick_interval: '$AUTOCLICK_INTERVAL', keyboard: "'$KEYBOARD'"}' > ~/.config/sway/config.json
    ~/.config/sway/scripts/matugen.sh
fi

AUTOCLICK_ENABLED=$(jq -r '.autoclick_enabled' ~/.config/sway/config.json)
AUTOCLICK_INTERVAL=$(jq -r '.autoclick_interval' ~/.config/sway/config.json)

if [ "$AUTOCLICK_ENABLED" = "true" ]; then
    AUTOCLICK_ENABLED="false"
else
    AUTOCLICK_ENABLED="true"
fi

jq ".background = \"$BACKGROUND_FILE\" | .mode = \"$MODE\" | .force_mode = \"$FORCE_MODE\" | .color = \"$COLOR\" | .force_color = \"$FORCE_COLOR\" | .enable_nightlight = $ENABLE_NIGHTLIGHT | .autoclick_enabled = $AUTOCLICK_ENABLED | .autoclick_interval = $AUTOCLICK_INTERVAL" ~/.config/sway/config.json > ~/.config/sway/config.json.tmp && \
mv ~/.config/sway/config.json.tmp ~/.config/sway/config.json


if [ "$AUTOCLICK_ENABLED" = "true" ]; then
    notify-send "Autoclick" "Enabled ($AUTOCLICK_INTERVAL ms)"

    # Stop any existing clicking process
    pkill -f "ydotool.*click"
    
    # Start clicking in background
    while true; do
        export YDOTOOL_SOCKET="/tmp/.ydotool_socket"
        ydotool click 0xC0
        sleep $(awk "BEGIN {print $AUTOCLICK_INTERVAL / 1000}")
    done &
    
    # Save PID for later cleanup
    echo $! > /tmp/autoclick.pid
else
    notify-send "Autoclick" "Disabled"

    # Stop clicking process
    if [ -f /tmp/autoclick.pid ]; then
        kill $(cat /tmp/autoclick.pid) 2>/dev/null
        rm /tmp/autoclick.pid
    fi
    pkill -f "ydotool.*click"
fi