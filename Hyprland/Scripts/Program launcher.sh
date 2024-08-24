#!/usr/bin/env bash

set -euo pipefail

Programs=(
	"                     󰌧  Run launcher                     "
	" "
	"  Alacritty            GPU-accelerated terminal emulator"
	""
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
	"󰍳  Minetest             Open source voxel game engine"
	"󰍳  NBT Explorer         NBT Explorer and editor"
	"  RetroPlus            ROM downloader"
	"  RPCS3                PlayStation 3 emulator"
	"  PCSX2                PlayStation 2/1 emulator"
	"  Steam                Needs a description ?"
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
	"󰒖  Warpinator           Local file sharing"
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
	"  Thunderbird          E-mail client"
	" "
#    "󰪫  Virtualbox           Virtual machines, the classic way"
	"󰪫  Virt Manager         Virtual machines using QEMU/KVM"
	" "
	"󰗼  Exit"
)

Program=$(
	printf '%s\n' "${Programs[@]}" | tofi \
		--width 485 \
		--height 720 \
		--prompt-text " " \
		"${@}"
)

[ "$Program" = " " ] &&
	bash "/etc/nixos/Hyprland/Scripts/Program launcher.sh"

[ "$Program" = "                     󰌧  Run launcher                     " ] &&
	tofi-drun --drun-launch=true & disown

[ "$Program" = "  Alacritty            GPU-accelerated terminal emulator" ] &&
	alacritty & disown

[ "$Program" = "  Amfora               CLI Gemini client" ] &&
	alacritty -e amfora & disown

[ "$Program" = "  Lagrange             GUI Gemini client" ] &&
	lagrange & disown

[ "$Program" = "  Audacious            Music player" ] &&
	audacious & disown

[ "$Program" = "  Audacity             Audio editor" ] &&
	GDK_BACKEND=x11 audacity & disown
#	audacity & disown

[ "$Program" = "  EasyEffects          Effects to inputs or outputs" ] &&
	easyeffects & disown

[ "$Program" = "  EasyTAG              Audio tag editor" ] &&
	easytag & disown

[ "$Program" = "  Pavucontrol          Audio volume manager" ] &&
	pavucontrol & disown

[ "$Program" = "󰤽  qpwgraph             Audio patchbay" ] &&
	qpwgraph & disown

[ "$Program" = "󰂫  Blender              3D modeling" ] &&
	blender & disown

[ "$Program" = "  Cura                 3D printing" ] &&
	QT_QPA_PLATFORM=xcb QT_STYLE_OVERRIDE="" com.ultimaker.cura & disown

[ "$Program" = "  BTOP                 Terminal-based system monitor" ] &&
	alacritty -e btop & disown

[ "$Program" = "  CPU-X                Detailed processor information" ] &&
	st -c CPU-X -g=81x28 -e cpu-x & disown

[ "$Program" = "  Mission Center       GUI-based system monitor" ] &&
	missioncenter & disown

[ "$Program" = "󱌐  Bottles              Run Windows programs in Bottles" ] &&
	com.usebottles.bottles & disown

[ "$Program" = "  Calcurse             Calendar" ] &&
	alacritty -e calcurse & disown

[ "$Program" = "  Clock                GNOME's clock" ] &&
	gnome-clocks & disown

[ "$Program" = "  CUPS                 Printer configuration" ] &&
	xdg-open "https://localhost:631/" & disown

[ "$Program" = "  DeSmuME              Nintendo DS/I emulator" ] &&
	desmume & disown

[ "$Program" = "  Jstest               Gamepad tester" ] &&
	jstest-gtk & disown

[ "$Program" = "󰍳  PrismLauncher        Minecraft Launcher" ] &&
	prismlauncher & disown

[ "$Program" = "󰍳  Minetest             Open source voxel game engine" ] &&
	minetest & disown

[ "$Program" = "󰍳  NBT Explorer         NBT Explorer and editor" ] &&
	page.codeberg.JakobDev.jdNBTExplorer & disown

[ "$Program" = "  RetroPlus            ROM downloader" ] &&
	com.vysp3r.RetroPlus & disown

[ "$Program" = "  RPCS3                PlayStation 3 emulator" ] &&
	net.rpcs3.RPCS3 & disown

[ "$Program" = "  PCSX2                PlayStation 2/1 emulator" ] &&
	net.pcsx2.PCSX2 & disown

[ "$Program" = "  Steam                Needs a description ?" ] &&
	steam & disown
#	nvidia-offload steam & disown

[ "$Program" = "  D.D.D                That's not my neighbor" ] &&
	steam-run "$HOME/Programs/Games/That's not my neighbor/That's not my neighbor.x86_64" & disown
#	nvidia-offload steam-run "$HOME/Programs/That's not my neighbor/That's not my neighbor.x86_64" & disown

[ "$Program" = "󰙯  Vesktop              Discord, but Vencorded" ] &&
#	vesktop --ozone-platform=x11 & disown
	vesktop & disown

[ "$Program" = "󰭻  Element              Actually, no need for spyware" ] &&
	element-desktop --ozone-platform=x11 & disown
#	element-desktop & disown

[ "$Program" = "󰭻  Revolt               FOSS alternative to Discord" ] &&
#	revolt-desktop --ozone-platform=x11 & disown
	revolt-desktop & disown

[ "$Program" = "  Freetube             Watch YouTube videos" ] &&
#	freetube --ozone-platform=x11 & disown
	freetube & disown

[ "$Program" = "󰋊  Gnome disk utility   GNOME's disk utility" ] &&
	gnome-disks & disown

[ "$Program" = "󰋊  Gparted              Partition manager" ] &&
	alacritty -e sudo -E gparted & disown

[ "$Program" = "󰋊  ncdu                 Disk usage" ] &&
	alacritty -e ncdu & disown

[ "$Program" = "  Ventoy               Bootable USB creation tool" ] &&
	alacritty -e sudo ventoy-web & disown

[ "$Program" = "  File roller          Archive manager" ] &&
	file-roller & disown

[ "$Program" = "  Thunar               File manager" ] &&
	thunar & disown

[ "$Program" = "󰒖  Warpinator           Local file sharing" ] &&
	warpinator & disown

[ "$Program" = "  Flatseal             Manage flatpak permissions" ] &&
	com.github.tchx84.Flatseal & disown

[ "$Program" = "  Galculator           Calculator" ] &&
	galculator & disown

[ "$Program" = "  Gcolor               Advanced color picker" ] &&
	gcolor3 & disown

[ "$Program" = "  Hyprpicker           Screen color picker" ] &&
	sleep 1 && \
	Color=$(hyprpicker -f hex --autocopy & disown) &&
	noty-send -t 1000 "$Color copied to clipboard"

[ "$Program" = "  GIMP                 GNU Image Manipulation Program" ] &&
	gimp & disown

[ "$Program" = "  Hyprpaper            Set desktop background/wallpaper" ] &&
	bash "/etc/nixos/Hyprland/Scripts/Hyprpaper.sh" & disown

[ "$Program" = "  Inkscape             Vector image manipulation" ] &&
	inkscape & disown

[ "$Program" = "  Krita                Digital painting" ] &&
	krita & disown

[ "$Program" = "  OpenTabletDriver     Configure your drawing tablet" ] &&
	otd-gui & disown

[ "$Program" = "  Pixelorama           Pixelart tool" ] &&
	pixelorama & disown

[ "$Program" = "  Upscayl              Upscale images" ] &&
	upscayl & disown

[ "$Program" = "  Keymapp              Layout tool for ZSA keyboards" ] &&
	keymapp & disown

[ "$Program" = "󰍽  Xclicker             X11 autocliker (for XWayland)" ] &&
	xclicker & disown

[ "$Program" = "  Kurso de Esperanto   Esperanto learning program" ] &&
	steam-run "$HOME/Programs/Kurso de Esperanto/kursokape" & disown

[ "$Program" = "  KeePassXC            Password manager" ] &&
	keepassxc & disown

[ "$Program" = "  Kdenlive             Video editor" ] &&
	kdenlive & disown

[ "$Program" = "󰑋  OBS studio           Recording and streaming" ] &&
	obs & disown

[ "$Program" = "󰏆  LibreOffice          Office suite" ] &&
	soffice & disown

[ "$Program" = "󰚫  Simple scan          Document scanner" ] &&
	simple-scan & disown

[ "$Program" = "  LibreWolf            Web browser" ] &&
	librewolf & disown

[ "$Program" = "  LibreWolf - private  Web browser (private window)" ] &&
	librewolf --private-window & disown

[ "$Program" = "󰗹  Torbrowser launcher  Tor browser" ] &&
	tor-browser & disown

[ "$Program" = "󰛳  Network Manager      Manage WiFi and Ethernet" ] &&
	alacritty -e nmtui & disown

[ "$Program" = "󰛳  NM-applet            NetworkManager applet" ] &&
	nm-applet & disown

[ "$Program" = "  qBittorrent          Torrent manager" ] &&
	qbittorrent & disown

[ "$Program" = "  Xfburn               Disc burning" ] &&
	xfburn & disown

[ "$Program" = "󰓅  Speedtest            Test internet speed" ] &&
	xyz.ketok.Speedtest & disown

[ "$Program" = "  Thunderbird          E-mail client" ] &&
	thunderbird & disown

[ "$Program" = "󰪫  Virtualbox           Virtual machines, the classic way" ] &&
	VirtualBox & disown

[ "$Program" = "󰪫  Virt Manager         Virtual machines using QEMU/KVM" ] &&
	virt-manager & disown

[ "$Program" = "󰗼  Exit" ] &&
	exit
