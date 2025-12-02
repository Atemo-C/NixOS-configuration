#!/run/current-system/sw/bin/dash

# Icon path.
printf "%s/.nix-profile/share/icons/Flat-Remix-Blue-Dark/apps/scalable/system-file-manager.svg\n" "$HOME"

# Tooltip title.
printf "                <b>File manager</b>\r\r"

# Tooltip content.
printf "<span foreground='#00c0ff'>󰍽</span> Left  │ Open the file manager\r"
printf "<span foreground='#ff8000'>󰍽</span> Right │ Open a file/directory in your \$HOME"