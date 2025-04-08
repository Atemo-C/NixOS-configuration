#!/bin/dash

# Shortcut for binaries.
SW="/run/current-system/sw/bin"

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid number of arguments.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument.
"
	exit 1
}

# Check for the --about argument.
[ "$1" = "--about" ] && {
	echo "$(tput bold)$(tput setaf 6)  $(tput setaf 2)Picker.sh$(tput sgr0)

This script allows you to pick a color on the screen within the $(tput bold)$(tput setaf 3)Hyprland$(tput sgr0) Wayland compositor using $(tput bold)$(tput setaf 6)hyprpicker$(tput sgr0).

$(tput dim)Whilst this script could currently be a single command, it exists so that it may be extended further in the future, such as the addition of a color picking history with a graphical menu that would show each color and their value, and let the user pick one of them.$(tput sgr0)

• When using the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument, this message is displayed.
• When no argument is given, the color picking starts.

Credits:
• $(tput bold)$(tput setaf 3)hyprpicker$(tput sgr0): $(tput setaf 4)https://github.com/hyprwm/hyprpicker$(tput sgr0)
"
	exit
}

# When no argument is provided, continue on with the color picking process.
[ "$1" = "" ] && {
	# Check if libnotify is installed
	[ -f "$SW/notify-send" ] || {
		echo "libnotify could not be found. It is needed to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "This color picking utility can only be used with Hyprland."
		echo "This wallpaper utility can only be used with Hyprland."
		exit 1
	}

	# Check if hyprpicker is installed.
	[ -f "$SW/hyprpicker" ] || {
		notify-send "hyprpicker could not be found. It is needed to pick a color on the screen."
		echo "hyprpicker could not be found. It is needed to pick a color on the screen."
		exit 1
	}

	# Pick a color on the screen.
	Color="$(hyprpicker -f hex --autocopy)" &&
	notify-send -t 1500 "$Color copied to the clipboard." &&
	exit
}

# Error out if an invalid argument is given.
echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid argument '$(tput setaf 1)$*$(tput sgr0)'.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument.
"
exit 1
