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

if [ "$Choice" = " " ]; then
	bash "$HOME/Programs/Scripts/Desktop scripts/Power menu.sh"

elif [ "$Choice" = "󰍹  Turn off display/s" ]; then
	sleep 0.2 && hyprctl dispatcher dpms off

elif [ "$Choice" = "󰒲  Suspend" ]; then
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 145 \
			--height 165 \
			--prompt-text "Suspend?"
	)
	if [ "$Choice" = " " ]; then
		exit
	elif [ "$Choice" = "  No" ]; then
		exit
	elif [ "$Choice" = "  Yes" ]; then
		systemctl suspend
	elif [ "$Choice" = "  Back" ]; then
		bash "$HOME/Programs/Scripts/Desktop scripts/Power menu.sh"
	fi

elif [ "$Choice" = "󰒲  Hibernate" ]; then
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 170 \
			--height 165 \
			--prompt-text "Hibernate? "
	)
	if [ "$Choice" = " " ]; then
		exit
	elif [ "$Choice" = "  No" ]; then
		exit
	elif [ "$Choice" = "  Yes" ]; then
		systemctl hibernate
	elif [ "$Choice" = "  Back" ]; then
		bash "$HOME/Programs/Scripts/Desktop scripts/Power menu.sh"
	fi

elif [ "$Choice" = "󱌂  Hybrid sleep" ]; then
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 190 \
			--height 165 \
			--prompt-text "Hybrid sleep? "
	)
	if [ "$Choice" = " " ]; then
		exit
	elif [ "$Choice" = "  No" ]; then
		exit
	elif [ "$Choice" = "  Yes" ]; then
		systemctl hybrid-sleep
	elif [ "$Choice" = "  Back" ]; then
		bash "$HOME/Programs/Scripts/Desktop scripts/Power menu.sh"
	fi

elif [ "$Choice" = "󰜉  Reboot" ]; then
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 145 \
			--height 165 \
			--prompt-text "Reboot? "
	)
	if [ "$Choice" = " " ]; then
		exit
	elif [ "$Choice" = "  No" ]; then
		exit
	elif [ "$Choice" = "  Yes" ]; then
		systemctl reboot
	elif [ "$Choice" = "  Back" ]; then
		bash "$HOME/Programs/Scripts/Desktop scripts/Power menu.sh"
	fi

elif [ "$Choice" = "  Reboot to UEFI firmware" ]; then
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 280 \
			--height 165 \
			--prompt-text "Reboot to UEFI firmware? "
	)
	if [ "$Choice" = " " ]; then
		exit
	elif [ "$Choice" = "  No" ]; then
		exit
	elif [ "$Choice" = "  Yes" ]; then
		systemctl reboot --firmware-setup
	elif [ "$Choice" = "  Back" ]; then
		bash "$HOME/Programs/Scripts/Desktop scripts/Power menu.sh"
	fi

elif [ "$Choice" = "  Power off" ]; then
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 170 \
			--height 165 \
			--prompt-text "Power off? "
	)
	if [ "$Choice" = " " ]; then
		exit
	elif [ "$Choice" = "  No" ]; then
		exit
	elif [ "$Choice" = "  Yes" ]; then
		systemctl poweroff
	elif [ "$Choice" = "  Back" ]; then
		bash "$HOME/Programs/Scripts/Desktop scripts/Power menu.sh"
	fi

elif [ "$Choice" = "󰺟  Halt" ]; then
	Choice=$(
		printf '%s\n' "${Confirmations[@]}" | tofi \
			--width 215 \
			--height 165 \
			--prompt-text "Halt the system? " & \
			notify-send "Manually turn off power once the system halts. This is archaic."
	)
	if [ "$Choice" = " " ]; then
		exit
	elif [ "$Choice" = "  No" ]; then
		exit
	elif [ "$Choice" = "  Yes" ]; then
		systemctl poweroff
	elif [ "$Choice" = "  Back" ]; then
		bash "$HOME/Programs/Scripts/Desktop scripts/Power menu.sh"
	fi

elif [ "$Choice" = "󰗼  Exit" ]; then
	exit

fi
