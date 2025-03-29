#!/bin/dash

# Loop that defines the type of screenshot being taken.
for type in "$@"; do
	case "$type" in
		area) shottype="area";;
		monitor) shottype="output";;
		all) shottype="screen";;
		--copy|-c|--save|-s);; # This is handled in the later part of this script.
		*);; # If the argument is not recognized, it is ignored.
	esac
done

# Copies the screenshot to the clipboard with the --copy or -c argument.
if echo "$*" | grep -q -- "--copy" || echo "$*" | grep -q -- "-c"; then
	grimblast --notify --freeze copy "$shottype"

# Saves the screenshot to a file with the --save or -s argument.
elif echo "$*" | grep -q -- "--save" || echo "$*" | grep -q -- "-s"; then
	# Sets the screenshot's name.
	IMAGE=$(date +'Screenshot_%d-%m-%Y_%H-%M-%S')

	# Changes the active directory to save the screenshot into.
	cd "$HOME/Images/Screenshots" || exit 1

	# Take the screenshot.
	grimblast --freeze copysave "$shottype" "$IMAGE".png &&

	# Convert the screenshot to a WEBP image.
	magick "$IMAGE".png -quality 100 "$IMAGE".webp &&

	# Remove the original screenshot.
	rm "$IMAGE".png

# Errors out if no argument or an invalid one is given.
else
echo "
 $(tput setaf 1)$(tput bold)Error$(tput sgr0): Missing or invalid argument.
 You can use the $(tput setaf 2)--copy$(tput sgr0) / $(tput setaf 2)-c$(tput sgr0) or the $(tput setaf 2)--save$(tput sgr0) / $(tput setaf 2)-s$(tput sgr0) argument, followed or preceeded by one of:
   $(tput setaf 6)area$(tput sgr0)    $(tput setaf 13)(to select an area or individual window)$(tput sgr0)
   $(tput setaf 6)monitor$(tput sgr0) $(tput setaf 13)(to select the current monitor)$(tput sgr0)
   $(tput setaf 6)all$(tput sgr0)     $(tput setaf 13)(to select all active monitors)$(tput sgr0)
	"
	notify-send "Missing or invalid argument."
	exit 1
fi
