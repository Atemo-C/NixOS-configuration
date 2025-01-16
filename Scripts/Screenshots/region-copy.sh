#!/usr/bin/env bash

set -euo pipefail

grim -g "$(slurp -d -w 0)" - | wl-copy && notify-send -t 1500 "Screenshot copied."
