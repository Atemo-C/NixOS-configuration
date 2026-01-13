#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/apps/scalable/diodon.svg\n" "$ICON_THEME_PATH"

# Tooltip title.
printf "<b>               Clipboard</b>\r\r"

# Tolltip content.
printf "<span foreground='#00c0ff'>󰍽</span> Left   │ Open the clipboard\r"
printf "<span foreground='#ff8000'>󰍽</span> Right  │ Edit a permanent clipboard file\r"
printf "<span foreground='#ff00ff'>󰍽</span> Middle │ Clear the clipboard"