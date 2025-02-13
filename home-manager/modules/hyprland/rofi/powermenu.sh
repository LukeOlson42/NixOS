#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5
## style-6   style-7   style-8   style-9   style-10

# Current Theme
dir="$HOME/NixOS/home-manager/modules/hyprland/rofi"
theme='powermenu'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown=' '
reboot=' '
lock=' '
logout='󰍃'

yes=' '
no=' '

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi \
        -hover-select \
        -me-select-entry '' \
        -me-accept-entry MousePrimary
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/${theme}.rasi \
        -hover-select \
        -me-select-entry '' \
        -me-accept-entry MousePrimary
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [[ $1 == '--shutdown' ]]; then
        if [[ "$selected" == "$yes" ]]; then
            systemctl poweroff
        fi
    elif [[ $1 == '--reboot' ]]; then
        if [[ "$selected" == "$yes" ]]; then
            systemctl reboot
        fi
    elif [[ $1 == '--logout' ]]; then
        if [[ "$selected" == "$yes" ]]; then
            hyprctl dispatch exit
        fi
    else
        return 0
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
        hyprlock
        ;;
    $logout)
		run_cmd --logout
        ;;
    *)
        ;;
esac
