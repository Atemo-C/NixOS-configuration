#!/bin/dash

# Shortcuts for binaries.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"

# Define the "about" message.
About="
Power.sh

This script allows you to execute power actions within the Hyprland Wayland compositor, using Tofi to display the menu.

It allows for:
• Turning off the active monitor(s).
• Suspending to RAM.
• Hibernating (suspending to disk).
• Hybrid sleep (suspend to RAM and disk).
• Reboot.
• Reboot to the UEFI firmware (only appears when booted in EFI mode).
• Power off.
• Halt (an archaic way to turn the device off, and power has to be manually turned off afterwards).

Note that if the \"Reboot to the UEFI firmware\" option does not appear despite your computer supporting it, you might have accidentally installed your operating system in BIOS mode.

• When using the --about argument, this message is displayed.
• When no argument is given, the power selection starts.
• When an invalid argument is given, it is ignored.

Credits:
• tofi: https://github.com/philj56/tofi
"

# Check for arguments.
for argument in "$@"; do
	case "$argument" in
		--about);;
		*);;
	esac
done

# Show the "about" message when the --about argument is given.
echo "$*" | grep -q -- "--about" &&
	echo "$About" &&
	exit ||

# When no or an invalid argument is given, check for relevant depedencies and show the power menu.

# Check if libnotify is installed.
# Check if libnotify is installed.
[ -f "$SW/notify-send" ] || {
	echo "libnotify could not be found. It is needed to display graphical notifications.";
	exit 1;
}

# Check if Hyprland is the active desktop.
[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
	notify-send "This wallpaper utility can only be used with Hyprland." &
	echo "This wallpaper utility can only be used with Hyprland.";
	exit 1;
}

# Check if Tofi is installed.
[ -f "$HM/tofi" ] || [ -f "$SW/tofi" ] || {
	notify-send "tofi could not be found. It is necessary to display the graphical menu." &
	echo "tofi could not be found. It is necessary to display the graphical menu.";
	exit 1;
}

# Create the Confirmation list, used in prompts where user confirmation is preferrable.
Confirmations="
  No
  Yes
  Back"

# Set the size of the Tofi menu for the main selection.
Width="187"
Height="292"

# Gather the number of active monitors.
Count=$(hyprctl monitors | grep -c "Monitor")

# Choose the correct orthography, depending on the monitor count, and add the relevant one to the Options list.
[ "$Count" -eq 1 ] && Options="󰍹  Turn off display"
[ "$Count" -ge 2 ] && Options="󰍹  Turn off displays"

# Add some of the other entries to the Options list.
Options="
$Options
󰒲  Suspend
󰒲  Hibernate
󱌂  Hybrid sleep
󰜉  Reboot"

# If booted in EFI mode, add the relevant option to the Options list, and change the size of the Tofi menu.
[ -d "/sys/firmware/efi" ] && Options="
$Options
  Reboot to UEFI firmware"
	Width="236"
	Height="327"

# Add the remaining entries to the Options list.
Options="
$Options
  Power off
󰺟  Halt
 ‎
󰗼  Exit"

# Let the user select an option.
Choice=$(printf '%s\n' "$Options" | tofi \
	--width "$Width" \
	--height "$Height" \
	--prompt-text " " \
	"$@"
)

# Define the actions for every choice.
[ "$Choice" = "󰍹  Turn off display" ] || [ "$Choice" = "󰍹  Turn off displays" ] &&
	sleep 0.2 &&
	hyprctl dispatcher dpms off && exit

[ "$Choice" = "󰒲  Suspend" ] &&
	Answer=$(printf '%s\n' "$Confirmations" | tofi \
		--width 140 \
		--height 124 \
		--prompt-text "Suspend?"
	)

	[ "$Answer" = "  No" ] &&
		exit

	[ "$Answer" = "  Yes" ] &&
		systemctl suspend && exit

	[ "$Answer" = "  Back" ] &&
		nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

[ "$Choice" = "󰒲  Hibernate" ] &&
	Answer=$(printf '%s\n' "$Confirmations" | tofi \
		--width 156 \
		--height 124 \
		--prompt-text "Hibernate?"
	)

	[ "$Answer" = "  No" ] &&
		exit

	[ "$Answer" = "  Yes" ] &&
		systemctl hibernate && exit

	[ "$Answer" = "  Back" ] &&
		nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

[ "$Choice" = "󱌂  Hybrid sleep" ] &&
	Answer=$(printf '%s\n' "$Confirmations" | tofi \
		--width 180 \
		--height 124 \
		--prompt-text "Hybrid sleep?"
	)

	[ "$Answer" = "  No" ] &&
		exit

	[ "$Answer" = "  Yes" ] &&
		systemctl hybrid-sleep && exit

	[ "$Answer" = "  Back" ] &&
		nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

[ "$Choice" = "󰜉  Reboot" ] &&
	Answer=$(printf '%s\n' "$Confirmations" | tofi \
		--width 131 \
		--height 124 \
		--prompt-text "Reboot?"
	)

	[ "$Answer" = "  No" ] &&
		exit

	[ "$Answer" = "  Yes" ] &&
		systemctl reboot

	[ "$Answer" = "  Back" ] &&
		nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

[ "$Choice" = "  Reboot to UEFI firmware" ] &&
	Answer=$(printf '%s\n' "$Confirmations" | tofi \
		--width 268 \
		--height 124 \
		--prompt-text "Reboot to UEFI firmware?"
	)

	[ "$Answer" = "  No" ] &&
		exit

	[ "$Answer" = "  Yes" ] &&
		systemctl reboot --firmware-setup

	[ "$Answer" = "  Back" ] &&
		nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

[ "$Choice" = "  Power off" ] &&
	Answer=$(printf '%s\n' "$Confirmations" | tofi \
		--width 156 \
		--height 124 \
		--prompt-text "Power off?"
	)

	[ "$Answer" = "  No" ] &&
		exit

	[ "$Answer" = "  Yes" ] &&
		systemctl poweroff

	[ "$Answer" = "  Back" ] &&
		nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

[ "$Choice" = "󰺟  Halt" ] &&
	Answer=$(printf '%s\n' "$Confirmations" | tofi \
		--width 156 \
		--height 124 \
		--prompt-text "Halt the system?" & \
		notify-send "Manually turn off power once the system is halted. This is archaic."
	)

	[ "$Answer" = "  No" ] &&
		exit

	[ "$Answer" = "  Yes" ] &&
		pkexec systemctl halt

	[ "$Answer" = "  Back" ] &&
		nohup dash "/etc/nixos/Scripts/Power.sh" > /dev/null 2>&1 &

[ "$Choice" = "󰗼  Exit" ] &&
	exit
