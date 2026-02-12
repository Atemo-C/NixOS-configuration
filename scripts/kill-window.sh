#!/run/current-system/sw/bin/dash
kill -9 "$(niri msg focused-window | sed -n 's/^  PID: //p')" & exit