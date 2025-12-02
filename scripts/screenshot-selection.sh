#!/run/current-system/sw/bin/dash

script="/etc/nixos/scripts/screenshot.sh"

selection=$({
	printf "%b\n" "Area screenshot\000icon\037accessories-screenshot"
	printf "%b\n" "Window screenshot\000icon\037preferences-system-windows"
	printf "%b\n" "Monitor screenshot\000icon\037preferences-desktop-display"
	printf "\n"
	printf "%b\n" "Area screneshot (save)\000icon\037accessories-screenshot"
	printf "%b\n" "Window screenshot (save)\000icon\037preferences-system-windows"
	printf "%b\n" "Monitor screenshot (save)\000icon\037preferences-desktop-display"
	printf "\n"
	printf "%b\n" "Exit\000icon\037x"
} | fuzzel --lines 9 --width 28 --anchor top-left --dmenu)

[ "$selection" = "Area screenshot" ] && { nohup "$script" --copy area > /dev/null 2>&1 & exit; }
[ "$selection" = "Window screenshot" ] && { nohup "$script" --copy window > /dev/null 2>&1 & exit; }
[ "$selection" = "Monitor screenshot" ] && { nohup "$script" --copy monitor > /dev/null 2>&1 & exit; }

[ "$selection" = "Area screneshot (save)" ] && { nohup "$script" --save area > /dev/null 2>&1 & exit; }
[ "$selection" = "Window screenshot (save)" ] && { nohup "$script" --save  window > /dev/null 2>&1 & exit; }
[ "$selection" = "Monitor screenshot (save)" ] && { nohup "$script" --save  monitor > /dev/null 2>&1 & exit; }

[ "$selection" = "" ] || [ "$selection" = "exit" ] && exit