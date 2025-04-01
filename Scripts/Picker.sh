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

# Give an --about argument.
for type in "$@"; do
	case "$type" in
		--about);;
		*);;
	esac
done

# Define the about message.
About="
Picker.sh

This scripts (that should honestly be just a simple command) allows you to pick a color on the screen within the Hyprland Wayland compositor, using hyprpicker to do so.

Why is this a script? Because I have ideas upon improvements and additional features that could come from it, such as color picking history with a graphical menu that shows each color and their value. We shall see.

When using the $(tput setaf 2)--about$(tput sgr0) argument, this message is displayed.

Credits:
• $(tput bold)hyprpicker$(tput sgr0) $(tput setaf 4)https://github.com/hyprwm/hyprpicker$(tput sgr0)
"

# Show the about message when the --about argument is given.
if echo "$*" | grep -q -- "--about"; then
	echo "$About" && exit

# Pick a color normally if no argument is given.
else

# Pick a color on the screen, save it to the clipboard, and send a notification.
Color="$(hyprpicker -f hex --autocopy)" && notify-send -t 1500 "$Color copied to the clipboard"

fi
