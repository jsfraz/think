#!/bin/bash

BACKGROUND_FILE="~/.config/sway/backgrounds/LightWaves-b4b59bda185758ebaa2735e4e9fc78a2f7277c64.webp"
COLOR="auto"
FORCE_COLOR=false
MODE="auto"
FORCE_MODE=false

# Create ~/.config/sway/config.json with default background
if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: '$FORCE_MODE', color: "'$COLOR'", force_color: '$FORCE_COLOR'}' > ~/.config/sway/config.json
    ~/.config/sway/scripts/matugen.sh
fi

BACKGROUND_FILE=$(jq -r '.background' ~/.config/sway/config.json)
# Expand ~ to home directory
BACKGROUND_FILE_EXPANDED="${BACKGROUND_FILE/#\~/$HOME}"
FORCE_COLOR=$(jq -r '.force_color' ~/.config/sway/config.json)
if [ $FORCE_COLOR = true ]; then
    COLOR=$(jq -r '.color' ~/.config/sway/config.json)
else
    COLOR=$(~/.config/sway/scripts/get_color.py $BACKGROUND_FILE_EXPANDED)
fi

# Supported config colors: red, blue, green orange, pink, purple, red, teal, yellow
# Chosen supported neo-matrix colors: green, red, blue, cyan, purple, yellow, orange, pink
case ${COLOR} in
    red|blue|green|purple|yellow|orange|pink)
        # These colors are directly supported by neo-matrix
        MATRIX_COLOR=$COLOR
        ;;
    teal)
        # Teal is closest to cyan
        MATRIX_COLOR="cyan"
        ;;
    *)
        # Default fallback to green (classic matrix color)
        MATRIX_COLOR="green"
        ;;
esac

# Start camtrix-like screensaver in foot terminal with ID "screensaver"
foot -a screensaver --font="FiraCode Nerd Font Mono":size=14 neo-matrix -aF --colormode 256 -c $MATRIX_COLOR