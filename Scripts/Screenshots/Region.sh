#!/usr/bin env bash

# Closes on error.
set -euo pipefail

# • Takes a region screenshot.
# • Sets the output folder of the screenshot.
# • Sets the name of the screenshot.
hyprshot \
	--mode region \
	--freeze \
	--output-folder "$HOME/Images/Screenshots" \
	--filename Screenshot"$(echo ' ')""$(date +'%d-%m-%Y %H-%M-%S')".png
