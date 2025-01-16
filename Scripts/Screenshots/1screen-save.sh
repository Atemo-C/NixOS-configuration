#!/usr/bin/env bash

set -euo pipefail

IMAGE=$(date +'Screenshot_%d-%m-%Y_%H-%M-%S.jpg') && \
	grim -t jpeg -q 100 -o "$(hyprctl activeworkspace -j | jq -r '.monitor')" ~/Images/Screenshots/"$IMAGE" && \
	jpegoptim -sv ~/Images/Screenshots/"$IMAGE" && \
	notify-send "Screenshot saved."
