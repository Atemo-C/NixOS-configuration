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

	exit
}

# Check for the --about or --help argument.
[ "$1" = "--about" ] || [ "$1" = "--help" ] && {
	echo \
		"${ico}  ${arg}Picker.sh${c}\n" \
		"\nThis script allows you to pick a color on the screen within the ${exe}Hyprland${c} Wayland compositor using ${exe}hyprpicker${c}.\n" \
		"\n${dim}Whilst this script could currently be a single command, it exists so that it may be extended further in the future, such as the addition of a color picking history with a graphical menu that would show each color and their value, and let the user pick one of them.${c}\n" \
		"\n• When using the ${arg}--about${c} or ${arg}--help${c} argument, this message is displayed." \
		"\n• When no argument is given, the color picking starts.\n" \
		"\nCredits:" \
		"\n• ${exe}hyprpicker${c}: ${web}https://github.com/hyprwm/hyprpicker${c}\n"

	exit
}

# When no argument is provided, start the color picking process.
[ "$1" = "" ] && {
	# Check if libnotify is installed.
	command -v notify-send || {
		echo "${err}: libnotify could not be found. It is required to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "Error: This color picking utility can only be used with the Hyprland Wayland compositor."
		echo "${err}: This color picking utility can only be used with the ${exe}Hyprland${c} Wayland compositor."
		exit 1
	}

	# Check if hyprpicker is installed.
	command -v hyprpicker || {
		notify-send "Error: hyprpicker could not be found. It is required to pick a color on the screen."
		echo "${err}: ${exe}hyprpicker${c} could not be found. It is required to pick a color on the screen."
		exit 1
	}

	# Pick a color on the screen.
	Color="$(hyprpicker -f hex --autocopy)"
	Out=$?
	# Notify the user when a color has been picked.
	[ "$Out" = "0" ] && {
		notify-send -t 1500 "$Color copied to the clipboard."
		echo "${ico}$Color${c} copied to the clipboard."
		exit
	}

	# Notify the user when the color selection process has been aborted.
	[ "$Out" = "1" ] && {
		notify-send -t 1500 "The color picking process has been aborted."
		echo "The color picking process has been aborted."
		exit 1
	}
}

# Error out if an invalid argument is given.
echo \
	"${err}: Invalid argument '${arg}$*${c}'.\n" \
	"\nSee the ${arg}--about${c} / ${arg}--help${c} argument.\n"

exit 1
