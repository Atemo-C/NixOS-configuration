#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/apps/scalable/colorpicker.svg\n" "$ICON_THEME_PATH"

# Tooltip title.
printf "<b>              Color picker</b>\r\r"

# Tooltip content.
printf "<span foreground='#00c0ff'>󰍽</span> L │ Pick a color anywhere on the screen\r"
printf "<span foreground='#ff8000'>󰍽</span> R │ Open a more advanced color picker"