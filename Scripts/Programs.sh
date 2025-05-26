#!/bin/dash

# Set text formatting shortcuts for `printf`.
arg=$(tput bold; tput setaf 2)
bol=$(tput bold)
c=$(tput sgr0)
err=$(tput bold; tput setaf 1)Error$(tput sgr0)
exe=$(tput bold; tput setaf 3)
ico=$(tput bold; tput setaf 6)
web=$(tput setaf 4)

# Set text formatting shortcuts for `dunstify`.
herr="<b><span foreground='#ff0000'>Error</span></b>"
hexe1="<b><span foreground='#ffc000'>"
hexe2="</span></b>"

# Shortcut for scripts.
scr="/etc/nixos/Scripts"

# Function to add a program to the list if it exists.
# (`addX` functions include a check to see if there is nothingness before them, to avoid extra entry at the top.)
# `add alacritty "Alacritty terminal emulator"` will launch `alacritty`
add() {
	command -v "$1" >/dev/null 2>&1 || return
	[ -z "$programs" ] && programs="$2|$1" || programs="$programs
$2|$1"
}

# Function to add a program to the list if it exists, but with a custom launch command.
# `add amfora "Terminal Gemini client" "$TERMINAL -e amfora"` will launch `amfora` in your default terminal.
adda() {
	command -v "$1" >/dev/null 2>&1 || return
	[ -z "$programs" ] && programs="$2|$3" || programs="$programs
$2|$3"
}

# Function to add a custom program, separator, script, etc to the script.
# `[ -f "$HOME/Programs/Duck" ] && addc "The beautiful duck webpage" "xdg-open duckduckgo.com"` will launch DuckDuckGo in your default browser.
addc() {
	[ -z "$programs" ] && programs="$1|$2" || programs="$programs
$1|$2"
}

# Function to cleanly detach lanuched programs from the script.
f() {
	nohup "$@" > /dev/null 2>&1 & exit
}

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	printf "%s: Invalid number of arguments '%s%d%s'.\n\n" \
		"$err" "$arg" "$#" "$c"

	printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" \
		"$arg" "$c" "$arg" "$c" "$arg" "$c"

	exit 1
}

# Check for the `--about` / `--help` / `-h` arguments.
[ "$1" = "--about" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ] && {
	printf "%s  %sPrograms.sh%s\n\n" \
		"$ico" "$arg" "$c"

	printf "%s[ Description ]%s\n" \
		"$bol" "$c"

	printf " This script lets you launch any program of your choosing in a custom list within the %sHyprland%s Wayland compositor.\n" \
		"$exe" "$c"

	printf " If a program from the list is not installed, it will automatically be omitted from the list.\n\n"

	printf "%s[ Arguments ]%s\n" \
		"$bol" "$c"

	printf " %s--about%s / %s--help%s / %s-h%s \n" \
		"$arg" "$c" "$arg" "$c" "$arg" "$c"

	printf "  Display this message.\n\n"

	printf " No argument: Display the program launcher.\n\n"

	printf "%s[ Credits ]%s\n" \
		"$bol" "$c"

	printf " %sFuzzel%s: %shttps://codeberg.org/dnkl/fuzzel?ref=mark.stosberg.com%s\n" \
		"$exe" "$c" "$web" "$c"

	exit 0
}

# When no argument is provided, start the program selection.
[ "$1" = "" ] && {
	# Check if Dunst is installed.
	command -v dunstify > /dev/null 2>&1 || {
		printf "%s: %sDunst%s could not be found. It is required to display graphical notifications.\n" \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		dunstify -u critical "  Programs.sh" "$herr: This script can only be used with the $hexe1 Hyprland$hexe2 Wayland compositor."

		printf "%s: This script can only be used within the %sHyprland%s Wayland Compositor.\n" \
			"$err" "$exe" "$c"

		exit 1
	}

	# Check if Fuzzel is installed.
	command -v fuzzel > /dev/null 2>&1 || {
		dunstify -u critical "  Programs.sh" "$herr:$hexe1 Fuzzel$hexe2 could not be found. It is required to show graphical menus."

		printf "%s: %sFuzzel%s could not be found. It is required to show graphical menus.\n" \
			"$err" "$exe" "$c"

		exit 1
	}

	# Calculate the height of the program menu, in accordance with the screen resolution.
	vertical=$(hyprctl monitors -j | jq '.[] | select(.focused == true) | .height')
	lines=$(( vertical / 28 ))

	# This is the program list. Add elements of your choosing and they will appear in the menu if present.
	# Remember to use the proper function (`add`, `adda`, or `addc`).
	programs=""
	addc "                     󰌧  Run launcher" "fuzzel --no-icons"
	addc " ‎" ""
	add alacritty              "  Alacritty            Terminal emulator"
	adda amfora                "  Amfora               Terminal Gemini client" "$TERMINAL -e amfora"
	add lagrange               "  Lagrange             Graphical Gemini client"
	add audacious              "  Audacious            Audio player"
	add easyeffects            "  EasyEffects          Live audio effects"
	add easytag                "  EasyTAG              Audio tag editor"
	add pwvucontrol            "  PWvucontrol          Audio volume settings"
	add qpwgraph               "󰤽  qpwgraph             Audio patchbay"
	add tenacity               "  Tenacity             Audio editor"
	add blender                "󰂫  Blender              3D modeling"
	adda cura                  "  Cura                 3D printing" "cura -platformtheme gtk3"
	add btop                   "  BTOP                 Terminal system monitor"
	add cpu-x                  "  CPU-X                Detailed processor information"
	add missioncenter          "  Mission Center       Graphical system monitor"
	add com.usebottles.bottles "󱌐  Bottles ( )         Run Windows programs in Bottles"
	adda calcurse              "  Calcurse             Terminal calendar" "$TERMINAL -e calcurse"

	[ -f "/run/current-system/sw/share/applications/cups.desktop" ] && addc \
		"  CUPS                 Printer configuration" "xdg-open https://localhost:631"

	[ -f "$scr/Crosshair/Crosshair.sh" ] && {
		addc "  Enable crosshair     A simple red-dot crosshair" "dash $scr/Crosshair/Crosshair --start"
		addc "󰽅  Disable crosshair    Kill the active crosshair" "dash $scr/Crosshair/Crosshair --stop"
	}

	add desmume                              "  DeSmuME              Nintendo DS/I emulator"
	add duckstation-qt                       "  DuckStation          Playstation 1 emulator"
	add pcsx2-qt                             "  PCSX2                PlayStation 2 emulator"
	add rpcs3                                "  RPCS3                PlayStation 3 emulator"
	add prismlauncher                        "󰍳  PrismLauncher        Minecraft Launcher"
	adda mcpelauncher-ui-qt                  "󰍳  MC Bedrock Launcher  Minecraft Bedrock" "mcpelauncher-ui-qt -platformtheme gtk3"
	add luanti                               "󰍳  Luanti (Minetest)    Open source voxel game engine"
	add page.codeberg.JakobDev.jdNBTExplorer "󰍳  NBT Explorer ( )    NBT Explorer and editor"
	add org.vinegarhq.Sober                  "  Sober ( )           Roblox client"
	add steam                                "  Steam                Valve winning by doing nothing"
	add jstest-gtk                           "  Jstest               Gamepad / controller tester"
	add keymapp                              "  Keymapp              Layout tool for ZSA keyboards"
	add sc-controller                        "  SC-Controller        Remap controllers"
	add xclicker                             "󰍽  Xclicker             X11 autocliker (for XWayland)"
	add vesktop                              "󰙯  Vesktop              Discord, but Vencorded"
	add element-desktop                      "󰭻  Element              Matrix client"
	add freetube                             "󰭻  Revolt               FOSS alternative to Discord"
	add gnome-disks                          "  Freetube             Watch YouTube videos"
	add gnome-disks                          "󰋊  Gnome disk utility   GNOME's disk utility"
	add gparted                              "󰋊  Gparted              Partition manager"
	adda ncdu                                "󰋊  ncdu                 Disk usage" "$TERMINAL -e ncdu"
	adda timeshift                           "󰁯  Timeshift           System restore" "timeshift-launcher"
	add thunar                               "  Thunar               File manager"
	add com.github.tchx84.Flatseal           "  Flatseal ( )        Manage flatpak permissions"
	add galculator                           "  Galculator           Calculator"
	add gcolor3                              "  Gcolor               Advanced color picker"
	adda hyprpicker                          "  Hyprpicker           Screen color picker" "$scr/Picker.sh"
	add gimp                                 "  GIMP                 GNU Image Manipulation Program"
	adda hyprpaper                           "  Hyprpaper            Set desktop background/wallpaper" "$scr/Hyprpaper.sh"
	add inkscape                             "  Inkscape             Vector graphics (SVG) editor"
	add krita                                "  Krita                Digital painting"
	adda otd                                 "  OpenTabletDriver     Configure your drawing tablet" "otd-gui"
	add upscayl                              "  Upscayl              Upscale images"

	[ -f "$HOME/Programs/Kurso de Esperanto/kursokape" ] && addc \
		"  Kurso de Esperanto   Esperanto learning program" "QT_QPA_PLATFORM=xcb steam-run $HOME/Programs/Kurso de Esperanto/kursokape"

	add keepassxc             "  KeePassXC            Password manager"
	add kdenlive              "  Kdenlive             Video editor"
	add com.obsproject.Studio "󰑋  OBS studio ( )      Video recording and streaming"
	add libreoffice           "󰏆  LibreOffice          Office suite"
	add simple-scan           "󰚫  Simple scan          Document scanner"
	add librewolf             "  LibreWolf            Web browser"
	adda librewolf            "  LibreWolf - private  Web browser (private window)" "librewolf --private-window"
	add tor-browser           "󰗹  Torbrowser launcher  Tor browser"
	adda nmtui                "󰛳  Network Manager      Manage WiFi and Ethernet" "$TERMINAL -e nmtui"
	add qbittorrent           "  qBittorrent          Torrent manager"
	add xfburn                "  Xfburn               Disc burning"
	add speedtest             "󰓅  Speedtest            Test internet speed"
	add virt-manager          "󰪫  Virt Manager         Virtual machines using QEMU/KVM"
	addc " ‎" continue
	addc "󰗼  Exit" exit

	# Main loop for the program selection.
	while :; do
		# Show the program menu (only display the first field before the delimiter).
		program=$(printf '%s\n' "$programs" | awk -F'|' '{print $1}' | fuzzel \
			--no-icons \
			--lines "$lines" \
			--width 58 \
			--dmenu "$@"
		)

		# Exit if no selection or "Exit" is chosen.
		[ -z "$program" ] || [ "$program" = "󰗼  Exit" ] && exit

		# Continue if a spacer is chosen.
		[ "$program" = " ‎" ] && continue

		# Find the matching command and execute it.
		cmd=$(printf '%s\n' "$programs" | grep "^$program|" | awk -F'|' '{print $2}')
		[ -n "$cmd" ] && eval "f $cmd"
	done
}

# Error out if an invalid argument is given.
printf "%s: Invalid argument '%s%s%s'.\n\n" \
	"$err" "$arg" "$*" "$c"

printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" \
	"$arg" "$c" "$arg" "$c" "$arg" "$c"

exit 1
