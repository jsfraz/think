#!/bin/bash

ENABLE_NIGHTLIGHT=$(jq -r '.enable_nightlight' ~/.config/sway/config.json)
if [ $ENABLE_NIGHTLIGHT = false ]; then
    killall -q wlsunset
    exit 0
else
    if ! pgrep -x wlsunset >/dev/null; then
        lat=$(grep '^lat:' ~/.config/darkman/config.yaml | awk '{print $2}')
        lng=$(grep '^lng:' ~/.config/darkman/config.yaml | awk '{print $2}')
        wlsunset -l $lat -L $lng &
    fi
fi