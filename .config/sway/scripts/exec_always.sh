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
# Set keyboard layout
KEYBOARD=$(jrch get keyboard)
swaymsg input type:keyboard xkb_layout "$KEYBOARD"

# Stop swayosd-server
killall -q swayosd-server

# Stop ags
killall -q gjs
while pgrep -x gjs >/dev/null; do sleep 0.001; done

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

# wlsunset
~/.config/sway/scripts/wlsunset.sh

# TODO conky weather
# TODO conky system load

# Start swayosd-server
swayosd-server > /dev/null 2>&1 &
disown

# ags
ASTAL_BATTERY_DIR=$(dirname $(find /usr -name "*AstalBattery*.typelib" 2>/dev/null))
export GI_TYPELIB_PATH=$ASTAL_BATTERY_DIR:$GI_TYPELIB_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ags run &

# mako
mako
