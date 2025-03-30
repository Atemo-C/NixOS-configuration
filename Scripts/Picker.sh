#!/bin/dash

# Shortcut for binaries.
SW="/run/current-system/sw/bin"

# Check if libnotify is installed.
[ -f "$SW/notify-send" ] || {
	echo "libnotify could not be found. It is needed to display graphical notifications.";
	exit 1;
}

# Check if Hyprland is the active desktop.
[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
	notify-send "This color picking utility can only be used with Hyprland." &
	echo "This wallpaper utility can only be used with Hyprland.";
	exit 1;
}

# Check if hyprpicker is installed.
[ -f "$SW/hyprpicker" ] || {
	notify-send "hyprpicker could not be found. It is needed to pick a color on the screen." &
	echo "hyprpicker could not be found. It is needed to pick a color on the screen.";
	exit 1;
}

# Pick a color on the screen, save it to the clipboard, and send a notification.
Color="$(hyprpicker -f hex --autocopy)" && notify-send -t 1500 "$Color copied to the clipboard"
