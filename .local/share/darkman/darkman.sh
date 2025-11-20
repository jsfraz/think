#!/bin/bash

# Wait for Sway to be running and socket to be available (max 10 seconds)
for i in {1..20}; do
    SWAY_PID=$(pgrep -x sway)
    if [ -n "$SWAY_PID" ]; then
        # https://github.com/swaywm/sway/issues/3769#issuecomment-1807181019
        export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).${SWAY_PID}.sock
        if [ -S "$SWAYSOCK" ]; then
            break
        fi
    fi
    sleep 0.5
done

# Check if socket is available before trying to reload
if [ -n "$SWAYSOCK" ] && [ -S "$SWAYSOCK" ]; then
    BACKGROUND_FILE="~/.config/sway/backgrounds/Road-aa422ff7289e3617adecf8df5349931de0992eab.webp"
    COLOR="auto"
    FORCE_COLOR=false
    MODE=auto
    FORCE_MODE=false

    # Create ~/.config/sway/config.json with default background
    if [ ! -f ~/.config/sway/config.json ]; then
        jq -n '{background: "'$BACKGROUND_FILE'", mode: "'$MODE'", force_mode: '$FORCE_MODE', color: "'$COLOR'", force_color: '$FORCE_COLOR'}' > ~/.config/sway/config.json
    fi

    # Check whether the mode actually changed
    if [ "$(darkman get)" = "$(jq -r '.mode' ~/.config/sway/config.json)" ] || [ $(jq -r '.force_mode' ~/.config/sway/config.json) = true ]; then
        exit 0
    fi

    BACKGROUND_FILE=$(jq -r '.background' ~/.config/sway/config.json)
    FORCE_COLOR=$(jq -r '.force_color' ~/.config/sway/config.json)
    COLOR=$(jq -r '.color' ~/.config/sway/config.json)
    MODE=$(darkman get)
    FORCE_MODE=$(jq -r '.force_mode' ~/.config/sway/config.json)

    jq ".background = \"$BACKGROUND_FILE\" | .mode = \"$MODE\" | .force_mode = \"$FORCE_MODE\" | .color = \"$COLOR\" | .force_color = \"$FORCE_COLOR\"" ~/.config/sway/config.json > ~/.config/sway/config.json.tmp && \
    mv ~/.config/sway/config.json.tmp ~/.config/sway/config.json

    # matugen
    ~/.config/sway/scripts/matugen.sh

    swaymsg reload
else
    echo "Sway socket not available, skipping reload" >&2
    exit 0
fi

# Wait for notification service to be available (max 5 seconds)
if ! pgrep -x mako > /dev/null; then
    for i in {1..10}; do
        if pgrep -x mako > /dev/null; then
            break
        fi
        sleep 0.5
    done
    # Additional wait for notification daemon
    sleep 1
fi

notify-send "Changed theme" "$(darkman get)"