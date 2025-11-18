#!/bin/bash

COLOR=red
MODE=$(darkman get)

# Create ~/.config/sway/config.json with default background
if [ ! -f ~/.config/sway/config.json ]; then
    jq -n '{background: "", mode: "'$MODE'", color: "'$COLOR'"}' > ~/.config/sway/config.json
fi

# Check if property name argument is provided
if [ -z "$1" ]; then
    exit 1
fi

echo $(jq -r ".$1" ~/.config/sway/config.json)