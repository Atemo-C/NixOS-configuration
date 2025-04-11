#!/bin/dash

# Shortcuts for binaries.
SW="/run/current-system/sw/bin"
HM="$HOME/.nix-profile/bin"
UF="$HOME/.local/share/flatpak/app"
HP="$HOME/Programs"

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid number of arguments.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) and $(tput setaf 2)$(tput bold)--help$(tput sgr0) arguments.
"
	exit 1
}

# Check for the --about argument.
[ "$1" = "--about" ] && {
	echo "$(tput bold)$(tput setaf 6)  $(tput setaf 2)Programs.sh$(tput sgr0)

This script allows you to launch any program that exists in the Program$(tput setaf 5)=$(tput setaf 6)\"\"$(tput sgr0) list within the $(tput bold)$(tput setaf 3)Hyprland$(tput sgr0) Wayland compositor, using $(tput bold)$(tput setaf 6)Tofi$(tput sgr0) to display the menu.

$(tput dim)If a program is in the list but not detected, it is automatically omitted from the list.$(tput sgr0)

• When using the $(tput setaf 2)$(tput bold)--about$(tput sgr0) argument, this message is displayed.
• When using the $(tput setaf 2)$(tput bold)--help$(tput sgr0) argument, help about this script is displayed.
• When no argument is given, the program selection process starts.

Credits:
• $(tput bold)$(tput setaf 3)Tofi$(tput sgr0): $(tput setaf 4)https://github.com/philj56/tofi$(tput sgr0)
"
	exit
}

# Check for the --help argument.
[ "$1" = "--help" ] && {
	echo "$(tput bold)$(tput setaf 6)  $(tput setaf 2)Programs.sh$(tput sgr0)

When editing this script, you will see these elements in the Program$(tput setaf 5)=$(tput setaf 6)\"\"$(tput sgr0) list:

  $(tput setaf 5)[ $(tput setaf 3)-f $(tput setaf 6)\"\$SW/program-name\"$(tput setaf 5)] && $(tput sgr0)Programs$(tput setaf 5)=$(tput setaf 6)\"
  \$Programs
  ICON Program name   Short description of the program\"$(tput sgr0)

• $(tput setaf 3)-f$(tput sgr0) checks if the program executable is present.
• $(tput setaf 6)\$SW$(tput sgr0) is a shortened path to system-installed programs on NixOS ($(tput dim)$SW$(tput sgr0)).
• $(tput setaf 6)\$HW$(tput sgr0) is a shortened path to Home Manager-installed programs on NixOS ($(tput dim)$HM$(tput sgr0)).
• $(tput setaf 6)\$UF$(tput sgr0) is a shortened path to user-Flatpak-installed programs ($(tput dim)$UF$(tput sgr0)).
• $(tput setaf 6)\$HP$(tput sgr0) is a shortened path to a custom directory for other binaries ($(tput dim)$HP$(tput sgr0)).
• $(tput setaf 6)program-name$(tput sgr0) is the name of the executable that contains the desired command.
• $(tput setaf 6)\$Programs$(tput sgr0) is the list of programs in the list, added before every new program to retain them.
• $(tput setaf 6)ICON$(tput sgr0) is, optionally, a fancy text icon for the desired program.
• The rest is self-explanatory.

Once you have added the desired programs, you will need to define their actions after the Program$(tput setaf 5)=\$()$(tput sgr0) prompt, like so:

$(tput dim)…$(tput sgr0)
Program$(tput setaf 5)=\$($(tput setaf 2)
  printf $(tput setaf 6)'%s\\\n' \"\$Programs\" $(tput sgr0)| tofi \\
    $(tput setaf 3)--width $(tput setaf 5)484 $(tput sgr0)\\
    $(tput setaf 3)--height $(tput setaf 6)\"\$Vertical\" $(tput sgr0)\\
    $(tput setaf 3)--prompt-text $(tput setaf 6)\" \" $(tput sgr0)\\
    $(tput setaf 6)\"\$@\"$(tput setaf 5)
)$(tput setaf sgr0)

$(tput setaf 5)[ $(tput setaf 6)\"\$Program\" $(tput setaf 5)= $(tput setaf 6)\"program-name\"$(tput setaf 5) ] &&
  $(tput setaf 2)nohup $(tput sgr0)program-name $(tput setaf 5)> $(tput sgr0)/dev/null $(tput setaf 5)2>&1 &$(tput sgr0)
$(tput dim)…$(tput sgr0)

• $(tput setaf 2)nohup$(tput sgr0) is used to start the program quietly, and the pipe to $(tput setaf 5)/dev/null 2>&1 &$(tput sgr0) further quiets things down.

$(tput bold)[ Arguments ]$(tput sgr0)
  $(tput setaf 2)$(tput bold)--about$(tput sgr0)
  Display information about this script.

  $(tput setaf 2)$(tput bold)--help$(tput sgr0)
  Display this message.
"
	exit
}

# When no argument is provided, continue on with the program selection process.
[ "$1" = "" ] && {
	# Check if libnotify is installed.
	[ -f "$SW/notify-send" ] || {
		echo "libnotify could not be found. It is needed to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		notify-send "This program menu can only be used with Hyprland."
		echo "This program menu can only be used with Hyprland."
		exit 1
	}

	# Check if Tofi is installed.
	[ -f "$HM/tofi" ] || [ -f "$SW/tofi" ] || {
		notify-send "tofi could not be found. It is necessary to display the graphical menu."
		echo "tofi could not be found. It is necessary to display the graphical menu."
		exit 1
	}

	# Define the height of the program menu, in accordance with the screen selotion.
	# • List monitors.
	# • List the 20 lines above "focused: yes".
	# • Reverse the sorting order.
	# • Grep any lines with x.
	# • Keep only the first one.
	# • Trim the output to only keep the vertical resolution.
	Get_vertical=$(hyprctl monitors | grep -B20 "focused: yes" | tac | grep x | head -n 1 | awk -F 'x|@' '{print $2
	}')

	# Remove some space to have proper gaps.
	Gap="84"

	# Set the vertical size of the Tofi menu.
	Vertical=$((Get_vertical - Gap))

	# Create the programs list, filled by the programs below when detected.
	Programs="
                     󰌧  Run launcher
 ‎
"

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
󰭻  Element (web)         Matrix client"

	Programs="
$Programs
󰭻  Element (Electron)    Matrix client"

	[ -f "$SW/fractal" ] && Programs="
$Programs
󰭻  Fractal              GTK Matrix client"

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

	[ -d "$UF/com.github.tchx84.Flatseal" ] && Programs="
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

#	[ -f "$SW/" ] && Programs="
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

	[ "$Program" = " ‎" ] && {
			nohup dash "/etc/nixos/Scripts/Program launcher.sh" > /dev/null 2>&1 & exit
		}

	[ "$Program" = "                     󰌧  Run launcher" ] && {
			nohup tofi-drun --drun-launch=true > /dev/null 2>&1 & exit
		}

	[ "$Program" = "  Alacritty            GPU-accelerated terminal emulator" ] && {
		nohup alacritty > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  LXTerminal           Lightweight VTE terminal emulator" ] && {
		nohup lxterminal > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Amfora               CLI Gemini client" ] && {
		nohup "$TERMINAL" -e amfora > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Lagrange             GUI Gemini client" ] && {
		nohup lagrange > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Audacious            Music player" ] && {
		nohup audacious > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  EasyEffects          Effects to inputs or outputs" ] && {
		nohup easyeffects > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  EasyTAG              Audio tag editor" ] && {
		nohup easytag > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Pavucontrol          Audio volume manager" ] && {
		nohup pavucontrol > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰤽  qpwgraph             Audio patchbay" ] && {
		nohup qpwgraph > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Tenacity             Audio editor" ] && {
		nohup tenacity > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰂫  Blender              3D modeling" ] && {
		nohup blender > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Cura                 3D printing" ] && {
		nohup cura > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  BTOP                 Terminal-based system monitor" ] && {
		nohup "$TERMINAL" -e btop > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  CPU-X                Detailed processor information" ] && {
		nohup cpu-x > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Mission Center       GUI-based system monitor" ] && {
		nohup missioncenter > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󱌐  Bottles              Run Windows programs in Bottles" ] && {
		nohup bottles > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Calcurse             Calendar" ] && {
		nohup "$TERMINAL" -e calcurse > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Clock                GNOME's clock" ] && {
		nohup gnome-clocks > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  CUPS                 Printer configuration" ] && {
		nohup xdg-open "https://localhost:631/" > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Enable crosshair     A simple red-dot crosshair" ] && {
		nohup dash /etc/nixos/Scripts/Crosshair/Crosshair.sh --start > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰽅  Disable crosshair    Kills the active crosshair/s" ] && {
		nohup dash /etc/nixos/Scripts/Crosshair/Crosshair.sh --stop > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  DeSmuME              Nintendo DS/I emulator" ] && {
		nohup desmume > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  DuckStation          Playstation 1 emulator" ] && {
		nohup duckstation > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  PCSX2                PlayStation 2/1 emulator" ] && {
		nohup pcsx2-qt > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  RPCS3                PlayStation 3 emulator" ] && {
		nohup rpcs3 > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰍳  PrismLauncher        Minecraft Launcher" ] && {
		nohup prismlauncher > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰍳  Luanti (minetest)    Open source voxel game engine" ] && {
		nohup luanti > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰍳  NBT Explorer         NBT Explorer and editor" ] && {
		nohup page.codeberg.JakobDev.jdNBTExplorer > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Sober                Roblox client" ] && {
		nohup org.vinegarhq.Sober > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Steam                Valve winning by doing nothing" ] && {
		nohup steam > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  D.D.D                That's not my neighbor" ] && {
		nohup steam-run "$HOME/Programs/That's not my neighbor/That's not my neighbor.x86_64" > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Jstest               Gamepad / controller tester" ] && {
		nohup jstest-gtk > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Keymapp              Layout tool for ZSA keyboards" ] && {
		nohup keymapp > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  SC-Controller        Remap controllers in userspace" ] && {
		nohup sc-controller > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰍽  Xclicker             X11 autocliker (for XWayland)" ] && {
		nohup xclicker > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰙯  Vesktop              Discord, but Vencorded" ] && {
		nohup vesktop --ozone-platform=x11 > /dev/null 2>&1 & exit
	#	nohup vesktop --ozone-platform=wayland > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰭻  Element (web)         Matrix client" ] && {
		nohup librewolf --new-window "https://app.element.io/" > /dev/null 2>&1 & exit
	}

	[ "$Programs" = "󰭻  Element (Electron)    Matrix client" ] && {
		nohup element-desktop > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰭻  Fractal              GTK Matrix client" ] && {
		nohup fractal > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰭻  Revolt               FOSS alternative to Discord" ] && {
		nohup revolt-desktop --ozone-platform=x11 > /dev/null 2>&1 & exit
	#	nohup revolt-desktop --ozone-platform=wayland > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Freetube             Watch YouTube videos" ] && {
		nohup freetube --ozone-platform=x11 > /dev/null 2>&1 & exit
	#	nohup freetube --ozone-platform=wayland > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰋊  Gnome disk utility   GNOME's disk utility" ] && {
		nohup gnome-disks > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰋊  Gparted              Partition manager" ] && {
		nohup gparted > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰋊  ncdu                 Disk usage" ] && {
		nohup "$TERMINAL" -e ncdu > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Ventoy               Bootable USB creation tool" ] && {
		nohup "$TERMINAL" -e run0 ventoy-web > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  File roller          Archive manager" ] && {
		nohup file-roller > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Thunar               File manager" ] && {
		nohup thunar > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰒖  Warpinator           Local file sharing" ] && {
		nohup warpinator > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Flatseal             Manage flatpak permissions" ] && {
		nohup com.github.tchx84.Flatseal > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Galculator           Calculator" ] && {
		nohup galculator > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Gcolor               Advanced color picker" ] && {
		nohup gcolor3 > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Hyprpicker           Screen color picker" ] && {
		nohup dash "/etc/nixos/Scripts/Picker.sh" > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  GIMP                 GNU Image Manipulation Program" ] && {
		nohup gimp > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Hyprpaper            Set desktop background/wallpaper" ] && {
		nohup dash "/etc/nixos/Scripts/Hyprpaper.sh" > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Krita                Digital painting" ] && {
		nohup krita > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  OpenTabletDriver     Configure your drawing tablet" ] && {
		nohup otd-gui > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Upscayl              Upscale images" ] && {
		nohup upscayl > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Kurso de Esperanto   Esperanto learning program" ] && {
		QT_QPA_PLATFORM=xcb nohup steam-run "$HOME/Programs/Kurso de Esperanto/kursokape" > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  KeePassXC            Password manager" ] && {
		nohup keepassxc > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Kdenlive             Video editor" ] && {
		nohup kdenlive > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰑋  OBS studio           Recording and streaming" ] && {
		nohup com.obsproject.Studio > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰏆  LibreOffice          Office suite" ] && {
		nohup soffice > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰚫  Simple scan          Document scanner" ] && {
		nohup simple-scan > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  LibreWolf            Web browser" ] && {
		nohup librewolf > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  LibreWolf - private  Web browser (private window)" ] && {
		nohup librewolf --private-window > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰗹  Torbrowser launcher  Tor browser" ] && {
		nohup tor-browser > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰛳  Network Manager      Manage WiFi and Ethernet" ] && {
		nohup "$TERMINAL" -e nmtui > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰛳  NM-applet            NetworkManager applet" ] && {
		nohup nm-applet > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  qBittorrent          Torrent manager" ] && {
		nohup qbittorrent > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Xfburn               Disc burning" ] && {
		nohup xfburn > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰓅  Speedtest            Test internet speed" ] && {
		nohup speedtest > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰪫  Virt Manager         Virtual machines using QEMU/KVM" ] && {
		nohup virt-manager > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰗼  Exit" ] && {
		exit
	}

}

# Error out if an invalid argument is given.
echo "$(tput bold)$(tput setaf 1)Error$(tput sgr0): Invalid argument '$(tput setaf 1)$*$(tput sgr0)'.

See the $(tput setaf 2)$(tput bold)--about$(tput sgr0) and $(tput setaf 2)$(tput bold)--help$(tput sgr0) arguments.
"
exit 1
