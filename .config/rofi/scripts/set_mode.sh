#!/bin/bash

# Check if property name argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <dark|light|auto>"
    exit 1
fi

# Create or update ~/.config/sway/config.json
BACKGROUND_FILE="~/.config/sway/backgrounds/LightWaves-b4b59bda185758ebaa2735e4e9fc78a2f7277c64.webp"
COLOR="auto"
FORCE_COLOR=false
MODE="auto"
FORCE_MODE=false
ENABLE_NIGHTLIGHT=true
AUTOCLICK_ENABLED=false
AUTOCLICK_INTERVAL=1000
KEYBOARD=cs

if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: '$FORCE_MODE', color: "'$COLOR'", force_color: '$FORCE_COLOR', enable_nightlight: '$ENABLE_NIGHTLIGHT', autoclick_enabled: '$AUTOCLICK_ENABLED', autoclick_interval: '$AUTOCLICK_INTERVAL', keyboard: "'$KEYBOARD'"}' > ~/.config/sway/config.json 
elif [ "$1" = $(jq -r '.mode' ~/.config/sway/config.json) ]; then
    # Exit if the selected mode is the same as the current one
    exit 0
fi

BACKGROUND_FILE=$(jq -r '.background' ~/.config/sway/config.json)
COLOR=$(jq -r '.color' ~/.config/sway/config.json)
FORCE_COLOR=$(jq -r '.force_color' ~/.config/sway/config.json)
ENABLE_NIGHTLIGHT=$(jq -r '.enable_nightlight' ~/.config/sway/config.json)
KEYBOARD=$(jq -r '.keyboard' ~/.config/sway/config.json)

if [ "$1" = "auto" ]; then
    FORCE_MODE=false
    MODE="auto"
else
    FORCE_MODE=true
    MODE=$1
fi

jq ".background = \"$BACKGROUND_FILE\" | .mode = \"$MODE\" | .force_mode = \"$FORCE_MODE\" | .color = \"$COLOR\" | .force_color = \"$FORCE_COLOR\" | .enable_nightlight = $ENABLE_NIGHTLIGHT | .autoclick_enabled = $AUTOCLICK_ENABLED | .autoclick_interval = $AUTOCLICK_INTERVAL | .keyboard = \"$KEYBOARD\"" ~/.config/sway/config.json > ~/.config/sway/config.json.tmp && \
mv ~/.config/sway/config.json.tmp ~/.config/sway/config.json

# matugen
~/.config/sway/scripts/matugen.sh

swaymsg reload
