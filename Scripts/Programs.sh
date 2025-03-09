#!/usr/bin/env bash

set -euo pipefail

Programs=(
	"                     󰌧  Run launcher                     "
	" "
	"  Alacritty            GPU-accelerated terminal emulator"
	"  LXTerminal           Lightweight VTE terminal emulator"
	""
	" "
	"  Amfora               CLI Gemini client"
	"  Lagrange             GUI Gemini client"
	" "
	"  Audacious            Music player"
	"  EasyEffects          Effects to inputs or outputs"
	"  EasyTAG              Audio tag editor"
	"  Pavucontrol          Audio volume manager"
	"󰤽  qpwgraph             Audio patchbay"
	"  Tenacity             Audio editor"
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
	"  Enable crosshair     A simple red-dot crosshair"
	"󰽅  Disable crosshair    Closes the active crosshair/s"
	"  DeSmuME              Nintendo DS/I emulator"
	"  DuckStation          Playstation 1 emulator"
	"  PCSX2                PlayStation 2 emulator"
	"  RPCS3                PlayStation 3 emulator"
	"󰍳  PrismLauncher        Minecraft Launcher"
	"󰍳  Luanti (minetest)    Open source voxel game engine"
	"󰍳  NBT Explorer         NBT Explorer and editor"
	"  Sober                Roblox client"
	"  Steam                Valve winning by doing nothing"
	"  D.D.D                That's not my neighbor"
	" "
	"  Jstest               Gamepad / controller tester"
	"  Keymapp              Layout tool for ZSA keyboards"
	"  SC-Controller        Remap controllers in userspace"
	"󰍽  Xclicker             X11 autocliker (for XWayland)"
	" "
	"󰙯  Vesktop              Discord, but Vencorded"
	"󰭻  Element              Matrix client"
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
	"  Krita                Digital painting"
	"  OpenTabletDriver     Configure your drawing tablet"
	"  Upscayl              Upscale images"
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
	nohup bash "/etc/nixos/Scripts/Program launcher.sh" > /dev/null 2>&1 &

[ "$Program" = "                     󰌧  Run launcher                     " ] &&
	nohup tofi-drun --drun-launch=true > /dev/null 2>&1 &

[ "$Program" = "  Alacritty            GPU-accelerated terminal emulator" ] &&
	nohup alacritty > /dev/null 2>&1 &

[ "$Program" = "  LXTerminal           Lightweight VTE terminal emulator" ] &&
	nohup lxterminal > /dev/null 2>&1 &

[ "$Program" = "  Amfora               CLI Gemini client" ] &&
	nohup $TERMINAL -e amfora > /dev/null 2>&1 &

[ "$Program" = "  Lagrange             GUI Gemini client" ] &&
	nohup lagrange > /dev/null 2>&1 &

[ "$Program" = "  Audacious            Music player" ] &&
	nohup audacious > /dev/null 2>&1 &

[ "$Program" = "  EasyEffects          Effects to inputs or outputs" ] &&
	nohup easyeffects > /dev/null 2>&1 &

[ "$Program" = "  EasyTAG              Audio tag editor" ] &&
	nohup easytag > /dev/null 2>&1 &

[ "$Program" = "  Pavucontrol          Audio volume manager" ] &&
	nohup pavucontrol > /dev/null 2>&1 &

[ "$Program" = "󰤽  qpwgraph             Audio patchbay" ] &&
	nohup qpwgraph > /dev/null 2>&1 &

[ "$Program" = "  Tenacity             Audio editor" ] &&
	nohup GDK_BACKEND=x11 tenacity > /dev/null 2>&1 &
#	nohup tenacity > /dev/null 2>&1 &

[ "$Program" = "󰂫  Blender              3D modeling" ] &&
	nohup blender > /dev/null 2>&1 &

[ "$Program" = "  Cura                 3D printing" ] &&
	nohup com.ultimaker.cura > /dev/null 2>&1 &

[ "$Program" = "  BTOP                 Terminal-based system monitor" ] &&
	nohup $TERMINAL -e btop > /dev/null 2>&1 &

[ "$Program" = "  CPU-X                Detailed processor information" ] &&
	nohup cpu-x > /dev/null 2>&1 &

[ "$Program" = "  Mission Center       GUI-based system monitor" ] &&
	nohup missioncenter > /dev/null 2>&1 &

[ "$Program" = "󱌐  Bottles              Run Windows programs in Bottles" ] &&
	nohup bottles > /dev/null 2>&1 &

[ "$Program" = "  Calcurse             Calendar" ] &&
	nohup $TERMINAL -e calcurse > /dev/null 2>&1 &

[ "$Program" = "  Clock                GNOME's clock" ] &&
	nohup gnome-clocks > /dev/null 2>&1 &

[ "$Program" = "  CUPS                 Printer configuration" ] &&
	nohup xdg-open "https://localhost:631/" > /dev/null 2>&1 &

[ "$Program" = "  Enable crosshair     A simple red-dot crosshair" ] &&
	nohup dash /etc/nixos/Scripts/Crosshair/Crosshair-start.sh > /dev/null 2

[ "$Program" = "󰽅  Disable crosshair    Closes the active crosshair/s" ] &&
	nohup dash /etc/nixos/Scripts/Crosshair/Crosshair-kill.sh > /dev/null 2

[ "$Program" = "  DeSmuME              Nintendo DS/I emulator" ] &&
	nohup desmume > /dev/null 2>&1 &

[ "$Program" = "  DuckStation          Playstation 1 emulator" ] &&
	nohup duckstation > /dev/null 2>&1 &

[ "$Program" = "  PCSX2                PlayStation 2/1 emulator" ] &&
	nohup pcsx2-qt > /dev/null 2>&1 &

[ "$Program" = "  RPCS3                PlayStation 3 emulator" ] &&
	nohup rpcs3 > /dev/null 2>&1 &

[ "$Program" = "󰍳  PrismLauncher        Minecraft Launcher" ] &&
	nohup prismlauncher > /dev/null 2>&1 &

[ "$Program" = "󰍳  Luanti (minetest)    Open source voxel game engine" ] &&
	nohup luanti > /dev/null 2>&1 &

[ "$Program" = "󰍳  NBT Explorer         NBT Explorer and editor" ] &&
	nohup page.codeberg.JakobDev.jdNBTExplorer > /dev/null 2>&1 &

[ "$Program" = "  Sober                Roblox client" ] &&
	nohup org.vinegarhq.Sober > /dev/null 2>&1 &

[ "$Program" = "  Steam                Valve winning by doing nothing" ] &&
	nohup steam > /dev/null 2>&1 &
#	nohup nvidia-offload steam > /dev/null 2>&1 &

[ "$Program" = "  D.D.D                That's not my neighbor" ] &&
	nohup steam-run "$HOME/Programs/That's not my neighbor/That's not my neighbor.x86_64" > /dev/null 2>&1 &
#	nohup nvidia-offload steam-run "$HOME/Programs/That's not my neighbor/That's not my neighbor.x86_64" > /dev/null 2>&1 &

[ "$Program" = "  Jstest               Gamepad / controller tester" ] &&
	nohup jstest-gtk > /dev/null 2>&1 &

[ "$Program" = "  Keymapp              Layout tool for ZSA keyboards" ] &&
	nohup keymapp > /dev/null 2>&1 &

[ "$Program" = "  SC-Controller        Remap controllers in userspace" ] &&
	nohup sc-controller > /dev/null 2>&1 &

[ "$Program" = "󰍽  Xclicker             X11 autocliker (for XWayland)" ] &&
	nohup xclicker > /dev/null 2>&1 &

[ "$Program" = "󰙯  Vesktop              Discord, but Vencorded" ] &&
	nohup vesktop --ozone-platform=x11 > /dev/null 2>&1 &
#	nohup vesktop --ozone-platform=wayland > /dev/null 2>&1 &

[ "$Program" = "󰭻  Element              Matrix client" ] &&
	nohup librewolf --new-window "https://app.element.io/" > /dev/null 2>&1 &

[ "$Program" = "󰭻  Revolt               FOSS alternative to Discord" ] &&
	nohup revolt-desktop --ozone-platform=x11 > /dev/null 2>&1 &
#	nohup revolt-desktop --ozone-platform=wayland > /dev/null 2>&1 &

[ "$Program" = "  Freetube             Watch YouTube videos" ] &&
	nohup freetube --ozone-platform=x11 > /dev/null 2>&1 &
#	nohup freetube --ozone-platform=wayland > /dev/null 2>&1 &

[ "$Program" = "󰋊  Gnome disk utility   GNOME's disk utility" ] &&
	nohup gnome-disks > /dev/null 2>&1 &

[ "$Program" = "󰋊  Gparted              Partition manager" ] &&
	nohup gparted > /dev/null 2>&1 &

[ "$Program" = "󰋊  ncdu                 Disk usage" ] &&
	nohup $TERMINAL -e ncdu > /dev/null 2>&1 &

[ "$Program" = "  Ventoy               Bootable USB creation tool" ] &&
	nohup $TERMINAL -e sudo ventoy-web > /dev/null 2>&1 &

[ "$Program" = "  File roller          Archive manager" ] &&
	nohup file-roller > /dev/null 2>&1 &

[ "$Program" = "  Thunar               File manager" ] &&
	nohup thunar > /dev/null 2>&1 &

[ "$Program" = "󰒖  Warpinator           Local file sharing" ] &&
	nohup warpinator > /dev/null 2>&1 &

[ "$Program" = "  Flatseal             Manage flatpak permissions" ] &&
	nohup com.github.tchx84.Flatseal > /dev/null 2>&1 &

[ "$Program" = "  Galculator           Calculator" ] &&
	nohup galculator > /dev/null 2>&1 &

[ "$Program" = "  Gcolor               Advanced color picker" ] &&
	nohup gcolor3 > /dev/null 2>&1 &

[ "$Program" = "  Hyprpicker           Screen color picker" ] &&
	sleep 1 && \
	Color=$(hyprpicker -f hex --autocopy ) &&
	noty-send -t 1000 "$Color copied to clipboard"

[ "$Program" = "  GIMP                 GNU Image Manipulation Program" ] &&
	nohup gimp > /dev/null 2>&1 &

[ "$Program" = "  Hyprpaper            Set desktop background/wallpaper" ] &&
	nohup bash "/etc/nixos/Scripts/Hyprpaper.sh" > /dev/null 2>&1 &

[ "$Program" = "  Krita                Digital painting" ] &&
	nohup krita > /dev/null 2>&1 &

[ "$Program" = "  OpenTabletDriver     Configure your drawing tablet" ] &&
	nohup otd-gui > /dev/null 2>&1 &

[ "$Program" = "  Upscayl              Upscale images" ] &&
	nohup upscayl > /dev/null 2>&1 &

[ "$Program" = "  Kurso de Esperanto   Esperanto learning program" ] &&
	QT_QPA_PLATFORM=xcb nohup steam-run "$HOME/Programs/Kurso de Esperanto/kursokape" > /dev/null 2>&1 &

[ "$Program" = "  KeePassXC            Password manager" ] &&
	nohup keepassxc > /dev/null 2>&1 &

[ "$Program" = "  Kdenlive             Video editor" ] &&
	nohup kdenlive > /dev/null 2>&1 &

[ "$Program" = "󰑋  OBS studio           Recording and streaming" ] &&
	nohup com.obsproject.Studio > /dev/null 2>&1 &

[ "$Program" = "󰏆  LibreOffice          Office suite" ] &&
	nohup soffice > /dev/null 2>&1 &

[ "$Program" = "󰚫  Simple scan          Document scanner" ] &&
	nohup simple-scan > /dev/null 2>&1 &

[ "$Program" = "  LibreWolf            Web browser" ] &&
	nohup librewolf > /dev/null 2>&1 &

[ "$Program" = "  LibreWolf - private  Web browser (private window)" ] &&
	nohup librewolf --private-window > /dev/null 2>&1 &

[ "$Program" = "󰗹  Torbrowser launcher  Tor browser" ] &&
	nohup tor-browser > /dev/null 2>&1 &

[ "$Program" = "󰛳  Network Manager      Manage WiFi and Ethernet" ] &&
	nohup $TERMINAL -e nmtui > /dev/null 2>&1 &

[ "$Program" = "󰛳  NM-applet            NetworkManager applet" ] &&
	nohup nm-applet > /dev/null 2>&1 &

[ "$Program" = "  qBittorrent          Torrent manager" ] &&
	nohup qbittorrent > /dev/null 2>&1 &

[ "$Program" = "  Xfburn               Disc burning" ] &&
	nohup xfburn > /dev/null 2>&1 &

[ "$Program" = "󰓅  Speedtest            Test internet speed" ] &&
	nohup speedtest > /dev/null 2>&1 &

[ "$Program" = "󰪫  Virt Manager         Virtual machines using QEMU/KVM" ] &&
	nohup virt-manager > /dev/null 2>&1 &

[ "$Program" = "󰗼  Exit" ] &&
	exit
