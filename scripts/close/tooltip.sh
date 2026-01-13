#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/apps/scalable/diodon.svg\n" "$ICON_THEME_PATH"

# Tooltip title.
printf "<b>                      Close</b>\r\r"

# Tolltip content.
printf "<span foreground='#00c0ff'>󰍽</span> Left  │ Close the focused window\r"
printf "<span foreground='#ff8000'>󰍽</span> Right │ Kill the focused window (not implemented)\r"