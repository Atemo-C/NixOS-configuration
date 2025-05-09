#!/bin/dash

# Set some text formatting shortcuts for printf.
err=$(tput bold)$(tput setaf 1)Error$(tput sgr0)
arg=$(tput bold)$(tput setaf 2)
exe=$(tput bold)$(tput setaf 3)
ico=$(tput bold)$(tput setaf 6)
web=$(tput setaf 4)
dim=$(tput dim)
bol=$(tput bold)
c=$(tput sgr0)

# Set some text formatting shortcuts for dunstify.
herr="<b><span foreground='#ff0000'>Error</span></b>"
hexe1="<b><span foreground='#ffc000'>"
hexe2="</span></b>"

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	printf "%s: Invalid number of arguments '%s%d%s'.\n\n" \
		"$err" "$arg" "$#" "$c"

	printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" \
		"$arg" "$c" "$arg" "$c" "$arg" "$c"

	exit 1
}

# Check for the `--about` and `--help` arguments.
[ "$1" = "--about" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ] && {
	printf "%s  %sPicker.sh%s\n\n" \
		"$ico" "$arg" "$c"

	printf "%s[ Description ]%s\n" \
		"$bol" "$c"

	printf " This script allows you to pick a color on the screen within the %sHyprland%s Wayland compositor.\n" \
		"$exe" "$c"

	printf " %sWhilst this script could currently be a single command, it exists so that it may be extended further in the future, such as with the addition of a color picking history with a graphical menu that shows each color and their value, letting the user pick any one of them.%s\n\n" \
		"$dim" "$c"

	printf "%s[ Arguments ]%s\n" \
		"$bol" "$c"

	printf " No argument: Pick a color on the screen.\n\n"

	printf " %s--about%s / %s--help%s / %s-h%s \n" \
		"$arg" "$c" "$arg" "$c" "$arg" "$c"

	printf "  Display this message.\n\n"

	printf "%s[ Credits ]%s\n" \
		"$bol" "$c"

	printf " %sHyprpicker%s: %shttps://github.com/hyprwm/hyprpicker%s" \
		"$exe" "$c" "$web" "$c"

	exit 0
}

# When no argument is provided, start the color picking process.
[ "$1" = "" ] && {
	# Check if Dunst is installed.
	command -v dunstify > /dev/null 2>&1 || {
		printf "%s: %sDunst%s could not be found. It is required to display graphical notifications." \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		dunstify -u critical "Picker.sh" "$herr: This script can only be used with the$hexe1 Hyprland$hexe2 Wayland compositor."

		printf "%s: This script can only be used with the %sHyprland%s Wayland compositor." \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Hyprpicker is installed.
	command -v hyprpicker || {
		dunstify -u critical "Picker.sh" "$herr:$hexe1 Hyprpicker$hexe2 could not be found. It is required to pick a color on the screen."

		printf "%s: %sHyprpicker%s could not be found. It is required to pick a color on the screen." \
			"$err" "$exe" "$c"

		exit 1
	}

	# Pick a color on the screen.
	Color="$(hyprpicker -f hex --autocopy)"
	Out=$?

	# Notify the user when a color has been picked.
	[ "$Out" = "0" ] && {
		dunstify -t 1500 "Picker.sh" "$Color copied to the clipboard."

		printf "%s copied to the clipboard." \
			"$Color"

		exit 0
	}

	# Notify the user when the color selection process has been aborted.
	[ "$Out" = "1" ] && {
		dunstify -u critical "Picker.sh" "$herr: The color picking process was aborted or failed."

		printf "%s: The color picking process was aborted or failed." \
			"$err"
	}
}

# Error out if an invalid argument is given.
printf "%s: Invalid argument '%s%s%s'.\n\n" \
	"$err" "$arg" "$*" "$c"

printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" \
	"$arg" "$c" "$arg" "$c" "$arg" "$c"

exit 1
