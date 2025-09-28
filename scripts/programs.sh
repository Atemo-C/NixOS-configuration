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

# Function to add a program to the list.
add() {
	command -v "$1" > /dev/null 2>&1 || return
	[ -z "$programs" ] && programs="$2|$1" || programs="$programs
$2|$1"
}

# Function to add a program to the list, but with a custom launch command.
adda() {
	command -v "$1" > /dev/null 2>&1 || return
	[ -z "$programs" ] && programs="$2|$3" || programs="$programs
$2|$3"
}

# Function to add a fully custom program path, script, separator, etc.
addc() {
	[ -z "$programs" ] && programs="$1|$2" || programs="$programs
$1|$2"
}

# Function to cleanly detach launched programs from the script.
f() { nohup "$@" > /dev/null 2>&1 & exit; }

# Set the height of the program menu.
# In the future, it could potentially be automatically calculated.
#	vertical=$(niri msg outputs | jq '.[] | select(.focused == true) | .height')
#  lines=$(( vertical / 28 ))
lines=24

# The program list. Add elements of your choosing and they will appear in the menu if present on your system.
# Remember to use the appropriate functions (`add`, `adda`, or `addc`).
programs=""
addc                          "                     󰌧  Run launcher" "fuzzel --no-icons"
addc " ‎"                     ""
adda amfora                   "  Amfora               Terminal Gemini client" "$TERMINAL -e amfora"
add  audacious                "  Audacious            Audio player"
add  io.github.kolunmi.Bazaar "  Bazaar ( )          Flatpak application store"
add  blender                  "󰂫  Blender              3D modeling"
add  com.usebottles.bottles   "󱌐  Bottles ( )         Run Windows programs in Bottles"
adda btop                     "  BTOP                 Terminal system monitor" "$TERMINAL -e btop"

[ -f "/etc/nixos/scripts/calculator.sh" ] && command -v bc && addc \
"  Calculator           Simple terminal-based calculator" \
"footclient --app-id \"dash-calculator.sh\" --window-size-chars 54x22 dash /etc/nixos/scripts/calculator.sh"

adda calcurse "  Calcurse             Terminal calendar" "$TERMINAL -e calcurse"
add  cpu-x    "  CPU-X                Detailed processor information"

command -v eww > /dev/null 2>&1 && [ -f "/etc/nixos/scripts/crosshair/eww.yuck" ] && {
	addc "  Crosshair ON         Activate a simple red-dot crosshair" \
	"eww -c /etc/nixos/scripts/crosshair/ open crosshair"

	addc "󰽅  Crosshair OFF        Disable the active red-dor crosshhair." \
	"eww -c /etc/nixos/scripts/crosshair/ close crosshair"
}

adda cupsd "  CUPS                 Printer configuration" \
"xdg-open https://localhost:631"

add  cura            "  Cura                 3D printing"
add  desmume         "  DeSmuME              Nintendo DS/I emulator"
add  easyeffects     "  EasyEffects          Live audio effects"
add  easytag         "  EasyTAG              Audio tag editor"
adda element-desktop "󰭻  Element              Matrix client" \
"element-desktop code --password-store=gnome-libsecret"

add  com.github.tchx84.Flatseal "  Flatseal ( )        Manage flatpak permissions"
add  footclient                 "  Foot (client)        Terminal emulator"
add  foot                       "  Foot (standalone)    Terminal emulator"
add  gcolor3                    "  Gcolor3              Advanced color picker"
add  gimp                       "  GIMP                 GNU Image Manipulation Program"
add  gnome-disks                "󰋊  Gnome disk utility   GNOME's disk utility"
add  gparted                    "󰋊  Gparted              Partition manager"
add  heroic                     "  Heroic               Launcher for GOG, Epic, Amazon games"
adda hyprpaper                  "  Hyprpaper            Set desktop background/wallpaper" \
"dash /etc/nixos/scripts/background.sh"

add inkscape   "  Inkscape             Vector graphics (SVG) editor"
add jstest-gtk "  Jstest               Gamepad / controller tester"
add keymapp    "  Keymapp              Layout tool for ZSA keyboards"
add kdenlive   "  Kdenlive             Video editor"
add keepassxc  "  KeePassXC            Password manager"
add krita      "  Krita                Digital painting"

[ -f "$HOME/Programs/Kurso de Esperanto/kursokape" ] && addc \
"  Kurso de Esperanto   Esperanto learning program" \
"QT_QPA_PLATFORM=xcb steam-run $HOME/Programs/Kurso de Esperanto/kursokape"

add  lact        "  LACT                 Configure and overclock GPUs"
add  lagrange    "  Lagrange             Graphical Gemini client"
add  libreoffice "󰏆  LibreOffice          Office suite"
add  librewolf   "  LibreWolf            Web browser"
adda librewolf   "  LibreWolf - private  Web browser (private window)" \
"librewolf --private-window"

add  luanti             "󰍳  Luanti (Minetest)    Open source voxel game engine"
add  mcpelauncher-ui-qt "󰍳  MC Bedrock Launcher  Minecraft Bedrock"
add  minder             "  Minder               Mind-mapping utility"
add  missioncenter      "  Mission Center       Graphical system monitor"
adda ncdu "󰋊  ncdu                 Disk usage" \
"$TERMINAL -e ncdu"

adda nmtui "󰛳  Network Manager      Manage WiFi and Ethernet" \
"$TERMINAL -e nmtui"

add  com.obsproject.Studio "󰑋  OBS studio ( )      Video recording and streaming"
add  obs                   "󰑋  OBS studio           Video recording and streaming"
add  otg-gui               "  OpenTabletDriver     Configure your drawing tablet"
add  pcsx2-qt              "  PCSX2                PlayStation 2 emulator"
add  prismlauncher         "󰍳  PrismLauncher        Minecraft Launcher"

[ -f "/etc/nixos/scripts/power.sh" ] && addc \
"  Power menu           Suspend, reboot, power off…" \
"/etc/nixos/scripts/power.sh"

add  pwvucontrol         "  PWvucontrol          Audio volume settings"
add  qbittorrent         "  qBittorrent          Torrent manager"
add  qpwgraph            "󰤽  qpwgraph             Audio patchbay"
add  revolt-desktop      "󰭻  Revolt               FOSS alternative to Discord"
add  rpcs3               "  RPCS3                PlayStation 3 emulator"
add  ruffle              "  Ruffle               Adobe Flash emulator"
add  sc-controller       "  SC-Controller        Remap controllers"
add  simple-scan         "󰚫  Simple scan          Document scanner"
add  org.vinegarhq.Sober "  Sober ( )           Roblox client"
add  speedtest           "󰓅  Speedtest            Test internet speed"
add  steam               "  Steam                Valve winning by doing nothing"
add  tenacity            "  Tenacity             Audio editor"
add  thunar              "  Thunar               File manager"
add  timeshift-launcher  "󰁯  Timeshift            System restore"
add  tor-browser         "󰗹  Torbrowser           Web browsing through Tor"
add  upscayl             "  Upscayl              Upscale images"
add  org.upscayl.Upscayl "  Upscayl ( )         Upscale images"
add  vesktop             "󰙯  Vesktop              Discord, but Vencorded"
add  vintagestory        "  Vintage Story        Sandbox game of innovation and exploration"
add  virt-manager        "󰪫  Virt Manager         Virtual machines using QEMU/KVM"
adda xclicker            "󰍽  Xclicker             X11 autocliker (for XWayland)" \
"sh -c 'DISPLAY=:0 xclicker'"

add xfburn "  Xfburn               Disc burning"

addc " ‎" continue
addc "󰗼  Exit" exit

# Loop for the program selection.
while :; do
	# Show the program menu.
	program=$(printf '%s\n' "$programs" | awk -F '|' '{print $1}' | fuzzel \
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