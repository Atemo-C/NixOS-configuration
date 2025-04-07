#!/bin/dash

# Shortcut for hyprpaper's configuration file location.
CF="$HOME/.config/hypr"

# Shortcuts for binaries.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"

# Define the "about" message.
About="
Hyprpaper.sh

This script allows you to graphically select a background image within the Hyprland Wayland compositor, using hyprpaper and zenity.

If image thumbnails do not show, you might want to open the relevant directory(ies) in a graphical file manager to let the desired thumbnailer service create thumbnails for the images.

• When using the --about argument, this message is displayed.
• When no argument is given, the background image selection starts.
• When an invalid argument is given, it is ignored.

Credits:
• hyprpaper: https://github.com/hyprwm/hyprpaper
• zenity: https://gitlab.gnome.org/GNOME/zenity.git
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

# When no or an invalid argument is given, check for relevant depedencies and select a background image.

# Check if libnotify is installed.
[ -f "$SW/notify-send" ] || {
	echo "libnotify could not be found. It is needed to display graphical notifications.";
	exit 1;
}

# Check if Hyprland is the active desktop.
[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
	notify-send "This wallpaper utility can only be used with Hyprland." &
	echo "This wallpaper utility can only be used with Hyprland.";
	exit 1;
}

# Check if Zenity is installed.
[ -f "$SW/zenity" ] || {
	notify-send "zenity could not be found. It is requiered toselect the wallpaper." &
	echo "zenity could not be found. It is requiered toselect the wallpaper.";
	exit 1;
}

# Check if Hyprpaper is installed.
[ -f "$SW/hyprpaper" ] || [ -f "$HM/hyprpaper" ] || {
	notify-send "hyprpaper could not be found. It is requiered to apply the wallpaper." &
	echo "hyprpaper could not be found. It is requiered to apply the wallpaper.";
	exit 1;
}

# Show the file selection dialogue and define the the background image to be used.
Background=$(zenity \
	--file-selection \
	--filename="$HOME/Images/Backgrounds/ /" \
	--file-filter="*.png *.jpg *.jpeg *.webp *.jxl" \
	--title="Select a background image."
)

case $? in
	# Write the select background image's path to hyprpaper's configuration file.
	0) echo \
"preload = $Background
wallpaper = ,$Background
splash = false
ipc = on" \
		> "$CF/hyprpaper.conf";

		# Kill hyprpaper if it is already running.
		pkill --exact "hyprpaper" || true;

		# Wait until hyprpaper is no longer running.
		while pgrep -x "hyprpaper" > /dev/null; do
			sleep 0.05
		done

		# Start hyprpaper with the updated configuration.
		nohup hyprpaper > /dev/null 2>&1 & ;;

	# Notify the user if an error occurs.
	1) notify-send "An unknown error occured, or the file selection was closed." &
	echo "An unknown error occured, or the file selection was closed." ;;
esac
