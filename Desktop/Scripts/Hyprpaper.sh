#!/usr/bin/env bash

set -euo pipefail

Wallpaper=$(zenity \
	--file-selection \
	--filename="$HOME/Images/Backgrounds/ /" \
	--file-filter="*.png *.jpg *.jpg *.jpeg *.webp" \
	--title="Select an image")
# Removed the "*.jxl" extension support, for now.
# See https://github.com/hyprwm/hyprpaper/issues/85

case $? in
	0) echo -e \
		"preload = $Wallpaper\nwallpaper = ,$Wallpaper\nsplash = false\nipc = off" \
		> "$HOME/.config/hypr/hyprpaper.conf" ;
		killall hyprpaper || true ;
		sleep 1 &&
		hyprpaper & disown;;
	1) notify-send "No wallpaper has been selected.";;
	-1) notify-send "An unexpected error has occured - Run this program from the terminal.";;
esac
