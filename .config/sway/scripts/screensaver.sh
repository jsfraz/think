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
SCREENSAVER=$(jrch get screensaver)
# Check if screensaver is set to none
if [ "$SCREENSAVER" = "none" ]; then
    exit 0
fi

# Kill rofi
killall -q rofi

# Set random screensaver if selected
if [ "$SCREENSAVER" = "random" ]; then
    SCREENSAVER_OPTIONS=("matrix" "pipes" "aquarium" "lavalamp" "hollywood" "train" "weather")
    RANDOM_INDEX=$((RANDOM % ${#SCREENSAVER_OPTIONS[@]}))
    SCREENSAVER=${SCREENSAVER_OPTIONS[$RANDOM_INDEX]}
fi

COLOR_HEX=$(~/.config/sway/scripts/get_color.py -color2hex $COLOR)

case $SCREENSAVER in
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
        color_lighter_hex=$(~/.config/sway/scripts/get_color.py -color2hex -lighten $COLOR)
        foot -a screensaver lavat -c ${color_lighter_hex#\#} -k ${COLOR_HEX#\#} -g
        ;;
    hollywood)
        foot -a screensaver --font="FiraCode Nerd Font Mono":size=10 bash -c "sleep 0.1 && hollywood"
        ;;
    train)
        foot -a screensaver --font="FiraCode Nerd Font Mono":size=10 bash -c "sleep 0.1 && while true; do sl -ec3; sleep 2; done"
        ;;
    weather)
        foot -a screensaver --font="FiraCode Nerd Font Mono":size=10 bash -c "sleep 0.1 && weathr"
        ;;
    *)
        notify-send "Screensaver Error" "Unknown screensaver: $SCREENSAVER"
        ;;
esac

# It is important to start screensaver in foot terminal with ID "screensaver"