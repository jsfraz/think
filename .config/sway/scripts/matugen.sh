#!/bin/bash

BACKGROUND_FILE=$(jq -r '.background' ~/.config/sway/config.json)
# Expand ~ to home directory
BACKGROUND_FILE_EXPANDED="${BACKGROUND_FILE/#\~/$HOME}"
FORCE_COLOR=$(jq -r '.force_color' ~/.config/sway/config.json)
if [ $FORCE_COLOR = true ]; then
    COLOR=$(jq -r '.color' ~/.config/sway/config.json)
else
    COLOR=$(~/.config/sway/scripts/get_color.py $BACKGROUND_FILE_EXPANDED)
fi
FORCE_MODE=$(jq -r '.force_mode' ~/.config/sway/config.json)
if [ $FORCE_MODE = true ]; then
    MODE=$(jq -r '.mode' ~/.config/sway/config.json)
else
    MODE=$(darkman get)
fi 

# matugen
if [ $FORCE_COLOR = true ]; then
    matugen color hex $(~/.config/sway/scripts/get_color.py -color2hex $COLOR) -m $MODE
else
    matugen image $BACKGROUND_FILE_EXPANDED -m $MODE
fi