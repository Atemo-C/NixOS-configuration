#!/usr/bin/env bash

set -euo pipefail

Programs=(
	"                     󰌧  Run launcher                     "
	" "
	"  Amfora               CLI Gemini client"
	"  Lagrange             GUI Gemini client"
	" "
	"  Audacious            Music player"
	"  Audacity             Audio editor"
	"  EasyEffects          Effects to inputs or outputs"
	"  EasyTAG              Audio tag editor"
	"  Pavucontrol          Audio volume manager"
	"󰤽  qpwgraph             Audio patchbay"
	" "
	"󰂫  Blender              3D modeling"
	"  Cura                 3D printing"
	"󰻬  OpenSCAD             3D CAD modeling"
	" "
	"  BTOP                 Terminal-based system monitor"
	"  CPU-X                Detailed processor information"
	"  Mission Center       GUI-based system monitor"
	" "
	"󱌐  Bottles              Run Windows programs in Bottles"
	" "
	"  Calcurse             Calendar"
	"  Clock                GNOME's clock"
	"  CUPS                 Printer configuration"
	" "
	"  DeSmuME              Nintendo DS/I emulator"
	"  Jstest               Gamepad tester"
	"󰍳  PrismLauncher        Minecraft Launcher"
	"󰍳  Minetest             Minecraft-inspired engine"
	"󰍳  NBT Explorer         NBT Explorer and editor"
	"  RetroPlus            ROM downloader"
#	"  Roblox               Launch the desktop Roblox app"
#	"  Vinegar              Configure how Roblox works"
	"  RPCS3                PlayStation 3 emulator"
	"  PCSX2                PlayStation 2/1 emulator"
	"  Steam                Needs a description ?"
	"󰵹  SuperTuxKart         FOSS Mario-Kart like game"
	"  D.D.D                That's not my neighbor"
	" "
	"󰙯  Vesktop              Discord, but Vencorded"
	"󰭻  Element              Actually, no need for spyware"
	"󰭻  Revolt               FOSS alternative to Discord"
	" "
	"  Freetube             Watch YouTube videos"
	" "
	"󰋊  Gnome disk utility   GNOME's disk utility"
	"󰋊  Gparted              Partition manager"
	"󰋊  ncdu                 Disk usage"
	"  Ventoy               Bootable USB creation tool"
	" "
	"  File roller          Archive manager"
	"  Thunar               File manager"
	" "
	"  Flatseal             Manage flatpak permissions"
	"  Galculator           Calculator"
	" "
	"  Gcolor               Advanced color picker"
	"  Hyprpicker           Screen color picker"
	"  GIMP                 GNU Image Manipulation Program"
	"  Hyprpaper            Set desktop background/wallpaper"
	"  Inkscape             Vector image manipulation"
	"  Krita                Digital painting"
	"  OpenTabletDriver     Configure your drawing tablet"
	"  Pixelorama           Pixelart tool"
	"  Upscayl              Upscale images"
	" "
	"  Keymapp              Layout tool for ZSA keyboards"
	"󰍽  Xclicker             X11 autocliker (for XWayland)"
	" "
	"  Kurso de Esperanto   Esperanto learning program"
	" "
	"  KeePassXC            Password manager"
	" "
	"  Kdenlive             Video editor"
	"󰑋  OBS studio           Recording and streaming"
	" "
	"󰏆  LibreOffice          Office suite"
	"󰚫  Simple scan          Document scanner"
	" "
	"  LibreWolf            Web browser"
	"  LibreWolf - private  Web browser (private window)"
	"󰗹  Torbrowser launcher  Tor browser"
	" "
	"󰛳  Network Manager      Manage WiFi and Ethernet"
	"󰛳  NM-applet            NetworkManager applet"
	" "
	"  qBittorrent          Torrent manager"
	"  Xfburn               Disc burning"
	" "
	"󰓅  Speedtest            Test internet speed"
	" "
	"  ST                   Suckless terminal emulator"
	" "
	"  Thunderbird          E-mail client"
	" "
#    "󰪫  Virtualbox           Virtual machines, the classic way"
	"󰪫  Virt Manager         Virtual machines using QEMU/KVM"
	" "
	"󰗼  Exit"
)

Program=$(
	printf '%s\n' "${Programs[@]}" | tofi \
		--font /run/current-system/sw/share/X11/fonts/UbuntuMonoNerdFontMono-Regular.ttf \
		--font-size 14 \
		--width 545 \
		--height 720 \
		--prompt-text " " \
		"${@}"
)

if [ "$Program" = " " ]; then
	bash "$HOME/Programs/Scripts/Desktop scripts/Program launcher.sh"

elif [ "$Program" = "                     󰌧  Run launcher                     " ]; then
	tofi-drun --drun-launch=true & disown

elif [ "$Program" = "  Amfora               CLI Gemini client" ]; then
	st -e amfora & disown

elif [ "$Program" = "  Lagrange             GUI Gemini client" ]; then
	lagrange & disown

elif [ "$Program" = "  Audacious            Music player" ]; then
	audacious & disown

elif [ "$Program" = "  Audacity             Audio editor" ]; then
	GDK_BACKEND=x11 audacity & disown
#	audacity & disown

elif [ "$Program" = "  EasyEffects          Effects to inputs or outputs" ]; then
	easyeffects & disown

elif [ "$Program" = "  EasyTAG              Audio tag editor" ]; then
	easytag & disown

elif [ "$Program" = "  Pavucontrol          Audio volume manager" ]; then
	pavucontrol & disown

elif [ "$Program" = "󰤽  qpwgraph             Audio patchbay" ]; then
	qpwgraph & disown

elif [ "$Program" = "󰂫  Blender              3D modeling" ]; then
	blender & disown

elif [ "$Program" = "  Cura                 3D printing" ]; then
	QT_QPA_PLATFORM=xcb QT_STYLE_OVERRIDE="" com.ultimaker.cura & disown

elif [ "$Program" = "󰻬  OpenSCAD             3D CAD modeling" ]; then
	openscad & disown

elif [ "$Program" = "  BTOP                 Terminal-based system monitor" ]; then
	st -e btop & disown

elif [ "$Program" = "  CPU-X                Detailed processor information" ]; then
	st -c CPU-X -g=81x28 -e cpu-x & disown

elif [ "$Program" = "  Mission Center       GUI-based system monitor" ]; then
	missioncenter & disown

elif [ "$Program" = "󱌐  Bottles              Run Windows programs in Bottles" ]; then
	com.usebottles.bottles & disown

elif [ "$Program" = "  Calcurse             Calendar" ]; then
	st -e calcurse & disown

elif [ "$Program" = "  Clock                GNOME's clock" ]; then
	gnome-clocks & disown

elif [ "$Program" = "  CUPS                 Printer configuration" ]; then
	xdg-open "https://localhost:631/" & disown

elif [ "$Program" = "  DeSmuME              Nintendo DS/I emulator" ]; then
	desmume & disown

elif [ "$Program" = "  Jstest               Gamepad tester" ]; then
	jstest-gtk & disown

elif [ "$Program" = "󰍳  PrismLauncher        Minecraft Launcher" ]; then
	prismlauncher & disown

elif [ "$Program" = "󰍳  Minetest             Minecraft-inspired engine" ]; then
#	minetest & disown
	nvidia-offload minetest & disown

elif [ "$Program" = "󰍳  NBT Explorer         NBT Explorer and editor" ]; then
	page.codeberg.JakobDev.jdNBTExplorer & disown

elif [ "$Program" = "  RetroPlus            ROM downloader" ]; then
	com.vysp3r.RetroPlus & disown

elif [ "$Program" = "  Roblox               Launch the desktop Roblox app" ]; then
	org.vinegarhq.Vinegar player run & disown

elif [ "$Program" = "  Vinegar              Configure how Roblox works" ]; then
	st -e org.vinegarhq.Vinegar edit & disown

elif [ "$Program" = "  RPCS3                PlayStation 3 emulator" ]; then
	net.rpcs3.RPCS3 & disown

elif [ "$Program" = "  PCSX2                PlayStation 2/1 emulator" ]; then
	net.pcsx2.PCSX2 & disown

elif [ "$Program" = "  Steam                Needs a description ?" ]; then
#	steam & disown
	nvidia-offload steam & disown

elif [ "$Program" = "󰵹  SuperTuxKart         FOSS Mario-Kart like game" ]; then
#	supertuxkart & disown
	nvidia-offload supertuxkart & disown

elif [ "$Program" = "  D.D.D                That's not my neighbor" ]; then
#	steam-run "$HOME/Programs/Games/That's not my neighbor/That's not my neighbor.x86_64" & disown
	nvidia-offload steam-run "$HOME/Programs/Games/That's not my neighbor/That's not my neighbor.x86_64" & disown

elif [ "$Program" = "󰙯  Vesktop              Discord, but Vencorded" ]; then
#	vesktop --ozone-platform=x11 & disown
	vesktop & disown

elif [ "$Program" = "󰭻  Element              Actually, no need for spyware" ]; then
	element-desktop --ozone-platform=x11 & disown
#	element-desktop & disown

elif [ "$Program" = "󰭻  Revolt               FOSS alternative to Discord" ]; then
#	revolt-desktop --ozone-platform=x11 & disown
	revolt-desktop & disown

elif [ "$Program" = "  Freetube             Watch YouTube videos" ]; then
#	freetube --ozone-platform=x11 & disown
	freetube & disown

elif [ "$Program" = "󰋊  Gnome disk utility   GNOME's disk utility" ]; then
	gnome-disks & disown

elif [ "$Program" = "󰋊  Gparted              Partition manager" ]; then
	pkexec gparted & disown

elif [ "$Program" = "󰋊  ncdu                 Disk usage" ]; then
	st -e ncdu & disown

elif [ "$Program" = "  Ventoy               Bootable USB creation tool" ]; then
	st -e sudo ventoy-web & disown

elif [ "$Program" = "  File roller          Archive manager" ]; then
	file-roller & disown

elif [ "$Program" = "  Thunar               File manager" ]; then
	thunar & disown

elif [ "$Program" = "  Flatseal             Manage flatpak permissions" ]; then
	com.github.tchx84.Flatseal & disown

elif [ "$Program" = "  Galculator           Calculator" ]; then
	galculator & disown

elif [ "$Program" = "  Gcolor               Advanced color picker" ]; then
	gcolor3 & disown

elif [ "$Program" = "  Hyprpicker           Screen color picker" ]; then
	sleep 1 && \
	Color=$(hyprpicker -f hex --autocopy & disown) &&
	notify-send -t 1000 "$Color copied to clipboard"

elif [ "$Program" = "  GIMP                 GNU Image Manipulation Program" ]; then
	gimp & disown

elif [ "$Program" = "  Hyprpaper            Set desktop background/wallpaper" ]; then
	bash "$HOME/Programs/Scripts/Desktop scripts/Hyprpaper.sh" & disown

elif [ "$Program" = "  Inkscape             Vector image manipulation" ]; then
	inkscape & disown

elif [ "$Program" = "  Krita                Digital painting" ]; then
	krita & disown

elif [ "$Program" = "  OpenTabletDriver     Configure your drawing tablet" ]; then
	otd-gui & disown

elif [ "$Program" = "  Pixelorama           Pixelart tool" ]; then
	pixelorama & disown

elif [ "$Program" = "  Upscayl              Upscale images" ]; then
	upscayl & disown

elif [ "$Program" = "  Keymapp              Layout tool for ZSA keyboards" ]; then
	keymapp & disown

elif [ "$Program" = "󰍽  Xclicker             X11 autocliker (for XWayland)" ]; then
	xclicker & disown

elif [ "$Program" = "  Kurso de Esperanto   Esperanto learning program" ]; then
	steam-run "$HOME/Programs/Kurso de Esperanto/kursokape" & disown

elif [ "$Program" = "  KeePassXC            Password manager" ]; then
	keepassxc & disown

elif [ "$Program" = "  Kdenlive             Video editor" ]; then
	kdenlive & disown

elif [ "$Program" = "󰑋  OBS studio           Recording and streaming" ]; then
	obs & disown

elif [ "$Program" = "󰏆  LibreOffice          Office suite" ]; then
	soffice & disown

elif [ "$Program" = "󰚫  Simple scan          Document scanner" ]; then
	simple-scan & disown

elif [ "$Program" = "  LibreWolf            Web browser" ]; then
	librewolf & disown

elif [ "$Program" = "  LibreWolf - private  Web browser (private window)" ]; then
	librewolf --private-window & disown

elif [ "$Program" = "󰗹  Torbrowser launcher  Tor browser" ]; then
	tor-browser & disown

elif [ "$Program" = "󰛳  Network Manager      Manage WiFi and Ethernet" ]; then
	st -e nmtui & disown

elif [ "$Program" = "󰛳  NM-applet            NetworkManager applet" ]; then
	nm-applet & disown

elif [ "$Program" = "  qBittorrent          Torrent manager" ]; then
	qbittorrent & disown

elif [ "$Program" = "  Xfburn               Disc burning" ]; then
	xfburn & disown

elif [ "$Program" = "󰓅  Speedtest            Test internet speed" ]; then
	xyz.ketok.Speedtest & disown

elif [ "$Program" = "  ST                   Suckless terminal emulator" ]; then
	st & disown

elif [ "$Program" = "  Thunderbird          E-mail client" ]; then
	thunderbird & disown

elif [ "$Program" = "󰪫  Virtualbox           Virtual machines, the classic way" ]; then
	VirtualBox & disown

elif [ "$Program" = "󰪫  Virt Manager         Virtual machines using QEMU/KVM" ]; then
	virt-manager & disown

elif [ "$Program" = "󰗼  Exit" ]; then
	exit

fi
