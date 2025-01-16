#!/usr/bin/env bash

set -euo pipefail

grim -o "$(hyprctl activeworkspace -j | jq -r '.monitor')" | wl-copy && notify-send -t 1500 "Screenshot copied."
