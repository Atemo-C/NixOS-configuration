#!/bin/dash

# Shortcuts for binaries.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"

# Shortcut for the script.
Script() {
    nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 & exit
}

# Define the "about" message.
About="$(tput bold)$(tput setaf 6)  $(tput setaf 2)Power.sh$(tput sgr0)

This script allows you to execute power action within the $(tput bold)$(tput setaf 3)Hyprland$(tput sgr0) Wayland compositor, using $(tput bold)$(tput setaf 6)Tofi$(tput sgr0) to display the menu.

It allows for:
• Turning off the active monitor(s).
• Suspending to RAM.
• Hibernating (suspending to disk).
• Hybrid sleep (suspend to RAM and disk).
• Reboot.
• Reboot to the UEFI firmware (only appears when booted in EFI mode).
• Power off.
• Halt (an archaic way to turn the device off, and power has to be manually turned off afterwards).

$(tput dim)Note that if the \"Reboot to the UEFI firmware\" option does not appear despite your computer supporting it, you might have accidentally installed or started your operating system in BIOS mode.$(tput sgr0)

• When using the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument, this message is displayed.
• When no argument is given, the power action selection process starts.

Credits:
• $(tput bold)$(tput setaf 3)Tofi$(tput sgr0): $(tput setaf 4)https://github.com/philj56/tofi$(tput sgr0)
"

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid number of arguments.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument.
"
	exit 1
}

# Check for the --about argument.
[ "$1" = "--about" ] && {
	echo "$About"
	exit
}

# When no argument is provided, continue on with the power action selection process.
[ "$1" = "" ] && {
	# Check if libnotify is installed.
	[ -f "$SW/notify-send" ] || {
		echo "libnotify could not be found. It is needed to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "This wallpaper utility can only be used with Hyprland."
		echo "This wallpaper utility can only be used with Hyprland."
		exit 1
	}

	# Check if Tofi is installed.
	[ -f "$HM/tofi" ] || [ -f "$SW/tofi" ] || {
		notify-send "tofi could not be found. It is necessary to display the graphical menu."
		echo "tofi could not be found. It is necessary to display the graphical menu."
		exit 1
	}

	# Create the Confirmation list, used in prompts where user confirmation is preferrable.
	Confirmations="
  No
  Yes
  Back"

	# Set the size of the Tofi menu for the main selection and for the height of the confirmation dialogues.
	Width="187"
	Height="292"
	ConfHeight="124"

	# Gather the number of active monitors.
	Count=$(hyprctl monitors | grep -c "Monitor")

	# Choose the correct orthography depending on the monitor count, and add the relevant one to the Options list.
	[ "$Count" -eq 1 ] && Options="󰍹  Turn off display"
	[ "$Count" -ge 2 ] && Options="󰍹  Turn off displays"

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
	Height="327"

	# Add the remaining entries to the Options list.
	Options="
$Options
  Power off
󰺟  Halt
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
		Answer=$(printf '%s\n' "$Confirmations" | tofi \
			--width 156 \
			--height "$ConfHeight" \
			--prompt-text "Power off?"
		)
		notify-send "Manually turn off the power once the system is halted. This is archaic."

		[ "$Answer" = "  No" ] && {
			exit
		}

		[ "$Answer" = "  Yes" ] && {
			pkexec systemctl halt
		}

		[ "$Answer" = "  Back" ] && {
			Script
		}
	}

	[ "$Choice" = " ‎" ] && {
		nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &
	}

	[ "$Choice" = "󰗼  Exit" ] && {
		exit
	}
}

# Error out if an invalid argument is given.
echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid argument '$(tput setaf 1)$1$(tput sgr0)'.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument.
"
exit 1
