#!/bin/bash

# TODO other screensavers: starwars, sl...!

BACKGROUND_FILE="~/.config/sway/backgrounds/LightWaves-b4b59bda185758ebaa2735e4e9fc78a2f7277c64.webp"
COLOR="auto"
FORCE_COLOR=false
MODE="auto"
FORCE_MODE=false
ENABLE_NIGHTLIGHT=true
AUTOCLICK_ENABLED=false
AUTOCLICK_INTERVAL=1000
KEYBOARD=cs
SCREENSAVER=matrix

# Create ~/.config/sway/config.json with default background
if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: '$FORCE_MODE', color: "'$COLOR'", force_color: '$FORCE_COLOR', enable_nightlight: '$ENABLE_NIGHTLIGHT', autoclick_enabled: '$AUTOCLICK_ENABLED', autoclick_interval: '$AUTOCLICK_INTERVAL', keyboard: "'$KEYBOARD'", screensaver: "'$SCREENSAVER'"}' > ~/.config/sway/config.json
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
SCREENSAVER=$(jq -r '.screensaver' ~/.config/sway/config.json)

# Check if screensaver is set to none
if [ "$SCREENSAVER" = "none" ]; then
    exit 0
fi

# Kill rofi
killall -q rofi

# Set random screensaver if selected
if [ "$SCREENSAVER" = "random" ]; then
    SCREENSAVER_OPTIONS=("matrix" "pipes" "aquarium" "lavalamp" "hollywood" "train")
    RANDOM_INDEX=$((RANDOM % ${#SCREENSAVER_OPTIONS[@]}))
    SCREENSAVER=${SCREENSAVER_OPTIONS[$RANDOM_INDEX]}
fi

COLOR_HEX=$(~/.config/sway/scripts/get_color.py -color2hex $COLOR)

case $SCREENSAVER in
    # TODO
    matrix)
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
        foot -a screensaver --font="FiraCode Nerd Font Mono":size=14 neo-matrix -aF --colormode 256 -c $MATRIX_COLOR
        ;;
    pipes)
        foot -a screensaver --font="FiraCode Nerd Font Mono":size=20 bash -c "sleep 0.1 && pipes.sh"             
        ;;
    aquarium)
        foot -a screensaver --font="FiraCode Nerd Font Mono":size=14 asciiquarium
        ;;
    lavalamp)
        foot -a screensaver --font="FiraCode Nerd Font Mono":size=5 lavat -c ${COLOR_HEX#\#} -k ${COLOR_HEX#\#} -g
        ;;
    hollywood)
        foot -a screensaver --font="FiraCode Nerd Font Mono":size=10 bash -c "sleep 0.1 && hollywood"
        ;;
    train)
        foot -a screensaver --font="FiraCode Nerd Font Mono":size=10 bash -c "sleep 0.1 && while true; do sl -c3; sleep 2; done"
        ;;
    *)
        notify-send "Screensaver Error" "Unknown screensaver: $SCREENSAVER"
        ;;
esac

# It is important to start screensaver in foot terminal with ID "screensaver"