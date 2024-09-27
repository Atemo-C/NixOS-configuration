#!/usr/bin env bash

# Closes on error.
set -euo pipefail

# • Takes a region screenshot.
# • Saves the screenshot.
# • Sets the name of the screenshot.
hyprshot \
	--mode region \
	--output-folder "$HOME/Images/Screenshots" \
	--filename Screenshot"$(echo ' ')""$(date +'%d-%m-%Y %H-%M-%S')".png
