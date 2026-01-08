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
    FORCE_MODE=$(jrch get force_mode)

    # Check whether the mode actually changed
    if [ $FORCE_MODE = true ]; then
        # Mode is forced, exit
        exit 0
    fi

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

notify-send "Changed theme" "Time for $(darkman get) theme"