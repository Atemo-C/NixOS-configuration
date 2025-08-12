#!/usr/bin/env dash

# Credits.
# • DASH:         http://gondor.apana.org.au/~herbert/dash
# • Dunst:        https://dunst-project.org
# • libwebp:      https://developers.google.com/speed/webp
# • Niri:         https://github.com/YaLTeR/niri
# • Oxipng:       https://github.com/shssoichiro/oxipng
# • wl-clipboard: https://github.com/bugaevc/wl-clipboard

# Note: `screenshot-path` needs to be set to `null` in Niri's configuration file.
# This is necessary as Niri does not have consistent command-line arguments.
# https://github.com/YaLTeR/niri/discussions/1885

# Text formatting shortcuts for console messages using `printf`.
arg=$(tput bold; tput setaf 2)
sarg=$(tput bold; tput setaf 5)
bol=$(tput bold)
clr=$(tput sgr0)
dim=$(tput dim)
err=$(tput bold; tput setaf 1)Error$(tput sgr0)
exe=$(tput bold; tput setaf 3)
ico=$(tput bold; tput setaf 6)
war=$(tput bold; tput setaf 5)Warning$(tput sgr0)

# Text formatting for graphical notifications using `dunstify`.
bspan="</span></b>"
darg="<b><span foreground='#00ff00'>"
derr="<b><span foreground='#ff0000'>Error</span></b>"
dexe="<b><span foreground='#ffc000'>"
dico="<b><span foreground='#00ffff'>"
dwar="<b><span foreground='#ff0080'>Warning</span></b>"

# Get the script's full path.
scr=$(readlink -f "$0")

# Check if Dunst is installed.
command -v dunstify > /dev/null 2>&1 || {
	printf "%s: %sDunst%s could not be found. Graphical notifications disabled. Continuing.\n" "$war" "$exe" "$clr"

	dunst_dep=false
}; [ "$dunst_dep" = false ] || { dunst_dep=true; }

# Function for graphical notifications using dunstify.
notify() { [ "$dunst_dep" = "false" ] || dunstify -u critical "$1" "$2"; }
warify() { [ "$dunst_dep" = "false" ] || dunstify "$1" "$2"; }

# Check if the number of arguments is greater than 2.
[ "$#" -gt 2 ] && {
	printf "%s: Invalid number of arguments (%s%d%s).\n\n" "$err" "$arg" "$#" "$clr"

	printf "See the %s--about%s / %s--help%s / %s-h%s argument. Exiting.\n" "$arg" "$clr" "$arg" "$clr" "$arg" "$clr"

	notify "Invalid argument" \
	"${derr}: Invalid number of arguments (${darg}$#${bspan})
See the ${darg}--about${bspan} / ${darg}--help${bspan} / ${darg}-h${bspan} argument. Exiting."

	exit 1
}

# Check for the `--about` / `--help` / `-h` arguments.
[ "$1" = "--about" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ] && {
	printf "%s[ Description ]%s\n" "$bol" "$clr"
	printf "This script helps taking screenshots in the %sNiri%s Wayland compositor.\n" "$exe" "$clr"
	printf "It uses Niri's built-in screenshot tool, extended with other utilities.\n\n\n"


	printf "%s[ Dependencies ]%s\n" "$bol" "$clr"
	printf "• Standard shell utilities %s(basics + tput)%s\n" "$dim" "$clr"
	printf "• %sDASH%s shell %s(or other fully POSIX-compliant shell)%s\n" "$exe" "$clr" "$dim" "$clr"
	printf "• %sNiri%s Wayland compositor\n" "$exe" "$clr"
	printf "• %sDunst%s notification daemon %s(Optional: For graphical notifications)%s\n" "$exe" "$clr" "$dim" "$clr"
	printf "• %sOxipng%s image optimizer %s(Optional: For initial image optimization)%s\n" "$exe" "$clr" "$dim" "$clr"
	printf "• %slibwebp%s library %s(Optional: Image convertion to the WEBP format)%s\n" "$exe" "$clr" "$dim" "$clr"
	printf "• %swl-clipboard%s %s(Necessary to save the screenshot)%s\n\n\n" "$exe" "$clr" "$dim" "$clr"


	printf "%s[ Arguments ]%s\n" "$bol" "$clr"
	printf "• %s--about%s / %s--help%s / %s-h%s\n" "$arg" "$clr" "$arg" "$clr" "$arg" "$clr"
	printf "  Display this message.\n\n"

	printf "• %s--copy%s %s(followed by one of the sub-arguments)%s\n" "$arg" "$clr" "$dim" "$clr"
	printf "  Take a screenshot and copy it to the clipboard.\n\n"

	printf "• %s--save%s %s(followed by one of the sub-arguments)%s\n" "$arg" "$clr" "$dim" "$clr"
	printf "  · Take a screenshot and paste it to a %sPNG%s file with %swl-clipboard%s.\n" "$ico" "$clr" "$exe" "$clr"
	printf "  · Optimize the PNG file losslessly with %sOxipng%s %s(optional)%s.\n" "$exe" "$clr" "$dim" "$clr"
	printf "  · Convert it losslessly with %scwebp%s to a %sWEBP%s file %s(optional)%s.\n" "$exe" "$clr" "$ico" "$clr" "$dim" "$clr"
	printf "  · Remove the original PNG file %s(if converted)%s.\n\n\n" "$dim" "$clr"


	printf "%s[ Sub-arguments ]%s\n" "$bol" "$clr"
	printf "• %sarea%s / %sfree%s / %sregion%s\n" "$sarg" "$clr" "$sarg" "$clr" "$sarg" "$clr"
	printf "  Take a screenshot of any free area on a display.\n\n"

	printf "• %swindow%s\n" "$sarg" "$clr"
	printf "  Take a screenshot of the currently active window.\n\n"

	printf "• %sdisplay%s / %smonitor%s / %sscreen%s\n" "$sarg" "$clr" "$sarg" "$clr" "$sarg" "$clr"
	printf "  Take a screenshot of the currently active display.\n\n\n"


	printf "%s[ Examples ]%s\n" "$bol" "$clr"
	printf "• To copy a free area screenshot to the clipboard:\n"
	printf "  %s%s%s %s--copy%s %sarea%s\n\n" "$ico" "$scr" "$clr" "$arg" "$clr" "$sarg" "$clr"

	printf "• To save a screenshot of the currently active monitor:\n"
	printf "  %s%s%s %s--save%s %smonitor%s\n\n" "$ico" "$scr" "$clr" "$arg" "$clr" "$sarg" "$clr"

	exit
}

# Check if Niri is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "%s: This script is made to be used within the %sNiri%s Wayland compositor. Exiting.\n" "$err" "$exe" "$clr"

	notify "Niri not detected" \
	"${derr}: This script is made to be used within the ${dexe}Niri${bspan} Wayland compositor. Exiting."

	exit 1
}

# Check for the `--copy` argument and its sub-arguments.
[ "$1" = "--copy" ] && {
	# Check for the sub-arguments.
	[ "$#" -eq 2 ] && printf "free region area window screen monitor display\n" | grep -qw "$2" && {
		# Set the screenshot type.
		[ "$2" = "free" ] || [ "$2" = "region" ] || [ "$2" = "area" ] && type="screenshot"
		[ "$2" = "window" ] && type="screenshot-window"
		[ "$2" = "screen" ] || [ "$2" = "monitor" ] || [ "$2" = "display" ] && type="screenshot-screen"

		# Take the screenshot.
		niri msg action "$type" || {
			printf "%s: An error occured when taking the screenshot. Exiting.\n" "$err"

			notify "Error" \
			"${derr}: An error occured when taking the screenshot. Exiting."

			exit 1
		}

		exit
	}
}

# Check for the `--save` argument and its sub-arguments.
[ "$1" = "--save" ] && {
	# Check for the sub-arguments.
	[ "$#" -eq 2 ] && printf "free region area window screen monitor display\n" | grep -qw "$2" && {
		[ "$2" = "free" ] || [ "$2" = "region" ] || [ "$2" = "area" ] && type="screenshot"
		[ "$2" = "window" ] && type="screenshot-window"
		[ "$2" = "screen" ] || [ "$2" = "monitor" ] || [ "$2" = "display" ] && type="screenshot-screen"

		# Check if wl-clipboard is installed.
		command -v wl-paste > /dev/null 2>&1 || {
			printf "%s: %swl-clipboard%s could not be found. It is needed to save the screenshot. Exiting." "$err" "$exe" "$clr"

			notify "wl-clipboard not found" \
			"${derr}: ${dexe}wl-clipboard${bspan} could not be found. It is needed to save the screenshot. Exiting"

			exit 1
		}

		# Check if Oxipng is installed.
		command -v oxipng > /dev/null 2>&1 || {
			printf "%s: %sOxipng%s could not be found. The %sPNG%s image will not be optimized. Continuing.\n" "$war" "$exe" "$clr" "$ico" "$clr"

			warify "Oxipng not found" \
			"${dwar}: ${dexe}Oxipng${bspan} could not be found. The ${dico}PNG${bspan} image will not be optimized. Continuing."

			oxipng_dep=false
		}; [ "$oxipng_dep" = "false" ] || { oxipng_dep=true; }

		# Check if libwebp is installed.
		command -v cwebp > /dev/null 2>&1 || {
			printf "%s: %slibwebp%s could not be found. The %sPNG%s image will not be converted to a %WEBP% one. Continuing.\n" "$war" "$exe" "$clr" "$ico" "$clr" "$ico" "$clr"

			warify "libwebp not found" \
			"${dwar}: ${dexe}libwebp${bspan} could not be found. The ${dico}PNG${bspan} image will not be converted to a ${dico}WEBP${bspan} one. Continuing."

			libwebp_dep=false
		}; [ "$libwebp_dep" = "false" ] || { libwebp_dep=true; }

		# Take the screenshot.
		niri msg action "$type" || {
			printf "%s: An error occured when taking the screenshot. Exiting.\n" "$err"

			notify "Error" \
			"${derr}: An error occured when taking the screenshot. Exiting."

			exit 1
		}

		# Set the screenshot's name.
		image=$(date +'Screenshot_%d-%m-%Y_%H-%M-%S')

		# Set values to wait until the image is detected in the clipboard.
		max_attempts=20
		attempt=1

		# Loop until the image is detected in the clipboard, and save it when it is.
		while [ "$attempt" -le "$max_attempts" ]; do
			# Check if the clipboard contains image data.
			wl-paste --list-types | grep -q "image/" || {
				sleep 0.1; attempt=$((attempt +1)); continue
			}

			# Check for valid directories
			scrdir="$HOME/Images/Screenshots/"
			[ -d "$scrdir" ] || scrdir="$XDG_PICTURES_DIR/"
			[ -d "$scrdir" ] || scrdir="$HOME/"
			cd "$scrdir"

			# Paste the image into a file.
			wl-paste > "$image".png || {
				printf "%s: An error occured when saving the screenshot. Exiting." "$err"

				notify "Unable to save" \
				"${derr}: An error occured when saving the screenshot. Exiting."

				exit 1
			}

			# Optimize the image with Oxipng.
			[ "$oxipng_dep" = "false" ] || {
				oxipng --strip all "$image".png || {
					printf "%s: An error occured when optimizing the image. Ignoring." "$war"

					notify "Unable to optimize" \
					"${dwar}: An error occured when optimizing the image. Ignoring."
				}
			}

			# Convert the PNG image to a WEBP one.
			[ "$libwebp_dep" = "false" ] || {
				cwebp -lossless -z 7 "$image".png -o "$image".webp || {
					printf "%s: An error occured when converting the screenshot. Keeping the original one." "$war"

					warify "Unable to convert" \
					"${dwar}: An error occured when converting the screenshot. Keeping the original one."

					exit 2
				}

				# Delete the original PNG image.
				rm -v "$image".png

				exit
			}
			exit
		done

		printf "%s: An error occured when saving the screenshot. Exiting." "$err"

		notify "Error saving screenshot" \
		"${derr}: An error occured when saving the screenshot. Exiting."

		exit 1
	}
}

# Error when no argument is given.
[ "$1" = "" ] && {
	printf "%s: No argument was given.\n\n" "$err"
	printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" "$arg" "$clr" "$arg" "$clr" "$arg" "$clr"

	notify "Missing argument" \
	"${derr}: No argument was given.
See the ${darg}--about${bspan} / ${darg}--help${bspan} / ${darg}-h${bspan} argument."

	exit 1
}

# Error when an invalid argument is given.
printf "%s: Invalid argument '%s%s%s'.\n\n" "$err" "$arg" "$*" "$clr"
printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" "$arg" "$clr" "$arg" "$clr" "$arg" "$clr"

notify "Invalid argument" \
"${derr}: Invalid argument '${darg}${*}${bspan}'
See the ${darg}--about${bspan} / ${darg}--help${bspan} / ${darg}-h${bspan} argument."

exit 1