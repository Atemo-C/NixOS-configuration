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

# Check if imagemagick is installed.
[ -f "$SW/magick" ] || {
	notify-send "imagemagick could not be found. It is needed to get the properties of the crosshair image." &
	echo "imagemagick could not be found. It is needed to get the properties of the crosshair image.";
	exit 1;
}

# Check if feh is installed.
[ -f "$SW/feh" ] || {
	notify-send "feh could not be found. It is needed to display the crosshair image." &
	echo "feh could not be found. It is needed to display the crosshair image.";
	exit 1;
}

# Shortcut for the path of the crosshair image.
Crosshair="/etc/nixos/Scripts/Crosshair/Crosshair.png";

# Check if the crosshair file exists.
[ -f "$Crosshair" ] || {
	notify-send "$Crosshair does not exist." &
	echo "$Crosshair does not exist.";
	exit 1;
}

# Shortcuts for hyprctl dispatch commands.
Setprop="hyprctl dispatch setprop class:feh"
Dispatch="hyprctl dispatch"

case "$1" in
	# Start the crosshair.
	--start|-s)
		# Display the crosshair image.
		feh "$Crosshair" || exit 1 &

		# Wait for the image to be loaded.
		while ! pgrep -x ".feh-wrapped" > /dev/null; do
			sleep 0.05
		done

		# Make the image floating.
		$Dispatch togglefloating class:feh &&

		# Gather the size of the crosshair image.
		Width=$(identify -format "%w" "$Crosshair")
		Height=$(identify -format "%h" "$Crosshair")

		# Set the appropriate size for the image.
		$Setprop minsize "$Width" "$Height" &&
		$Setprop maxsize "$Width" "$Height" &&
		$Dispatch resizewindowpixel "$Width" "$Height", class:feh &&

		# Remove the border from the image.
		$Setprop bordersize 0 &&

		# Round the image so that it is not a square.
		# It uses the width of the image to determine the rounding value.
		$Setprop rounding "$Width" &&

		# Remove shadows from the image so it is less distracting.
		$Setprop noshadow 1 &&

		# Center the image on the screen (it is assumed that the program used with it is fullscreen).
		$Dispatch centerwindow class:feh &&

		# Prevent the image from getting focused.
		$Setprop nofocus true &&

		# Pin the image.
		$Dispatch pin class:feh
	;;

	# Kill the crosshair.
	--kill|-k)
		trap 'pkill feh && notify-send "Crosshair killed."' EXIT
	;;

	# Error out if no argument or an invalid one is given.
	*)
		echo "
 $(tput setaf 1)$(tput bold)Error$(tput sgr0): Missing or invalid argument.
 You can use the $(tput setaf 2)--start$(tput sgr0) / $(tput setaf 2)-s$(tput sgr0) or the $(tput setaf 2)--kill$(tput sgr0) / $(tput setaf 2)-k$(tput sgr0) argument.
"
		notify-send "Missing or invalid argument."
		exit 1
	;;
esac
