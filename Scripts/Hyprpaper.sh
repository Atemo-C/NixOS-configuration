#!/bin/dash

# Set some useful color shortcuts.
err=$(tput bold)$(tput setaf 1)
arg=$(tput bold)$(tput setaf 2)
ico=$(tput bold)$(tput setaf 6)
nam=$(tput bold)$(tput setaf 3)
lin=$(tput setaf 4)
dim=$(tput dim)
x=$(tput sgr0)

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	echo \
		"${err}Error${x}: Invalid number of arguments.\n" \
		"\nSee the ${arg}--about${x} argument.\n"

	exit
}

# Check for the --about argument.
[ "$1" = "--about" ] && {
	echo \
		"${ico} ${x} ${arg}Hyprpaper.sh${x}\n" \
		"\nThis script allows you to graphically select a wallpaper within the ${nam}Hyprland${x} Wayland compositor using ${nam}hyprpaper${x}.\n" \
		"\n${dim}If image thumbnails do not show while picking a wallpaper, you may want to open the relevant directory(ies) in a graphical file manager to let the desired thumbnailer service create thumbnails for the images.${x}\n" \
		"\n• When using the ${arg}--about${x} argument, this message is displayed." \
		"\n• When no argument is given, the wallpaper selection starts.\n" \
		"\nCredits:" \
		"\n• ${nam}hyprpaper${x}: ${lin}https://github.com/hyprwm/hyprpaper${x}\n"

	exit
}

# When no argument is provided, continue on with the wallpaper selection process.
[ "$1" = "" ] && {
	# Check if libnotify is installed.
	command -v notify-send || {
		echo "libnotify could not be found. It is required to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "This wallpaper utility can only be used with Hyprland."
		echo "This wallpaper utility can only be used with Hyprland."
		exit 1
	}

	# Check if Zenity is installed.
	command -v zenity || {
		notify-send "zenity could not be found. It is requiered toselect the wallpaper."
		echo "zenity could not be found. It is requiered toselect the wallpaper."
		exit 1
	}

	# Check if Hyprpaper is installed.
	command -v hyprpaper || {
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
		notify-send "An error occured, or the file selection was closed before selecting a wallpaper."
		echo "An error occured, or the file selection was closed before selecting a wallpaper."
		exit 1
	}
}

# Error out if an invalid argument is given.
echo "${err}Error${x}: Invalid argument '${arg}$*${x}'.

See the ${arg}--about${x} argument.
"
exit 1
