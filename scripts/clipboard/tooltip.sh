#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/apps/scalable/diodon.svg\n" "$ICON_THEME_PATH"

# Tooltip title.
printf "<b>             Clipboard</b>\r\r"

# Tolltip content.
printf "<span foreground='#00c0ff'>󰍽</span> L │ Open the clipboard\r"
printf "<span foreground='#ff8000'>󰍽</span> R │ Edit a permanent clipboard file\r"
printf "<span foreground='#ff00ff'>󰍽</span> M │ Clear the clipboard"