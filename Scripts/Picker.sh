#!/bin/dash

# Shortcut for binaries.
SW="/run/current-system/sw/bin"

# Define the "about" message.
About="
Picker.sh

This script allows you to pick a color on the screen within the Hyprland Wayland compositor using hyprpicker.

Whilst this script could currently be a single command, it exists so that it may be extended further in the future, such as the addition of a color picking history with a graphical menu that would show each color and their value, and let the user pick one of them.

• When using the --about argument, this message is displayed.
• When no argument is given, the color picking starts.
• When an invalid argument is given, it is ignored.

Credits:
• hyprpicker: https://github.com/hyprwm/hyprpicker
"

# Check for arguments.
for argument in "$@"; do
	case "$argument" in
		--about);;
		*);;
	esac
done

# Show the "about" message when the --about argument is given.
echo "$*" | grep -q -- "--about" &&
	echo "$About" &&
	exit ||

# When no or an invalid argument is given, check for relevant depedencies and pick a color on the screen.

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

# Pick a color if no argument is given.
Color="$(hyprpicker -f hex --autocopy)" && notify-send -t 1500 "$Color copied to the clipboard."
