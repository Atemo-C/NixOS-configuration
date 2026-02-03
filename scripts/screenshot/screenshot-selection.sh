#!/run/current-system/sw/bin/dash

# Check for any command-line arguments, and ignore them if any is detected.
[ "$#" -gt 0 ] && {
	printf "This script does not support command-line arguments. Ignoring.\n"
	nohup "$0" >/dev/null 2>&1 & exit
}

# Check if `niri` is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "Niri is not the running desktop.\nIf it is, check that %s is correct.\n" "$XDG_CURRENT_DESKTOP"
	exit 1
}

# Check if `fuzzel` is available.
command -v fuzzel >/dev/null 2>&1 || {
	printf "The fuzzel menu program was not found; The screenshot menu cannot be displayed.\n"
	exit 1
}

# Loop for the screenshot action menu and selection.
while :; do
	# Shortcut for the screenshot's main script path.
	script="/etc/nixos/scripts/screenshots/screenshot.sh"

	# Screnshot menu entries.
	selection=$({
		printf "%b\n" "Area screenshot\000icon\037accessories-screenshot"
		printf "%b\n" "Window screenshot\000icon\037preferences-system-windows"
		printf "%b\n" "Monitor screenshot\000icon\037preferences-desktop-display"
		printf " ‎\n"
		printf "%b\n" "Area screneshot (save)\000icon\037accessories-screenshot"
		printf "%b\n" "Window screenshot (save)\000icon\037preferences-system-windows"
		printf "%b\n" "Monitor screenshot (save)\000icon\037preferences-desktop-display"
		printf " ‎\n"
		printf "%b\n" "Exit\000icon\037x"
	} | fuzzel --lines 9 --width 28 --anchor top-left --dmenu)

	# Run the selected command.
	case "$selection" in
		"Area screenshot") nohup "$script" --copy area & exit 0;;
		"Window screenshot") nohup "$script" --copy window & exit 0;;
		"Monitor screenshot") nohup "$script" --copy monitor& exit 0;;
		"Area screneshot (save)") nohup "$script" --save area& exit 0;;
		"Window screenshot (save)") nohup "$script" --save window & exit 0;;
		"Monitor screenshot (save)") nohup "$script" --save monitor & exit 0;;

		# Loop back if selecting the spacer.
		" ‎") continue;;

		# Exit if selecting Exit or pressing escape.
		""|"Exit") exit 0;;
	esac
done