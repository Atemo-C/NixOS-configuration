#!/usr/bin env bash

# Closes on error.
set -euo pipefail

# • Takes a full-screen screenshot.
# • Automatically selects the active monitor to capture.
# • Copies the screenshot to the clipboard.
hyprshot \
	--mode output \
	--mode active \
	--clipboard-only
