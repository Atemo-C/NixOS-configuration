#!/bin/dash

# Shortcut for binaries.
SW="/run/current-system/sw/bin"

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

# Define the type of screenshot being taken and handle other arguments.
for type in "$@"; do
	case "$type" in
		area) shottype="area";;
		monitor) shottype="output";;
		all) shottype="screen";;
		--copy|-c);;
		--save|-s);;
		--about);;
		--help);;
		*);;
	esac
done

# Define the help and argument missing messages.
Help="
You can use the $(tput setaf 2)--copy$(tput sgr0) / $(tput setaf 2)-c$(tput sgr0) or the $(tput setaf 2)--save$(tput sgr0) / $(tput setaf 2)-s$(tput sgr0) argument, followed or preceeded by one of:
  $(tput setaf 6)area$(tput sgr0)    $(tput setaf 13)(to select an area or individual window)$(tput sgr0)
  $(tput setaf 6)monitor$(tput sgr0) $(tput setaf 13)(to select the current monitor)$(tput sgr0)
  $(tput setaf 6)all$(tput sgr0)     $(tput setaf 13)(to select all active monitors)$(tput sgr0)

Additionally, you can use the $(tput setaf 2)--about$(tput sgr0) argument to see information about this script, or the $(tput setaf 2)--help$(tput sgr0) argument to see this message.
"

# Define the about message.
About="
Screenshot.sh

This script allows you to take screenshots in the Hyprland Wayland compositor using the grimblast utility.

When using the $(tput setaf 2)--copy$(tput sgr0)/$(tput setaf 2)-c$(tput sgr0) argument, the taken screenshot is copied into the clipboard.

When using the $(tput setaf 2)--save$(tput sgr0)/$(tput setaf 2)-s$(tput sgr0) argument:
• The taken screenshot is copied into the clipboard and saved to a file.
• The file is then optimized by the oxipng utility.
• The file is then converted to a lossless WEBP image by the magick utility.
• The original image is deleted, leaving the WEBP image saved.

When using the $(tput setaf 2)--about$(tput sgr0) argument, this message is displayed.

When using the $(tput setaf 2)--help$(tput sgr0) argument, help about the script is displayed.

Credits:
• $(tput bold)grimblast$(tput sgr0):   $(tput setaf 4)https://github.com/hyprwm/contrib/tree/main/grimblast$(tput sgr0)
• $(tput bold)oxipng$(tput sgr0):      $(tput setaf 4)https://github.com/shssoichiro/oxipng$(tput sgr0)
• $(tput bold)imagemagick$(tput sgr0): $(tput setaf 4)http://www.imagemagick.org/$(tput sgr0)
"

# Copy the screenshot to the clipboard with the --copy or -c argument.
if echo "$*" | grep -q -- "--copy" || echo "$*" | grep -q -- "-c"; then
	grimblast --notify --freeze copy "$shottype"

# Save the screenshot to a file with the --save or -s argument.
elif echo "$*" | grep -q -- "--save" || echo "$*" | grep -q -- "-s"; then
	# Set the screenshot's name.
	Image=$(date +'Screenshot_%d-%m-%Y_%H-%M-%S')

	# Change the active directory to save the screenshot into.
	cd "$HOME/Images/Screenshots" || exit 1

	# Take the screenshot.
	grimblast --freeze copysave "$shottype" "$Image".png &&

	# Optimize the image.
	oxipng --strip all "$Image".png &&

	# Convert the screenshot to a WEBP image.
	magick "$Image".png -quality 100 "$Image".webp &&

	# Remove the original screenshot.
	rm "$Image".png

# Shows the about message with the --about argument.
elif echo "$*" | grep -q -- "--about"; then
	echo "$About"

# Shows the help message with the --help argument.
elif echo "$*" | grep -q -- "--help"; then
	echo "$Help"

# Shows the help message when no or an invalid argument is given.
else
	echo "\n$(tput setaf 1)$(tput bold)Error$(tput sgr0): Missing or invalid argument."
	echo "$Help"
	exit 1
fi
