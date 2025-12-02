#!/run/current-system/sw/bin/dash

# Function to start a selected program by its executable name.
l() {
	command -v "$@" > /dev/null 2>&1 && {
		nohup "$@" > /dev/null 2>&1 & exit 0
	}
	command -v dunstify > /dev/null 2>&1 && dunstify -u critical "$1 not found"
	printf "%s was not found. Is it installed?\n" "$1"
	exit 1
}

# Function to start a selected program with custom arguments.
la() {
	command -v "$1" > /dev/null 2>&1 && {
		shift
		nohup "$@" > /dev/null 2>&1 & exit 0
	}
	command -v dunstify > /dev/null 2>&1 && dunstify -u critical "$1 not found"
	printf '%s was not found. Is it installed?\n' "$1"
	exit 1
}

# Function to start a selected program not in default executable paths.
lc() {
	[ -f "$1" ] && [ -x "$1" ] && {
		shift
		nohup "$@" > /dev/null 2>&1 & exit 0
	}
	command -v dunstify > /dev/null 2>&1 && \
		dunstify -u critical "$1 not found" "$1 is missing or is not executable."
	printf '%s not found or not executable.\n' "$1"
	exit 1
}

# The program list.
program=$({
	printf "%b\n" "Run launcher\000icon\037application-default-icon"
	printf "\n"
	printf "%b\n" "Amfora                 Terminal Gemini client\000icon\037rocket"
	printf "%b\n" "Audacious              Audio player\000icon\037audacious"
	printf "%b\n" "Blender                3D modeling and animation\000icon\037blender"
	printf "%b\n" "Bottles               Run Windows programs in Bottles\000icon\037bottles_wine"
	printf "%b\n" "BTOP++                 Terminal system monitor\000icon\037htop"
	printf "%b\n" "Calculator             Terminal calculator\000icon\037accessories-calculator"
	printf "%b\n" "Calcurse               Terminal calendar\000icon\037calendar"
	printf "%b\n" "Character map          Browse charcaters\000icon\037accessories-character-map"
	printf "%b\n" "CPU-X                  Detailed processor information\000icon\037cpu"
	printf "%b\n" "Crosshair ON           Activate a red-dot crosshair\000icon\037eyewitness"
	printf "%b\n" "Crosshair OFF          Disable a red-dot crosshair\000icon\037eyewitness"
	printf "%b\n" "CUPS                   Printer/scanner configuration\000icon\037cups"
	printf "%b\n" "DeSmuME                Nintendo DS(i) emulator\000icon\037desmume"
	printf "%b\n" "Disks                  GNOME's disks utility\000icon\037gnome-disks"
	printf "%b\n" "Simple Scan            Document scanner\000icon\037scanner"
	printf "%b\n" "Easy Effects           Live audio effects\000icon\037easyeffects"
	printf "%b\n" "EasyTag                Audio tag editor\000icon\037easytag"
	printf "%b\n" "Element                Matrix client\000icon\037element"
	printf "%b\n" "Flatseal              Manage Flatpak permissions\000icon\037com.github.tchx84.Flatseal"
	printf "%b\n" "Foot (client)          Terminal emulator\000icon\037utilities-terminal"
	printf "%b\n" "Foot (standalone)      Terminal emulator\000icon\037utilities-terminal"
	printf "%b\n" "Gcolor3                Advanced color picker\000icon\037colorpicker"
	printf "%b\n" "GIMP                   GNU Image Manipulation Program\000icon\037gimp"
	printf "%b\n" "Gparted                Partition manager\000icon\037gparted"
	printf "%b\n" "Heroic                 Launcher for GOG, Epic, Amazon games\000icon\037games"
	printf "%b\n" "Hyprpaper              Set the desktop wallpaper/background\000icon\037wallpaper"
	printf "%b\n" "Inkscape               Vector graphics (SVG) editor\000icon\037inkscape"
	printf "%b\n" "jdNBTExplorer          Minecraft NBT explorer and editor\000icon\037dconf-editor"
	printf "%b\n" "jstest-gtk             Gamepad/controller tester\000icon\037games"
	printf "%b\n" "Kdenlive               Video editor\000icon\037kdenlive"
	printf "%b\n" "KeePassXC              Password manager\000icon\037keepassxc"
	printf "%b\n" "Keymapp                Layout and heatmap tool for ZSA keyboards\000icon\037input-keyboard"
	printf "%b\n" "Krita                  Digital painting\000icon\037krita"
	printf "%b\n" "Kurso de Esperanto     Esperanto learning program\000icon\037preferences-desktop-locale"
	printf "%b\n" "LACT                   Configure and overclock GPUs\000icon\037hardware"
	printf "%b\n" "Lagrange               Graphical Gemini client\000icon\037rocket"
	printf "%b\n" "LibreOffice            Office suite\000icon\037libreoffice"
	printf "%b\n" "LibreOffice Base       · Databases\000icon\037libreoffice-base"
	printf "%b\n" "LibreOffice Calc       · Spreadsheets\000icon\037libreoffice-calc"
	printf "%b\n" "LibreOffice Draw       · Drawing\000icon\037libreoffice-draw"
	printf "%b\n" "LibreOffice Math       · Mathematics\000icon\037libreoffice-math"
	printf "%b\n" "LibreOffice Writer     · Word processing\000icon\037libreoffice-writer"
	printf "%b\n" "LibreOffice Impress    · Presentations\000icon\037libreoffice-impress"
	printf "%b\n" "LibreWolf              Web browser\000icon\037kali-volafox"
	printf "%b\n" "LibreWolf - private    Web browser (private window)\000icon\037view-private"
	printf "%b\n" "Luanti (Minetest)      Open-source voxel game engine\000icon\037minetest"
	printf "%b\n" "Micro                  Terminal text editor\000icon\037accessories-text-editor"
	printf "%b\n" "Minder                 Mind-mapping utility\000icon\037application-default-icon"
	printf "%b\n" "MC Bedrock Launcher    Minecraft Bedrock launcher\000icon\037minecraft"
	printf "%b\n" "Mission Center         Graphical system monitor\000icon\037utilities-system-monitor"
	printf "%b\n" "ncdu                   Terminal disk usage analyzer\000icon\037disk-usage-analyzer"
	printf "%b\n" "NixOS manual           Offline manual for NixOS\000icon\037help-browser"
	printf "%b\n" "NVIDIA settings        NVIDIA GPU control panel\000icon\037nvidia"
	printf "%b\n" "OrcaSlicer             3D-printing slicer\000icon\037orca"
	printf "%b\n" "OBS Studio             Video recording and streaming\000icon\037obs"
	printf "%b\n" "OpenTabletDriver       Configure connected drawing tablets\000icon\037input-tablet"
	printf "%b\n" "PCSX2                  PlayStation 2 emulator\000icon\037pcsx2"
	printf "%b\n" "PrismLauncher          Minecraft launcher\000icon\037minecraft"
	printf "%b\n" "Power                  Suspend, reboot, power off…\000icon\037system-shutdown"
	printf "%b\n" "pwvucontrol            Audio volume control\000icon\037preferences-desktop-sound"
	printf "%b\n" "qBittorrent            Torrent manager\000icon\037transmission"
	printf "%b\n" "qpwgraph               PipeWire patchbay\000icon\037audio-input-line"
	printf "%b\n" "Revolt                 FOSS alternative to Discord\000icon\037empathy"
	printf "%b\n" "RPCS3                  PlayStation 3 emulator\000icon\037games"
	printf "%b\n" "Ruffle                 Adobe Flash emulator\000icon\037flash"
	printf "%b\n" "Speedtest              Test internet speed\000icon\037preferences-system-network"
	printf "%b\n" "Steam                  Valve can count to 3\000icon\037steam"
	printf "%b\n" "Tenacity               Audio editor\000icon\037audacity"
	printf "%b\n" "Thunar                 File manager\000icon\037system-file-manager"
	printf "%b\n" "Timeshift              System restore\000icon\037timeshift"
	printf "%b\n" "Tor browser            Web browsing through the Tor network\000icon\037browser-tor"
	printf "%b\n" "Upscayl                Upscale images\000icon\037showimage"
	printf "%b\n" "Vesktop                Discord with built-in Vencord\000icon\037discord"
	printf "%b\n" "Vintage Story          Sandbox game of innovation and exploration\000icon\037minecraft"
	printf "%b\n" "Virt Manager           Virtual machines using libvirt (QEMU/KVM)\000icon\037virt-manager"
	printf "%b\n" "Xclicker               X11/XWayland autoclicker\000icon\037input-mouse"
	printf "%b\n" "Xfburn                 Disc burning\000icon\037brasero"
	printf "\n"
	printf "%b\n" "Exit\000icon\037x"
} | fuzzel --lines 24 --width 63 --dmenu)

# The actions to run upon selection of a program.
[ "$program" = "Run launcher" ] &&
l fuzzel

[ "$program" = "Amfora                 Terminal Gemini client" ] &&
la amfora "$TERMINAL" -e amfora

[ "$program" = "Audacious              Audio player" ] &&
l audacious

[ "$program" = "Blender                3D modeling and animation" ] &&
l blender

[ "$program" = "Bottles               Run Windows programs in Bottles" ] &&
l com.usebottles.bottles

[ "$program" = "BTOP++                 Terminal system monitor" ] &&
la btop "$TERMINAL" -e btop

[ "$program" = "Calculator             Terminal calculator" ] &&
lc "/etc/nixos/scripts/calculator.sh" \
"$TERMINAL" --app-id "dash-calculator.sh" --window-size-chars 54x22 "/etc/nixos/scripts/calculator.sh"

[ "$program" = "Calcurse               Terminal calendar" ] &&
la calcurse "$TERMINAL" -e calcurse

[ "$program" = "Character map          Browse charcaters" ] &&
l gucharmap

[ "$program" = "CPU-X                  Detailed processor information" ] &&
l cpu-x

[ "$program" = "Crosshair ON           Activate a red-dot crosshair" ] &&
lc "/etc/nixos/scripts/crosshair/eww.yuck" \
eww -c /etc/nixos/scripts/crosshair/ open crosshair

[ "$program" = "Crosshair OFF          Disable a red-dot crosshair" ] &&
lc "/etc/nixos/scripts/crosshair/eww.yuck" \
eww -c /etc/nixos/scripts/crosshair/ close crosshair

[ "$program" = "CUPS                   Printer/scanner configuration" ] &&
la cupsd "$BROWSER" "http://localhost:631"

[ "$program" = "DeSmuME                Nintendo DS(i) emulator" ] &&
l desmume

[ "$program" = "Disks                  GNOME's disks utility" ] &&
l gnome-disks

[ "$program" = "Simple Scan            Document scanner" ] &&
l simple-scan

[ "$program" = "Easy Effects           Live audio effects" ] &&
l easyeffects

[ "$program" = "EasyTag                Audio tag editor" ] &&
l easytag

[ "$program" = "Element                Matrix client" ] &&
la element-desktop element-desktop code --password-store=gnome-libsecret

[ "$program" = "Flatseal              Manage Flatpak permissions" ] &&
l com.github.tchx84.Flatseal

[ "$program" = "Foot (client)         Terminal emulator" ] &&
l footclient

[ "$program" = "Foot (standalone)     Terminal emulator" ] &&
l foot

[ "$program" = "Gcolor3                Advanced color picker" ] &&
l gcolor3

[ "$program" = "GIMP                   GNU Image Manipulation Program" ] &&
l gimp

[ "$program" = "Gparted                Partition manager" ] &&
l gparted

[ "$program" = "Heroic                 Launcher for GOG, Epic, Amazon games" ] &&
l heroic

[ "$program" = "Hyprpaper              Set the desktop wallpaper" ] &&
lc "/etc/nixos/scripts/background.sh" "/etc/nixos/scripts/background.sh"

[ "$program" = "Inkscape               Vector graphics (SVG) editor" ] &&
l inkscape

[ "$program" = "jdNBTExplorer          Minecraft NBT explorer and editor" ] &&
l page.codeberg.JakobDev.jdNBTExplorer

[ "$program" = "jstest-gtk             Gamepad/controller tester" ] &&
l jstest-gtk

[ "$program" = "Kdenlive               Video editor" ] &&
l kdenlive

[ "$program" = "KeePassXC              Password manager" ] &&
l keepassxc

[ "$program" = "Keymapp                Layout and heatmap tool for ZSA keyboards" ] &&
l keymapp

[ "$program" = "Krita                  Digital painting" ] &&
l krita

[ "$program" = "Kurso de Esperanto     Esperanto learning program" ] &&
lc "$HOME/Programs/Kurso de Esperanto/kursokape" "$HOME/Programs/Kurso de Esperanto/kursokape"

[ "$program" = "LACT                   Configure and overclock GPUs" ] &&
l lact

[ "$program" = "Lagrange               Graphical Gemini client" ] &&
l lagrange

[ "$program" = "LibreOffice            Office suite" ] &&
l libreoffice

[ "$program" = "LibreOffice Base       · Databases" ] &&
la libreoffice libreoffice --base

[ "$program" = "LibreOffice Calc       · Spreadsheets" ] &&
la libreoffice libreoffice --calc

[ "$program" = "LibreOffice Draw       · Drawing" ] &&
la libreoffice libreoffice --draw

[ "$program" = "LibreOffice Math       · Mathematics" ] &&
la libreoffice libreoffice --math

[ "$program" = "LibreOffice Writer     · Word processing" ] &&
la libreoffice libreoffice --writer

[ "$program" = "LibreOffice Impress    · Presentations" ] &&
la libreoffice libreoffice --impress

[ "$program" = "LibreWolf              Web browser" ] &&
l librewolf

[ "$program" = "LibreWolf - private    Web browser (private window)" ] &&
la librewolf librewolf --private-window

[ "$program" = "Luanti (Minetest)      Open-source voxel game engine" ] &&
l luanti

[ "$program" = "Micro                  Terminal text editor" ] &&
la micro "$TERMINAL" -e micro

[ "$program" = "Minder                 Mind-mapping utility" ] &&
l minder

[ "$program" = "MC Bedrock Launcher    Minecraft Bedrock launcher" ] &&
l mcpelauncher-ui-qt

[ "$program" = "Mission Center         Graphical system monitor" ] &&
l missioncenter

[ "$program" = "ncdu                   Terminal disk usage analyzer" ] &&
la ncdu "$TERMINAL" -e ncdu "$HOME/"

[ "$program" = "NixOS manual           Offline manual for NixOS" ] &&
la nix "$BROWSER" "/run/current-system/sw/share/doc/nixos/index.html"

[ "$program" = "NVIDIA settings        NVIDIA GPU control panel" ] &&
l nvidia-settings

[ "$program" = "OrcaSlicer             3D-printing slicer" ] &&
la orca-slicer GBM_BACKEND=dri XDG_SESSION_TYPE=x11 orca-slicer

[ "$program" = "OBS Studio             Video recording and streaming" ] &&
l obs

[ "$program" = "OpenTabletDriver       Configure connected drawing tablets" ] &&
l otg-gui

[ "$program" = "PCSX2                  PlayStation 2 emulator" ] &&
l pcsx2-qt

[ "$program" = "PrismLauncher          Minecraft launcher" ] &&
l prismlauncher

[ "$program" = "Power                  Suspend, reboot, power off…" ] &&
lc "/etc/nixos/scripts/power.sh" "/etc/nixos/scripts/power.sh"

[ "$program" = "pwvucontrol            Audio volume control" ] &&
l pwvucontrol

[ "$program" = "qBittorrent            Torrent manager" ] &&
l qbittorrent

[ "$program" = "qpwgraph               PipeWire patchbay" ] &&
l qpwgraph

[ "$program" = "Revolt                 FOSS alternative to Discord" ] &&
l revolt-desktop

[ "$program" = "RPCS3                  PlayStation 3 emulator" ] &&
l rpcs3

[ "$program" = "Ruffle                 Adobe Flash emulator" ] &&
l ruffle

[ "$program" = "Speedtest              Test internet speed" ] &&
l speedtest

[ "$program" = "Steam                  Valve can count to 3" ] &&
l steam

[ "$program" = "Tenacity               Audio editor" ] &&
l tenacity

[ "$program" = "Thunar                 File manager" ] &&
l thunar

[ "$program" = "Timeshift              System restore" ] &&
l timeshift-launcher

[ "$program" = "Tor browser            Web browsing through the Tor network" ] &&
l tor-browser

[ "$program" = "Upscayl                Upscale images" ] &&
l upscayl

[ "$program" = "Vesktop                Discord with built-in Vencord" ] &&
l vesktop

[ "$program" = "Vintage Story          Sandbox game of innovation and exploration" ] &&
l vintagestory

[ "$program" = "Virt Manager           Virtual machines using libvirt (QEMU/KVM)" ] &&
l virt-manager

[ "$program" = "Xclicker               X11/XWayland autoclicker" ] &&
la xclicker DISPLAY=:0 xclicker

[ "$program" = "Xfburn                 Disc burning" ] &&
l xfburn

[ "$program" = "" ] || [ "$program" = "Exit" ] && exit 0