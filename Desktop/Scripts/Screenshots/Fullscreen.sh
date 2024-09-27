#!/usr/bin env bash

# Closes on error.
set -euo pipefail

# • Takes a full-screen screenshot.
# • Automatically selects the active monitor to capture.
# • Saves the screenshot.
# • Sets the name of the screenshot.
hyprshot \
	--mode output \
	--mode active \
	--output-folder "$HOME/Images/Screenshots" \
	--filename Screenshot"$(echo ' ')""$(date +'%d-%m-%Y %H-%M-%S')".png
