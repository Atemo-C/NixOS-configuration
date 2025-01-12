#!/usr/bin env bash

# Closes on error.
set -euo pipefail

# • Takes a region screenshot.
# • Copies the screenshot to the clipboard.
hyprshot \
	--mode region \
	--freeze \
	--clipboard-only
