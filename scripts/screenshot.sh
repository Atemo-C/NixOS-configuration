#!/usr/bin/env dash

# This script was written for my NixOS configuration.
# https://github.com/Atemo-C/NixOS-configuration/blob/main/scripts/screenshot.sh
#
# Required dependencies
#──────────────────────
# • DASH        http://gondor.apana.org.au/~herbert/dash
# • Niri        https://github.com/YaLTeR/niri
#
# Recommended dependencies
#─────────────────────────
# • Dunst         https://dunst-project.org
# • Oxipng:       https://github.com/shssoichiro/oxipng
# • wl-clipboard: https://github.com/bugaevc/wl-clipboard
#
# Notes
#──────
# The `screenshot-path` option needs to be set to `null` in Niri's configuration file.
# This is necessary as Niri does not have consistent command-line arguments for its screenshot utility.
# https://github.com/YaLTeR/niri/discussions/1885
#
# Exit codes
#───────────
# ✔ [0] Sucess.
# ✘ [1] Invalid number of arguments.
# ✘ [2] The Niri Wayland compositor was not detected.
# ✘ [3] An error occured when taking the screenshot.
# ✘ [4] `wl-clipboard` is not installed, preventing saving the screenshot.
# ✘ [5] An error occured when saving the screenshot.
# ✔ [6] The screenshot was saved, but not optimized due to the abscense of Oxipng.
# ✓ [7] An error occured when optimizing the saved screenshot.
# ✘ [8] Invalid argument.
# ✘ [9] Of all errors, what the hell happened?

# Text formatting shortcuts for console messages using `printf`.
arg=$(tput bold; tput setaf 2)
arg2=$(tput bold; tput setaf 5)
bol=$(tput bold)
clr=$(tput sgr0)
dim=$(tput dim)
err=$(tput bold; tput setaf 1)Error$(tput sgr0):
exe=$(tput bold; tput setaf 3)
ico=$(tput bold; tput setaf 6)
war=$(tput bold; tput setaf 5)Warning$(tput sgr0):

# Text formatting for graphical notifications using `dunstify`.
bspan="</span></b>"
darg="<b><span foreground='#00ff00'>"
derr="<b><span foreground='#ff0000'>Error</span></b>:"
dexe="<b><span foreground='#ffc000'>"
dwar="<b><span foreground='#ff0080'>Warning</span></b>:"

# Get the script's full path.
scr=$(readlink -f "$0")

# Check if Dunst is installed.
command -v dunstify > /dev/null 2>&1 || {
	printf "%s %sDunst%s was not found. Graphical notifications disabled. Continuing.\n" \
	"$war" "$exe" "$clr"

	dunst_dep=false
}

# Functions for graphical notifications using dunstify.
errify() { [ "$dunst_dep" = "false" ] || dunstify -u critical "$1" "$2"; }
warify() { [ "$dunst_dep" = "false" ] || dunstify "$1" "$2"; }

# Check if the number of arguments is greater than 2.
[ "$#" -gt 2 ] && {
	printf "%s Invalid number of arguments (%s%d%s).\n\n" \
	"$err" "$arg" "$#" "$clr"

	printf "See the %s--about%s / %s--help%s / %s-h%s argument. Exiting.\n" \
	"$arg" "$clr" "$arg" "$clr" "$arg" "$clr"

	errify "Invalid argument" \
	"${derr} Invalid number of arguments (${darg}$#${bspan})
See the ${darg}--about${bspan} / ${darg}--help${bspan} / ${darg}-h${bspan} argument. Exiting."

	exit 1
}

# Check for the `--about` / `--help` / `-h` arguments.
[ "$1" = "--about" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ] && {
	printf "%s[ Description ]%s\n" "$bol" "$clr"
	printf "This script helps taking screenshots in the Niri Wayland compositor.\n"
	printf "It uses Niri's buit-in screnshot tool, extended with other utilities.\n\n"

	printf "%s[ Required dependencies ]%s\n" "$bol" "$clr"
	printf "• %sDASH%s shell               %s(for fast, POSIX-compliant script execution)%s\n" "$exe" "$clr" "$dim" "$clr"
	printf "• %sNiri%s Wayland compositor  %s(this script relies on Niri's screenshot utility)%s\n" "$exe" "$clr" "$dim" "$clr"
	printf "• Standard shell utilities %s(basics + tput, for proper text output)%s\n\n" "$dim" "$clr"

	printf "%s[ Optional dependencies ]%s\n" "$bol" "$clr"
	printf "• %sDunst%s        %s(for graphical notifications)%s\n" "$exe" "$clr" "$dim" "$clr"
	printf "• %sOxipng%s       %s(for optimizing saved screenshots)%s\n" "$exe" "$clr" "$dim" "$clr"
	printf "• %swl-clipboard%s %s(for saving screenshots)%s\n\n\n" "$exe" "$clr" "$dim" "$clr"


	printf "%s[ Arguments ]%s\n" "$bol" "$clr"
	printf " %s--about%s / %s--help%s / %s-h%s\n" "$arg" "$clr" "$arg" "$clr" "$arg" "$clr"
	printf "   Display this message.\n\n"

	printf " %s--copy%s %s(followed by one of the sub-arguments)%s\n" "$arg" "$clr" "$dim" "$clr"
	printf "   Take a screenshot and copy it to the clipboard.\n\n"

	printf " %s--save%s %s(followed by one of the sub-arguments)%s\n" "$arg" "$clr" "$dim" "$clr"
	printf "  %s1)%s Take a screenshot and paste it to a PNG file with %swl-clipboard%s.\n" "$bol" "$clr" "$exe" "$clr"
	printf "  %s2)%s Optimize the PNG file losslessly with %sOxipng%s %s(optional)%s.\n\n\n" "$bol" "$clr" "$exe" "$clr" "$dim" "$clr"

	printf "%s[ Sub-arguments ]%s\n" "$bol" "$clr"
	printf " %sarea%s / %sfree%s / %sregion%s %s(preceeded by one of the arguments)%s\n" "$arg2" "$clr" "$arg2" "$clr" "$arg2" "$clr" "$dim" "$clr"
	printf "   Take a screenshot of any free area on a display.\n\n\n"


	printf " %swindow%s %s(preceeded by one of the arguments)%s\n" "$arg2" "$clr" "$dim" "$clr"
	printf "   Take a screenshot of the currently active window.\n\n"

	printf " %sdisplay%s / %smonitor%s / %sscreen%s %s(preceeded by one of the arguments)%s\n" "$arg2" "$clr" "$arg2" "$clr" "$arg2" "$clr" "$dim" "$clr"
	printf "   Take a screenshot of the currently active display.\n\n\n"


	printf "%s[ Examples ]%s\n" "$bol" "$clr"
	printf " To copy a free area screenshot to the clipboard:\n"
	printf "   %s%s%s %s--copy%s %sarea%s\n\n" "$ico" "$scr" "$clr" "$arg" "$clr" "$arg2" "$clr"

	printf " To save a screenshot of the currently active monitor:\n"
	printf "   %s%s%s %s--save%s %smonitor%s\n\n" "$ico" "$scr" "$clr" "$arg" "$clr" "$arg2" "$clr"

	printf " An invalid command due to wrong arguments order:\n"
	printf "   %s%s%s %swindow%s %s--save%s\n\n" "$ico" "$scr" "$clr" "$arg2" "$clr" "$arg" "$clr"

	printf " An invalid command due to too many arguments:\n"
	printf "   %s%s%s %s--copy%s %s--save%s %sarea%s\n" "$ico" "$scr" "$clr" "$arg" "$clr" "$arg" "$clr" "$arg2" "$clr"
	printf " %s(Note that saved screenshots are also copied to the clipboard.)%s\n\n" "$dim" "$clr"

	exit 0
}

# Check if Niri is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "%s This script has been designed for the %sNiri%s Wayland compositor. Exiting.\n" \
	"$err" "$exe" "$clr"

	errify "Not using Niri" \
	"${derr} This script has been designed for the %sNiri%s Wayland compositor. Exiting."

	exit 2
}

# Check for the `--copy` argument.
[ "$1" = "--copy" ] && {
	# Check for the sub-arguments.
	[ "$#" -eq 2 ] && printf "free region area window screen monitor display\n" | grep -qw "$2" && {
		# Set the screenshot type recognized by Niri's built-in screenshot utility.
		[ "$2" = "free" ] || [ "$2" = "region" ] || [ "$2" = "area" ] && type="screenshot"
		[ "$2" = "window" ] && type="screenshot-window"
		[ "$2" = "screen" ] || [ "$2" = "monitor" ] || [ "$2" = "display" ] && type="screenshot-screen"

		# Take the screenshot.
		niri msg action "$type" || {
			printf "%s An error occured when taking the screenshot. Exiting.\n" "$err"

			errify "Error" \
			"${derr} An error occured when taking the screenshot. Exiting."

			exit 3
		}
		exit 0
	}
}

# Check for the `--save` argument.
[ "$1" = "--save" ] && {
	# Check for the sub-arguments.
	[ "$#" -eq 2 ] && printf "free region area window screen monitor display\n" | grep -qw "$2" && {
		[ "$2" = "free" ] || [ "$2" = "region" ] || [ "$2" = "area" ] && type="screenshot"
		[ "$2" = "window" ] && type="screenshot-window"
		[ "$2" = "screen" ] || [ "$2" = "monitor" ] || [ "$2" = "display" ] && type="screenshot-screen"

		# Check if wl-clipboard is installed.
		command -v wl-paste > /dev/null 2>&1 || {
			printf "%s %swl-clipboard%s could not be found. It is needed to save the screenshot. Exiting." "$err" "$exe" "$clr"

			errify "wl-clipboard not found" \
			"${derr} ${dexe}wl-clipboard${bspan} could not be found. It is needed to save the screenshot. Exiting."

			exit 4
		}

		# Check if Oxipng is installed.
		command -v oxipng > /dev/null 2>&1 || {
			printf "%s %sOxipng%s could not be found. The saved screenshot will not be optimized. Continuing.\n" "$war" "$exe" "$clr"

			warify "Oxipng not found" \
			"${dwar} ${dexe}Oxipng${bspan} could not be found. The saved screenshot will not be optimized. Continuing."

			oxipng_dep=false
		}

		# Take the screenshot.
		niri msg action "$type" || {
			printf "%s An error occured when taking the screenshot. Exiting.\n" "$err"

			errify "Error" \
			"${derr} An error occured when taking the screenshot. Exiting."

			exit 3
		}

		# Set the screenshot's name.
		image=$(date +'Screenshot_%d-%m-%Y_%H-%M-%S')

		# Set values to wait until the image is detected in the clipboard.
		max_attempts=20
		attempt=1

		# Loop until the image is detected in the clipboard.
		while [ "$attempt" -le "$max_attempts" ]; do
			# Check if the clipboard contains image data.
			wl-paste --list-types | grep -q "image/" || { sleep 0.1; attempt=$((attempt +1)); continue; }

			# Check for valid directories to save the screenshot to.
			scrdir="$HOME/Images/Screenshots/"
			[ -d "$scrdir" ] || scrdir="$XDG_PICTURES_DIR/"
			[ -d "$scrdir" ] || scrdir="$HOME/"
			cd "$scrdir" || exit 9

			# Paste the image into a file.
			wl-paste > "$image".png || {
				printf "%s An error occured when saving the screenshot. Exiting." "$err"

				errify "Unable to save" \
				"${derr} An error occured when saving the screenshot. Exiting."

				exit 5
			}

			# Optimize the image with Oxipng.
			[ "$oxipng_dep" != "false" ] && {
				oxipng --strip all "$image".png || {
					printf "%s An error occured when optimizing the image. Ignoring." "$war"

					notify "Unable to optimize" \
					"${dwar} An error occured when optimizing the image. Ignoring."

					exit 6
				}
				exit 0
			}
		done
	}
}

# Error when no argument is given.
[ "$1" = "" ] && {
	printf "%s No argument was given.\n\n" "$err"
	printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" "$arg" "$clr" "$arg" "$clr" "$arg" "$clr"

	notify "Missing argument" \
	"${derr} No argument was given.
See the ${darg}--about${bspan} / ${darg}--help${bspan} / ${darg}-h${bspan} argument."

	exit 1
}

# Error when an invalid argument is given.
printf "%s Invalid argument '%s%s%s'.\n\n" "$err" "$arg" "$*" "$clr"
printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" "$arg" "$clr" "$arg" "$clr" "$arg" "$clr"

notify "Invalid argument" \
"${derr} Invalid argument '${darg}${*}${bspan}'
See the ${darg}--about${bspan} / ${darg}--help${bspan} / ${darg}-h${bspan} argument."

exit 8