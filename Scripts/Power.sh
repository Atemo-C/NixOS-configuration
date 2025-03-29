#!/usr/bin/env bash

# Create the Options list, filled later by the script.
Options=()

# Create the Confirmation list, used in some prompts.
Confirmations=(
	"  No"
	"  Yes"
	"  Back"
	" "
	"󰗼  Exit"
)

# Gather the number of active monitors.
Count=$(hyprctl monitors | grep -c "Monitor")

# Choose the correct orthography depending on the monitor count.
if [ "$Count" -eq 1 ]; then
	Options+=("󰍹  Turn off display")

elif [ "$Count" -ge 2 ]; then
	Options+=("󰍹  Turn off displays")

else
	echo "An error occured during fetching of any active output."
	exit 1
fi

# Add some of the other entries to Options.
Options+=(
	"󰒲  Suspend"
	"󰒲  Hibernate"
	"󱌂  Hybrid sleep"
	"󰜉  Reboot"
)

# If on an EFI system, add the option to reboot into the UEFI firmware, and set the appropriate size for Tofi.
if [ -d "/sys/firmware/efi" ]; then
	Options+=("  Reboot to UEFI firmware")
	Width="236"
	Height="327"
else
	Width="187"
	Height="292"
fi

# Add the remaining entries to Options.
Options+=(
	"  Power off"
	"󰺟  Halt"
	" "
	"󰗼  Exit"
)

# Let the user select an option.
Choice=$(
	printf '%s\n' "${Options[@]}" | tofi \
		--width "$Width" \
		--height "$Height" \
		--prompt-text " " \
		"${@}"
)

# Defines the actions for every option.
[ "$Choice" = " " ] &&
	nohup bash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

[ "$Choice" = "󰍹  Turn off display" ] || [ "$Choice" = "󰍹  Turn off displays" ] &&
	sleep 0.2 && hyprctl dispatcher dpms off

[ "$Choice" = "󰒲  Suspend" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 140 \
			--height 182 \
			--prompt-text "Suspend?"
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl suspend

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

	[ "$Choice" = "󰗼  Exit" ] &&
		exit

[ "$Choice" = "󰒲  Hibernate" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 164 \
			--height 182 \
			--prompt-text "Hibernate? "
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl hibernate

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

	[ "$Choice" = "󰗼  Exit" ] &&
		exit

[ "$Choice" = "󱌂  Hybrid sleep" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 188 \
			--height 182 \
			--prompt-text "Hybrid sleep? "
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl hybrid-sleep

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

	[ "$Choice" = "󰗼  Exit" ] &&
		exit

[ "$Choice" = "󰜉  Reboot" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 139 \
			--height 182 \
			--prompt-text "Reboot? "
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl reboot

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

[ "$Choice" = "  Reboot to UEFI firmware" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 276 \
			--height 182 \
			--prompt-text "Reboot to UEFI firmware? "
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl reboot --firmware-setup

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

	[ "$Choice" = "󰗼  Exit" ] &&
		exit

[ "$Choice" = "  Power off" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 164 \
			--height 182 \
			--prompt-text "Power off? "
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl poweroff

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

	[ "$Choice" = "󰗼  Exit" ] &&
		exit

[ "$Choice" = "󰺟  Halt" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 212 \
			--height 182 \
			--prompt-text "Halt the system? " & \
			notify-send "Manually turn off power once the system halts. This is archaic."
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl poweroff

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

	[ "$Choice" = "󰗼  Exit" ] &&
		exit

[ "$Choice" = "󰗼  Exit" ] &&
	exit
