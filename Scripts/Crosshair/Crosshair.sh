#!/bin/dash

# Shortcut for the path of the image.
Crosshair="/etc/nixos/Scripts/Crosshair/Crosshair.png"

# Check if the determined crosshair file exists.
[ -f "$Crosshair" ] || { notify-send "$Crosshair does not exist."; exit 1; }

# Executeables shortcut.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"

# Check if the requiered dependencies are installed.
# Can be rewritten into a function, but this is simple enough not to be worth the bother.
[ -f "$HM/hyprland" ] || [ -f "$SW/hyprland" ] || { notify-send "This crosshair is made for Hyprland."; exit 1; }
[ -f "$SW/feh" ] || [ -f "$HM/feh"] || { notify-send "feh is not installed."; exit 1; }
[ -f "$SW/magick" ] || { notify-send "imagemagick is not installed."; exit 1; }
[ -f "$SW/notify-send" ] || { echo "notify-send is not installed."; exit 1; }

# Command shortcuts.
Setprop="hyprctl dispatch setprop class:feh"
Dispatch="hyprctl dispatch"

case "$1" in
	# Starts the crosshair. There is no need to notify the user, as the crosshair will appear right on the screen.
	--start|-s)
		# Displays the crosshair image.
		feh "$Crosshair" || exit 1 &

		# Wait for the image to be loaded.
		while ! pgrep -x ".feh-wrapped" > /dev/null; do
			sleep 0.05
		done

		# Makes the image floating.
		$Dispatch togglefloating class:feh &&

		# Gather the size of the crosshair image.
		Width=$(identify -format "%w" "$Crosshair")
		Height=$(identify -format "%h" "$Crosshair")

		# Sets the appropriate size for the image.
		$Setprop minsize "$Width" "$Height" &&
		$Setprop maxsize "$Width" "$Height" &&
		$Dispatch resizewindowpixel "$Width" "$Height", class:feh &&

		# Removes the border from the image.
		$Setprop bordersize 0 &&

		# Rounds the image so that it is not a square.
		# It uses the width of the image to determine the rounding value.
		$Setprop rounding "$Width" &&

		# Removes shadows from the image so it is less distracting.
		$Setprop noshadow 1 &&

		# Centers the image on the screen (it is assumed that the program used with it is fullscreen).
		$Dispatch centerwindow class:feh &&

		# Prevent the image from getting focused.
		$Setprop nofocus true &&

		# Pin the image.
		$Dispatch pin class:feh
	;;

	# Kills the crosshair. The && here is normal.
	--kill|-k)
		trap 'pkill feh && notify-send "Crosshair killed."' EXIT
	;;

	# Errors out if no argument or an invalid one is given.
	*)
		echo "
 $(tput setaf 1)$(tput bold)Error$(tput sgr0): Missing or invalid argument.
 You can use the $(tput setaf 2)--start$(tput sgr0) / $(tput setaf 2)-s$(tput sgr0) or the $(tput setaf 2)--kill$(tput sgr0) / $(tput setaf 2)-k$(tput sgr0) argument.
"
		notify-send "Missing or invalid argument."
		exit 1
	;;
esac
