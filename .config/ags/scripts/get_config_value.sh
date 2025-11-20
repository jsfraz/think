#!/bin/bash

BACKGROUND_FILE="~/.config/sway/backgrounds/Road-aa422ff7289e3617adecf8df5349931de0992eab.webp"
COLOR="auto"
FORCE_COLOR=false
MODE="auto"
FORCE_MODE=false

# Create ~/.config/sway/config.json with default background
if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: '$FORCE_MODE', color: "'$COLOR'", force_color: '$FORCE_COLOR'}' > ~/.config/sway/config.json
fi

# Check if property name argument is provided
if [ -z "$1" ]; then
    exit 1
fi

echo $(jq -r ".$1" ~/.config/sway/config.json)