#!/bin/bash

# Programs to start on sway launch

# KDE Connect
/usr/bin/kdeconnectd &
kdeconnect-indicator &

# Mega
sleep 1; megasync &
sleep 2; swaymsg '[class="MEGAsync"] move scratchpad'

# Betterbird
betterbird &
sleep 3; swaymsg '[app_id="betterbird"] move scratchpad'