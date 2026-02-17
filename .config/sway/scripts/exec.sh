#!/bin/bash

# Programs to start on sway launch

# KDE Connect
/usr/bin/kdeconnectd &
kdeconnect-indicator &

# Mega
sleep 1; megasync &
sleep 4; swaymsg '[class="MEGAsync"] move scratchpad'

# Betterbird
betterbird &
sleep 3; swaymsg '[app_id="betterbird"] move scratchpad'

# wayvnc
wayvnc 0.0.0.0 -f 60 -k $(jrch get keyboard) &
