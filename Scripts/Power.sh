#!/usr/bin/env bash

set -euo pipefail

Options=(
	"󰍹  Turn off display/s"
	"󰒲  Suspend"
	"󰒲  Hibernate"
	"󱌂  Hybrid sleep"
	"󰜉  Reboot"
	"  Reboot to UEFI firmware"
	"  Power off"
	"󰺟  Halt"
	" "
	"󰗼  Exit"
)

Confirmations=(
	"  No"
	"  Yes"
	"  Back"
	" "
	"󰗼  Exit"
)

Choice=$(
	printf '%s\n' "${Options[@]}" | tofi \
		--width 240 \
		--height 290 \
		--prompt-text " " \
		"${@}"
)

[ "$Choice" = " " ] &&
	nohup bash "/etc/nixos/Desktop/Scripts/Power menu.sh"

[ "$Choice" = "󰍹  Turn off display/s" ] &&
	sleep 0.2 && hyprctl dispatcher dpms off

[ "$Choice" = "󰒲  Suspend" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 145 \
			--height 165 \
			--prompt-text "Suspend?"
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl suspend

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Desktop/Scripts/Power menu.sh"


[ "$Choice" = "󰒲  Hibernate" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 170 \
			--height 165 \
			--prompt-text "Hibernate? "
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl hibernate

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Desktop/Scripts/Power menu.sh"


[ "$Choice" = "󱌂  Hybrid sleep" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 190 \
			--height 165 \
			--prompt-text "Hybrid sleep? "
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl hybrid-sleep

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Desktop/Scripts/Power menu.sh"


[ "$Choice" = "󰜉  Reboot" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 145 \
			--height 165 \
			--prompt-text "Reboot? "
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl reboot

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Desktop/Scripts/Power menu.sh"


[ "$Choice" = "  Reboot to UEFI firmware" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 280 \
			--height 165 \
			--prompt-text "Reboot to UEFI firmware? "
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl reboot --firmware-setup

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Desktop/Scripts/Power menu.sh"


[ "$Choice" = "  Power off" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 170 \
			--height 165 \
			--prompt-text "Power off? "
	)
	[ "$Choice" = " " ] &&
		exit

	[ "$Choice" = "  No" ] &&
		exit

	[ "$Choice" = "  Yes" ] &&
		systemctl poweroff

	[ "$Choice" = "  Back" ] &&
		nohup bash "/etc/nixos/Desktop/Scripts/Power menu.sh"


[ "$Choice" = "󰺟  Halt" ] &&
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 215 \
			--height 165 \
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
		nohup bash "/etc/nixos/Desktop/Scripts/Power menu.sh"


[ "$Choice" = "󰗼  Exit" ] &&
	exit
