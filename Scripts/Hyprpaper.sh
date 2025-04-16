#!/bin/dash

# Set some text formatting shortcuts.
err=$(tput bold)$(tput setaf 1)Error$(tput sgr0)
arg=$(tput bold)$(tput setaf 2)
exe=$(tput bold)$(tput setaf 3)
ico=$(tput bold)$(tput setaf 6)
web=$(tput setaf 4)
dim=$(tput dim)
c=$(tput sgr0)

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	echo \
		"${err}: Invalid number of arguments (${arg}$#${c}).\n" \
		"\nSee the ${arg}--about${c} / ${arg}--help${c} argument.\n"

	exit 1
}

# Check for the --about or --help argument.
[ "$1" = "--about" ] || [ "$1" = "--help" ] && {
	echo \
		"${ico}  ${arg}Hyprpaper.sh${c}\n" \
		"\nThis script allows you to graphically select a wallpaper within the ${exe}Hyprland${c} Wayland compositor using ${exe}hyprpaper${c}.\n" \
		"\n${dim}If image thumbnails do not show while picking a wallpaper, you may want to open the relevant directory(ies) in a graphical file manager to let the desired thumbnailer service create thumbnails for the images.${c}\n" \
		"\n• When using the ${arg}--about${c} or ${arg}--help${c} argument, this message is displayed." \
		"\n• When using the ${arg}--check${c} argument, required dependencies will be checked." \
		"\n• When no argument is given, the wallpaper selection starts.\n" \
		"\nCredits:" \
		"\n• ${exe}hyprpaper${c}: ${web}https://github.com/hyprwm/hyprpaper${c}\n"

	exit
}

# Check for the --check argument.
[ "$1" = "--check" ] && {
	echo "${ico}  ${arg}Hyprpaper.sh${c}\n"

	# Check if libnotify is installed.
	(command -v notify-send > /dev/null 2>&1) && {
		echo "✅ ${exe}libnotify${c} is installed."
	} ||
		echo "❌ ${exe}libnotify${c} is not installed. It is required to display graphical notifications. The script will not run without it."

	# Check if Zenity is installed.
	(command -v zenity > /dev/null 2>&1) && {
		echo "✅ ${exe}zenity${c} is installed."
	} ||
		echo "❌ ${exe}zenity${c} is not installed. It is required to graphically select a wallpaper. The script will not run without it."

	# Check if Hyprpaper is installed.
	(command -v hyprpaper > /dev/null 2>&1) && {
		echo "✅ ${exe}hyprpaper${c} is installed."
	} ||
		echo "❌ ${exe}hyprpaper${c} is not installed. It is required to apply a wallpaper. The script will not run without it."

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] && {
		echo "✅ ${exe}Hyprland${c} is the active Wayland compositor."
	} ||
		echo "❌ ${exe}Hyprland${c} is not the currently active Wayland compositor. The script will not run outside of Hyprland."

	exit
}

# When no argument is provided, start the wallpaper selection process.
[ "$1" = "" ] && {
	# Check if libnotify is installed.
	command -v notify-send || {
		echo "${err}: libnotify could not be found. It is required to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "Error: This wallpaper utility can only be used with the Hyprland Wayland compositor."
		echo "${err}: This wallpaper utility can only be used with the ${exe}Hyprland${c} Wayland compositor."
		exit 1
	}

	# Check if Zenity is installed.
	command -v zenity || {
		notify-send "Error: zenity could not be found. It is required to select a wallpaper."
		echo "${err}: ${exe}zenity${c} could not be found. It is required to select a wallpaper."
		exit 1
	}

	# Check if Hyprpaper is installed.
	command -v hyprpaper || {
		notify-send "Error: hyprpaper could not be found. It is required to apply a wallpaper."
		echo "${err}: ${exe}hyprpaper${c} could not be found. It is required to apply a wallpaper."
		exit 1
	}

	# Show the file selection dialogue and define the wallpaper to be used.
	Wallpaper=$(zenity \
		--file-selection \
		--filename="$HOME/Images/Backgrounds/ /" \
		--file-filter="*.png *.jpg *.jpeg *.webp *.jxl" \
		--title="Select a wallpaper."
	)

	# If the wallpaper selection is successful, write the output to hyprpaper's configuration file and restart it.
	Out=$?
	[ "$Out" = "0" ] && {
		echo \
			"preload = $Wallpaper" \
			"\nwallpaper = ,$Wallpaper" \
			"\nsplash = false" \
			"\nipc = on" \
		> "$HOME/.config/hypr/hyprpaper.conf";

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
		notify-send "Error: An error occurred, or the file selection was closed before selecting a wallpaper."
		echo "${err}: An error occurred, or the file selection was closed before selecting a wallpaper."
		exit 1
	}
}

# Error out if an invalid argument is given.
echo \
	"${err}: Invalid argument '${arg}$*${c}'.\n" \
	"\nSee the ${arg}--about${c} / ${arg}--help${c} argument.\n"

exit 1
