#!/usr/bin/env bash

set -euo pipefail

grim - | wl-copy && notify-send -t 1500 "Screenshot copied."
