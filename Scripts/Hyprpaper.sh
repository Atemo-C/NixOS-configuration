#!/bin/dash

# Shortcut for the path where hyprpaper.conf is located.
CF="$HOME/.config/hypr"

# Shortcuts for binaries.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"

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

# Check if Hyprpaper's configuration file exists.
# If it does not, it creates it in the expected directory.
[ -f "$CF/hyprpaper.conf" ] || {
	mkdir "$CF" &&
	touch "$CF/hyprpaper.conf";
}

# Show the file selection dialogue and defines the wallpaper used.
Wallpaper=$(zenity \
	--file-selection \
	--filename="$HOME/Images/Backgrounds/ /" \
	--file-filter="*.png *.jpg *.jpeg *.webp *.jxl" \
	--title="Select a wallpaper."
)

case $? in
	# Write the select wallpaper's path to hyprpaper's configuration file.
	0) echo \
		"preload = $Wallpaper
		wallpaper = ,$Wallpaper
		splash = false
		ipc = on" \
		> "$CF/hyprpaper.conf";

		# Kills hyprpaper if it is already running.
		pkill --exact "hyprpaper" || true;

		# Wait until hypraper is no longer running.
		while pgrep -x "hyprpaper" > /dev/null; do
			sleep 0.05
		done

		# Starts hyprpaper with the updated configuration.
		nohup hyprpaper > /dev/null 2>&1 & ;;

	# Notify the sure in case an error occurs.
	1) notify-send "An error occured." & echo "An error occured.";;
esac
