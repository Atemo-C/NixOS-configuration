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
hweb1="<span foreground='#0080ff'>"
hweb2="</span>"

# Check if the number of arguments is greater than 2.
[ "$#" -gt 2 ] && {
	printf "%s: Invalid number of arguments '%s%d%s'.\n\n" \
		"$err" "$arg" "$#" "$c"

	printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" \
		"$arg" "$c" "$arg" "$c" "$arg" "$c"

	exit 1
}

# Check for the `--about` and `--help` arguments.
[ "$1" = "--about" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ] && {

	printf "%s  %sScreenshot.sh%s\n\n" \
		"$ico" "$arg" "$c"

	printf "%s[ Description ]%s\n" \
		"$bol" "$c"

	printf " This script allows you to take screenshots within the %sHyprland%s Wayland compositor.\n\n" \
		"$exe" "$c"

	printf "%s[ Arguments ]%s\n" \
		"$bol" "$c"

	printf " %s--about%s / %s--help%s / %s-h%s \n" \
		"$arg" "$c" "$arg" "$c" "$arg" "$c"

	printf "  Display this message.\n\n"

	printf " %s--copy%s %s(followed by one of the sub-arguments)%s\n" \
		"$arg" "$c" "$dim" "$c"

	printf "   Take a screenshot with %sGrimblast%s and copy it to the clipboard.\n\n" \
		"$exe" "$c"

	printf " %s--save%s %s(followed by one of the sub-arguments)%s\n" \
		"$arg" "$c" "$dim" "$c"

	printf "   • Take a screenshot with %sGrimblast%s and save it to a file.\n" \
		"$exe" "$c"

	printf "   • Optimize it with %sOxipng%s.\n" \
		"$exe" "$c"

	printf "   • Convert it to a WEBP image with %sImageMagick%s.\n" \
		"$exe" "$c"

	printf "   • Delete the original image, keeping the WEBP one.\n\n"

	printf "%s[ Sub-arguments ]%s\n" \
		"$bol" "$c"

	printf " %sarea%s\n" \
		"$arg" "$c"

	printf "   Select an area or individual window to screenshot.\n\n"

	printf " %smonitor%s\n" \
		"$arg" "$c"

	printf "   Select the current monitor to screenshot.\n\n"

	printf " %sall%s\n" \
		"$arg" "$c"

	printf "   Select all active monitors to screenshot.\n\n"

	printf "%s[ Examples ]%s\n" \
		"$bol" "$c"

	printf " To copy an area screenshot to the clipboard:\n"

	printf "   %sdash%s %s/path/to/Screenshot.sh %s--copy area%s\n\n" \
		"$arg" "$c" "$web" "$arg" "$c"

	printf " To save a screenshot of all monitors:\n"

	printf "   %sdash%s %s/path/to/Screenshot.sh %s--save all%s\n\n" \
		"$arg" "$c" "$web" "$arg" "$c"

	printf " %sNote: The arguments cannot be swapped around.%s\n\n" \
		"$dim" "$c"

	printf "%s[ Credits ]%s\n" \
		"$bol" "$c"

	printf " %sGrimblast%s:   %shttps://github.com/hyprwm/contrib/tree/main/grimblast%s\n" \
		"$exe" "$c" "$web" "$c"

	printf " %sImageMagick%s: %shttps://imagemagick.org%s\n" \
		"$exe" "$c" "$web" "$c"

	printf " %sOxipng%s:      %shttps://github.com/shssoichiro/oxipng%s\n" \
		"$exe" "$c" "$web" "$c"

	exit 0
}

# Check for the `--copy` argument and its sub-arguments.
[ "$1" = "--copy" ] && {
	# Check if Dunst is installed.
	command -v dunstify > /dev/null 2>&1 || {
		printf "%s: %sDunst%s could not be found. It is required to display graphical notifications." \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		dunstify -u critical "Screenshot.sh" "$herr: This script can only be used with the$hexe1 Hyprland$hexe2 Wayland compositor."

		printf "%s: This script can only be used with the %sHyprland%s Wayland compositor." \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Grimblast is installed.
	command -v grimblast > /dev/null 2>&1 || {
		dunstify -u critical "Screenshot.sh" "$herr:$hexe1 Grimblast$hexe2 could not be found. It is required to take screenshots."

		printf "%s: %sGrimblast%s could not be found. It is required to take screenshots." \
			"$err" "$exe" "$c"
	}

	# Copy a screenshot to the clipboard.
	[ "$#" -eq 2 ] && [ "$2" = "area" ] || [ "$2" = "monitor" ] || [ "$2" = "all" ] && {
		[ "$2" = "area" ] && Type="area"
		[ "$2" = "monitor" ] && Type="output"
		[ "$2" = "all" ] && Type="screen"

		# Take the screenshot.
		grimblast --notify --freeze copy "$Type"  > /dev/null 2>&1 || {
			dunstify -u critical "Screenshot.sh" "$herr: There was an error when taking a screenshot."

			printf "%s: There was an error when taking a screenshot." \
				"$err"

			exit 1
		}

		exit 0
	}
}

# Check for the `--save` argument and its sub-arguments.
[ "$1" = "--save" ] && {
	# Check if Dunst is installed.
	command -v dunstify > /dev/null 2>&1 || {
		printf "%s: %sDunst%s could not be found. It is required to display graphical notifications." \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		dunstify -u critical "Screenshot.sh" "$herr: This script can only be used with the$hexe1 Hyprland$hexe2 Wayland compositor."

		printf "%s: This script can only be used with the %sHyprland%s Wayland compositor." \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Grimblast is installed.
	command -v grimblast > /dev/null 2>&1 || {
		dunstify -u critical "Screenshot.sh" "$herr:$hexe1 Grimblast$hexe2 could not be found. It is required to take screenshots."

		printf "%s: %sGrimblast%s could not be found. It is required to take screenshots." \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Oxipng is installed.
	command -v oxipng > /dev/null 2>&1 || {
		dunstify -u critical "Screenshot.sh" "$herr:$hexe1 Oxipng$hexe2 could not be found. It is required to optimize the initial screenshot."

		printf "%s: %sOxipng%s could not be found. It is required to optimize the initial screenshot." \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if ImageMagick is installed.
	command -v magick > /dev/null 2>&1 || {
		dunstify -u critical "Screenshot.sh" "$herr:$hexe1 ImageMagick$hexe2 could not be found. It is required to convert the screenshot to a WEBP image."

		printf "%s: %ImageMagick%s could not be found. It is required to convert the screenshot to a WEBP image." \
			"$err" "$exe" "$c"

		exit 1
	}

	# Save a screenshot to a file.
	[ "$#" -eq 2 ] && [ "$2" = "area" ] || [ "$2" = "monitor" ] || [ "$2" = "all" ] && {
		[ "$2" = "area" ] && Type="area"
		[ "$2" = "monitor" ] && Type="output"
		[ "$2" = "all" ] && Type="screen"

		# Set the screenshot's name.
		Image=$(date +'Screenshot_%d-%m-%Y_%H-%M-%S')

		# Change the active directory to save the screenshot into.
		# If it is not found, simply save it in the $HOME directory.
		cd "$HOME/Images/Screenshots" || cd "$HOME" || {
			dunstify -u critical "… What? How? How is there not even a \$HOME directory??????"

			printf "… What? How? How is there not even a \$HOME directory??????"

			exit 1
		}

		# Take the screenshot.
		grimblast --freeze copysave "$Type" "$Image".png > /dev/null 2>&1 || {
			dunstify -u critical "Screenshot.sh" "$herr: There was an error when taking a screenshot."

			printf "%s: There was an error when taking a screenshot." \
				"$err"

			exit 1
		}

		# Optimize the image.
		oxipng --strip all "$Image".png || {
			dunstify -u critical "Screenshot.sh" "$herr: There was an error when optimizing$hweb1 $Image.png$hweb2"

			printf "%s: There was an error when optimizing %s$Image.png%s" \
				"$err" "$web" "$c"

			exit 1
		}

		# Convert the image to a WEBP one.
		magick "$Image".png -quality 100 "$Image".webp || {
			dunstify -u critical "Screenshot.sh" "$herr: There was an error when converting$hweb1 $Image.png$hweb2 to a WEBP image."

			printf "%s: There was an error when converting %s$Image.png%s to a WEBP image." \
				"$err" "$web" "$c"

			exit 1
		}

		# Remove the original screenshot.
		rm -v "$Image.png"

		# Notify the user.
		dunstify "Screenshot.sh" "Screenshot$hweb1 $Image.webp$hweb2 has been taken."

		exit 0
	}
}

# Error out if an invalid argument is given.
printf "%s: Invalid argument '%s%s%s'.\n\n" \
	"$err" "$arg" "$*" "$c"

printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" \
	"$arg" "$c" "$arg" "$c" "$arg" "$c"

exit 1
