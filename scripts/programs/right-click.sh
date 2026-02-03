#!/run/current-system/sw/bin/dash

# Text shortcuts for console log messages.
CHK="  $(tput setaf 7)Check$(tput sgr0)  │"
ACT=" $(tput setaf 5; tput bold)Action>$(tput sgr0) │"
SUC=" $(tput setaf 2; tput bold)Success$(tput sgr0) │"
WAR=" $(tput setaf 3; tput bold)Warning$(tput sgr0) │"
ERR="  $(tput setaf 1; tput bold)Error$(tput sgr0)  │"
RBG="$(tput setab 52)"
CMD="$(tput setaf 6; tput bold)"
CLR="$(tput sgr0)"

# Text functions for console log messages.
spacer() { printf "─────────┤\n"; }
ending() { printf "─────────┘\n"; }

# Text formatting shortcuts for graphical notifications.
DERR="<b><span foreground='#e60000'>Error</span></b>:"
DCMD="<b><span foreground='#00d0ff'>"
DCLR="</span></b>"

# Print the beginning separator for console log messages.
printf "─────────┐\n"

# Check for any command-line arguments.
printf "%s Checking for command-line arguments…\n" "$CHK"
[ "$#" -eq 0 ] \
	&& printf "%s Argument check passed.\n" "$SUC" \
	|| printf "%s Command-line arguments are ignored in this script.\n" "$WAR"
spacer

# Check if `dunstify` is available.
printf "%s Checking if %sdunstify%s is available…\n" "$CHK" "$CMD" "$CLR"
command -v dunstify >/dev/null 2>&1 \
	&& printf "%s %sdunstify%s found; Graphical notifications enabled.\n" "$SUC" "$CMD" "$CLR" \
	&& dunst_dep=true \
	|| printf "%s %sdunstify%s not found; Graphical notifications disabled.\n" "$WAR" "$CMD" "$CLR"
spacer

# Functions for graphical notifications using `dunstify`.
errify() { [ "$dunst_dep" = "true" ] && dunstify -u critical "$1" "$2"; }
warify() { [ "$dunst_dep" = "true" ] && dunstify "$1" "$2"; }

# Check if `niri` is the active Wayland compositor.
printf "%s Checking if %sniri%s is the active desktop…\n" "$CHK" "$CMD" "$CLR"
if [ "$XDG_CURRENT_DESKTOP" = "niri" ];
then
	printf "%s %sniri%s is the active desktop.\n" "$SUC" "$CMD" "$CLR"
else
	printf "%s %s%sniri%s%s is not the active desktop. Exiting…%s\n" \
	"$ERR" "$RBG" "$CMD" "$CLR" "$RBG" "$CLR"

	errify "Unsupported environment" \
	"${DERR} ${DCMD}niri${DCLR} is not the active desktop. Exiting…"

	ending
	exit 1
fi; spacer


# Check if `fuzzel` is available.
printf "%s Checking if %sfuzzel%s is available…\n" "$CHK" "$CMD" "$CLR"
if command -v fuzzel >/dev/null 2>&1;
then
	printf "%s %sfuzzel%s found; The right-click menu can be displayed.\n" "$SUC" "$CMD" "$CLR"
else
	printf "%s %s%sfuzzel%s%s not found; The right-click menu cannot be displayed. Exiting…%s\n" \
	"$ERR" "$RBG" "$CMD" "$CLR" "$RBG" "$CLR"

	errify "Menu program not found" \
	"${DERR} ${DCMD}fuzzel${DCLR} not found; The right-click menu cannot be displayed. Exiting…"

	ending
	exit 1
fi; spacer

# Show the right-click menu.
selection=$({
	printf "%b\n" "Edit the personalized program menu\000icon\037accessories-text-editor"
	printf "%b\n" "Open a generic run launcher\000icon\037application-default-icon"
	printf "%b\n" "Exit\000icon\037x"
} | fuzzel --lines 3 --width 35 --anchor top-left --dmenu)

[ "$selection" = "Edit the personalized program menu" ] && {
	printf "%s Opening the personalized program menu with %s%s%s…\n" "$ACT" "$CMD" "$EDITOR" "CLR"
	ending
	$EDITOR /etc/nixos/scripts/programs/program-launcher.sh >/dev/null 2>&1 & exit 0
}

[ "$selection" = "Open a generic run launcher" ] && {
	printf "%s Opening the generic run launcher…\n" "$ACT"
	ending
	nohup fuzzel >/dev/null 2>&1 & exit 0
}

[ "$selection" = "Exit" ] || [ "$selection" = "" ] && exit 0