#!/bin/dash

# Shortcuts for binaries.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"

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

# Check if Tofi is installed.
[ -f "$HM/tofi" ] || [ -f "$SW/tofi" ] || {
	notify-send "tofi could not be found. It is necessary to display the graphical menu." &
	echo "tofi could not be found. It is necessary to display the graphical menu.";
	exit 1;
}

# Create the Confirmation list, used in prompts where user confirmation is good to have.
Confirmations="
  No
  Yes
  Back"

# Set the size of the Tofi menu for the main selection.
Width="187"
Height="292"

# Gather the number of active monitors.
Count=$(hyprctl monitors | grep -c "Monitor")

# Choose the correct orthography, depending on the monitor count.
[ "$Count" -eq 1 ] && Options="󰍹  Turn off display"
[ "$Count" -ge 2 ] && Options="󰍹  Turn off displays"

# Add some of the other entries to the options.
Options="
$Options
󰒲  Suspend
󰒲  Hibernate
󱌂  Hybrid sleep
󰜉  Reboot"

# If booted in EFI mode, add the option to reboot into the UEFI firmware and change the size of the Tofi menu.
[ -d "/sys/firmware/efi" ] && Options="
$Options
  Reboot to UEFI firmware"
	Width="236"
	Height="327"

# Add the remaining entries to the options.
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

# Defines the actions for every choice.
case "$Choice" in
	"󰍹  Turn off display")
		sleep 0.2 && hyprctl dispatcher dpms off
	;;

	"󰍹  Turn off displays")
		sleep 0.2 && hyprctl dispatcher dpms off
	;;

	"󰒲  Suspend")
		Choice=$(printf '%s\n' "$Confirmations" | tofi \
			--width 140 \
			--height 124 \
			--prompt-text "Suspend?"
		)
		case "$Choice" in
			"  No")
				exit
			;;

			"  Yes")
				systemctl suspend
			;;

			"  Back")
				nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &
			;;
		esac
	;;

	"󰒲  Hibernate")
		Choice=$(printf '%s\n' "$Confirmations" | tofi \
			--width 156 \
			--height 124 \
			--prompt-text "Hibernate?"
		)
		case "$Choice" in
			"  No")
				exit
			;;

			"  Yes")
				systemctl hibernate
			;;

			"  Back")
				nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &
			;;
		esac
	;;

	"󱌂  Hybrid sleep")
		Choice=$(printf '%s\n' "$Confirmations" | tofi \
			--width 180 \
			--height 124 \
			--prompt-text "Hybrid sleep?"
		)
		case "$Choice" in
			"  No")
				exit
			;;

			"  Yes")
				systemctl hybrid-sleep
			;;

			"  Back")
				nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &
			;;
		esac
	;;

	"󰜉  Reboot")
		Choice=$(printf '%s\n' "Confirmations" | tofi \
			--width 131 \
			--height 124 \
			--prompt-text "Reboot?"
		)
		case "$Choice" in
			"  No")
				exit
			;;

			"  Yes")
				systemctl reboot
			;;

			"  Back")
				nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &
			;;
		esac
	;;

	"  Reboot to UEFI firmware")
		Choice=$(printf '%s\n' "$Confirmations" | tofi \
			--width 268 \
			--height 124 \
			--prompt-text "Reboot to UEFI firmware?"
		)
		case "$Choice" in
			"  No")
				exit
			;;

			"  Yes")
				systemctl reboot --firmware-setup
			;;

			"  Back")
				nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &
			;;
		esac
	;;

	"  Power off")
		Choice=$(printf '%s\n' "$Confirmations" | tofi \
			--width 156 \
			--height 124 \
			--prompt-text "Power off?"
		)
		case "$Choice" in
			"  No")
				exit
			;;

			"  Yes")
				systemctl poweroff
			;;

			"  Back")
				nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &
			;;
		esac
	;;

	"󰺟  Halt")
		Choice=$(printf '%s\n' "$Confirmations" | tofi \
			--width 204 \
			--height 124 \
			--prompt-text "Halt the system?" & \
			notify-send "Manually turn off power once the system has halted. This is archaic."
		)
		case "$Choice" in
			"  No")
				exit
			;;

			"  Yes")
				pkexec systemctl halt
			;;

			"  Back")
				nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &
			;;
		esac
	;;

	" ‎")
		exit
	;;

	"󰗼  Exit")
		exit
	;;

esac
