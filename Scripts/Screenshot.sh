#!/bin/dash

# Set some text formatting shortcuts.
err=$(tput bold)$(tput setaf 1)Error$(tput sgr0)
arg=$(tput bold)$(tput setaf 2)
exe=$(tput bold)$(tput setaf 3)
ico=$(tput bold)$(tput setaf 6)
web=$(tput setaf 4)
dim=$(tput dim)
bol=$(tput bold)
c=$(tput sgr0)

# Check if the number of arguments is greater than 2.
[ "$#" -gt 2 ] && {
	echo \
		"${err}: Invalid number of arguments (${arg}$#${c}).\n" \
		"\nSee the ${arg}--about${c} and the ${arg}--help${c} arguments.\n"

	exit 1
}

# Check for the --about argument.
[ "$1" = "--about" ] && {
	echo \
		"${ico}  ${arg}Screenshot.sh${c}\n" \
		"\nThis script allows you to take screenshots within the $(exe)Hypralnd${c} Wayland compositor, using ${exe}grimblast${c} to take the screenshots, ${exe}oxipng${c} to optimize the intially saved screenshots, and ${exe}imagemagick${c} to convert the optimized screenshots into WEBP images.\n" \
		"\n• When using the ${arg}--about${c} argument, this message is displayed." \
		"\n• When using the ${arg}--help${c} argument, help about this script is displayed." \
		"\n• When using the ${arg}--check${c} argument, required dependencies will be checked." \
		"\n• When using the ${arg}--copy${c} argument, followed by one of \"${arg}area${c}\" \"${arg}monitor${c}\", or \"${arg}all${c}\", the taken screenshot is copied to the clipboard." \
		"\n• When using the ${arg}--save${c} argument, followed by one of \"${arg}area${c}\" \"${arg}monitor${c}\", or \"${arg}all${c}\", the taken screenshot is saved, optimized, and converted to a WEBP image.\n" \
		"\nCredits:" \
		"\n• ${exe}grimblast${c}: ${web}https://github.com/hyprwm/contrib/tree/main/grimblast${c}" \
		"\n• ${exe}imagemagick${c}: ${web}https://imagemagick.org/${c}" \
		"\n• ${exe}oxipng${c}: ${web}https://github.com/shssoichiro/oxipng${c}\n"

	exit
}

# Check for the --help argument.
[ "$1" = "--help" ] && {
	echo \
		"${ico}  ${arg}Screenshot.sh${c}\n" \
		"\n${bol}[ Arguments ]${c}" \
		"\n${arg}--about${c}" \
		"\nDisplay information about this script.\n" \
		"\n${arg}--help${c}" \
		"\nDisplay this message.\n" \
		"\n${arg}--check${c}" \
		"\nCheck for required dependencies.\n" \
		"\n${arg}--copy${c}${dim}(followed by one of the sub-arguments)${c}" \
		"\nCopy the created screenshot to the clipboard.\n" \
		"\n${arg}--save${c}${dim}(followed by one of the sub-arguments)${c}" \
		"\n· Save the created screenshot to a file with ${exe}grimblast${c}." \
		"\n· Optimize it with ${exe}oxipng${c}." \
		"\n· Convert it to a lossless WEBP image with ${exe}imagemagick${c}." \
		"\n· Delete the original image and keep the WEBP screenshot.\n" \
		"\n${bol}[ Sub-arguments ]${c}" \
		"\n${arg}area${c}" \
		"\nTo select an area or individual window.\n" \
		"\n${arg}monitor${c}" \
		"\nTo select the current monitor.\n" \
		"\n${arg}all${c}" \
		"\nTo select all active monitors.\n" \
		"\n${bol}[ Examples ]${c}" \
		"\n• To copy an area screenshot to the clipboard." \
		"\n    ${arg}dash${c} ${web}/path/to/Screenshot.sh${c} ${arg}--copy area${c}\n" \
		"\n• To save a screenot of all monitors." \
		"\n    ${arg}dash${c} ${web}/path/to/Screenshot.sh${c} ${arg}--save all ${c}\n" \
		"\n${dim}Note: The arguments cannot be swapped around.${c}\n"

	exit
}

# Check for the --check argument.
[ "$1" = "--check" ] && {
	echo "${ico}  ${arg}Screenshot.sh${c}\n"

	# Check if libnotify is installed.
	command -v notify-send > /dev/null 2>&1 && {
		echo "✅ ${exe}libnotify${c} is installed."
	} ||
		echo "❌ ${exe}libnotify${c} is not installed. It is required to display graphical notifications. The script will not run without it."

	# Check if grimblast is installed.
	command -v grimblast > /dev/null 2>&1 && {
		echo "✅ ${exe}grimblast${c} is installed."
	} ||
		echo "❌ ${exe}grimblast is not installed. It is required to take screenshots. The script will not run without it."

	# Check if oxipng is installed.
	command -v notify-send > /dev/null 2>&1 && {
		echo "✅ ${exe}oxipng${c} is installed."
	} ||
		echo "❌ ${exe}oxipng${c} is not installed. It is required to optimize saved screenshots. The script will only run when using the ${arg}--copy${c} argument."

	# Check if imagemagick is installed.
	command -v magick > /dev/null 2>&1 && {
		echo "✅ ${exe}imagemagick${c} is installed."
	} ||
		echo "❌ ${exe}imagemagick${c} is not installed. It is required to convert the saved screenshots into WEBP images. The script will only run when using the ${arg}--copy${c} argument."

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] && {
		echo "✅ ${exe}Hyprland${c} is the active Wayland compositor."
	} ||
		echo "❌ ${exe}Hyprland${c} is not the currently active Wayland compositor. The script will not run outside of Hyprland."

	exit
}

# Check for the --copy argument and its sub-arguments.
[ "$1" = "--copy" ] && {
	# Check if libnotify is installed.
	command -v notify-send || {
		echo "${err}: libnotify could not be found. It is required to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "Error: This screenshot utility can only be used with the Hyprland Wayland compositor."
		echo "${err}: This screenshot utility can only be used with the ${exe}Hyprland${c} Wayland compositor."
		exit 1
	}

	# Check if grimblast is installed.
	command -v grimblast || {
		notify-send "Error: grimblast could not be found. It is required to take screenshots."
		echo "${err}: ${exe}grimblast${c} could not be found. It is required to take screenshots."
		exit 1
	}

	# Copy a screenshot to the clipboard.
	[ "$#" -eq 2 ] && [ "$#" -eq 2 ] && [ "$2" = "area" ] || [ "$2" = "monitor" ] || [ "$2" = "all" ] && {
		[ "$2" = "area" ] && Type="area"
		[ "$2" = "monitor" ] && Type="output"
		[ "$2" = "all" ] && Type="screen"
		grimblast --notify --freeze copy "$Type"
		exit
	}
}

# Check for the --save argument and its sub-arguments.
[ "$1" = "--save" ] && {
	# Check if libnotify is installed.
	command -v notify-send || {
		echo "${err}: libnotify could not be found. It is required to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "Error: This screenshot utility can only be used with the Hyprland Wayland compositor."
		echo "${err}: This screenshot utility can only be used with the ${exe}Hyprland${c} Wayland compositor."
		exit 1
	}

	# Check if grimblast is installed.
	command -v grimblast || {
		notify-send "Error: grimblast could not be found. It is required to take screenshots."
		echo "${err}: ${exe}grimblast${c} could not be found. It is required to take screenshots."
		exit 1
	}

	# Check if oxipng is installed.
	command -v oxipng || {
		notify-send "Error: oxipng could not be found. It is required to optimize the saved screenshot."
		echo "${err}: ${exe}oxipng${c} could not be found. It is required to optimize the saved screenshot."
		exit 1
	}

	# Check if imagemagick is installed.
	command -v magick || {
		notify-send "Error: imagemagick could not be found. It is required to convert the saved screenshot to a WEBP image."
		echo "${err}: ${exe}imagemagick${c} could not be found. It is required to convert the saved screenshot to a WEBP image."
		exit 1
	}

	# Save a screenshot to a file.
	[ "$2" = "area" ] && Type="area"
	[ "$2" = "monitor" ] && Type="output"
	[ "$2" = "all" ] && Type="screen"

	# Set the screenshot's name
	Image=$(date +'Screenshot_%d-%m-%Y_%H-%M-%S')

	# Change the active directory to save the screenshot into.
	cd "$HOME/Images/Screenshots" || cd "$HOME/" || exit 1

	# Take the screenshot.
	grimblast --freeze copysave "$Type" "$Image".png

	# Optimize the image
	oxipng --strip all "$Image".png

	# Convert the screenshot to a WEBP image.
	magick "$Image".png -quality 100 "$Image".webp

	# Remove the original screenshot.
	rm "$Image"

	exit
}

# Error out if an invalid argument is given.
echo \
	"${err}: Invalid argument '${arg}$*${c}'.\n" \
	"\nSee the ${arg}--about${c} and the ${arg}--help${c} arguments.\n"

exit 1
