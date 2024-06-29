#!/usr/bin/env bash

set -euo pipefail

Options=(
	"󰆓  Save and copy an image of the entire screen"
	"󰆓  Save and copy an image of an open window"
	"󰆓  Save and copy an image of a selected region"
	" "
	"󰅍  Copy an image of the entire screen"
	"󰅍  Copy an image of an open window"
	"󰅍  Copy an image of a selected region"
	" "
	"󰗼  Exit"
)

Choice=$(
	printf '%s\n' "${Options[@]}" | tofi \
		--width 405 \
		--height 270 \
		--prompt-text " " \
		"${@}"
)

if [ "$Choice" = " " ]; then
	bash "$HOME/Programs/Scripts/Desktop scripts/Hyprshot.sh"


elif [ "$Choice" = "󰆓  Save and copy an image of the entire screen" ]; then
	sleep 0.3 &&
	hyprshot \
		--current \
		--mode output \
		--output-folder "$HOME/Images/Screenshots" \
		--filename Screenshot_"$(date +'%d-%m-%Y_%H-%M-%S')".png

elif [ "$Choice" = "󰆓  Save and copy an image of an open window" ]; then
	hyprshot \
		--mode window \
		--output-folder "$HOME/Images/Screenshots" \
		--filename Screenshot_"$(date +'%d-%m-%Y_%H-%M-%S')".png

elif [ "$Choice" = "󰆓  Save and copy an image of a selected region" ]; then
	hyprshot \
		--mode region \
		--output-folder "$HOME/Images/Screenshots" \
		--filename Screenshot_"$(date +'%d-%m-%Y_%H-%M-%S')".png

elif [ "$Choice" = "󰅍  Copy an image of the entire screen" ]; then
	hyprshot \
		--mode output \
		--clipboard-only

elif [ "$Choice" = "󰅍  Copy an image of an open window" ]; then
	hyprshot \
		--mode window \
		--clipboard-only

elif [ "$Choice" = "󰅍  Copy an image of a selected region" ]; then
	hyprshot \
		--mode region \
		--clipboard-only

elif [ "$Choice" = "󰗼  Exit" ]; then
	exit

fi
