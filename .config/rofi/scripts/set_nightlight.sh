#!/bin/bash

# Check if property name argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <true|false>"
    exit 1
fi

# Create or update ~/.config/sway/config.json
BACKGROUND_FILE="~/.config/sway/backgrounds/LightWaves-b4b59bda185758ebaa2735e4e9fc78a2f7277c64.webp"
COLOR="auto"
FORCE_COLOR=false
MODE="auto"
FORCE_MODE=false
ENABLE_NIGHTLIGHT=true

if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: '$FORCE_MODE', color: "'$COLOR'", force_color: '$FORCE_COLOR', enable_nightlight: '$ENABLE_NIGHTLIGHT'}' > ~/.config/sway/config.json 
elif [ "$1" = $(jq -r '.enable_nightlight' ~/.config/sway/config.json) ]; then
    # Exit if the selected mode is the same as the current one
    exit 0
fi

BACKGROUND_FILE=$(jq -r '.background' ~/.config/sway/config.json)
COLOR=$(jq -r '.color' ~/.config/sway/config.json)
FORCE_COLOR=$(jq -r '.force_color' ~/.config/sway/config.json)
MODE=$(jq -r '.mode' ~/.config/sway/config.json)
FORCE_MODE=$(jq -r '.force_mode' ~/.config/sway/config.json)
ENABLE_NIGHTLIGHT=$1

jq ".background = \"$BACKGROUND_FILE\" | .mode = \"$MODE\" | .force_mode = \"$FORCE_MODE\" | .color = \"$COLOR\" | .force_color = \"$FORCE_COLOR\" | .enable_nightlight = $ENABLE_NIGHTLIGHT" ~/.config/sway/config.json > ~/.config/sway/config.json.tmp && \
mv ~/.config/sway/config.json.tmp ~/.config/sway/config.json

# wlsunset
if [ $ENABLE_NIGHTLIGHT = false ]; then
    killall -q wlsunset
    exit 0
else
    if ! pgrep -x wlsunset >/dev/null; then
        lat=$(grep '^lat:' ~/.config/darkman/config.yaml | awk '{print $2}')
        lng=$(grep '^lng:' ~/.config/darkman/config.yaml | awk '{print $2}')
        wlsunset -l $lat -L $lng &
    fi
fi