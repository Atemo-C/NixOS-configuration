#!/bin/dash

# Executeables shortcut.
SW="/run/current-system/sw/bin"

# Check if the required dependencies are installed.
[ -f "$HM/hyprland" ] || [ -f "$SW/hyprland" ] || { notify-send "This color picker is made for Hyprland."; exit 1; }
[ -f "$SW/hyprpicker" ] || { notify-send "hyprpicker is not installed."; exit 1; }
[ -f "$SW/notify-send" ] || { echo "notify-send is not installed."; exit 1; }

# Pick a color on the screen, save it to the clipboard, and send a notification.
Color="$(hyprpicker -f hex --autocopy)" && notify-send -t 1500 "$Color copied to the clipboard"
