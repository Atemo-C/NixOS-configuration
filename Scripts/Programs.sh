#!/bin/dash

# Shortcuts for binaries.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"
UF="$HOME/.local/share/flatpak/app"
HP="$HOME/Programs"

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

# Define the height of the program menu in accordance with the screen resolution.
#---#
# List monitors.
# List the 20 lines above "focused: yes".
# Reverse the sorting order.
# Grep any lines with x.
# Keep only the first one.
# Trim the output so that it only keeps the vertical resolution.
Get_vertical=$(hyprctl monitors | grep -B20 "focused: yes" | tac | grep x | head -n 1 | awk -F 'x|@' '{print $2
}')

# Remove some space for the bar and neat gaps.
Gap="84"

# Set the vertical size of the Tofi menu.
Vertical=$((Get_vertical - Gap))

# Create the programs list, filled by the programs below when detected.
Programs="
                     󰌧  Run launcher
 ‎
"

# Detection of all possible programs used in this script.
# If they are not detected, they are not added to the list.
# Some are manually added (e.g. website shortcuts).
[ -f "$HM/alacritty" ] && Programs="
$Programs
  Alacritty            GPU-accelerated terminal emulator"

[ -f "$SW/lxterminal" ] && Programs="
$Programs
  LXTerminal           Lightweight VTE terminal emulator"

[ -f "$SW/amfora" ] && Programs="
$Programs
  Amfora               CLI Gemini client"

[ -f "$SW/lagrange" ] && Programs="
$Programs
  Lagrange             GUI Gemini client"

[ -f "$SW/audacious" ] && Programs="
$Programs
  Audacious            Music player"

[ -f "$HM/easyeffects" ] && Programs="
$Programs
  EasyEffects          Effects to inputs or outputs"

[ -f "$SW/easytag" ] && Programs="
$Programs
  EasyTAG              Audio tag editor"

[ -f "$SW/pavucontrol" ] && Programs="
$Programs
  Pavucontrol          Audio volume manager"

[ -f "$SW/qpwgraph" ] && Programs="
$Programs
󰤽  qpwgraph             Audio patchbay"

[ -f "$SW/tenacity" ] && Programs="
$Programs
  Tenacity             Audio editor"

[ -f "$SW/blender" ] && Programs="
$Programs
󰂫  Blender              3D modeling"

[ -f "$SW/cura" ] && Programs="
$Programs
  Cura                 3D printing"

[ -f "$SW/btop" ] && Programs="
$Programs
  BTOP                 Terminal-based system monitor"

[ -f "$SW/cpu-x" ] && Programs="
$Programs
  CPU-X                Detailed processor information"

[ -f "$SW/missioncenter" ] && Programs="
$Programs
  Mission Center       GUI-based system monitor"

[ -f "$SW/bottles" ] && Programs="
$Programs
󱌐  Bottles              Run Windows programs in Bottles"

[ -f "$SW/calcurse" ] && Programs="
$Programs
  Calcurse             Calendar"

[ -f "$SW/gnome-clocks" ] && Programs="
$Programs
  Clock                GNOME's clock"

Programs="
$Programs
  CUPS                 Printer configuration"

Programs="
$Programs
  Enable crosshair     A simple red-dot crosshair"

Programs="
$Programs
󰽅  Disable crosshair    Kills the active crosshair/s"

[ -f "$SW/desmume" ] && Programs="
$Programs
  DeSmuME              Nintendo DS/I emulator"

[ -f "$SW/duckstation-qt" ] && Programs="
$Programs
  DuckStation          Playstation 1 emulator"

[ -f "$SW/pcsx2-qt" ] && Programs="
$Programs
  PCSX2                PlayStation 2 emulator"

[ -f "$SW/rpcs3" ] && Programs="
$Programs
  RPCS3                PlayStation 3 emulator"

[ -f "$SW/prismlauncher" ] && Programs="
$Programs
󰍳  PrismLauncher        Minecraft Launcher"

[ -f "$SW/luanti" ] && Programs="
$Programs
󰍳  Luanti (minetest)    Open source voxel game engine"

[ -d "$UF/page.codeberg.JakobDev.jdNBTExplorer/" ] && Programs="
$Programs
󰍳  NBT Explorer         NBT Explorer and editor"

[ -d "$UF/org.vinegarhq.Sober/" ] && Programs="
$Programs
  Sober                Roblox client"

[ -f "$SW/steam" ] && Programs="
$Programs
  Steam                Valve winning by doing nothing"

[ -d "$HP/That's not my neighbor/" ] && Programs="
$Programs
  D.D.D                That's not my neighbor"

[ -f "$SW/jstest-gtk" ] && Programs="
$Programs
  Jstest               Gamepad / controller tester"

[ -f "$SW/keymapp" ] && Programs="
$Programs
  Keymapp              Layout tool for ZSA keyboards"

[ -f "$SW/sc-controller" ] && Programs="
$Programs
  SC-Controller        Remap controllers in userspace"

[ -f "$SW/xclicker" ] && Programs="
$Programs
󰍽  Xclicker             X11 autocliker (for XWayland)"

[ -f "$SW/vesktop" ] && Programs="
$Programs
󰙯  Vesktop              Discord, but Vencorded"

Programs="
$Programs
󰭻  Element              Matrix client"

[ -f "$SW/revolt-desktop" ] && Programs="
$Programs
󰭻  Revolt               FOSS alternative to Discord"

[ -f "$SW/freetube" ] && Programs="
$Programs
  Freetube             Watch YouTube videos"

[ -f "$SW/gnome-disks" ] && Programs="
$Programs
󰋊  Gnome disk utility   GNOME's disk utility"

[ -f "$SW/gparted" ] && Programs="
$Programs
󰋊  Gparted              Partition manager"

[ -f "$SW/ncdu" ] && Programs="
$Programs
󰋊  ncdu                 Disk usage"

[ -f "$SW/ventoy" ] && Programs="
$Programs
  Ventoy               Bootable USB creation tool"

[ -f "$SW/file-roller" ] && Programs="
$Programs
  File roller          Archive manager"

[ -f "$SW/thunar" ] && Programs="
$Programs
  Thunar               File manager"

[ -f "$SW/warpinator" ] && Programs="
$Programs
󰒖  Warpinator           Local file sharing"

[ -d "$UF/com.github.tchx86.Flatseal" ] && Programs="
$Programs
  Flatseal             Manage flatpak permissions"

[ -f "$SW/galculator" ] && Programs="
$Programs
  Galculator           Calculator"

[ -f "$SW/gcolor3" ] && Programs="
$Programs
  Gcolor               Advanced color picker"

[ -f "$SW/hyprpicker" ] && Programs="
$Programs
  Hyprpicker           Screen color picker"

[ -f "$SW/gimp" ] && Programs="
$Programs
  GIMP                 GNU Image Manipulation Program"

[ -f "$SW/hyprpaper" ] && Programs="
$Programs
  Hyprpaper            Set desktop background/wallpaper"

[ -f "$SW/krita" ] && Programs="
$Programs
  Krita                Digital painting"

[ -f "$SW/otd" ] && Programs="
$Programs
  OpenTabletDriver     Configure your drawing tablet"

[ -f "$SW/upscayl" ] && Programs="
$Programs
  Upscayl              Upscale images"

[ -d "$HP/Kurso de Esperanto" ] && Programs="
$Programs
  Kurso de Esperanto   Esperanto learning program"

[ -f "$SW/keepassxc" ] && Programs="
$Programs
  KeePassXC            Password manager"

[ -f "$SW/kdenlive" ] && Programs="
$Programs
  Kdenlive             Video editor"

[ -d "$UF/com.obsproject.Studio" ] && Programs="
$Programs
󰑋  OBS studio           Recording and streaming"

[ -f "$SW/libreoffice" ] && Programs="
$Programs
󰏆  LibreOffice          Office suite"

[ -f "$SW/simple-scan" ] && Programs="
$Programs
󰚫  Simple scan          Document scanner"

[ -f "$SW/librewolf" ] && Programs="
$Programs
  LibreWolf            Web browser"

[ -f "$SW/librewolf" ] && Programs="
$Programs
  LibreWolf - private  Web browser (private window)"

[ -f "$SW/tor-browser" ] && Programs="
$Programs
󰗹  Torbrowser launcher  Tor browser"

[ -f "$SW/nmtui" ] && Programs="
$Programs
󰛳  Network Manager      Manage WiFi and Ethernet"

#[ -f "$SW/" ] && Programs="
#$Programs
#󰛳  NM-applet            NetworkManager applet"

[ -f "$SW/qbittorrent" ] && Programs="
$Programs
  qBittorrent          Torrent manager"


[ -f "$SW/xfburn" ] && Programs="
$Programs
  Xfburn               Disc burning"


[ -f "$SW/speedtest" ] && Programs="
$Programs
󰓅  Speedtest            Test internet speed"

[ -f "$SW/virt-manager" ] && Programs="
$Programs
󰪫  Virt Manager         Virtual machines using QEMU/KVM"

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
