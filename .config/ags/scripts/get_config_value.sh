#!/bin/bash

COLOR=red
MODE=$(darkman get)

# Create ~/.config/sway/config.json with default background
if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "~/.config/sway/backgrounds/LightWaves-b4b59bda185758ebaa2735e4e9fc78a2f7277c64.webp", mode: "'$MODE'", color: "'$COLOR'"}' > ~/.config/sway/config.json
else
    BACKGROUND_FILE=$(jq -r '.background' ~/.config/sway/config.json)
    COLOR=$(~/.config/sway/scripts/get_color.py $BACKGROUND_FILE)
    jq ".background = \"$BACKGROUND_FILE\" | .mode = \"$MODE\" | .color = \"$COLOR\"" ~/.config/sway/config.json > ~/.config/sway/config.json.tmp && \
    mv ~/.config/sway/config.json.tmp ~/.config/sway/config.json
fi

# Check if property name argument is provided
if [ -z "$1" ]; then
    exit 1
fi

echo $(jq -r ".$1" ~/.config/sway/config.json)