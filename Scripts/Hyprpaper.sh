#!/bin/dash

# Path shortcut.
CF="$HOME/.config/hypr"

# Executeables shortcut.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"

# Check if the required dependencies are installed.
[ -f "$HM/hyprland" ] || [ -f "$SW/hyprland" ] || { notify-send "This wallpaper utility is made for Hyprland."; exit 1; }
[ -f "$SW/zenity" ] || { notify-send "zenity is not installed."; exit 1; }
[ -f "$SW/hyprpaper" ] || [ -f "$HM/hyprpaper" ] || { notify-send "hyprpaper is not installed."; exit 1; }
[ -f "$SW/notify-send" ] || { echo "notify-send is not installed."; exit 1; }

# Check if Hyprpaper's configuration file exists. If not, create it.
[ -f "$CF/hyprpaper.conf" ] || { mkdir "$CF" && touch "$CF/hyprpaper.conf"; }

# Wallpaper file selection.
Wallpaper=$(zenity \
	--file-selection \
	--filename="$HOME/Images/Backgrounds/ /" \
	--file-filter="*.png *.jpg *.jpeg *.webp *.jxl" \
	--title="Select a wallpaper"
)

case $? in
	# Write the wallpaper's path to hyprpaper's configuration file.
	0) echo \
		"preload = $Wallpaper
		wallpaper = ,$Wallpaper
		splash = false
		ipc = on" \
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
