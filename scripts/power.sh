#!/usr/bin/env dash

# Credits.
# • DASH:     http://gondor.apana.org.au/~herbert/dash
# • Fuzzel:   https://codeberg.org/dnkl/fuzzel
# • Swaylock: https://github.com/jirutka/swaylock-effects

# Text formatting shortcuts for console messages using `printf`.
clr=$(tput sgr0)
err=$(tput bold; tput setaf 1)Error$(tput sgr0)
exe=$(tput bold; tput setaf 3)
war=$(tput bold; tput setaf 5)Warning$(tput sgr0)

# Text formatting for graphical notifications using `dunstify`.
bspan="</span></b>"
derr="<b><span foreground='#ff0000'>Error</span></b>"
dexe="<b><span foreground='#ffc000'>"
dwar="<b><span foreground='#ff0080'>Warning</span></b>"

# Check for any argument that may be present.
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
	printf "%s: %sFuzzel%s could not be found. It is necessary to display the power menu. Exiting\n" "$err" "$exe" "$clr"

	notify "Fuzzel not found" \
	"${derr}: ${dexe}Fuzzel${bspan} could not be found. It is necessary to display the power menu. Exiting"

	exit 1
}

# Check if Swaylock is installed.
command -v swaylock > /dev/null 2>&1 || {
	printf "%s: %sSwaylock%s could not be found. It is necessary to lock the screen. Continuing.\n" "$war" "$exe" "$clr"

	notify "Swaylock not found" \
	"${dwar}: ${dexe}Swaylock${bspan} could not be found. It is ncessary to lock the screen. Continuing."

	swaylock_dep=false
}; [ "$swaylock_dep" = "false" ] || { swaylock_dep=true; }

# Confirmation list, used in prompts where user confirmation is preferrable.
areyousure="  No
  Yes
  Back"

# Loop for the power action selection.
while :; do
	lines="9"
	width="20"

	# Gather the number of active monitors.
	count=$(niri msg outputs | grep -c '^Output')

	# Be nit-picky about orthography, and add the relevant monitor option to the `items` list.
	[ "$count" -gt 1 ] && { items="󰍹  Turn off displays" && width="21"; } || items="󰍹  Turn off display"

	# Add an option to lock the session if `swaylock` is installed.
	[ "$swaylock_dep" = "true" ] && {
		items="$items
  Lock session"

		lines=$((lines + 1))
	}

	# Add other generic entries to the list.
	items="$items
󰒲  Suspend
󰒲  Hibernate
󱌂  Hybrid sleep
󰜉  Reboot"

	# If booted in EFI mode, add an option to reboot to the EFI firmware (BIOS).
	[ -d "/sys/firmware/efi" ] && {
		items="$items
  Reboot to UEFI firmware"

		lines=$((lines + 1))
		width="28"
	}

	# Add the remaining entries to the list.
	items="$items
  Power off
󰿅  Leave Niri
 ‎
󰗼  Exit"

	# Select one of the options in the list.
	choice=$(printf '%s\n' "$items" | fuzzel \
		--no-icons \
		--lines "$lines" \
		--width "$width" \
		--dmenu "$@"
	)

	# Turn off monitors.
	[ "$choice" = "󰍹  Turn off display" ] || [ "$choice" = "󰍹  Turn off displays" ] && { sleep 0.5 && niri msg action power-off-monitors && exit; }

	# Lock the session.
	[ "$choice" = "  Lock session" ] && { swaylock & niri msg action power-off-monitors && exit; }

	# Common handler for confirmation prompts.
	[ "$choice" = "󰒲  Suspend" ] || [ "$choice" = "󰒲  Hibernate" ] || [ "$choice" = "󱌂  Hybrid sleep" ] || \
	[ "$choice" = "󰜉  Reboot" ] || [ "$choice" = "  Reboot to UEFI firmware" ] || \
	[ "$choice" = "  Power off" ] || [ "$choice" = "󰿅  Leave Niri" ] && {
		# Set prompt, width, and notifications based on choice.
		[ "$choice" = "󰒲  Suspend" ]                 && prompt="Suspend? "                 && width=13
		[ "$choice" = "󰒲  Hibernate" ]               && prompt="Hibernate? "               && width=15
		[ "$choice" = "󱌂  Hybrid sleep" ]            && prompt="Hybrid sleep? "            && width=18
		[ "$choice" = "󰜉  Reboot" ]                  && prompt="Reboot? "                  && width=12
		[ "$choice" = "  Reboot to UEFI firmware" ] && prompt="Reboot to UEFI firmware? " && width=29
		[ "$choice" = "  Power off" ]               && prompt="Power off? "               && width=15
		[ "$choice" = "󰿅  Leave Niri" ]              && prompt="Log out? "                 && width=13

		# Main confirmation meu.
		answer=$(printf '%s\n' "$areyousure" | fuzzel --no-icons --dmenu \
			--lines 3 \
			--width "$width" \
			--prompt "$prompt"
		)

		# Set the "no" and "back" actions for confirmations.
		[ "$answer" = "  No" ] && exit
		[ "$answer" = "  Back" ] && continue

		# Execute the selected actions.
		[ "$answer" = "  Yes" ] && {
			[ "$choice" = "󰒲  Suspend" ]                 && { swaylock & systemctl suspend; }
			[ "$choice" = "󰒲  Hibernate" ]               && { swaylock & systemctl hibernate; }
			[ "$choice" = "󱌂  Hybrid sleep" ]            && { swaylock & systemctl hybrid-sleep; }
			[ "$choice" = "󰜉  Reboot" ]                  && systemctl reboot
			[ "$choice" = "  Reboot to UEFI firmware" ] && systemctl reboot --firmware-setup
			[ "$choice" = "  Power off" ]               && systemctl poweroff
			[ "$choice" = "󰿅  Leave Niri" ]              && { pkill cmd-polkit & niri msg action quit --skip-confirmation; }
			exit
		}
	}

	# Loop back when selecting the spacer.
	[ "$choice" = " ‎" ] && continue

	# Exit if no selection or "Exit" is chosen.
	[ "$choice" = "󰗼  Exit" ] || [ "$choice" = "" ] && exit
done