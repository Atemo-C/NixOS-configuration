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
	printf "The fuzzel menu program was not found; The program menu cannot be displayed.\n"
	exit 1
}

# Function to start a selected program by its executable name.
l() {
	if command -v "$1" >/dev/null 2>&1;
	then
		nohup "$1" >/dev/null 2>&1 &
		exit 0
	else
		printf "%s not found; Is it installed?\n" "$1"
		exit 1
	fi
}

# Function to start a selected program with command-line arguments.
la() {
	if command -v "$1" >/dev/null 2>&1;
	then
		shift
		nohup "$@" >/dev/null 2>&1 &
		exit 0
	else
		printf "%s not found; Is it installed?\n" "$1"
		exit 1
	fi
}

# Function to start a selected program not in default execuatble paths.
lc() {
	if [ -f "$1" ] && [ -x "$1" ];
	then
		shift
		nohup "$@" >/dev/null 2>&1 &
		exit 0
	else
		printf "%s not found; Does the executable exist, and is it executable?\n" "$1"
		exit 1
	fi
}

# Loop for the program menu and selection.
while :; do
	# The program list.
	choice=$({
		printf "%b\n" "Run launcher\000icon\037application-default-icon"
		printf "%b\n" " ‎"
		printf "%b\n" "Amfora                 Terminal Gemini client\000icon\037rocket"
		printf "%b\n" "Audacious              Audio player\000icon\037audacious"
		printf "%b\n" "Audacity               Audio editor\000icon\037audacity"
		printf "%b\n" "Blender                3D modeling and animation\000icon\037blender"
		printf "%b\n" "Bottles               Run Windows programs in Bottles\000icon\037com.usebottles.bottles"
		printf "%b\n" "BTOP++                 Terminal system monitor\000icon\037btop"
		printf "%b\n" "Calculator             Terminal calculator\000icon\037accessories-calculator"
		printf "%b\n" "Calcurse               Terminal calendar\000icon\037calendar"
		printf "%b\n" "Character map          Browse charcaters\000icon\037accessories-character-map"
		printf "%b\n" "CPU-X                  Detailed processor information\000icon\037cpu"
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
		printf "%b\n" "Heroic                 Launcher for GOG, Epic, Amazon games\000icon\037com.heroicgameslauncher.hgl"
		printf "%b\n" "Inkscape               Vector graphics (SVG) editor\000icon\037inkscape"
		printf "%b\n" "jdNBTExplorer          Minecraft NBT explorer and editor\000icon\037dconf-editor"
		printf "%b\n" "jstest-gtk             Gamepad/controller tester\000icon\037games"
		printf "%b\n" "Kdenlive               Video editor\000icon\037kdenlive"
		printf "%b\n" "KeePassXC              Password manager\000icon\037keepassxc"
		printf "%b\n" "Keymapp                Layout and heatmap tool for ZSA keyboards\000icon\037input-keyboard"
		printf "%b\n" "Keypunch               Typing speed tests\000icon\037dev.bragefuglseth.Keypunch.Devel"
		printf "%b\n" "Krita                  Digital painting\000icon\037krita"
		printf "%b\n" "Kurso de Esperanto     Esperanto learning program\000icon\037preferences-desktop-locale"
		printf "%b\n" "LACT                   Configure and overclock GPUs\000icon\037hardware"
		printf "%b\n" "Lagrange               Graphical Gemini client\000icon\037fi.skyjake.Lagrange"
		printf "%b\n" "LibreOffice            Office suite\000icon\037libreoffice"
		printf "%b\n" "LibreOffice Base       · Databases\000icon\037libreoffice-base"
		printf "%b\n" "LibreOffice Calc       · Spreadsheets\000icon\037libreoffice-calc"
		printf "%b\n" "LibreOffice Draw       · Drawing\000icon\037libreoffice-draw"
		printf "%b\n" "LibreOffice Math       · Mathematics\000icon\037libreoffice-math"
		printf "%b\n" "LibreOffice Writer     · Word processing\000icon\037libreoffice-writer"
		printf "%b\n" "LibreOffice Impress    · Presentations\000icon\037libreoffice-impress"
		printf "%b\n" "LibreWolf              Web browser\000icon\037librewolf"
		printf "%b\n" "LibreWolf - private    Web browser (private window)\000icon\037view-private"
		printf "%b\n" "Luanti (Minetest)      Open-source voxel game engine\000icon\037minetest"
		printf "%b\n" "Lutris                Gaming platform and collection\000icon\037lutris"
		printf "%b\n" "mGBA                   Modern GBA emulator with a focus on accuracy\000icon\037mgba"
		printf "%b\n" "Micro                  Terminal text editor\000icon\037micro"
		printf "%b\n" "Minder                 Mind-mapping utility\000icon\037com.github.phase1geo.minder"
		printf "%b\n" "Mission Center         Graphical system monitor\000icon\037utilities-system-monitor"
		printf "%b\n" "ncdu                   Terminal disk usage analyzer\000icon\037disk-usage-analyzer"
		printf "%b\n" "NixOS manual           Offline manual for NixOS\000icon\037help-browser"
		printf "%b\n" "NVIDIA settings        NVIDIA GPU control panel\000icon\037nvidia"
		printf "%b\n" "OBS Studio             Video recording and streaming\000icon\037obs"
		printf "%b\n" "OpenTabletDriver       Configure connected drawing tablets\000icon\037input-tablet"
		printf "%b\n" "PCSX2                  PlayStation 2 emulator\000icon\037pcsx2"
		printf "%b\n" "PrismLauncher          Minecraft launcher\000icon\037minecraft"
		printf "%b\n" "Power                  Suspend, reboot, power off…\000icon\037system-shutdown"
		printf "%b\n" "pwvucontrol            Audio volume control\000icon\037preferences-desktop-sound"
		printf "%b\n" "qBittorrent            Torrent manager\000icon\037transmission"
		printf "%b\n" "qpwgraph               PipeWire patchbay\000icon\037org.rncbc.qpwgraph"
		printf "%b\n" "Revolt                 FOSS alternative to Discord\000icon\037revolt-desktop"
		printf "%b\n" "RPCS3                  PlayStation 3 emulator\000icon\037rpcs3"
		printf "%b\n" "Ruffle                 Adobe Flash emulator\000icon\037rs.ruffle.Ruffle"
		printf "%b\n" "Speedtest              Test internet speed\000icon\037xyz.ketok.Speedtest"
		printf "%b\n" "Steam                  Valve can count to 3\000icon\037steam"
		printf "%b\n" "Thunar                 File manager\000icon\037system-file-manager"
		printf "%b\n" "Tor browser            Web browsing through the Tor network\000icon\037browser-tor"
		printf "%b\n" "Upscayl                Upscale images\000icon\037org.upscayl.Upscayl"
		printf "%b\n" "Vintage Story          Sandbox game of innovation and exploration\000icon\037vintagestory"
		printf "%b\n" "Virt Manager           Virtual machines using libvirt (QEMU/KVM)\000icon\037virt-manager"
		printf "%b\n" "Xemu                   Original Xbox emulator\000icon\037xemu"
		printf "%b\n" "Xfburn                 Disc burning\000icon\037stock_xfburn"
		printf "\n"
		printf "%b\n" "Exit\000icon\037x"
	} | fuzzel --lines 24 --width 63 --dmenu)

	# Start the proper program for the selection.
	case "$choice" in
		"Run launcher") l fuzzel;;
		"Amfora                 Terminal Gemini client") la amfora xdg-terminal-exec amfora;;
		"Audacious              Audio player") l audacious;;
		"Audacity               Audio editor") l audacity;;
		"Blender                3D modeling and animation") l blender;;
		"Bottles               Run Windows programs in Bottles") l com.usebottles.bottles;;
		"BTOP++                 Terminal system monitor") la btop xdg-terminal-exec btop;;

		"Calculator             Terminal calculator")
			lc /etc/nixos/scripts/calculator.sh \
			xdg-terminal-exec --app-id "dash-calculator.sh" \
			--window-size-chars 54x22 /etc/nixos/scripts/calculator.sh
		;;

		"Calcurse               Terminal calendar") la calcurse xdg-terminal-exec calcurse;;
		"Character map          Browse charcaters") l gucharmap;;
		"CPU-X                  Detailed processor information") l cpu-x;;

		"Crosshair ON           Activate a red-dot crosshair")
			lc /etc/nixos/scrips/crosshair/eww.yuck \
			eww -c /etc/nixos/scripts/crosshair/ open crosshair
		;;

		"Crosshair OFF          Disable a red-dot crosshair")
			lc /etc/nixos/scrips/crosshair/eww.yuck \
			eww -c /etc/nixos/scripts/crosshair/ close crosshair
		;;

		"CUPS                   Printer/scanner configuration") la cupsd xdg-open "http://localhost:631";;
		"DeSmuME                Nintendo DS(i) emulator") l desmume;;
		"Disks                  GNOME's disks utility") l gnome-disks;;
		"Simple Scan            Document scanner") l simple-scan;;
		"Easy Effects           Live audio effects") l easyeffects;;
		"EasyTag                Audio tag editor") l easytag;;
		"Element                Matrix client") l element-desktop;;
		"Flatseal              Manage Flatpak permissions") l com.github.tchx84.Flatseal;;
		"Foot (client)          Terminal emulator") l footclient;;
		"Foot (standalone)      Terminal emulator") l foot;;
		"Gcolor3                Advanced color picker") l gcolor3;;
		"GIMP                   GNU Image Manipulation Program") l gimp;;
		"Gparted                Partition manager") l gparted;;
		"Heroic                 Launcher for GOG, Epic, Amazon games") l heroic;;
		"Inkscape               Vector graphics (SVG) editor") l inkscape;;
		"jdNBTExplorer          Minecraft NBT explorer and editor") l page.codeberg.JakobDev.jdNBTExplorer;;
		"jstest-gtk             Gamepad/controller tester") l jstest-gtk;;
		"Kdenlive               Video editor") l kdenlive;;
		"KeePassXC              Password manager") l keepassxc;;
		"Keymapp                Layout and heatmap tool for ZSA keyboards") l keymapp;;
		"Keypunch               Typing speed tests") l keypunch;;
		"Krita                  Digital painting") l krita;;

		"Kurso de Esperanto     Esperanto learning program")
			lc "$HOME/Programs/Kurso de Esperanto/kursokape" \
			"$HOME/Programs/Kurso de Esperanto/kursokape"
		;;

		"LACT                   Configure and overclock GPUs") l lact;;
		"Lagrange               Graphical Gemini client") l lagrange;;
		"LibreOffice            Office suite") l libreoffice;;
		"LibreOffice Base       · Databases") la libreoffice libreoffice --base;;
		"LibreOffice Calc       · Spreadsheets") la libreoffice libreoffice --calc;;
		"LibreOffice Draw       · Drawing") la libreoffice libreoffice --draw;;
		"LibreOffice Math       · Mathematics") la libreoffice libreoffice --math;;
		"LibreOffice Writer     · Word processing") la libreoffice libreoffice --writer;;
		"LibreOffice Impress    · Presentation") la libreoffice libreoffice --impress;;
		"LibreWolf              Web browser") l librewolf --new-window;;
		"LibreWolf - private    Web browser (private window)") la librewolf librewolf --private-window;;
		"Luanti (Minetest)      Open-source voxel game engine") l luanti;;
		"Lutris                Gaming platform and collection") l net.lutris.Lutris;;
		"mGBA                   Modern GBA emulator with a focus on accuracy") l mgba-qt;;
		"Micro                  Terminal text editor" ) la micro xdg-terminal-exec micro;;
		"Minder                 Mind-mapping utility") l minder;;
		"Mission Center         Graphical system monitor") l missioncenter;;
		"ncdu                   Terminal disk usage analyzer") la ncdu xdg-terminal-exec ncdu "$HOME/";;
		"NixOS manual           Offline manual for NixOS") la nix "$BROWSER" /run/current-system/sw/share/doc/nixos/index.html;;
		"NVIDIA settings        NVIDIA GPU control panel") l nvidia-settings;;
		"OBS Studio             Video recording and streaming") l obs;;
		"OpenTabletDriver       Configure connected drawing tablets") l otg-gui;;
		"PCSX2                  PlayStation 2 emulator") l pcsx2-qt;;
		"PrismLauncher          Minecraft launcher") l prismlauncher;;

		"Power                  Suspend, reboot, power off…")
			lc /etc/nixos/scripts/power/power-menu.sh \
			/etc/nixos/scripts/power/power-menu.sh
		;;

		"pwvucontrol            Audio volume control") l pwvucontrol;;
		"qBittorrent            Torrent manager") l qbittorrent;;
		"qpwgraph               PipeWire patchbay") l qpwgraph;;
		"Revolt                 FOSS alternative to Discord") l revolt-desktop;;
		"RPCS3                  PlayStation 3 emulator") l rpcs3;;
		"Ruffle                 Adobe Flash emulator") l ruffle;;
		"Speedtest              Test internet speed") l speedtest;;
		"Steam                  Valve can count to 3") l steam;;
		"Thunar                 File manager") l thunar;;
		"Tor browser            Web browsing through the Tor network") l tor-browser;;
		"Upscayl                Upscale images") l upscayl;;
		"Vintage Story          Sandbox game of innovation and exploration") l vintagestory;;
		"Virt Manager           Virtual machines using libvirt (QEMU/KVM)") l virt-manager;;
		"Xemu                   Original Xbox emulator") l xemu;;
		"Xfburn                 Disc burning") l xfburn;;

		# Loop back.
		" ‎") continue;;

		# Exit the script.
		"Exit"|"") exit 0;;
	esac
done