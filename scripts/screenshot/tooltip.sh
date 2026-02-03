#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/apps/scalable/gnome-screenshot.svg\n" "$HOME"

# Tooltip title.
printf "<b>                  Screenshot</b>\r\r"

# Tolltip content.
printf "<span foreground='#00c0ff'>󰍽</span> L │ Copy a region screenshot to the clipboard\r"
printf "<span foreground='#ff8000'>󰍽</span> R │ Open the screenshot menu for more options\r"
printf "<span foreground='#ff00ff'>󰍽</span> M │ Save a region screenshot to the clipboard"