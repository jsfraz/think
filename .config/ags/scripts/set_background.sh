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

if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: '$FORCE_MODE', color: "'$COLOR'", force_color: '$FORCE_COLOR'}' > ~/.config/sway/config.json
fi

COLOR=$(jq -r '.color' ~/.config/sway/config.json)
FORCE_COLOR=$(jq -r '.force_color' ~/.config/sway/config.json)
MODE=$(jq -r '.mode' ~/.config/sway/config.json)
FORCE_MODE=$(jq -r '.force_mode' ~/.config/sway/config.json)

jq ".background = \"$BACKGROUND_FILE\" | .mode = \"$MODE\" | .force_mode = \"$FORCE_MODE\" | .color = \"$COLOR\" | .force_color = \"$FORCE_COLOR\"" ~/.config/sway/config.json > ~/.config/sway/config.json.tmp && \
mv ~/.config/sway/config.json.tmp ~/.config/sway/config.json

swaymsg reload