#!/bin/dash

# Shortcut for the location of hyprpaper's configuration file.
CF="$HOME/.config/hypr"

# Shortcuts for binaries.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"

# Define the "about" message.
About="$(tput bold)$(tput setaf 6)  $(tput setaf 2)Hyprpaper.sh$(tput sgr0)

This script allows you to graphically select a wallpaper within the $(tput bold)$(tput setaf 3)Hyprland$(tput sgr0) Wayland compositor using $(tput bold)$(tput setaf 6)hyprpaper$(tput sgr0).

$(tput dim)If image thumbnails do not show while picking a wallpaper, you might want to open the relevant directory(ies) in a graphical file manager to let the desired thumbnailer service create thumbnails for the images.$(tput sgr0)

• When using the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument, this message is displayed.
• When no argument is given, the wallpaper selection starts.

Credits:
• $(tput bold)$(tput setaf 3)hyprpaper$(tput sgr0): $(tput setaf 4)https://github.com/hyprwm/hyprpaper$(tput sgr0)
"

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid number of arguments.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument.
"
	exit 1
}

# Check for the --about argument.
[ "$1" = "--about" ] && {
	echo "$About"
	exit
}

# When no argument is provided, continue on with the wallpaper selection process.
[ "$1" = "" ] && {
	# Check if libnotify is installed.
	[ -f "$SW/notify-send" ] || {
		echo "libnotify could not be found. It is needed to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "This wallpaper utility can only be used with Hyprland."
		echo "This wallpaper utility can only be used with Hyprland."
		exit 1
	}

	# Check if Zenity is installed.
	[ -f "$SW/zenity" ] || {
		notify-send "zenity could not be found. It is requiered toselect the wallpaper."
		echo "zenity could not be found. It is requiered toselect the wallpaper."
		exit 1
	}

	# Check if Hyprpaper is installed.
	[ -f "$SW/hyprpaper" ] || [ -f "$HM/hyprpaper" ] || {
		notify-send "hyprpaper could not be found. It is requiered to apply the wallpaper."
		echo "hyprpaper could not be found. It is requiered to apply the wallpaper."
		exit 1
	}

	# Show the file selection dialogue and define the wallpaper to be used.
	Wallpaper=$(zenity \
		--file-selection \
		--filename="$HOME/Images/Backgrounds/ /" \
		--file-filter="*.png *.jpg *.jpeg *.webp *.jxl" \
		--title="Select a background image."
	)

	# When the wallpaper selection is sucessful, write the output to hyprpaper's configuration file and restart it.
	Out=$?
	[ "$Out" = "0" ] && {
		echo \
"preload = $Wallpaper
wallpaper = ,$Wallpaper
splash = false
ipc = on" \
		> "$CF/hyprpaper.conf";

		# Kill hyprpaper if it is already running.
		pkill --exact "hyprpaper" || true;

		# Wait until hyprpaper is no longer running before proceeding with the next step.
		while pgrep -x "hyprpaper" > /dev/null; do
			sleep 0.05
		done

		# Start hyprpaper with the updated configuration.
		nohup hyprpaper > /dev/null 2>&1 &
		exit
	}

	# If an error occurs or the file picker is closed, display an error message.
	[ "$Out" = "1" ] && {
		notify-send "An error occured, or the file selection was closed before selecting a wallpaper."
		echo "An error occured, or the file selection was closed before selecting a wallpaper."
		exit 1
	}
}

# Error out if an invalid argument is given.
echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid argument '$(tput setaf 1)$1$(tput sgr0)'.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument.
"
exit 1
