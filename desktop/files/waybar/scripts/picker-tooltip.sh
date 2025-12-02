#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/.nix-profile/share/icons/Flat-Remix-Blue-Dark/apps/scalable/colorpicker.svg\n" "$HOME"

# Tooltip title.
printf "<b>              Color picker</b>\r\r"

# Tooltip content.
printf "<span foreground='#00c0ff'>󰍽</span> Left   │ Pick a color anywhere on the screen\r"
printf "<span foreground='#ff8000'>󰍽</span> Right  │ Open a more advanced color picker"