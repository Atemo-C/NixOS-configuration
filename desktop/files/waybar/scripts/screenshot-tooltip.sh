#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/.nix-profile/share/icons/Flat-Remix-Blue-Dark/apps/scalable/gnome-screenshot.svg\n" "$HOME"

# Tooltip title.
printf "<b>                   Screenshot</b>\r\r"

# Tolltip content.
printf "<span foreground='#00c0ff'>󰍽</span> Left   │ Copy a region screenshot to the clipboard\r"
printf "<span foreground='#ff8000'>󰍽</span> Right  │ Open the screenshot menu for more options\r"
printf "<span foreground='#ff00ff'>󰍽</span> Middle │ Save a region screenshot to the clipboard"