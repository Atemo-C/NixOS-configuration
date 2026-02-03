#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/apps/scalable/applications-all.svg\n" "$ICON_THEME_PATH"

# Tooltip title.
printf "             <b>Program menu</b>\r\r"

# Tooltip content.
printf "<span foreground='#00c0ff'>󰍽</span> L │ Open the personalized program menu\r"
printf "<span foreground='#ff8000'>󰍽</span> R │ Show more options"