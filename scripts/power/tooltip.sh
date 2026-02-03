#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/apps/scalable/diodon.svg\n" "$ICON_THEME_PATH"

# Tooltip title.
printf "<b>       Power menu</b>\r\r"

# Tolltip content.
printf "<span foreground='#00c0ff'>󰍽</span> L │ Open the power menu\r"
printf "<span foreground='#ff8000'>󰍽</span> R │ Edit the power menu"