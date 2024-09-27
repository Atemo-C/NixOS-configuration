#!/usr/bin/env bash

# Closes on error.
set -euo pipefail

# Pick a color on the screen, save it to the clipboard, and send a notification.
Color=$(hyprpicker -f hex --autocopy & disown) && notify-send -t 1500 "$Color copied to the clipboard"
