#!/bin/dash

# Set some text formatting shortcuts.
err=$(tput bold)$(tput setaf 1)Error$(tput sgr0)
arg=$(tput bold)$(tput setaf 2)
exe=$(tput bold)$(tput setaf 3)
ico=$(tput bold)$(tput setaf 6)
web=$(tput setaf 4)
dim=$(tput dim)
c=$(tput sgr0)

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	echo \
		"${err}: Invalid number of arguments (${arg}$#${c}).\n" \
		"\nSee the ${arg}--about${c} and the ${arg}--help${c} arguments.\n"

	exit 1
}

# Check for the --about argument.
[ "$1" = "--about" ] && {
	echo \
		"${ico}  ${arg}Crosshair.sh${c}\n" \
		"\nThis script creates a single, simple dot crosshair in the middle of the currently focused monitor within the ${exe}Hyprland${c} Wayland compositor using ${exe}feh${c} and ${exe}imagemagick${c}.\n" \
		"\n${dim}It assumes use in applications such as video-gaming in fullscreen/borderless fullscreen-only.${c}\n" \
		"\n• When using the ${arg}--about${c} argument, this message is displayed." \
		"\n• When using the ${arg}--help${c} argument, help about this script is displayed." \
		"\n• When using the ${arg}--check${c} argument, required dependencies will be checked." \
		"\n• When using the ${arg}--start${c} argument, a crosshair appears on the currently focused monitor." \
		"\n• when using the ${arg}--stop${c} argument, the active crosshair is closed.\n" \
		"\nCredits:" \
		"\n• ${exe}feh${c}: ${web}https://feh.finalrewind.org/${c}" \
		"\n• ${exe}imagemagick${c}: ${web}https://imagemagick.org/${c}\n"

	exit
}

# Check for the --help argument.
[ "$1" = "--help" ] && {
	echo \
		"${ico}  ${arg}Crosshair.sh${c}\n" \
		"\n${arg}--about${c}" \
		"\nDisplay information about this script.\n" \
		"\n${arg}--help${c}" \
		"\nDisplay this message.\n" \
		"\n${arg}--check${c}" \
		"\nCheck for required dependencies.\n" \
		"\n${arg}--start${c}" \
		"\n· Get the image size with imagemagick." \
		"\n· Check if a crosshair is already running." \
		"\n  · If yes, it is closed to be replaced with the new one." \
		"\n· Open the crosshair image with ${exe}feh${c}." \
		"\n· Set it as a floating window." \
		"\n· Gather the image's properties with ${exe}imagemagick${c}." \
		"\n· Resize the window with the image's size." \
		"\n· Remove its borders." \
		"\n· Remove its shadows." \
		"\n· Round it with the width of the image." \
		"\n· Center it on the screen." \
		"\n· Prevent it from being focused / stealing focus." \
		"\n· Pin it on the active monitor.\n" \
		"\n${arg}--stop${c}" \
		"\nStop the active crosshair.\n"

	exit
}

# Check for the --check argument.
[ "$1" = "--check" ] && {
	echo "${ico}  ${arg}Crosshair.sh${c}\n"

	# Check if libnotify is installed.
	command -v notify-send > /dev/null 2>&1 && {
		echo "✅ ${exe}libnotify${c} is installed."
	} ||
		echo "❌ ${exe}libnotify${c} is not installed. It is required to display graphical notifications. The script will not run without it."

	# Check if imagemagick is installed.
	command -v magick > /dev/null 2>&1 && {
		echo "✅ ${exe}imagemagick${c} is installed."
	} ||
		echo "❌ ${exe}imagemagick${c} is not installed. It is required to get the properties of the crosshiar image. The script will not run without it."

	# Check if feh is installed.
	command -v feh > /dev/null 2>&1 && {
		echo "✅ ${exe}feh${c} is installed."
	} ||
		echo "❌ ${exe}feh${c} is not installed. It is required to display the crosshair image. The script will not run without it."

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] && {
		echo "✅ ${exe}Hyprland${c} is the active Wayland compositor."
	} ||
		echo "❌ ${exe}Hyprland${c} is not the currently active Wayland compositor. The script will not run outside of Hyprland."

	exit
}

# Check for the --start argument.
[ "$1" = "--start" ] && {
	# Check if libnotify is installed.
	command -v notify-send || {
		echo "${err}: libnotify could not be found. It is required to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "Error: This crosshair can only be used with the Hyprland Wayland compositor."
		echo "${err}: This crosshair can only be used with the ${exe}Hyprland${c} Wayland compositor."
		exit 1
	}

	# Check if imagemagick is installed.
	command -v magick || {
		notify-send "Error: imagemagick could not be found. It is required to get the crosshair image's properties."
		echo "${err}: ${exe}imagemagick${c} could not be found. It is required to get the crosshair image's properties."
		exit 1
	}

	# Check if feh is installed.
	command -v feh || {
		notify-send "Error: feh could not be found. It is required to display the crosshair image."
		echo "${err}: ${exe}feh${c} could not be found. It is required to display the crosshair image."
		exit 1
	}

	# Shortcut to the crosshair image.
	Crosshair="/etc/nixos/Scripts/Crosshair/Crosshair.png"

	# Check if the crosshair image exists.
	[ -f "$Crosshair" ] || {
		notify-send "Error: $Crosshair could not be found."
		echo "${err}: ${web}$Crosshair${c} could not be found."
		exit 1
	}

	# Gather the size of the crosshair image.
	Width=$(identify -format "%w" "$Crosshair")
	Height=$(identify -format "%h" "$Crosshair")

	# Shortcut to the crosshair's PID file.
	Crosshair_PID_file="/tmp/crosshair_pid.txt"

	# Check if a crosshair is already running. If so, close it.
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

	# Set some hyprctl dispatch commands shortcuts.
	Setprop="hyprctl dispatch setprop"
	Dispatch="hyprctl dispatch"

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
	# Shortcut to the crosshair's PID file.
	Crosshair_PID_file="/tmp/crosshair_pid.txt"

	# Check for the last crosshair's PID, and close the associated crosshair.
	[ -f "$Crosshair_PID_file" ] && {
		Crosshair_PID=$(cat "$Crosshair_PID_file")
		kill "$Crosshair_PID"
		exit
	}
}

# Error out if an invalid argument is given.
echo \
	"${err}: Invalid argument '${arg}$*${c}'.\n" \
	"\nSee the ${arg}--about${c} and the ${arg}--help${c} arguments.\n"

exit 1
