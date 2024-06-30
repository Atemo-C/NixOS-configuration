#!/usr/bin/env bash

set -euo pipefail

hyprshot \
	--mode output \
	--mode active \
	--output-folder "$HOME/Images/Screenshots" \
	--filename Screenshot"$(echo ' ')""$(date +'%d-%m-%Y %H-%M-%S')".png
