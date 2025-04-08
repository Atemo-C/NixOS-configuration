#!/bin/dash

# Shortcut for binaries.
SW="/run/current-system/sw/bin"

# Check if the number of arguments is greater than 2.
[ "$#" -gt 2 ] && {
	echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid number of arguments.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) and $(tput setaf 2)$(tput bold)--help$(tput sgr0) arguments.
"
	exit 1
}

# Check for the --about argument.
[ "$1" = "--about" ] && {
	echo "$(tput bold)$(tput setaf 6)  $(tput setaf 2)Screenshot.sh$(tput sgr0)

This script allows you to take screenshots within the $(tput bold)$(tput setaf 3)Hyprland$(tput sgr0) Wayland compositor, using $(tput bold)$(tput setaf 6)grimblast$(tput sgr0) to take the screenshot, $(tput bold)$(tput setaf 6)oxipng$(tput sgr0) to optimize the saved ones, and $(tput bold)$(tput setaf 6)imagemagick$(tput sgr0) to convert the saved ones to WEBP images.

• When using the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument, this message is displayed.
• When using the $(tput setaf 2)$(tput bold)--copy$(tput sgr0) argument followed by one of \"$(tput bold)$(tput setaf 6)area$(tput sgr0)\", \"$(tput bold)$(tput setaf 6)monitor$(tput sgr0)\", or \"$(tput bold)$(tput setaf 6)all$(tput sgr0)\", the taken screenshot is copied to the clipboard.
• When using the $(tput setaf 2)$(tput bold)--save$(tput sgr0) argument followed by one of \"$(tput bold)$(tput setaf 6)area$(tput sgr0)\", \"$(tput bold)$(tput setaf 6)monitor$(tput sgr0)\", or \"$(tput bold)$(tput setaf 6)all$(tput sgr0)\", the taken screenshot is saved, optimized, and converted to a WEBP image.

Credits:
• $(tput bold)$(tput setaf 3)grimblast$(tput sgr0): $(tput setaf 4)https://github.com/hyprwm/contrib/tree/main/grimblast$(tput sgr0)
• $(tput bold)$(tput setaf 3)imagemagick$(tput sgr0): $(tput setaf 4)https://imagemagick.org/$(tput sgr0)
• $(tput bold)$(tput setaf 3)oxipng$(tput sgr0): $(tput setaf 4)https://github.com/shssoichiro/oxipng$(tput sgr0)
"

	exit
}

# Check for the --help argument.
[ "$1" = "--help" ] && {
	echo "$(tput bold)$(tput setaf 6)  $(tput setaf 2)Screenshot.sh$(tput sgr0)

$(tput bold)[ Arguments ]$(tput sgr0)
  $(tput bold)$(tput setaf 2)--about$(tput sgr0)
  Display information about this script.

  $(tput bold)$(tput setaf 2)--help$(tput sgr0)
  Display this message.

  $(tput bold)$(tput setaf 2)--copy$(tput sgr0) (followed by one of the sub-arguments).
  Copies the created screenshot to the clipboard.

  $(tput bold)$(tput setaf 2)--save$(tput sgr0) (followed by one of the sub-arguments).
  · Saves the created screenshot to a file with $(tput bold)$(tput setaf 6)grimblast$(tput sgr0).
  · Optimizes it with $(tput bold)$(tput setaf 6)oxipng$(tput sgr0).
  · Converts it to a lossless WEBP image with $(tput bold)$(tput setaf 6)magick$(tput sgr0).
  · Deletes the original image and leaves you with the WEBP screenshot.

$(tput bold)[ Sub-arguments ]$(tput sgr0)
  $(tput bold)$(tput setaf 6)area$(tput sgr0)
  To select an area or individual window.

  $(tput bold)$(tput setaf 6)monitor$(tput sgr0)
  To select the current monitor.

  $(tput bold)$(tput setaf 6)all$(tput sgr0)
  To select all active monitors.

$(tput bold)[ Examples ]$(tput sgr0)
  • To copy an area screenshot to the clipboard.
  $(tput setaf 4)dash $(tput setaf 6)/path/to/Screenshot.sh $(tput setaf 2)--copy $(tput setaf 5)area$(tput sgr0)

  • To save a screenshot of all monitors.
  $(tput setaf 4)dash $(tput setaf 6)/path/to/Screenshot.sh $(tput setaf 2)--save $(tput setaf 5)all$(tput sgr0)

  $(tput dim)Note: The arguments cannot be swapped around ($(tput bold)$(tput setaf 2)--copy $(tput setaf 6)all$(tput sgr0)$(tput dim) is valid, but $(tput bold)$(tput setaf 6)all $(tput setaf 2)--copy$(tput sgr0)$(tput dim) is not).
"

	exit
}

# Check for the --copy argument and its sub-arguments.
[ "$1" = "--copy" ] && {
	# Check if libnotify is installed.
	[ -f "$SW/notify-send" ] || {
		echo "libnotify could not be found. It is needed to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "This program menu can only be used with Hyprland."
		echo "This program menu can only be used with Hyprland."
		exit 1
	}

	# Check if grimblast is installed.
	[ -f "$SW/grimblast" ] || {
		notify-send "grimblast could not be found. It is needed to take screenshots."
		echo "grimblast could not be found. It is needed to take screenshots."
		exit 1
	}

	# Check if oxipng is installed.
	[ -f "$SW/oxipng" ] || {
		notify-send "oxipng could not be found. It is needed to optimize the intial saved screenshots."
		echo "oxipng could not be found. It is needed to optimize the intial saved screenshots."
		exit 1
	}

	# Check if imagemagick is installed.
	[ -f "$SW/magick" ] || {
		notify-send "imagemagick could not be found. It is needed to convert the saved screenshot to a WEBP image."
		echo "imagemagick could not be found. It is needed to convert the saved screenshot to a WEBP image."
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
	[ -f "$SW/notify-send" ] || {
		echo "libnotify could not be found. It is needed to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "This program menu can only be used with Hyprland."
		echo "This program menu can only be used with Hyprland."
		exit 1
	}

	# Check if grimblast is installed.
	[ -f "$SW/grimblast" ] || {
		notify-send "grimblast could not be found. It is needed to take screenshots."
		echo "grimblast could not be found. It is needed to take screenshots."
		exit 1
	}

	# Check if oxipng is installed.
	[ -f "$SW/oxipng" ] || {
		notify-send "oxipng could not be found. It is needed to optimize the intial saved screenshots."
		echo "oxipng could not be found. It is needed to optimize the intial saved screenshots."
		exit 1
	}

	# Check if imagemagick is installed.
	[ -f "$SW/magick" ] || {
		notify-send "imagemagick could not be found. It is needed to convert the saved screenshot to a WEBP image."
		echo "imagemagick could not be found. It is needed to convert the saved screenshot to a WEBP image."
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
echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid argument '$(tput setaf 1)$@$(tput sgr0)'.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) and $(tput setaf 2)$(tput bold)--help$(tput sgr0) arguments.
"
exit 1
