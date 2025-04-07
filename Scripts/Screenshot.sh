#!/bin/dash

# Shortcut for binaries.
SW="/run/current-system/sw/bin"

# Define the "about" message.
About="
Screenshot.sh

This script allows you to take screenshots in the Hyprland Wayland compositor using grimblast.

• When using the --about argument, this message is displayed.
• When using the --help argument, the help message is displayed.
• When no argument is given, the program selection starts.
• When an invalid argument is given, it is ignored.

Credits:
• grimblast: https://github.com/hyprwm/contrib/tree/main/grimblast
"

# Define the "help" message.
Help="
Screenshot.sh

[ Arguments ]
• --about
  Display information about this script.

• --help
  Display this message.

• --copy (followed by one of the sub-arguments).
  Copies the created screenshot to the clipboard.

• --save (followed by one of the sub-arguments).
  · Saves the created screenshot to a file.
  · Optimizes the screenshot with oxipng.
  · Converts the screenshot to a lossless WEBP image with magick.
  · Deletes the original image and leaves you with a nice, optimized WEBP screenshot.


[ Sub-arguments ]
• area
  To select an area or individual window.

• monitor
  To select the current monitor.

• all
  To select all active monitors.


[ Examples ]
• To copy an area to the clipboard.
dash /path/to/Screenshot.sh --copy area

• To save a screenshot of all monitors.
dash /path/to/Screenshot.sh --save all

Note: The arguments can be swapped around (all --save instead of --save all).
"

# Check for arguments.
for argument in "$@"; do
	case "$argument" in
		--about);;
		--help);;
		--copy);;
		--save);;
		area) shottype="area";;
		monitor) shottype="output";;
		all) shottype="screen";;
		*);;
	esac
done

# Show the "about" message when the --about argument is given.
echo "$*" | grep -q -- "--about" &&
	echo "$About" &&
	exit ||

# Show the "help" message when the --help argument is given.
echo "$*" | grep -q -- "--help" &&
	echo "$Help" &&
	exit ||

# When no or an invalid argument is given, check for relevant depedencies and take a screenshot.

# Check if libnotify is installed.
[ -f "$SW/notify-send" ] || {
	echo "libnotify could not be found. It is needed to display graphical notifications.";
	exit 1;
}

# Check if Hyprland is the active desktop.
[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
	notify-send "This wallpaper utility can only be used with Hyprland." &
	echo "This wallpaper utility can only be used with Hyprland.";
	exit 1;
}

# Check if grimblast is insalled.
[ -f "$SW/grimblast" ] || {
	notify-send "grimblast could not be found. It is needed to take screenshots." &
	echo "grimblast could not be found. It is needed to take screenshots.";
	exit 1;
}

# Check if oxipng is installed.
[ -f "$SW/oxipng" ] || {
	notify-send "oxipng could not be found. It is needed to optimize the intial saved screenshots." &
	echo "oxipng could not be found. It is needed to optimize the intial saved screenshots.";
	exit 1;
}

# Check if imagemagick is installed.
[ -f "$SW/magick" ] || {
	notify-send "imagemagick could not be found. It is needed to convert the saved screenshot to a WEBP image." &
	echo "imagemagick could not be found. It is needed to convert the saved screenshot to a WEBP image.";
	exit 1;
}

echo "$*" | grep -q -- "--copy" &&
	grimblast --notify --freeze copy "$shottype" &&
	exit ||

echo "$*" | grep -q -- "--save" &&
	# Set the screenshot's name.
	Image=$(date +'Screenshot_%d-%m-%Y_%H-%M-%S')

	# Change the active directory to save the screenshot into.
	cd "$HOME/Images/Screenshots" || cd "$HOME/" || exit 1

	# Take the screenshot.
	grimblast --freeze copysave "$shottype" "$Image".png &&

	# Optimize the image.
	oxipng --strip all "$Image".png &&

	# Convert the screenshot to a WEBP image.
	magick "$Image".png -quality 100 "$Image".webp &&

	# Remove the original screenshot.
	rm "$Image".png &&
	exit
