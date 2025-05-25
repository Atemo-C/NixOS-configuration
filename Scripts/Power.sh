#!/bin/dash

# Set some text formatting shortcuts for printf.
err=$(tput bold)$(tput setaf 1)Error$(tput sgr0)
arg=$(tput bold)$(tput setaf 2)
exe=$(tput bold)$(tput setaf 3)
ico=$(tput bold)$(tput setaf 6)
web=$(tput setaf 4)
bol=$(tput bold)
c=$(tput sgr0)

# Set some text formatting shortcuts for dunstify.
herr="<b><span foreground='#ff0000'>Error</span></b>"
hexe1="<b><span foreground='#ffc000'>"
hexe2="</span></b>"

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	printf "%s: Invalid number of arguments '%s%d%s'.\n\n" \
		"$err" "$arg" "$#" "$c"

	printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" \
		"$arg" "$c" "$arg" "$c" "$arg" "$c"

	exit 1
}

# Check for the `--about` & `--help` arguments.
[ "$1" = "--about" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ] && {
	printf "%s  %sPower.sh%s\n\n" \
		"$ico" "$arg" "$c"

	printf "%s[ Description ]%s\n" \
		"$bol" "$c"

	printf " This script lets you execute power actions within the %sHyprland%s Wayland compositor.\n\n" \
		"$exe" "$c"

	printf "%s[ Arguments ]%s\n" \
		"$bol" "$c"

	printf " %s--about%s / %s--help%s / %s-h%s \n" \
		"$arg" "$c" "$arg" "$c" "$arg" "$c"

	printf "  Display this message.\n\n"

	printf " No argument: Display a power action menu.\n\n"

	printf "%s[ Credits ]%s\n" \
		"$bol" "$c"

	printf " %sFuzzel%s: %shttps://codeberg.org/dnkl/fuzzel?ref=mark.stosberg.com%s\n" \
		"$exe" "$c" "$web" "$c"

	exit 0
}

# When no argument is provided, start the power action selection.
[ "$1" = "" ] && {
	# Check if Dunst is installed.
	command -v dunstify > /dev/null 2>&1 || {
		printf "%s: %sDunst%s could not be found. It is required to display graphical notifications.\n" \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		dunstify -u critical "  Power.sh" "$herr: This script can only be used with the $hexe1 Hyprland$hexe2 Wayland compositor."

		printf "%s: This script can only be used within the %sHyprland%s Wayland Compositor.\n" \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Fuzzel is installed.
	command -v fuzzel > /dev/null 2>&1 || {
		dunstify -u critical "  Power.sh" "$herr:$hexe1 Fuzzel$hexe2 could not be found. It is required to show graphical menus."

		printf "%s: %sFuzzel%s could not be found. It is required to show graphical menus.\n" \
			"$err" "$exe" "$c"

		exit 1
	}

	# Create the confirmation list, used in prompts where user confirmation is preferrable.
	confirmations="  No
  Yes
  Back"

	# Main loop for the power action selection.
	while true; do
		# Gather the number of active monitors.
		count=$(hyprctl monitors -j | jq length)

		# Choose the correct orthography depending on the monitor count, & add the relevant one to the options list.
		[ "$count" -eq 1 ] && {
			options="󰍹  Turn off display"
		}

		[ "$count" -ge 2 ] && {
			options="󰍹  Turn off displays"
		}

		# Add more entries to the options list.
		options="$options
󰒲  Suspend
󰒲  Hibernate
󱌂  Hybrid sleep
󰜉  Reboot"

		# If booted in EFI mode, add the relevant option to the options list, & change the size of the menu.
		[ -d "/sys/firmware/efi" ] && options="$options
  Reboot to UEFI firmware"

		# Add the remaining entries to the options list.
		options="$options
  Power off
󰺟  Halt
󰿅  Log out
 ‎
󰗼  Exit"

		# Let the user select an option.
		choice=$(printf '%s\n' "$options" | fuzzel \
			--no-icons \
			--lines 11 \
			--width 28 \
			--dmenu "$@"
		)

		# Turning off monitors.
		[ "$choice" = "󰍹  Turn off display" ] || [ "$choice" = "󰍹  Turn off displays" ] && {
			sleep 0.2
			hyprctl dispatcher dpms off
			exit
		}

		# Common handler for confirmation prompts.
		[ "$choice" = "󰒲  Suspend" ] || [ "$choice" = "󰒲  Hibernate" ] || [ "$choice" = "󱌂  Hybrid sleep" ] || \
		[ "$choice" = "󰜉  Reboot" ] || [ "$choice" = "  Reboot to UEFI firmware" ] || \
		[ "$choice" = "  Power off" ] || [ "$choice" = "󰺟  Halt" ] || [ "$choice" = "󰿅  Log out" ] && {
			# Set prompt, width, and notifications (if desired) based on choice.
			[ "$choice" = "󰒲  Suspend" ]                 && prompt="Suspend?"                 && width=9
			[ "$choice" = "󰒲  Hibernate" ]               && prompt="Hibernate?"               && width=14
			[ "$choice" = "󱌂  Hybrid sleep" ]            && prompt="Hybrid sleep?"            && width=17
			[ "$choice" = "󰜉  Reboot" ]                  && prompt="Reboot?"                  && width=11
			[ "$choice" = "  Reboot to UEFI firmware" ] && prompt="Reboot to UEFI firmware?" && width=28
			[ "$choice" = "  Power off" ]               && prompt="Power off?"               && width=14
			[ "$choice" = "󰺟  Halt" ]                    && prompt="Halt?"                    && width=9
			[ "$choice" = "󰿅  Log out" ]                 && prompt="Log out?"                 && width=12
			[ "$choice" = "󰺟  Halt" ] && {
				dunstify "  Power.sh" "Manually turn off the power once the system is halted. This is archaic."
				echo "Manually turn off the power once the system is halted. This is archaic."
			}

			# Create the main confirmation menu.
			answer=$(printf '%s\n' "$confirmations" | fuzzel --no-icons --dmenu \
				--lines 3 \
				--width "$width" \
				--prompt "$prompt"
			)

			# Set the "no" and "back" actions for confirmations.
			[ "$answer" = "  No" ] && exit
			[ "$answer" = "  Back" ] && continue

			# Execute the selected action.
			[ "$answer" = "  Yes" ] && {
				[ "$choice" = "󰒲  Suspend" ]                 && systemctl suspend
				[ "$choice" = "󰒲  Hibernate" ]               && systemctl hibernate
				[ "$choice" = "󱌂  Hybrid sleep" ]            && systemctl hybrid-sleep
				[ "$choice" = "󰜉  Reboot" ]                  && systemctl reboot
				[ "$choice" = "  Reboot to UEFI firmware" ] && systemctl reboot --firmware-setup
				[ "$choice" = "  Power off" ]               && systemctl poweroff
				[ "$choice" = "󰺟  Halt" ]                    && run0 systemctl halt
				[ "$choice" = "󰿅  Log out" ]                 && hyprctl dispatch exit
				exit
			}
		}

		# Spacer loops back.
		[ "$choice" = " ‎" ] && continue

		# Exiting.
		[ "$choice" = "󰗼  Exit" ] || [ "$choice" = "" ] && exit
	done
}

# Error out if an invalid argument is given.
printf "%s: Invalid argument '%s%s%s'.\n\n" \
	"$err" "$arg" "$*" "$c"

printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" \
	"$arg" "$c" "$arg" "$c" "$arg" "$c"

exit 1
