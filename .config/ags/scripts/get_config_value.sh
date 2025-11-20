#!/bin/bash

BACKGROUND_FILE="~/.config/sway/backgrounds/LightWaves-b4b59bda185758ebaa2735e4e9fc78a2f7277c64.webp"
COLOR=""
FORCE_COLOR=false
MODE=$(darkman get)
FORCE_MODE=false

# Create ~/.config/sway/config.json with default background
if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: "'$FORCE_MODE'", color: "'$COLOR'", force_color: "'$FORCE_COLOR'"}' > ~/.config/sway/config.json
fi

# Check if property name argument is provided
if [ -z "$1" ]; then
    exit 1
fi

echo $(jq -r ".$1" ~/.config/sway/config.json)