#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/apps/scalable/x.svg\n" "$ICON_THEME_PATH"

# Tooltip title.
printf "<b>            Close</b>\r\r"

# Tolltip content.
printf "<span foreground='#00c0ff'>󰍽</span> L │ Close the focused window\r"
printf "<span foreground='#ff8000'>󰍽</span> R │ Kill the focused window\r"