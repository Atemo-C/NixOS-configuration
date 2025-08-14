#!/usr/bin/env dash

# Credits.
# • DASH:   http://gondor.apana.org.au/~herbert/dash
# • Fuzzel: https://codeberg.org/dnkl/fuzzel
# • Niri:   https://github.com/YaLTeR/niri

# Text formatting shortcuts for console messages using `printf`.
clr=$(tput sgr0)
err=$(tput bold; tput setaf 1)Error$(tput sgr0)
exe=$(tput bold; tput setaf 3)
war=$(tput bold; tput setaf 5)Warning$(tput sgr0)

# Text formatting for graphical notifications using `dunstify`.
bspan="</span></b>"
derr="<b><span foreground='#ff0000'>Error</span></b>"
dexe="<b><span foreground='#ffc000'>"

# Get the script's full path.
scr=$(readlink -f "$0")

# Check for any argument that may be present
[ "$#" -ne 0 ] && { printf "%s: This script does not support command-line arguments. Ignoring.\n" "$war"; }

# Check if Dunst is installed.
command -v dunstify > /dev/null 2>&1 || {
	printf "%s: %sDunst%s could not be found. Graphical notifications disabled. Continuing.\n" "$war" "$exe" "$clr"

	dunst_dep=false
}; [ "$dunst_dep" = false ] || { dunst_dep=true; }

# Function for graphical notifications using dunstify.
notify() { [ "$dunst_dep" = "false" ] || dunstify -u critical "$1" "$2"; }

# Check if Niri is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "%s: This script is made to be used within the %sNiri%s Wayland compositor. Exiting.\n" "$err" "$exe" "$clr"

	notify "Niri not detected" \
	"${derr}: This script is made to be used within the ${dexe}Niri${bspan} Wayland compositor. Exiting."

	exit 1
}

# Check if Fuzzel is installed.
command -v fuzzel > /dev/null 2>&1 || {
	printf "%s: %sFuzzel%s could not be found. It is necessary to display the screenshot selection menu. Exiting.\n" "$err" "$exe" "$clr"

	notify "Fuzzel not found" \
	"${derr}: ${dexe}Fuzzel${bspan} could not be found. It is necessary to display the screenshot selection menu. Exiting."

	exit 1
}

# Check if the screenshot script exists.
[ -f "/etc/nixos/scripts/screenshot.sh" ] || {
	printf "%s: The screenshot script could not be found. Exiting.\n" "$err"

	notify "Script not found" \
	"${derr}: The screenshot script could not be found. Exiting."

	exit 1
}

# List of screenshot options.
list="  Area screenshot    󰒅
  Window screenshot  
  Monitor screenshot 󰍹
 ‎
  Area screenshot    󰒅
  Window screenshot  
  Monitor screenshot 󰍹
 ‎
󰗼  Exit
"

# Select one of the options in the list.
choice=$(printf '%s\n' "$list" | fuzzel \
	--no-icons \
	--lines "9" \
	--width "22" \
	--dmenu "$@"
)

# Launch the appropriate screenshot action.
[ "$choice" = "  Area screenshot    󰒅" ] && { /etc/nixos/scripts/screenshot.sh --copy area && exit; }
[ "$choice" = "  Window screenshot  " ] && { /etc/nixos/scripts/screenshot.sh --copy window && exit; }
[ "$choice" = "  Monitor screenshot 󰍹" ] && { /etc/nixos/scripts/screenshot.sh --copy monitor && exit; }

[ "$choice" = " ‎" ] && { "$scr" && exit; }

[ "$choice" = "  Area screenshot    󰒅" ] && { /etc/nixos/scripts/screenshot.sh --save area && exit; }
[ "$choice" = "  Window screenshot  " ] && { /etc/nixos/scripts/screenshot.sh --save window && exit; }
[ "$choice" = "  Monitor screenshot 󰍹" ] && { /etc/nixos/scripts/screenshot.sh --save monitor && exit; }

[ "$choice" = "󰗼  Exit" ] && { exit; }

exit