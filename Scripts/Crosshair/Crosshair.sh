#!/usr/bin/env bash

# Starts the crosshair.
if [[ "$1" == "--start" || "$1" == "-s" ]]; then
	feh /etc/nixos/Scripts/Crosshair/Crosshair.png & sleep 0.5 &&
	hyprctl dispatch togglefloating class:feh &&
	hyprctl dispatch setprop class:feh minsize 4 4 &&
	hyprctl dispatch setprop class:feh maxsize 4 4 &&
	hyprctl dispatch resizewindowpixel 4 4, class:feh &&
	hyprctl dispatch setprop class:feh bordersize 0 &&
	hyprctl dispatch setprop class:feh rounding 3 &&
	hyprctl dispatch setprop class:feh noshadow 1 &&
	hyprctl dispatch centerwindow class:feh &&
	hyprctl dispatch setprop class:feh nofocus true &&
	hyprctl dispatch pin class:feh

# Kills the crosshair.
elif [[ "$1" == "--kill" || "$1" == "-k" ]]; then
	pkill feh && notify-send "Crosshair/s killed".

# Errors out if no argument or an unvalid one is given.
else
	echo "
  $(tput setaf1)$(tput bold)Error$(tput sgr0): Missing or invalid argument.
  You can use the $(tput setaf 2)--start$(tput sgr0) / $(tput setaf 2)-s$(tput sgr0) or the $(tput setaf 2)--kill$(tput sgr0) / $(tput setaf 2)-k$(tput sgr0) argument.
	"
	notify-send "Missing or invalid argument."
	exit 1
fi
