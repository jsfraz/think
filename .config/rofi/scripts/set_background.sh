#!/bin/bash

# Choose background file
BACKGROUND_FILE=$(zenity --file-selection \
    --title="Choose background image" \
    --filename="$HOME/.config/sway/backgrounds/" \
    --file-filter="Images | *.jpg *.jpeg *.png *.webp *.bmp" \
    --file-filter="All files | *")

# Check if user canceled the selection
if [ -z "$BACKGROUND_FILE" ]; then
    exit 0
fi

# Create or update ~/.config/sway/config.json with background path
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
elif [ "$BACKGROUND_FILE" = $(jq -r '.background' ~/.config/sway/config.json) ]; then
    # Exit if the selected background is the same as the current one
    exit 0
fi

COLOR=$(jq -r '.color' ~/.config/sway/config.json)
FORCE_COLOR=$(jq -r '.force_color' ~/.config/sway/config.json)
MODE=$(jq -r '.mode' ~/.config/sway/config.json)
FORCE_MODE=$(jq -r '.force_mode' ~/.config/sway/config.json)
ENABLE_NIGHTLIGHT=$(jq -r '.enable_nightlight' ~/.config/sway/config.json)
KEYBOARD=$(jq -r '.keyboard' ~/.config/sway/config.json)

jq ".background = \"$BACKGROUND_FILE\" | .mode = \"$MODE\" | .force_mode = \"$FORCE_MODE\" | .color = \"$COLOR\" | .force_color = \"$FORCE_COLOR\" | .enable_nightlight = $ENABLE_NIGHTLIGHT | .autoclick_enabled = $AUTOCLICK_ENABLED | .autoclick_interval = $AUTOCLICK_INTERVAL | .keyboard = \"$KEYBOARD\"" ~/.config/sway/config.json > ~/.config/sway/config.json.tmp && \
mv ~/.config/sway/config.json.tmp ~/.config/sway/config.json

# matugen
~/.config/sway/scripts/matugen.sh

swaymsg reload