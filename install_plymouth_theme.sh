#!/bin/bash

# TODO maybe change theme to https://github.com/gevera/plymouth_themes/tree/master/thinkpad

paru -S plymouth-theme-arch-logo
sudo plymouth-set-default-theme -R arch-logo