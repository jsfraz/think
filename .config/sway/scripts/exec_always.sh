#!/bin/bash

BACKGROUND_FILE="~/.config/sway/backgrounds/LightWaves-b4b59bda185758ebaa2735e4e9fc78a2f7277c64.webp"
COLOR="auto"
FORCE_COLOR=false
MODE="auto"
FORCE_MODE=false

# Create ~/.config/sway/config.json with default background
if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: '$FORCE_MODE', color: "'$COLOR'", force_color: '$FORCE_COLOR'}' > ~/.config/sway/config.json
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
FORCE_MODE=$(jq -r '.force_mode' ~/.config/sway/config.json)
if [ $FORCE_MODE = true ]; then
    MODE=$(jq -r '.mode' ~/.config/sway/config.json)
else
    MODE=$(darkman get)
fi  

# GTK theme
if [ "$COLOR" == "blue" ]; then
    ORCHIS_THEME_NAME="Orchis-${MODE^}-Compact"
else
    ORCHIS_THEME_NAME="Orchis-${COLOR^}-${MODE^}-Compact"
fi
# gsettings list-recursively org.gnome.desktop.interface
gsettings set org.gnome.desktop.interface gtk-theme "$ORCHIS_THEME_NAME"
gsettings set org.gnome.desktop.interface color-scheme "prefer-$MODE"
gsettings set org.gnome.desktop.interface icon-theme "Adwaita-${COLOR}"
# TODO cursor-theme

# Set background image
swaymsg output "*" bg $BACKGROUND_FILE_EXPANDED fill

# matugen
if [ $FORCE_COLOR = true ]; then
    matugen color hex $(~/.config/sway/scripts/get_color.py -hex $BACKGROUND_FILE_EXPANDED) -m $MODE
else
    matugen image $BACKGROUND_FILE_EXPANDED -m $MODE
fi


# ags
ASTAL_BATTERY_DIR=$(dirname $(find /usr -name "*AstalBattery*.typelib" 2>/dev/null))
export GI_TYPELIB_PATH=$ASTAL_BATTERY_DIR:$GI_TYPELIB_PATH
killall -q gjs
while pgrep -x gjs >/dev/null; do sleep 0.1; done
ags run &

# mako
mako
