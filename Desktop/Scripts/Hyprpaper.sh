#!/usr/bin/env bash
#
# Documentation:
#───────────────
# • https://github.com/hyprwm/hyprpaper?tab=readme-ov-file#usage
#
# Relevant issues:
#─────────────────
# • https://github.com/hyprwm/hyprpaper/issues/85
#
# Depedencies:
#─────────────
# • [zenity]
#   https://gitlab.gnome.org/GNOME/zenity
#
# • [libnotify]
#   https://gitlab.gnome.org/GNOME/libnotify
#
# • [hyprpaper]
#   https://github.com/hyprwm/hyprpaper

# Closes on error.
set -euo pipefail

# Wallpaper selection menu
Wallpaper=$(zenity \
	--file-selection \
	--filename="$HOME/Images/Backgrounds/ /" \
	--file-filter="*.png *.jpg *.jpeg *.webp" \
	--title="Select an image")

case $? in
	# Put the selected wallpaper into hyprpaper's configuration file.
	0) echo -e \
		"preload = $Wallpaper\nwallpaper = ,$Wallpaper\nsplash = false\nipc = off" \
		> "$HOME/.config/hypr/hyprpaper.conf" ;

		# Kills hyprpaper if it is already running or not, then continues.
		pkill --exact "hyprpaper" || true ;

		# Buffer wait, then launch hyprpaper with the desired wallpaper.
		sleep 0.1 && hyprpaper & disown;;

	# Send a message if not wallpaper has been selected.
	1) notify-send "No wallpaper has been selected.";;

	# Send a message if another error occurs.
	-1) notify-send "An unexpected error occured. Run this script from a terminal emulator for further output.";;

esac
