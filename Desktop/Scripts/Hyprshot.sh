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

[ "$Choice" = " " ] &&
	bash "/etc/nixos/Desktop/Scripts/Hyprshot.sh"

[ "$Choice" = "󰆓  Save and copy an image of the entire screen" ] &&
	sleep 0.3 &&
	hyprshot \
		--mode output \
		--mode active \
		--output-folder "$HOME/Images/Screenshots" \
		--filename Screenshot"$(echo ' ')""$(date +'%d-%m-%Y %H-%M-%S')".png

[ "$Choice" = "󰆓  Save and copy an image of an open window" ] &&
	hyprshot \
		--mode window \
		--output-folder "$HOME/Images/Screenshots" \
		--filename Screenshot"$(echo ' ')""$(date +'%d-%m-%Y %H-%M-%S')".png

[ "$Choice" = "󰆓  Save and copy an image of a selected region" ] &&
	hyprshot \
		--mode region \
		--output-folder "$HOME/Images/Screenshots" \
		--filename Screenshot"$(echo ' ')""$(date +'%d-%m-%Y %H-%M-%S')".png

[ "$Choice" = "󰅍  Copy an image of the entire screen" ] &&
	sleep 0.3 &&
	hyprshot \
		--mode output \
		--mode active \
		--clipboard-only

[ "$Choice" = "󰅍  Copy an image of an open window" ] &&
	hyprshot \
		--mode window \
		--clipboard-only

[ "$Choice" = "󰅍  Copy an image of a selected region" ] &&
	hyprshot \
		--mode region \
		--clipboard-only

[ "$Choice" = "󰗼  Exit" ] &&
	exit
