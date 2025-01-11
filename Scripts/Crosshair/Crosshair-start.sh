#!/bin/dash

feh /etc/nixos/Desktop/Scripts/Crosshair/Crosshair.png & sleep 0.5 &&
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
