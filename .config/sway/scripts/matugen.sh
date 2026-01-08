#!/bin/bash

BACKGROUND_FILE=$(jrch get background)
# Expand ~ to home directory
BACKGROUND_FILE_EXPANDED="${BACKGROUND_FILE/#\~/$HOME}"
FORCE_COLOR=$(jrch get force_color)
if [ $FORCE_COLOR = true ]; then
    COLOR=$(jrch get color)
else
    COLOR=$(~/.config/sway/scripts/get_color.py $BACKGROUND_FILE_EXPANDED)
fi
FORCE_MODE=$(jrch get force_mode)
if [ $FORCE_MODE = true ]; then
    MODE=$(jrch get mode)
else
    MODE=$(darkman get)
fi 

# matugen
matugen color hex $(~/.config/sway/scripts/get_color.py -color2hex $COLOR) -m $MODE
