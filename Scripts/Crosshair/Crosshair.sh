#!/bin/dash

case "$1" in
	# Starts the crosshair.
	--start|-s)
		# Displays the crosshair image.
		feh /etc/nixos/Scripts/Crosshair/Crosshair.png &

		# Wait for the image to be loaded.
		while ! pgrep -x ".feh-wrapped" > /dev/null; do
			sleep 0.05
		done

		# Makes the image floating.
		hyprctl dispatch togglefloating class:feh &&

		# Sets the appropriate size for the image (adjust it to however big the crosshair is).
		hyprctl dispatch setprop class:feh minsize 4 4 &&
		hyprctl dispatch setprop class:feh maxsize 4 4 &&
		hyprctl dispatch resizewindowpixel 4 4, class:feh &&

		# Removes the border from the image.
		hyprctl dispatch setprop class:feh bordersize 0 &&

		# Rounds the image so that it is not a square.
		hyprctl dispatch setprop class:feh rounding 3 &&

		# Removes shadows from the image so it is less distracting.
		hyprctl dispatch setprop class:feh noshadow 1 &&

		# Centers the image on the screen (it is assumed that the program used with it is fullscreen).
		hyprctl dispatch centerwindow class:feh &&

		# Prevent the image from getting focused.
		hyprctl dispatch setprop class:feh nofocus true &&

		# Pin the image.
		hyprctl dispatch pin class:feh
	;;

	# Kills the crosshair.
	--kill|-k)
		pkill feh && notify-send "Crosshair killed."
	;;

	# Errors out if no argument or an invalid one is given.
	*)
		echo "
  $(tput setaf1)$(tput bold)Error$(tput sgr0): Missing or invalid argument.
  You can use the $(tput setaf 2)--start$(tput sgr0) / $(tput setaf 2)-s$(tput sgr0) or the $(tput setaf 2)--kill$(tput sgr0) / $(tput setaf 2)-k$(tput sgr0) argument.
		"
		notify-send "Missing or invalid argument."
		exit 1
	;;
esac
