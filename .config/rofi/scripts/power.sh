#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x

# Theme file
theme="$HOME/.config/rofi/power.rasi"
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

# Run rofi and wait for a choice
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
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

