# Closes on error.
set -euo pipefail

# Wallpaper file selection.
Wallpaper=$(zenity \
	--file-selection \
	--filename="$HOME/Images/Backgrounds/ /" \
	--file-filter="*.png *.jpg *.jpeg *.webp *.jxl" \
	--title="Select a wallpaper"
)

case $? in
	# Write the wallpaper's path to hyprpaper's configuration file.
	0) echo -e \
		"preload = $Wallpaper\nwallpaper = ,$Wallpaper\nsplash = false\nipc = on" \
		> "$HOME/.config/hypr/hyprpaper.conf";

		# Kills hyprpaper if it is already running, then continues.
		pkill --exact "hyprpaper" || true;

		# Small buffer wait, then launch hyprpaper with the desired wallpaper.
		sleep 0.1 && nohup hyprpaper ;;

	# Notify the user in case no wallpaper has been selected.
	1) notify-send "No wallpaper has been selected.";;

	# Send a message if another, unknown error occurs.
	-1) notify-send "An unexpected error occured. Run this script from a terminal emulator for further output.";;

esac
