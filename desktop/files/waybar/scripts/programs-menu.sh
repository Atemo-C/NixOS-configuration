#!/run/current-system/sw/bin/dash

selection=$({
	printf "%b\n" "Edit the personalized program menu\000icon\037accessories-text-editor"
	printf "%b\n" "Open a generic run launcher\000icon\037application-default-icon"
	printf "%b\n" "Exit\000icon\037x"
} | fuzzel --lines 3 --width 35 --anchor top-left --dmenu)

[ "$selection" = "Edit the personalized program menu" ] && {
	nohup "$TERMINAL" -e "$EDITOR" /etc/nixos/scripts/programs.sh > /dev/null 2>&1 & exit
}

[ "$selection" = "Open a generic run launcher" ] && {
	nohup fuzzel > /dev/null 2>&1 & exit
}

[ "$selection" = "Exit" ] || [ "$selection" = "" ] && { exit; }