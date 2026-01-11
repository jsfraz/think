#!/bin/bash

# Programs to start on sway launch

# KDE Connect
/usr/bin/kdeconnectd &
kdeconnect-indicator &

# Mega
sleep 1; megasync &

# Betterbird
betterbird &
sleep 3; swaymsg '[app_id="betterbird"] move to workspace 2'