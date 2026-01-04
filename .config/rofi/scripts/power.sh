#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x

# Theme files
theme="$HOME/.config/rofi/power.rasi"
yes_no_theme="$HOME/.config/rofi/multimenu.rasi"
# Info variables
name=$(grep ^NAME= /etc/os-release | cut -d= -f2- | tr -d '"')
name_icon=""
case $name in
	"Arch Linux") name_icon="" ;;
	*) name_icon="" ;;
esac
pretty_name="$name_icon $(grep ^PRETTY_NAME= /etc/os-release | cut -d= -f2- | tr -d '"')"
host="$USER@$HOSTNAME"
uptime="`uptime -p | sed -e 's/up //g'`"
# Option buttons
shutdown=""
reboot=""
lock=""
suspend=""

yes=" Yes"
no=" No"

# rofi command
rofi_cmd() {
    rofi -dmenu \
        -p "$host" \
        -mesg "Uptime: $uptime" \
        -theme-str "textbox-prompt-colon {str: \"$pretty_name\";}" \
        -theme $theme
}

# Run rofi and pass variables to rofi dmenu
run_rofi() {
	echo -e "$shutdown\n$reboot\n$lock\n$suspend" | rofi_cmd
}

# Yes/no dialog
# $1 - message
# $2 - theme string ("listview {columns: 2; lines: 1;}")
run_yes_no() {
    echo -e "$yes\n$no" | rofi -dmenu \
        -mesg "$1" \
        -theme-str "$2" \
        -theme $yes_no_theme
}

# Run rofi and wait for a choice
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        yes_no="$(run_yes_no "Shutdown now?" "window {width: 20%;} listview {columns: 2; lines: 1}")"
        case ${yes_no} in
            $yes)
                systemctl poweroff
                ;;
        esac
        ;;
    $reboot)
        yes_no="$(run_yes_no "Reboot now?" "window {width: 20%;} listview {columns: 2; lines: 1;}")"
        case ${yes_no} in
            $yes)
                systemctl reboot
                ;;
        esac
        ;;
    $lock)
        ~/.config/sway/scripts/lockscreen.sh
        ;;
    $suspend)
        ~/.config/sway/scripts/lockscreen.sh
        systemctl suspend
        # TODO psmouse
        ;;
esac
