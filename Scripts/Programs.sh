#!/bin/dash

# Set some text formatting shortcuts for printf.
err=$(tput bold; tput setaf 1)Error$(tput sgr0)
arg=$(tput bold; tput setaf 2)
exe=$(tput bold; tput setaf 3)
ico=$(tput bold; tput setaf 6)
web=$(tput setaf 4)
bol=$(tput bold)
c=$(tput sgr0)

# Set some text formatting shortcuts for dunstify.
herr="<b><span foreground='#ff0000'>Error</span></b>"
hexe1="<b><span foreground='#ffc000'>"
hexe2="</span></b>"

# Wayland/X11 shortcuts for annoying Electron programs.
way="--ozone-platform=wayland"
#x11="--ozne-platform=x11"

# Shortcut for scripts.
scr="/etc/nixos/Scripts/"

# Set a shortcut for adding programs to the list.
add() {
	if [ "$1" = "-" ]; then
		# If first argument is "-", add entry without checking for a command
		programs="$programs
$2"
	else
		# Otherwise, check if command exists
		command -v "$1" >/dev/null 2>&1 && programs="$programs
$2"
	fi
}

# Set a shortcut for launching programs and detaching them cleanly from the script.
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

	# Define the height of the program menu, in accordance with the screen selotion.
	# • List monitors.
	# • List the 20 lines above "focused: yes".
	# • Reverse the sorting order.
	# • Grep any lines with x.
	# • Keep only the first one.
	# • Trim the output to only keep the vertical resolution.
	# • Divide it by 28 for a reasonable size.
	#   (Depending on the bar size and fuzzel configuration, this needs to change.)
	vertical=$(hyprctl monitors | grep -B20 "focused: yes" \
		| tac | grep x | head -n 1 | awk -F 'x|@' '{print $2}'
	)
	lines=$(( vertical / 28 ))

	# This is the program list. Add elements of your choosing.
	# Once done, remember to add their actions in the graphical menu below the list.
	programs="                     󰌧  Run launcher
 ‎"

	add alacritty              "  Alacritty            Terminal emulator"
	add amfora                 "  Amfora               Terminal Gemini client"
	add lagrange               "  Lagrange             Graphical Gemini client"
	add audacious              "  Audacious            Audio player"
	add easyeffects            "  EasyEffects          Live audio effects"
	add easytag                "  EasyTAG              Audio tag editor"
	add pwvucontrol            "  PWvucontrol          Audio volume settings"
	add qpwgraph               "󰤽  qpwgraph             Audio patchbay"
	add tenacity               "  Tenacity             Audio editor"
	add blender                "󰂫  Blender              3D modeling"
	add cura                   "  Cura                 3D printing"
	add btop                   "  BTOP                 Terminal system monitor"
	add cpu-x                  "  CPU-X                Detailed processor information"
	add missioncenter          "  Mission Center       Graphical system monitor"
	add com.usebottles.bottles "󱌐  Bottles ( )         Run Windows programs in Bottles"
	add calcurse               "  Calcurse             Terminal calendar"

	[ -f "/run/current-system/sw/share/applications/cups.desktop" ] && add - \
		"  CUPS                 Printer configuration"

	[ -f "/etc/nixos/Scripts/Crosshair/Crosshair.sh" ] && {
		add - "  Enable crosshair     A simple red-dot crosshair"
		add - "󰽅  Disable crosshair    Kill the active crosshair"

		# Set shortcuts for the crosshair's path.
		cross="/etc/nixos/Scripts/Crosshair/Crosshair.sh"
	}

	add desmume                              "  DeSmuME              Nintendo DS/I emulator"
	add duckstation-qt                       "  DuckStation          Playstation 1 emulator"
	add pcsx2-qt                             "  PCSX2                PlayStation 2 emulator"
	add rpcs3                                "  RPCS3                PlayStation 3 emulator"
	add prismlauncher                        "󰍳  PrismLauncher        Minecraft Launcher"
	add mcpelauncher-ui-qt                   "󰍳  MC Bedrock Launcher  Minecraft Bedrock"
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
	add ncdu                                 "󰋊  ncdu                 Disk usage"
	add timeshift                            "󰁯  Timeshift           System restore"
	add thunar                               "  Thunar               File manager"
	add com.github.tchx84.Flatseal           "  Flatseal ( )        Manage flatpak permissions"
	add galculator                           "  Galculator           Calculator"
	add gcolor3                              "  Gcolor               Advanced color picker"
	add hyprpicker                           "  Hyprpicker           Screen color picker"
	add gimp                                 "  GIMP                 GNU Image Manipulation Program"
	add hyprpaper                            "  Hyprpaper            Set desktop background/wallpaper"
	add inkscape                             "  Inkscape             Vector graphics (SVG) editor"
	add krita                                "  Krita                Digital painting"
	add otd                                  "  OpenTabletDriver     Configure your drawing tablet"
	add upscayl                              "  Upscayl              Upscale images"

	[ -f "$HOME/Programs/Kurso de Esperanto/kursokape" ] && add - \
	"  Kurso de Esperanto   Esperanto learning program"

	add keepassxc             "  KeePassXC            Password manager"
	add kdenlive              "  Kdenlive             Video editor"
	add com.obsproject.Studio "󰑋  OBS studio ( )      Video recording and streaming"
	add libreoffice           "󰏆  LibreOffice          Office suite"
	add simple-scan           "󰚫  Simple scan          Document scanner"
	add librewolf             "  LibreWolf            Web browser"
	add librewolf             "  LibreWolf - private  Web browser (private window)"
	add tor-browser           "󰗹  Torbrowser launcher  Tor browser"
	add nmtui                 "󰛳  Network Manager      Manage WiFi and Ethernet"
	add qbittorrent           "  qBittorrent          Torrent manager"
	add xfburn                "  Xfburn               Disc burning"
	add speedtest             "󰓅  Speedtest            Test internet speed"
	add virt-manager          "󰪫  Virt Manager         Virtual machines using QEMU/KVM"
	add - " ‎"
	add - "󰗼  Exit"

	# Main loop for the program selection.
	while :; do

		# Show the program menu.
		program=$(printf '%s\n' "$programs" | fuzzel \
			--no-icons \
			--lines "$lines" \
			--width 58 \
			--dmenu "$@"
		)

		# Define the action of every entry.
		[ "$program" = " ‎" ] && continue
		[ "$program" = "                     󰌧  Run launcher" ] && f fuzzel
		[ "$program" = "  Alacritty            Terminal emulator" ] && f alacritty
		[ "$program" = "  Amfora               Terminal Gemini client" ] && f "$TERMINAL" -e amfora
		[ "$program" = "  Lagrange             Graphical Gemini client" ] && f lagrange
		[ "$program" = "  Audacious            Audio player" ] && f audacious
		[ "$program" = "  EasyEffects          Live audio effects" ] && f easyeffects
		[ "$program" = "  EasyTAG              Audio tag editor" ] && f easytag
		[ "$program" = "  PWvucontrol          Audio volume settings" ] && f pwvucontrol
		[ "$program" = "󰤽  qpwgraph             Audio patchbay" ] && f qpwgraph
		[ "$program" = "  Tenacity             Audio editor" ] && f tenacity
		[ "$program" = "󰂫  Blender              3D modeling" ] && f blender
		[ "$program" = "  Cura                 3D printing" ] && f cura -platformtheme gtk3
		[ "$program" = "  BTOP                 Terminal system monitor" ] && f "$TERMINAL" -e btop
		[ "$program" = "  CPU-X                Detailed processor information" ] && f cpu-x
		[ "$program" = "  Mission Center       Graphical system monitor" ] && f missioncenter
		[ "$program" = "󱌐  Bottles ( )         Run Windows programs in Bottles" ] && f com.usebottles.bottles
		[ "$program" = "  Calcurse             Terminal calendar" ] && f "$TERMINAL" calcurse
		[ "$program" = "  CUPS                 Printer configuration" ] && f xdg-open "https://localhost:631"
		[ "$program" = "  Enable crosshair     A simple red-dot crosshair" ] && f dash "$cross" --start
		[ "$program" = "󰽅  Disable crosshair    Kill the active crosshair" ] && f dash "$cross" --stop
		[ "$program" = "  DeSmuME              Nintendo DS/I emulator" ] && f desmume
		[ "$program" = "  DuckStation          Playstation 1 emulator" ] && f duckstation
		[ "$program" = "  PCSX2                PlayStation 2 emulator" ] && f pcsx2-qt
		[ "$program" = "  RPCS3                PlayStation 3 emulator" ] && f rpcs3
		[ "$program" = "󰍳  PrismLauncher        Minecraft Launcher" ] && f prismlauncher
		[ "$program" = "󰍳  MC Bedrock Launcher  Minecraft Bedrock" ] && f mcpelauncher-ui-qt -platformtheme gtk3
		[ "$program" = "󰍳  Luanti (Minetest)    Open source voxel game engine" ] && f luanti
		[ "$program" = "󰍳  NBT Explorer ( )    NBT Explorer and editor" ] && f page.codeberg.JakobDev.jdNBTExplorer
		[ "$program" = "  Sober ( )           Roblox client" ] && f org.vinegarhq.Sober
		[ "$program" = "  Steam                Valve winning by doing nothing" ] && f steam
		[ "$program" = "  Jstest               Gamepad / controller tester" ] && f jstest-gtk
		[ "$program" = "  Keymapp              Layout tool for ZSA keyboards" ] && f keymapp
		[ "$program" = "  SC-Controller        Remap controllers" ] && f sc-controller
		[ "$program" = "󰍽  Xclicker             X11 autocliker (for XWayland)" ] && f xclicker
		[ "$program" = "󰙯  Vesktop              Discord, but Vencorded" ] && f vesktop "$way"
		[ "$program" = "󰭻  Element              Matrix client" ] && f element-desktop "$way"
		[ "$program" = "󰭻  Revolt               FOSS alternative to Discord" ] && f revolt-desktop "$way"
		[ "$program" = "  Freetube             Watch YouTube videos" ] && f freetube "$way"
		[ "$program" = "󰋊  Gnome disk utility   GNOME's disk utility" ] && f gnome-disks
		[ "$program" = "󰋊  Gparted              Partition manager" ] && f gparted
		[ "$program" = "󰋊  ncdu                 Disk usage" ] && f "$TERMINAL" -e ncdu
		[ "$program" = "󰁯  Timeshift           System restore" ] && f timeshift-launcher
		[ "$program" = "  Thunar               File manager" ] && f thunar
		[ "$program" = "  Flatseal ( )        Manage flatpak permissions" ] && f com.github.tchx84.Flatseal
		[ "$program" = "  Galculator           Calculator" ] && f galculator
		[ "$program" = "  Gcolor               Advanced color picker" ] && f gcolor3
		[ "$program" = "  Hyprpicker           Screen color picker" ] && f dash "$scr"/Picker.sh
		[ "$program" = "  GIMP                 GNU Image Manipulation Program" ] && f gimp
		[ "$program" = "  Hyprpaper            Set desktop background/wallpaper" ] && f dash "$scr"/Hyprpaper.sh
		[ "$program" = "  Inkscape             Vector graphics (SVG) editor" ] && f inkscape
		[ "$program" = "  Krita                Digital painting" ] && f krita
		[ "$program" = "  OpenTabletDriver     Configure your drawing tablet" ] && f otd-gui
		[ "$program" = "  Upscayl              Upscale images" ] && f upscayl
		[ "$program" = "  KeePassXC            Password manager" ] && f keepassxc
		[ "$program" = "  Kdenlive             Video editor" ] && f kdenlive
		[ "$program" = "󰑋  OBS studio ( )      Video recording and streaming" ] && f com.obsproject.Studio
		[ "$program" = "󰏆  LibreOffice          Office suite" ] && f soffice
		[ "$program" = "󰚫  Simple scan          Document scanner" ] && f simple-scan
		[ "$program" = "  LibreWolf            Web browser" ] && f librewolf
		[ "$program" = "  LibreWolf - private  Web browser (private window)" ] && f librewolf --private-window
		[ "$program" = "󰗹  Torbrowser launcher  Tor browser" ] && f tor-browser
		[ "$program" = "󰛳  Network Manager      Manage WiFi and Ethernet" ] && f "$TERMINAL" -e nmtui
		[ "$program" = "  qBittorrent          Torrent manager" ] && f qbittorrent
		[ "$program" = "  Xfburn               Disc burning" ] && f xfburn
		[ "$program" = "󰓅  Speedtest            Test internet speed" ] && f speedtest
		[ "$program" = "󰪫  Virt Manager         Virtual machines using QEMU/KVM" ] && f virt-manager
		[ "$program" = "󰗼  Exit" ] || [ "$program" = "" ] && exit
	done
}

# Error out if an invalid argument is given.
printf "%s: Invalid argument '%s%s%s'.\n\n" \
	"$err" "$arg" "$*" "$c"

printf "See the %s--about%s / %s--help%s / %s-h%s argument.\n" \
	"$arg" "$c" "$arg" "$c" "$arg" "$c"

exit 1
