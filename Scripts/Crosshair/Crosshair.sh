#!/bin/dash

# Shortcut for binaries.
SW="/run/current-system/sw/bin"

# Shortcut for the path of the crosshair image.
Crosshair="/etc/nixos/Scripts/Crosshair/Crosshair.png"

# Shortcut for the crosshair's PID file.
Crosshair_PID_file="/tmp/crosshair_pid.txt"

# Shortcuts for hyprctl dispatch commands.
Setprop="hyprctl dispatch setprop"
Dispatch="hyprctl dispatch"

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid number of arguments.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) and $(tput setaf 2)$(tput bold)--help$(tput sgr0) arguments.
"
	exit 1
}

# Check for the --about argument.
[ "$1" = "--about" ] && {
	echo "$(tput bold)$(tput setaf 6)  $(tput setaf 2)Crosshair.sh$(tput sgr0)

This script allows you to summon and stop a single, simple dot crosshair within the $(tput bold)$(tput setaf 3)Hyprland$(tput sgr0) Wayland compositor, using $(tput bold)$(tput setaf 6)feh$(tput sgr0) to display the image, with a bit of help from $(tput bold)$(tput setaf 6)imagemagick$(tput sgr0).

$(tput dim)Notes: • It assumes use in applications such as video-gaming in fullscreen/borderless fullscreen-only.
       • Only a single crosshair can be spawned.$(tput sgr0)

• When using the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument, this message is displayed.
• When using the $(tput setaf 2)$(tput bold)--help$(tput sgr0) argument, help about this script is displayed.
• When using the $(tput setaf 2)$(tput bold)--start$(tput sgr0) argument, a crosshair is started on the currently focused monitor.
• When using the $(tput setaf 2)$(tput bold)--stop$(tput sgr0) argument, the active crosshair is closed.

Credits:
• $(tput bold)$(tput setaf 3)feh$(tput sgr0): $(tput setaf 4)https://feh.finalrewind.org/$(tput sgr0)
• $(tput bold)$(tput setaf 3)imagemagick$(tput sgr0): $(tput setaf 4)https://imagemagick.org/$(tput sgr0)
"

	exit
}

# Check for the --help argument.
[ "$1" = "--help" ] && {
	echo "$(tput bold)$(tput setaf 6)  $(tput setaf 2)Crosshair.sh$(tput sgr0)

$(tput bold)[ Arguments ]$(tput sgr0)
  $(tput setaf 2)$(tput bold)--about$(tput sgr0)
  Display information about this script.

  $(tput setaf 2)$(tput bold)--help$(tput sgr0)
  Display this message.

  $(tput setaf 2)$(tput bold)--start$(tput sgr0)
  · Gets the image size with imagemagick.
  · Checks if a crosshair is already running.
    · If yes, then it is closed to be replaced with the new one.
  · Opens the crosshair image with feh.
  · Sets it as a floating window.
  · Resizes the window with the image's size.
  · Removes its borders.
  · Removes its shadows.
  · Rounds it with the width of the image.
  · Centers it on the screen.
  · Prevents it from being focused / stealing focus.
  · Pins it on the active monitor.

  $(tput setaf 2)$(tput bold)--stop$(tput sgr0)
  Stops the active crosshair.
"

	exit
}

# Check for the --start argument.
[ "$1" = "--start" ] && {
	# Check if libnotify is installed.
	[ -f "$SW/notify-send" ] || {
		echo "libnotify could not be found. It is needed to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "This crosshair can only be used with Hyprland."
		echo "This crosshair can only be used with Hyprland."
		exit 1
	}

	# Check if imagemagick is installed.
	[ -f "$SW/magick" ] || {
		notify-send "imagemagick could not be found. It is needed to convert the saved screenshot to a WEBP image."
		echo "imagemagick could not be found. It is needed to convert the saved screenshot to a WEBP image."
		exit 1
	}

	# Check if feh is installed.
	[ -f "$SW/feh" ] || {
		notify-send "feh could not be found. It is needed to display the crosshair image."
		echo "feh could not be found. It is needed to display the crosshair image."
		exit 1
	}

	# Check if the crosshair image exists.
	[ -f "$Crosshair" ] || {
		notify-send "$Crosshair could not be found."
		echo "$Crosshair could not be found."
		exit 1
	}

	# Gather the size of the crosshair image.
	Width=$(identify -format "%w" "$Crosshair")
	Height=$(identify -format "%h" "$Crosshair")

	# Check if a crosshair is already running, and if so, try to close it.
	[ -f "$Crosshair_PID_file" ] && {
		Crosshair_PID=$(cat "$Crosshair_PID_file")
		kill "$Crosshair_PID"
	}

	# Start a crosshair and save its PID.
	feh "$Crosshair" &
	Crosshair_PID=$!
	echo "$Crosshair_PID" > "$Crosshair_PID_file"

	# Wait for the crosshair to be loaded.
	while ! pgrep -x ".feh-wrapped" > /dev/null; do
		sleep 0.05
	done

	# Make the crosshair window floating.
	$Dispatch togglefloating pid:"$Crosshair_PID"

	# Set the appropriate size for the crosshair window.
	$Setprop pid:"$Crosshair_PID" minsize "$Width" "$Height"
	$Setprop pid:"$Crosshair_PID" maxsize "$Width" "$Height"
	$Dispatch resizewindowpixel "$Width" "$Height", pid:"$Crosshair_PID"

	# Remove the border from the crosshair window.
	$Setprop pid:"$Crosshair_PID" bordersize 0

	# Remove the shadows from the crosshair window.
	$Setprop pid:"$Crosshair_PID" noshadow 1

	# Round the crosshair window, using the width of the crosshair image.
	$Setprop pid:"$Crosshair_PID" rounding "$Width"

	# Center the crosshair window.
	$Dispatch centerwindow pid:"$Crosshair_PID"

	# Prevent the crosshair window from getting or stealing focus.
	$Setprop pid:"$Crosshair_PID" nofocus true

	# Pin the crosshair window.
	$Dispatch pin pid:"$Crosshair_PID"

	exit
}

# Check for the --stop argument.
[ "$1" = "--stop" ] && {
	# Check for the last crosshair's PID and try to close it.
	[ -f "$Crosshair_PID_file" ] && {
		Crosshair_PID=$(cat "$Crosshair_PID_file")
		kill "$Crosshair_PID"
		exit
	}
}

# Error out if an invalid argument is given.
echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid argument '$(tput setaf 1)$*$(tput sgr0)'.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) and $(tput setaf 2)$(tput bold)--help$(tput sgr0) arguments.
"
exit 1
