#!/usr/bin env bash

# Closes on error.
set -euo pipefail

# • Takes a screenshot of the desired window.
# • Saves the screenshot.
# • Sets the name of the screenshot.
hyprshot \
	--mode window \
	--output-folder "$HOME/Images/Screenshots" \
	--filename Screenshot"$(echo ' ')""$(date +'%d-%m-%Y %H-%M-%S')".png
