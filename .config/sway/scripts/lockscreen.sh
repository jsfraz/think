#!/bin/bash

BACKGROUND_FILE=$(jrch get background)
# Expand ~ to home directory
BACKGROUND_FILE_EXPANDED="${BACKGROUND_FILE/#\~/$HOME}"

swaylock -f -i "$BACKGROUND_FILE_EXPANDED"