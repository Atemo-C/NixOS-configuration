#!/usr/bin/env bash

set -euo pipefail

hyprshot \
	--current \
	--mode output \
	--output-folder "$HOME/Images/Screenshots" \
	--filename Screenshot_"$(date +'%d-%m-%Y_%H-%M-%S')".png
