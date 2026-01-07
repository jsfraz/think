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
current_nightlight=$(~/.config/rofi/scripts/get_config_value.sh enable_nightlight)
# Mark night_light as selected
active_nightlight_element=""
if [ "$current_nightlight" = "true" ]; then
    active_nightlight_element="4"
fi
chosen="$(run_rofi "$appearence\n$network\n$sound\n$keyboard\n$night_light" "$settings_title" "listview {columns: 3; lines: 2;}" $active_nightlight_element)"
case ${chosen} in
    $appearence)
        chosen_appearance="$(run_rofi "$background\n$mode\n$color" "$appearence" "listview {columns: 3; lines: 1;}")"
        case ${chosen_appearance} in
            $background)
                ~/.config/rofi/scripts/set_background.sh
                ;;
            $mode)
                current_mode=$(~/.config/rofi/scripts/get_config_value.sh mode)
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
                chosen_mode="$(run_rofi "$auto_mode\n$dark_mode\n$light_mode" "$mode (${current_mode^})" "listview {columns: 3; lines: 1;}" $active_mode_element)"
                chosen_mode=$(echo "$chosen_mode" | sed 's/^.* //' | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
                ~/.config/rofi/scripts/set_mode.sh $chosen_mode
                ;;
            $color)
                current_color=$(~/.config/rofi/scripts/get_config_value.sh color)
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
                chosen_color="$(run_rofi "$auto_color\n$blue_color\n$green_color\n$orange_color\n$pink_color\n$purple_color\n$red_color\n$teal_color\n$yellow_color" "$color (${current_color^})" "listview {columns: 3; lines: 3;}" $active_color_element)"
                chosen_color=$(echo "$chosen_color" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
                echo $chosen_color
                ~/.config/rofi/scripts/set_color.sh $chosen_color
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
        current_keyboard=$(~/.config/rofi/scripts/get_config_value.sh keyboard)
        # Mark keyboard as selected
        active_keyboard_element=""
        case $current_keyboard in
            cs)
                active_keyboard_element="0"
                ;;
            us)
                active_keyboard_element="1"
                ;;
        esac
        # Switch keyboard layout
        chosen_keyboard="$(run_rofi "cz\nus" "$keyboard (${current_keyboard})" "listview {columns: 2; lines: 1;}" $active_keyboard_element)"
        chosen_keyboard=$(echo "$chosen_keyboard" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
        ~/.config/rofi/scripts/set_keyboard.sh $chosen_keyboard
        swaymsg input type:keyboard xkb_layout "$chosen_keyboard"
        ;;  
    $night_light)
        current_nightlight=$(~/.config/rofi/scripts/get_config_value.sh enable_nightlight)
        case $current_nightlight in
            true)
                ~/.config/rofi/scripts/set_nightlight.sh false
                ;;
            false)
                ~/.config/rofi/scripts/set_nightlight.sh true
                ;;
        esac
        ;;
    $bluetooth)
        # TODO
        ;;
    $power_profile)
        # TODO
        ;;
esac
