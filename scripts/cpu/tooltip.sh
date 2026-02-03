#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/apps/scalable/diodon.svg\n" "$ICON_THEME_PATH"

# Tooltip title.
printf "<b>              CPU monitoring</b>\r\r"

# Tolltip content.
printf "<span foreground='#00c0ff'>󰍽</span> L │ Open a system monitor\r"
printf "<span foreground='#ff8000'>󰍽</span> R │ Show detailed temperature information\r"
printf "<span foreground='#ff00ff'>󰍽</span> M │ Show detailed memory an swap usage"