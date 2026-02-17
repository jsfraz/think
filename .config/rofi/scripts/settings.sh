#!/usr/bin/env bash

# Theme file
theme="$HOME/.config/rofi/multimenu.rasi"
# Title
settings_title=" Settings"
# Option buttons
appearence=" Appearence"
network="  Network"
bluetooth=" Bluetooth"
sound="  Sound"
keyboard="󰌌 Keyboard"
screensaver="󱄄 Screensaver"
night_light="󱩌 Night light"
power_profile="󰢞 Power profile"

background="󰋩 Background"
mode=" Mode"
color=" Color"

auto_mode="Auto"
dark_mode=" Dark"
light_mode=" Light"

auto_color="Auto"
blue_color="Blue"
green_color="Green"
orange_color="Orange"
pink_color="Pink"
purple_color="Purple"
red_color="Red"
teal_color="Teal"
yellow_color="Yellow"

# rofi command
# $1 - option1\noption2\noption3...
# $2 - message
# $3 - theme string ("listview {columns: 2; lines: 1;}")
# $4 - active row (optional)
run_rofi() {
    local active_flag=""
    if [ -n "$4" ]; then
        active_flag="-a $4"
    fi
    echo -e "$1" | rofi -dmenu \
        -mesg "$2" \
        -theme-str "$3" \
        $active_flag \
        -theme $theme
}

# Run rofi and wait for a choice
current_nightlight=$(jrch get enable_night_light)
# Mark night_light as selected
active_nightlight_element=""
if [ "$current_nightlight" = "true" ]; then
    active_nightlight_element="5"
fi
chosen="$(run_rofi "$appearence\n$network\n$sound\n$keyboard\n$screensaver\n$night_light" "$settings_title" "listview {columns: 3; lines: 2;}" $active_nightlight_element)"
case ${chosen} in
    $appearence)
        chosen_appearance="$(run_rofi "$background\n$mode\n$color" "$appearence" "listview {columns: 3; lines: 1;}")"
        case ${chosen_appearance} in
            $background)
                # Choose background file
                background_file=$(zenity --file-selection \
                    --title="Choose background image" \
                    --filename="$HOME/.config/sway/backgrounds/" \
                    --file-filter="Images | *.jpg *.jpeg *.png *.webp *.bmp" \
                    --file-filter="All files | *")

                # Check if user canceled the selection
                if [ -z "$background_file" ]; then
                    exit 0
                fi
                jrch set background "$background_file"
                # Matugen
                ~/.config/sway/scripts/matugen.sh
                swaymsg reload
                ;;
            $mode)
                current_mode=$(jrch get mode)
                # Mark mode as selected
                active_mode_element=""
                case $current_mode in
                    auto)
                        active_mode_element="0"
                        ;;
                    dark)
                        active_mode_element="1"
                        ;;
                    light)
                        active_mode_element="2"
                        ;;
                esac
                chosen_mode="$(run_rofi "$auto_mode\n$dark_mode\n$light_mode" "$mode" "listview {columns: 3; lines: 1;}" $active_mode_element)"
                chosen_mode=$(echo "$chosen_mode" | sed 's/^.* //' | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
                # Check if user canceled the selection
                if [ -z "$chosen_mode" ]; then
                    exit 0
                fi
                if [ "$chosen_mode" = "auto" ]; then
                    force_mode=false
                else
                    force_mode=true
                fi
                jrch set mode "$chosen_mode"
                jrch set force_mode "$force_mode"
                # Matugen
                ~/.config/sway/scripts/matugen.sh
                swaymsg reload
                ;;
            $color)
                current_color=$(jrch get color)
                # Mark color as selected
                active_color_element=""
                case $current_color in
                    auto)
                        active_color_element="0"
                        ;;
                    blue)
                        active_color_element="1"
                        ;;
                    green)
                        active_color_element="2"
                        ;;
                    orange)
                        active_color_element="3"
                        ;;
                    pink)
                        active_color_element="4"
                        ;;
                    purple)
                        active_color_element="5"
                        ;;
                    red)
                        active_color_element="6"
                        ;;
                    teal)
                        active_color_element="7"
                        ;;
                    yellow)
                        active_color_element="8"
                        ;;
                esac
                chosen_color="$(run_rofi "$auto_color\n$blue_color\n$green_color\n$orange_color\n$pink_color\n$purple_color\n$red_color\n$teal_color\n$yellow_color" "$color" "listview {columns: 3; lines: 3;}" $active_color_element)"
                chosen_color=$(echo "$chosen_color" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
                # Check if user canceled the selection
                if [ -z "$chosen_color" ]; then
                    exit 0
                fi
                if [ "$chosen_color" = "auto" ]; then
                    force_color=false
                else
                    force_color=true
                fi
                jrch set color "$chosen_color"
                jrch set force_color "$force_color"
                # matugen
                ~/.config/sway/scripts/matugen.sh
                swaymsg reload
                ;;
        esac
        ;;
    $network)
        networkmanager_dmenu
        ;;
    $sound)
        pavucontrol
        ;;
    $keyboard)
        current_keyboard=$(jrch get keyboard)
        # Mark keyboard as selected
        active_keyboard_element=""
        case $current_keyboard in
            cz)
                active_keyboard_element="0"
                ;;
            us)
                active_keyboard_element="1"
                ;;
        esac
        # Switch keyboard layout
        chosen_keyboard="$(run_rofi "cz\nus" "$keyboard" "listview {columns: 2; lines: 1;}" $active_keyboard_element)"
        chosen_keyboard=$(echo "$chosen_keyboard" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
        # Check if user canceled the selection
        if [ -z "$chosen_keyboard" ]; then
            exit 0
        fi
        jrch set keyboard "$chosen_keyboard"
        swaymsg input type:keyboard xkb_layout "$chosen_keyboard"
        ;;
    $screensaver)
        current_screensaver=$(jrch get screensaver)
        # Mark screensaver as selected
        active_screensaver_element=""
        case $current_screensaver in
            none)
                active_screensaver_element="0"
                ;;
            random)
                active_screensaver_element="1"
                ;;
            matrix)
                active_screensaver_element="2"
                ;;
            pipes)
                active_screensaver_element="3"
                ;;
            aquarium)
                active_screensaver_element="4"
                ;;
            lavalamp)
                active_screensaver_element="5"
                ;;
            hollywood)
                active_screensaver_element="6"
                ;;
            train)
                active_screensaver_element="7"
                ;;
            weather)
                active_screensaver_element="8"
                ;;
        esac
        # Choose screensaver
        chosen_screensaver="$(run_rofi "None\nRandom\nMatrix\nPipes\nAquarium\nLavalamp\nHollywood\nTrain\nWeather" "$screensaver" "listview {columns: 3; lines: 3;}" $active_screensaver_element)"
        chosen_screensaver=$(echo "$chosen_screensaver" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
        # Check if user canceled the selection
        if [ -z "$chosen_screensaver" ]; then
            exit 0
        fi
        jrch set screensaver "$chosen_screensaver"
        ;;
    $night_light)
        current_night_light=$(jrch get enable_night_light)
        case $current_night_light in
            true)
                jrch set enable_night_light false
                ;;
            false)
                jrch set enable_night_light true
                ;;
        esac
        # wlsunset
        ~/.config/sway/scripts/wlsunset.sh
        ;;
    $bluetooth)
        # TODO
        ;;
    $power_profile)
        # TODO
        ;;
esac
