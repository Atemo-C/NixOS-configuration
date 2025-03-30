#!/bin/dash

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
if [ "$Count" -eq 1 ]; then
	Options="
$Options
󰍹  Turn off display
"

elif [ "$Count" -ge 2 ]; then
	Options="
$Options
󰍹  Turn off displays
"

else
	echo "An error occured during the fetching of any active output."
	exit 1
fi

# Add some of the other entries to the Options.
Options="
$Options
󰒲  Suspend
󰒲  Hibernate
󱌂  Hybrid sleep
󰜉  Reboot
"

# If booted in EFI mode, add the option to reboot into the UEFI firmware and set the appropriate size for Tofi.
if [ -d "/sys/firmware/efi" ]; then
	Options="
$Options
  Reboot to UEFI firmware
"
	Width="236"
	Height="327"
else
	Width="187"
	Height="292"
fi

# Add the remaining entries to the Options.
Options="
$Options
  Power off
󰺟  Halt
 ‎
󰗼  Exit
"

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
