#!/bin/bash

# Check if property name argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <color|auto>"
    exit 1
fi

# Create or update ~/.config/sway/config.json
BACKGROUND_FILE="~/.config/sway/backgrounds/LightWaves-b4b59bda185758ebaa2735e4e9fc78a2f7277c64.webp"
COLOR="auto"
FORCE_COLOR=false
MODE="auto"
FORCE_MODE=false

if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: '$FORCE_MODE', color: "'$COLOR'", force_color: '$FORCE_COLOR'}' > ~/.config/sway/config.json 
fi

BACKGROUND_FILE=$(jq -r '.background' ~/.config/sway/config.json)
MODE=$(jq -r '.mode' ~/.config/sway/config.json)
FORCE_MODE=$(jq -r '.force_mode' ~/.config/sway/config.json)

if [ "$1" = "auto" ]; then
    FORCE_COLOR=false
    COLOR="auto"
else
    FORCE_COLOR=true
    COLOR=$1
fi

jq ".background = \"$BACKGROUND_FILE\" | .mode = \"$MODE\" | .force_mode = \"$FORCE_MODE\" | .color = \"$COLOR\" | .force_color = \"$FORCE_COLOR\"" ~/.config/sway/config.json > ~/.config/sway/config.json.tmp && \
mv ~/.config/sway/config.json.tmp ~/.config/sway/config.json

swaymsg reload
