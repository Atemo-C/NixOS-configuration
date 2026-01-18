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
DWAR="<b><span foreground='#ffc000'>Warning</span></b>:"
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
	printf "%s %sfuzzel%s found; The power menu can be displayed.\n" "$SUC" "$CMD" "$CLR"
else
	printf "%s %s%sfuzzel%s%s not found; The power menu cannot be displayed. Exiting…%s\n" \
	"$ERR" "$RBG" "$CMD" "$CLR" "$RBG" "$CLR"

	errify "Menu program not found" \
	"${DERR} ${DCMD}fuzzel${DCLR} not found; The power menu cannot be displayed. Exiting…"

	ending
	exit 1
fi; spacer

# Check if `jq` is available.
printf "%s Checking if %sjq%s is available…\n" "$CHK" "$CMD" "$CLR"
if command -v jq >/dev/null 2>&1;
then
	printf "%s %sjq%s found; Niri's configuration can be parsed.\n" "$SUC" "$CMD" "$CLR"
else
	printf "%s %s%sjq%s%s not found; Niri's configuration cannot be pasred. Exiting…%s\n" \
	"$ERR" "$RBG" "$CMD" "$CLR" "$RBG" "$CLR"

	errify "Menu progarm not found" \
	"${DERR} ${DCMD}jq${DCLR} not found; Niri's configuration cannot be parsed. Exiting…"

	ending
	exit 1
fi; spacer

# Check if `swaylock` is available.
printf "%s Checking if %sswaylock%s is available…\n" "$CHK" "$CMD" "$CLR"
if command -v swaylock >/dev/null 2>&1;
then
	printf "%s %sswaylock%s found; Session locking option available.\n" "$SUC" "$CMD" "$CLR"
	has_swaylock=true
else
	printf "%s %sswaylock%s not found; Session locking option unavailable.\n" "$WAR" "$CMD" "$CLR"

	warify "Session locking program not found" \
	"${DWAR} ${DCMD}swaylock${DCLR} not found; Session locking option unavailable."
fi; spacer

# Function to call swaylock if it exists, with a small delay.
lock() {
	[ "$has_swaylock" = "true" ] \
		&& printf "%s Locking the session…\n" "$ACT" \
		&& swaylock >/dev/null 2>&1 &
}

# Check whether the system is booted in UEFI or BIOS mode.
printf "%s Checking whether the system is booted in UEFI or BIOS mode…\n" "$CHK"
[ -d "/sys/firmware/efi" ] \
	&& printf "%s Booted in UEFI mode; Option to reboot to the UEFI firmware available.\n" "$SUC" \
	&& is_uefi=true \
	|| printf "%s Booted in BIOS mode; Option to reboot to the UEFI firmware unavailable\n." "$SUC"
spacer

# Check the number of active monitors.
printf "%s Checking the number of active monitors…\n" "$CHK"
monitor_count=$(niri msg -j outputs | jq 'length')
if [ "$monitor_count" -gt 1 ];
then
	printf "%s %s%s%s monitors detected.\n" "$SUC" "$CMD" "$monitor_count" "$CLR"
	monitor_item="󰍹  Turn off monitors"
else
	printf "%s %s1%s monitor detected.\n" "$SUC" "$CMD" "$CLR"
	monitor_item="󰍹  Turn off monitor"
fi; spacer

# Default number of lines to show in the power menu.
lines="9"

# Default width of the power menu.
width="20"

# Confirmation list, used in prompts where user confirmation is desirable.
confirmoptions="  No
  Yes
  Back"

# List of options presented to the user.
list=$(
	printf "%s\n" "$monitor_item"
	[ "$has_swaylock" = "true" ] && printf "  Lock session\n"
	printf "󰒲  Suspend\n"
	printf "󰒲  Hibernate\n"
	printf "󱌂  Hybrid sleep\n"
	printf "󰜉  Reboot\n"
	[ "$is_uefi" = "true" ] && printf "  Reboot to UEFI firmware\n"
	printf "  Power off\n"
	printf "󰿅  Leave Niri\n"
	printf " ‎\n"
	printf "󰗼  Exit\n"
)

# Adjust the number of lines and width of the power menu depending on optional items.
[ "$has_swaylock" = "true" ] && lines=$((lines + 1))
[ "$is_uefi" = "true" ] && lines=$((lines + 1)) && width="28"

# Loop for the power menu and selection.
while :; do
	# Display the power menu.
	choice=$(printf "%s\n" "$list" | fuzzel \
		--no-icons \
		--lines "$lines" \
		--width "$width" \
		--dmenu "$@"
	)

	# Turn off monitors.
	[ "$choice" = "󰍹  Turn off monitor" ] || [ "$choice" = "󰍹  Turn off monitors" ] \
		&& lock \
		&& sleep 0.5 \
		&& niri msg action power-off-monitors \
		&& exit 0

	# Lock the session.
	[ "$choice" = "  Lock session" ] \
		&& lock \
		&& ending \
		&& exit 0

	# Common handler for items with a confirmation prompt.
	[ "$choice" = "󰒲  Suspend" ] || [ "$choice" = "󰒲  Hibernate" ] || [ "$choice" = "󱌂  Hybrid sleep" ] || \
	[ "$choice" = "󰜉  Reboot" ] || [ "$choice" = "  Reboot to UEFI firmware" ] || \
	[ "$choice" = "  Power off" ] || [ "$choice" = "󰿅  Leave Niri" ] && {
		# Set confirmation prompt name and width.
		[ "$choice" = "󰒲  Suspend" ] && prompt="Suspend? " && prompt_width="13"
		[ "$choice" = "󰒲  Hibernate" ] && prompt="Hibernate? " && prompt_width=15
		[ "$choice" = "󱌂  Hybrid sleep" ] && prompt="Hybrid sleep? " && prompt_width=18
		[ "$choice" = "󰜉  Reboot" ] && prompt="Reboot? " && prompt_width=12
		[ "$choice" = "  Reboot to UEFI firmware" ] && prompt="Reboot to UEFI firmware? " && prompt_width=29
		[ "$choice" = "  Power off" ] && prompt="Power off? " && prompt_width=15
		[ "$choice" = "󰿅  Leave Niri" ] && prompt="Log out? " && prompt_width=13

		# Display the confirmation menu.
		answer=$(printf "%s\n" "$confirmoptions" | fuzzel \
			--no-icons \
			--dmenu \
			--lines 3 \
			--width "$prompt_width" \
			--prompt "$prompt"
		)

		# Exit upon selecting "No".
		[ "$answer" = "  No" ] \
			&& printf "%s Exiting…\n" "$ACT" \
			&& ending \
			&& exit 0

		# Go back to the main menu upon selecting "Back".
		[ "$answer" = "  Back" ] \
			&& printf "%s Going back to the main menu…\n" "$ACT" \
			&& spacer \
			&& continue

		# Execute the selected actions upon selecting "Yes".
		[ "$answer" = "  Yes" ] && {
			# Suspend the system.
			[ "$choice" = "󰒲  Suspend" ] \
				&& lock \
				&& printf "%s Suspending the system…\n" "$ACT" \
				&& systemctl suspend \
				&& ending \
				&& exit 0

			# Hibernate the system.
			[ "$choice" = "󰒲  Hibernate" ] \
				&& lock \
				&& printf "%s Hibernating the system…\n" "$ACT" \
				&& systemctl hibernate \
				&& ending \
				&& exit 0

			# Hybrid suspend the system.
			[ "$choice" = "󱌂  Hybrid sleep" ] \
				&& lock \
				&& printf "%s Hybrid suspending the system…\n" "$ACT" \
				&& systemctl hybrid-sleep \
				&& ending \
				&& exit 0

			# Reboot the system.
			[ "$choice" = "󰜉  Reboot" ] \
				&& printf "%s Rebooting the system…\n" "$ACT" \
				&& ending \
				&& systemctl reboot

			# Reboot to the UEFI firmware setup.
			[ "$choice" = "  Reboot to UEFI firmware" ] \
				&& printf "%s Rebooting the system to the UEFI firmware setup…\n" "$ACT" \
				&& ending \
				&& systemctl reboot --firmware-setup

			# Power off the system.
			[ "$choice" = "  Power off" ] \
				&& printf "%s Powering off the system…\n" "$ACT" \
				&& ending \
				&& systemctl poweroff

			# Leave Niri.
			# (Also politely kill cmd-polkit so that it has no trouble relaunching.)
			[ "$choice" = "󰿅  Leave Niri" ] \
				&& printf "%s Leaving Niri…\n" "$ACT" \
				&& ending \
				&& pkill cmd-polkit \
				& niri msg action quit --skip-confirmation \
				exit 0
		}
	}

	# Loop back to the main menu when selecting the spacer.
	[ "$choice" = " ‎" ] \
		&& printf "%s Going back to the main menu…\n" "$ACT" \
		&& continue

	# Exit if no selection or "Exit" is selected.
	[ "$choice" = "󰗼  Exit" ] || [ "$choice" = "" ] \
		&& printf "%s Exiting…\n" "$ACT" \
		&& ending \
		&& exit 0
done

printf "%s%sAn undefined error occurred during the execution of the script. Exiting…%s\n" \
"$ERR" "$RBG" "$CLR"
exit 2