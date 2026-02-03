#!/run/current-system/sw/bin/dash

# Check for any command-line arguments, and ignore them if any is detected.
[ "$#" -gt 0 ] && {
	printf "This script does not support command-line arguments. Ignoring.\n"
	nohup "$0" >/dev/null 2>&1 & exit
}

# Check if `niri` is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "Niri is not the running desktop.\nIf it is, check that %s is correct.\n" "$XDG_CURRENT_DESKTOP"
	exit 1
}

# Check if `fuzzel` is available.
command -v fuzzel >/dev/null 2>&1 || {
	printf "The fuzzel menu program was not found; The power menu cannot be displayed.\n"
	exit 1
}

# Check if `swaylock` is available.
command -v swaylock >/dev/null 2>&1 && has_swaylock=true

# Function to call swaylock if it exists.
lock() {
	[ "$has_swaylock" = "true" ] && swaylock >/dev/null 2>&1 &
}

# Default number of lines to show in the power menu.
lines="9"

# Check the number of active monitors and set the initial power menu width.
if command -v jq >/dev/null 2>&1;
then
	monitor_count=$(niri msg -j outputs | jq 'length')
	if [ "$monitor_count" -gt 1 ];
	then
		monitor_item="󰍹  Turn off monitors"
		width="21"
	else
		monitor_item="󰍹  Turn off monitor"
		width="20"
	fi
else
	monitor_item="󰍹  Turn off monitor/s"
	width="22"
fi

# Confirmation options used in confirmation prompts.
confirmoptions="  No
  Yes
  Back"

# List of options presented to the user.
list=$(
	printf "%s\n" "$monitor_item"
	[ "$has_swaylock" = "true" ] && printf "  Lock session\n"
	printf "󰒲  Suspend\n"
	printf "󰒲  Hibernate\n"
	printf "󱌂  Hybrid sleep\n"
	printf "󰜉  Reboot\n"
	[ -d "/sys/firmware/efi" ] && printf "  Reboot to UEFI firmware\n"
	printf "  Power off\n"
	printf "󰿅  Leave Niri\n"
	printf " ‎\n"
	printf "󰗼  Exit\n"
)

# Adjust the number of lines and width of the power menu depending on optional items.
[ "$has_swaylock" = "true" ] && lines=10
[ -d "/sys/firmware/efi" ] && {
	lines=$((lines + 1))
	width="28"
}

# Loop for the power menu and selection.
while :; do
	# Display the power menu.
	choice=$(printf "%s\n" "$list" | fuzzel \
		--no-icons \
		--lines "$lines" \
		--width "$width" \
		--dmenu
	)

	case "$choice" in
		# Turn off monitors.
		"󰍹  Turn off monitor"|"󰍹  Turn off monitors"|"󰍹  Turn off monitor/s")
			lock
			sleep 0.25
			niri msg action power-off-monitors
			exit 0
		;;

		# Lock the session.
		"  Lock session")
			lock
			exit 0
		;;

		# Commond handler for items with a confirmation prompt.
		"󰒲  Suspend"|"󰒲  Hibernate"|"󱌂  Hybrid sleep"|"󰜉  Reboot"|"  Reboot to UEFI firmware"|"  Power off"|"󰿅  Leave Niri")
			# Set the correct prompt text and width for each prompt option.
			case "$choice" in
				"󰒲  Suspend")
					prompt="Suspend? "
					prompt_width="13"
				;;

				"󰒲  Hibernate")
					prompt="Hibernate? "
					prompt_width="15"
				;;

				"󱌂  Hybrid sleep")
					prompt="Hybrid sleep? "
					prompt_width=18
				;;

				"󰜉  Reboot")
					prompt="Reboot? "
					prompt_width=12
				;;

				"  Reboot to UEFI firmware")
					prompt="Reboot to UEFI firmware? "
					prompt_width=29
				;;

				"  Power off")
					prompt="Power off? "
					prompt_width=15
				;;

				"󰿅  Leave Niri")
					prompt="Leave Niri? "
					prompt_width=16
				;;
			esac

			# Display the confirmation menu.
			answer=$(printf "%s\n" "$confirmoptions" | fuzzel \
				--no-icons \
				--lines 3 \
				--width "$prompt_width" \
				--prompt "$prompt" \
				--dmenu
			)

			# Exit the script.
			case "$answer" in
				"  No")
					exit 0
				;;

				# Loop back to the main menu.
				"  Back")
					continue
				;;

				# Execute the proper action for the selection.
				"  Yes")
					case "$choice" in
						"󰒲  Suspend")
							lock & sleep 0.25
							systemctl suspend
							exit 0
						;;

						"󰒲  Hibernate")
							lock & sleep 0.25
							systemctl hibernate
							exit 0
						;;

						"󱌂  Hybrid sleep")
							lock & sleep 0.25
							systemctl hybrid-sleep
							exit 0
						;;

						"󰜉  Reboot")
							systemctl reboot
							exit
						;;

						"  Reboot to UEFI firmware")
							systemctl reboot --firmware-setup
							exit
						;;

						"  Power off")
							systemctl poweroff
							exit
						;;

						"󰿅  Leave Niri")
							pkill cmd-polkit & niri msg action quit --skip-confirmation
							exit
						;;
					esac
				;;
			esac
		;;

		" ‎")
			continue
		;;

		"󰗼  Exit"|"")
			exit 0
		;;
	esac
done

exit 2