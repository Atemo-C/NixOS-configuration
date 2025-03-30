#!/bin/dash

# Executeables shortcut.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"

# Check if the requiered dependencies are installed.
[ -f "$HM/hyprland" ] || [ -f "$SW/hyprland" ] || { notify-send "This power menu is made for Hyprland."; exit 1; }
[ -f "$HM/tofi" ] || [ -f "$SW/tofi" ] || { notify-send "tofi is not installed."; exit 1; }

# Create the Options list, filled later by the script.
Options="
"

# Create the Confirmation list, used in some prompts.
Confirmations="
  No
  Yes
  Back
"

# Gather the number of active monitors.
Count=$(hyprctl monitors | grep -c "Monitor")

# Choose the correct orthography depending on the monitor count.
[ "$Count" -eq 1 ] &&
	Options="
$Options
󰍹  Turn off display"

[ "$Count" -ge 2 ] &&
	Options="
$Options
󰍹  Turn off displays"

# Add some of the other entries to the Options.
Options="
$Options
󰒲  Suspend
󰒲  Hibernate
󱌂  Hybrid sleep
󰜉  Reboot"

# Sets the size of the Tofi menu for the main selection.
Width="187"
Height="292"

# If booted in EFI mode, add the option to reboot into the UEFI firmware and set the appropriate size for Tofi.
[ -d "/sys/firmware/efi" ] &&
	Options="
$Options
  Reboot to UEFI firmware"
	Width="236"
	Height="327"

# Add the remaining entries to the Options.
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
