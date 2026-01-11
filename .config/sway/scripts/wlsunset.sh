#!/bin/bash

ENABLE_NIGHT_LIGHT=$(jrch get enable_night_light)
if [ $ENABLE_NIGHT_LIGHT = false ]; then
    killall -q wlsunset
    exit 0
else
    if ! pgrep -x wlsunset >/dev/null; then
        lat=$(grep '^lat:' ~/.config/darkman/config.yaml | awk '{print $2}')
        lng=$(grep '^lng:' ~/.config/darkman/config.yaml | awk '{print $2}')
        wlsunset -t 0 -T 10000 -l $lat -L $lng &
    fi
fi