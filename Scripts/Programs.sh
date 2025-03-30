#!/bin/dash

# Defines the height of the program menu in accordance with the screen resolution.
#---#
# List monitors.
# List the 20 lines above "focused: yes".
# Reverse the sorting order.
# Grep any lines with x.
# Keep only the first one.
# Trim the output so that it only keeps the vertical resolution.
# Remove some space for the bar and neat gaps.
Get_vertical=$(hyprctl monitors | grep -B20 "focused: yes" | tac | grep x | head -n 1 | awk -F 'x|@' '{print $2
}')
Gap="84"
Vertical=$(( $Get_vertical - $Gap ))

# A neat shortening of paths.
HM="$HOME/.nix-profile/bin"
SW="/run/current-system/sw/bin"
UF="$HOME/.local/share/flatpak/app"
HP="$HOME/Programs"

# Creates the Programs list, filled by the detected programs below.
Programs="
                     󰌧  Run launcher
 ‎
"

# Detection of all possible programs used in this script.
# If they are not detected, they are not added to the list.
# Some are manually added (e.g. website shortcuts).
if [ -f "$HM/alacritty" ]; then Programs="
$Programs
  Alacritty            GPU-accelerated terminal emulator"
fi

if [ -f "$SW/lxterminal" ]; then Programs="
$Programs
  LXTerminal           Lightweight VTE terminal emulator"
fi

if [ -f "$SW/amfora" ]; then Programs="
$Programs
  Amfora               CLI Gemini client"
fi

if [ -f "$SW/lagrange" ]; then Programs="
$Programs
  Lagrange             GUI Gemini client"
fi

if [ -f "$SW/audacious" ]; then Programs="
$Programs
  Audacious            Music player"
fi

if [ -f "$HM/easyeffects" ]; then Programs="
$Programs
  EasyEffects          Effects to inputs or outputs"
fi

if [ -f "$SW/easytag" ]; then Programs="
$Programs
  EasyTAG              Audio tag editor"
fi

if [ -f "$SW/pavucontrol" ]; then Programs="
$Programs
  Pavucontrol          Audio volume manager"
fi

if [ -f "$SW/qpwgraph" ]; then Programs="
$Programs
󰤽  qpwgraph             Audio patchbay"
fi

if [ -f "$SW/tenacity" ]; then Programs="
$Programs
  Tenacity             Audio editor"
fi

if [ -f "$SW/blender" ]; then Programs="
$Programs
󰂫  Blender              3D modeling"
fi

if [ -f "$SW/cura" ]; then Programs="
$Programs
  Cura                 3D printing"
fi

if [ -f "$SW/btop" ]; then Programs="
$Programs
  BTOP                 Terminal-based system monitor"
fi

if [ -f "$SW/cpu-x" ]; then Programs="
$Programs
  CPU-X                Detailed processor information"
fi

if [ -f "$SW/missioncenter" ]; then Programs="
$Programs
  Mission Center       GUI-based system monitor"
fi

if [ -f "$SW/bottles" ]; then Programs="
$Programs
󱌐  Bottles              Run Windows programs in Bottles"
fi

if [ -f "$SW/calcurse" ]; then Programs="
$Programs
  Calcurse             Calendar"
fi

if [ -f "$SW/gnome-clocks" ]; then Programs="
$Programs
  Clock                GNOME's clock"
fi

Programs="
$Programs
  CUPS                 Printer configuration"

Programs="
$Programs
  Enable crosshair     A simple red-dot crosshair"

Programs="
$Programs
󰽅  Disable crosshair    Kills the active crosshair/s"

if [ -f "$SW/desmume" ]; then Programs="
$Programs
  DeSmuME              Nintendo DS/I emulator"
fi

if [ -f "$SW/duckstation-qt" ]; then Programs="
$Programs
  DuckStation          Playstation 1 emulator"
fi

if [ -f "$SW/pcsx2-qt" ]; then Programs="
$Programs
  PCSX2                PlayStation 2 emulator"
fi

if [ -f "$SW/rpcs3" ]; then Programs="
$Programs
  RPCS3                PlayStation 3 emulator"
fi

if [ -f "$SW/prismlauncher" ]; then Programs="
$Programs
󰍳  PrismLauncher        Minecraft Launcher"
fi

if [ -f "$SW/luanti" ]; then Programs="
$Programs
󰍳  Luanti (minetest)    Open source voxel game engine"
fi

if [ -d "$UF/page.codeberg.JakobDev.jdNBTExplorer/" ]; then Programs="
$Programs
󰍳  NBT Explorer         NBT Explorer and editor"
fi

if [ -d "$UF/org.vinegarhq.Sober/" ]; then Programs="
$Programs
  Sober                Roblox client"
fi

if [ -f "$SW/steam" ]; then Programs="
$Programs
  Steam                Valve winning by doing nothing"
fi

if [ -d "$HP/That's not my neighbor/" ]; then Programs="
$Programs
  D.D.D                That's not my neighbor"
fi

if [ -f "$SW/jstest-gtk" ]; then Programs="
$Programs
  Jstest               Gamepad / controller tester"
fi

if [ -f "$SW/keymapp" ]; then Programs="
$Programs
  Keymapp              Layout tool for ZSA keyboards"
fi

if [ -f "$SW/sc-controller" ]; then Programs="
$Programs
  SC-Controller        Remap controllers in userspace"
fi

if [ -f "$SW/xclicker" ]; then Programs="
$Programs
󰍽  Xclicker             X11 autocliker (for XWayland)"
fi

if [ -f "$SW/vesktop" ]; then Programs="
$Programs
󰙯  Vesktop              Discord, but Vencorded"
fi

Programs="
$Programs
󰭻  Element              Matrix client"

if [ -f "$SW/revolt-desktop" ]; then Programs="
$Programs
󰭻  Revolt               FOSS alternative to Discord"
fi

if [ -f "$SW/freetube" ]; then Programs="
$Programs
  Freetube             Watch YouTube videos"
fi

if [ -f "$SW/gnome-disks" ]; then Programs="
$Programs
󰋊  Gnome disk utility   GNOME's disk utility"
fi

if [ -f "$SW/gparted" ]; then Programs="
$Programs
󰋊  Gparted              Partition manager"
fi

if [ -f "$SW/ncdu" ]; then Programs="
$Programs
󰋊  ncdu                 Disk usage"
fi

if [ -f "$SW/ventoy" ]; then Programs="
$Programs
  Ventoy               Bootable USB creation tool"
fi

if [ -f "$SW/file-roller" ]; then Programs="
$Programs
  File roller          Archive manager"
fi

if [ -f "$SW/thunar" ]; then Programs="
$Programs
  Thunar               File manager"
fi

if [ -f "$SW/warpinator" ]; then Programs="
$Programs
󰒖  Warpinator           Local file sharing"
fi

if [ -d "$UF/com.github.tchx86.Flatseal" ]; then Programs="
$Programs
  Flatseal             Manage flatpak permissions"
fi

if [ -f "$SW/galculator" ]; then Programs="
$Programs
  Galculator           Calculator"
fi

if [ -f "$SW/gcolor3" ]; then Programs="
$Programs
  Gcolor               Advanced color picker"
fi

if [ -f "$SW/hyprpicker" ]; then Programs="
$Programs
  Hyprpicker           Screen color picker"
fi

if [ -f "$SW/gimp" ]; then Programs="
$Programs
  GIMP                 GNU Image Manipulation Program"
fi

if [ -f "$SW/hyprpaper" ]; then Programs="
$Programs
  Hyprpaper            Set desktop background/wallpaper"
fi

if [ -f "$SW/krita" ]; then Programs="
$Programs
  Krita                Digital painting"
fi

if [ -f "$SW/otd" ]; then Programs="
$Programs
  OpenTabletDriver     Configure your drawing tablet"
fi

if [ -f "$SW/upscayl" ]; then Programs="
$Programs
  Upscayl              Upscale images"
fi

if [ -d "$HP/Kurso de Esperanto" ]; then Programs="
$Programs
  Kurso de Esperanto   Esperanto learning program"
fi

if [ -f "$SW/keepassxc" ]; then Programs="
$Programs
  KeePassXC            Password manager"
fi

if [ -f "$SW/kdenlive" ]; then Programs="
$Programs
  Kdenlive             Video editor"
fi

if [ -d "$UF/com.obsproject.Studio" ]; then Programs="
$Programs
󰑋  OBS studio           Recording and streaming"
fi

if [ -f "$SW/libreoffice" ]; then Programs="
$Programs
󰏆  LibreOffice          Office suite"
fi

if [ -f "$SW/simple-scan" ]; then Programs="
$Programs
󰚫  Simple scan          Document scanner"
fi

if [ -f "$SW/librewolf" ]; then Programs="
$Programs
  LibreWolf            Web browser"
fi

if [ -f "$SW/librewolf" ]; then Programs="
$Programs
  LibreWolf - private  Web browser (private window)"
fi

if [ -f "$SW/tor-browser" ]; then Programs="
$Programs
󰗹  Torbrowser launcher  Tor browser"
fi

if [ -f "$SW/nmtui" ]; then Programs="
$Programs
󰛳  Network Manager      Manage WiFi and Ethernet"
fi

#if [ -f "$SW/" ]; then Programs="
#$Programs
#󰛳  NM-applet            NetworkManager applet"
#fi

if [ -f "$SW/qbittorrent" ]; then Programs="
$Programs
  qBittorrent          Torrent manager"
fi

if [ -f "$SW/xfburn" ]; then Programs="
$Programs
  Xfburn               Disc burning"
fi

if [ -f "$SW/speedtest" ]; then Programs="
$Programs
󰓅  Speedtest            Test internet speed"
fi

if [ -f "$SW/virt-manager" ]; then Programs="
$Programs
󰪫  Virt Manager         Virtual machines using QEMU/KVM"
fi

# Add the Exit button
Programs="
$Programs
󰗼  Exit
"

# Let the user select a program.
Program=$(
	printf '%s\n' "$Programs" | tofi \
		--width 484 \
		--height "$Vertical" \
		--prompt-text " " \
		"$@"
)

[ "$Program" = " ‎" ] &&
	nohup dash "/etc/nixos/Scripts/Program launcher.sh" > /dev/null 2>&1 &

[ "$Program" = "                     󰌧  Run launcher" ] &&
	nohup tofi-drun --drun-launch=true > /dev/null 2>&1 &

[ "$Program" = "  Alacritty            GPU-accelerated terminal emulator" ] &&
	nohup alacritty > /dev/null 2>&1 &

[ "$Program" = "  LXTerminal           Lightweight VTE terminal emulator" ] &&
	nohup lxterminal > /dev/null 2>&1 &

[ "$Program" = "  Amfora               CLI Gemini client" ] &&
	nohup "$TERMINAL" -e amfora > /dev/null 2>&1 &

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
	nohup tenacity > /dev/null 2>&1 &

[ "$Program" = "󰂫  Blender              3D modeling" ] &&
	nohup blender > /dev/null 2>&1 &

[ "$Program" = "  Cura                 3D printing" ] &&
	nohup cura > /dev/null 2>&1 &

[ "$Program" = "  BTOP                 Terminal-based system monitor" ] &&
	nohup "$TERMINAL" -e btop > /dev/null 2>&1 &

[ "$Program" = "  CPU-X                Detailed processor information" ] &&
	nohup cpu-x > /dev/null 2>&1 &

[ "$Program" = "  Mission Center       GUI-based system monitor" ] &&
	nohup missioncenter > /dev/null 2>&1 &

[ "$Program" = "󱌐  Bottles              Run Windows programs in Bottles" ] &&
	nohup bottles > /dev/null 2>&1 &

[ "$Program" = "  Calcurse             Calendar" ] &&
	nohup "$TERMINAL" -e calcurse > /dev/null 2>&1 &

[ "$Program" = "  Clock                GNOME's clock" ] &&
	nohup gnome-clocks > /dev/null 2>&1 &

[ "$Program" = "  CUPS                 Printer configuration" ] &&
	nohup xdg-open "https://localhost:631/" > /dev/null 2>&1 &

[ "$Program" = "  Enable crosshair     A simple red-dot crosshair" ] &&
	nohup dash /etc/nixos/Scripts/Crosshair/Crosshair.sh --start > /dev/null 2

[ "$Program" = "󰽅  Disable crosshair    Kills the active crosshair/s" ] &&
	nohup dash /etc/nixos/Scripts/Crosshair/Crosshair.sh --kill > /dev/null 2

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
	nohup "$TERMINAL" -e ncdu > /dev/null 2>&1 &

[ "$Program" = "  Ventoy               Bootable USB creation tool" ] &&
	nohup "$TERMINAL" -e sudo ventoy-web > /dev/null 2>&1 &

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
	nohup dash "/etc/nixos/Scripts/Hyprpaper.sh" > /dev/null 2>&1 &

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
	nohup "$TERMINAL" -e nmtui > /dev/null 2>&1 &

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
