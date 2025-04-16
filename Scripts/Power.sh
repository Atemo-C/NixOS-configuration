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
		"\nSee the ${arg}--about${c} / ${arg}--help${c} argument.\n"

	exit 1
}

# Check for the --about or --help argument.
[ "$1" = "--about" ] || [ "$1" = "--help" ] && {
	echo \
		"${ico}  ${arg}Power.sh${c}\n" \
		"\nThis script lets you execute power actions within the ${exe}Hyprland${c} Wayland compositor, using ${exe}Tofi${c} to display the menu.\n" \
		"\nIt allows for:" \
		"\n• Turning off the active monitor(s)." \
		"\n• Suspending to RAM." \
		"\n• Hibernating ${dim}(suspsending to disk)${c}." \
		"\n• Hybrid sleep ${dim}(suspsend to RAM and disk)${c}." \
		"\n• Reboot." \
		"\n• Reboot to the UEFI firmware ${dim}(only appears when booted in EFI mode)${c}." \
		"\n• Power off." \
		"\n• Halt ${dim}(an archaic way to turn the device off, and power has to be manually turned off afterwards)${c}." \
		"\n• Logging out of ${exe}Hyprland${c}.\n" \
		"\n• When using the ${arg}--about${c} or ${arg}--help${c} argument, this message is displayed." \
		"\n• When using the ${arg}--check${c} argument, required dependencies will be checked." \
		"\n• When no argument is given, the power action selection process starts.\n" \
		"\nCredits:" \
		"\n${exe}Tofi${c}: ${web}https://github.com/philj56/tofi${c}\n"
	exit
}

# Check for the --check argument.
[ "$1" = "--check" ] && {
	echo "${ico}  ${arg}Power.sh${c}\n"

	# Check if libnotify is installed.
	(command -v notify-send > /dev/null 2>&1) && {
		echo "✅ ${exe}libnotify${c} is installed."
	} ||
		echo "❌ ${exe}libnotify${c} is not installed. It is required to display graphical notifications. The script will not run without it."

	# Check if Tofi is installed.
	(command -v tofi > /dev/null 2>&1) && {
		echo "✅ ${exe}Tofi${c} is installed."
	} ||
		echo "❌ ${exe}Tofi is not installed. It is required to display the graphical menu. The script will not run without it."

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] && {
		echo "✅ ${exe}Hyprland${c} is the active Wayland compositor."
	} ||
		echo "❌ ${exe}Hyprland${c} is not the currently active Wayland compositor. The script will not run outside of Hyprland."

	exit
}

# When no argument is provided, start the power action selection process.
[ "$1" = "" ] && {
	# Check if libnotify is installed.
	command -v notify-send || {
		echo "${err}: libnotify could not be found. It is required to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "Error: This power utility can only be used with the Hyprland Wayland compositor."
		echo "${err}: This power utility can only be used with the ${exe}Hyprland${c} Wayland compositor."
		exit 1
	}

	# Check if Tofi is installed.
	command -v tofi || {
		notify-send "Error: Tofi could not be found. It is necessary to display the graphical menu."
		echo "${err}: ${exe}Tofi${c} could not be found. It is necessary to display the graphical menu."
		exit 1
	}

	# Create the Confirmation list, used in prompts where user confirmation is preferrable.
	Confirmations="
  No
  Yes
  Back"

	# Set the size of the Tofi menu for the main selection and for the height of the confirmation dialogues.
	Width="187"
	Height="309"
	ConfHeight="120"

	# Gather the number of active monitors.
	Count=$(hyprctl monitors | grep -c "Monitor")

	# Choose the correct orthography depending on the monitor count, and add the relevant one to the Options list.
	[ "$Count" -eq 1 ] && {
		Options="󰍹  Turn off display"
	}

	[ "$Count" -ge 2 ] && {
		Options="󰍹  Turn off displays"
	}

	# Add some of the other entries to the Options list.
	Options="
$Options
󰒲  Suspend
󰒲  Hibernate
󱌂  Hybrid sleep
󰜉  Reboot"

	# If booted in EFI mode, add the relevant option to the Options list, and change the size of the Tofi menu.
	[ -d "/sys/firmware/efi" ] && Options="
$Options
  Reboot to UEFI firmware"
	Width="236"
	Height="344"

	# Add the remaining entries to the Options list.
	Options="
$Options
  Power off
󰺟  Halt
󰿅  Log out
 ‎
󰗼  Exit"

	# Let the user select an option.
	Choice=$(printf '%s\n' "$Options" | tofi \
		--width "$Width" \
		--height "$Height" \
		--prompt-text " " \
		"$@"
	)

	# Define the actions for every choice.
	[ "$Choice" = "󰍹  Turn off display" ] || [ "$Choice" = "󰍹  Turn off displays" ] && {
		sleep 0.2
		hyprctl dispatcher dpms off
		exit
	}

	[ "$Choice" = "󰒲  Suspend" ] && {
		Answer=$(printf '%s\n' "$Confirmations" | tofi \
			--width 140 \
			--height "$ConfHeight" \
			--prompt-text "Suspend?"
		)

		[ "$Answer" = "  No" ] && {
			exit
		}

		[ "$Answer" = "  Yes" ] && {
			systemctl suspend
			exit
		}

		[ "$Answer" = "  Back" ] && {
			Script
		}
	}

	[ "$Choice" = "󰒲  Hibernate" ] && {
		Answer=$(printf '%s\n' "$Confirmations" | tofi \
			--width 156 \
			--height "$ConfHeight" \
			--prompt-text "Hibernate?"
		)

		[ "$Answer" = "  No" ] && {
			exit
		}

		[ "$Answer" = "  Yes" ] && {
			systemctl hibernate
			exit
		}

		[ "$Answer" = "  Back" ] && {
			Script
		}
	}

	[ "$Choice" = "󱌂  Hybrid sleep" ] && {
		Answer=$(printf '%s\n' "$Confirmations" | tofi \
			--width 180 \
			--height "$ConfHeight" \
			--prompt-text "Hybrid sleep?"
		)

		[ "$Answer" = "  No" ] && {
			exit
		}

		[ "$Answer" = "  Yes" ] && {
			systemctl hybrid-sleep
			exit
		}

		[ "$Answer" = "  Back" ] && {
			Script
		}
	}

	[ "$Choice" = "󰜉  Reboot" ] && {
		Answer=$(printf '%s\n' "$Confirmations" | tofi \
			--width 131 \
			--height "$ConfHeight" \
			--prompt-text "Reboot?"
		)

		[ "$Answer" = "  No" ] && {
			exit
		}

		[ "$Answer" = "  Yes" ] && {
			systemctl reboot
		}

		[ "$Answer" = "  Back" ] && {
			Script
		}
	}

	[ "$Choice" = "  Reboot to UEFI firmware" ] && {
		Answer=$(printf '%s\n' "$Confirmations" | tofi \
			--width 268 \
			--height "$ConfHeight" \
			--prompt-text "Reboot to UEFI firmware?"
		)

		[ "$Answer" = "  No" ] && {
			exit
		}

		[ "$Answer" = "  Yes" ] && {
			systemctl reboot --firmware-setup
		}

		[ "$Answer" = "  Back" ] && {
			Script
		}
	}

	[ "$Choice" = "  Power off" ] && {
		Answer=$(printf '%s\n' "$Confirmations" | tofi \
			--width 156 \
			--height "$ConfHeight" \
			--prompt-text "Power off?"
		)

		[ "$Answer" = "  No" ] && {
			exit
		}

		[ "$Answer" = "  Yes" ] && {
			systemctl poweroff
		}

		[ "$Answer" = "  Back" ] && {
			Script
		}
	}

	[ "$Choice" = "󰺟  Halt" ] && {
		notify-send "Manually turn off the power once the system is halted. This is archaic."
		echo "Manually turn off the power once the system is halted. This is archaic."
		Answer=$(printf '%s\n' "$Confirmations" | tofi \
			--width 116 \
			--height "$ConfHeight" \
			--prompt-text "Halt?"
		)

		[ "$Answer" = "  No" ] && {
			exit
		}

		[ "$Answer" = "  Yes" ] && {
			run0 systemctl halt
		}

		[ "$Answer" = "  Back" ] && {
			Script
		}
	}

	[ "$Choice" = "󰿅  Log out" ] && {
		Answer=$(printf '%s\n' "$Confirmations" | tofi \
			--width 236 \
			--height "$ConfHeight" \
			--prompt-text "Log out of Hyprland?"
		)

		[ "$Answer" = "  No" ] && {
			exit
		}

		[ "$Answer" = "  Yes" ] && {
			hyprctl dispatch exit
			exit
		}

		[ "$Answer" = "  Back" ] && {
			Script
		}
	}

	[ "$Choice" = " ‎" ] && {
		Script
	}

	[ "$Choice" = "󰗼  Exit" ] && {
		exit
	}
}

# Error out if an invalid argument is given.
echo \
	"${err}: Invalid argument '${arg}$*${c}'.\n" \
	"\nSee the ${arg}--about${c} / ${arg}--help${c} argument.\n"

exit 1
