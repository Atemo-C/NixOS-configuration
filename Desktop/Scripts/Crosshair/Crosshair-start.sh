#!/usr/bin/env bash

set -euo pipefail

feh /etc/nixos/Desktop/Scripts/Crosshair/Crosshair.png & sleep 0.5 &&
hyprctl dispatch togglefloating class:feh &&
hyprctl setprop class:feh maxsize 3 3 &&
hyprctl setprop class:feh bordersize 0 &&
hyprctl setprop class:feh rounding 3 &&
hyprctl setprop class:feh noshadow 1 &&
hyprctl dispatch centerwindow class:feh &&
hyprctl setprop class:feh nofocus true &&
hyprctl dispatch pin class:feh &&
notify-send "Crosshair created" || notify-send "An error occured"
