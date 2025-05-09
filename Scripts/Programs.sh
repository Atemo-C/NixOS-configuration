#!/bin/dash

# --ozone-platform=x11
# ^ In case some Electron programs ever need to run under Xwayland, use this.

# Set some text formatting shortcuts.
err=$(tput bold)$(tput setaf 1)Error$(tput sgr0)
arg=$(tput bold)$(tput setaf 2)
exe=$(tput bold)$(tput setaf 3)
ico=$(tput bold)$(tput setaf 6)
web=$(tput setaf 4)
mag=$(tput setaf 5)
cya=$(tput setaf 6)
c=$(tput sgr0)

# Check if the number of arguments is greater than 1.
[ "$#" -gt 1 ] && {
	echo \
		"${err}: Invalid number of arguments (${arg}$#${c}).\n" \
		"\nSee the ${arg}--about${c} and the ${arg}--help${c} arguments.\n"

	exit 1
}

# Check for the --about argument.
[ "$1" = "--about" ] && {
	echo \
		"${ico}  ${arg}Programs.sh${c}\n" \
		"\nThis script allows you to launch any program of your choosing in a custom list wihin the ${exe}Hyprland${c} Wayland compositor using ${exe}Tofi${c} to display the menu.\n" \
		"\n$(dim)If a program is in the list but not detected, it is automatically omitted from the list.${c}\n" \
		"\n• When using the ${arg}--about${c} argument, this message is displayed." \
		"\n• When using the ${arg}--help${c} argument, help about this script is displayed." \
		"\n• When using the ${arg}--check${c} argument, required dependencies will be checked." \
		"\n• When no argument is given, the program selection process starts.\n" \
		"\nCredits:" \
		"\n• ${exe}Tofi${c}: ${web}https://github.com/philj56/tofi${c}\n"

	exit
}

# Check for the --help argument.
[ "$1" = "--help" ] && {
	echo \
		"${ico}  ${arg}Programs.sh${c}\n" \
		"\n${arg}--about${c}" \
		"\nDisplay information about this script.\n" \
		"\n${arg}--help${c}" \
		"\nDisplay this message.\n" \
		"\n${arg}--check${c}" \
		"\nCheck for required dependencies." \
		"\n• To add the detection of a program, add an entry like any of the ones in Programs${mag}=${cya}\"\"${c}." \
		"\n• Then, you can add the action that should be executed upon launch of this program after the Program${mag}=\$()${c} prompt."

	exit
}

# Check for the --check argument.
[ "$1" = "--check" ] && {
	echo "${ico}  ${arg}Programs.sh${c}\n"

	# Check if Dunst is installed.
	command -v dunstify > /dev/null 2>&1 && {
		echo "✅ ${exe}Dunst${c} is installed."
	} ||
		echo "❌ ${exe}Dunst${c} is not installed. It is required to display graphical notifications. The script will not run without it."

	# Check if Tofi is installed.
	command -v tofi > /dev/null 2>&1 && {
		echo "✅ ${exe}Tofi${c} is installed."
	} ||
		echo "❌ ${exe}Tofi is not installed. It is required to display the graphical menu. The script will not run without it."

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] && {
		echo "✅ ${exe}Hyprland${c} is the active Wayland compositor."
	} ||
		echo "❌ ${exe}Hyprland${c} is not the currently active Wayland compositor. The script will not run outside of Hyprland."

	exit
}

# When no argument is provided, start the program selection process.
[ "$1" = "" ] && {
	# Check if Dunst is installed.
	command -v dunstify || {
		echo "${err}: Dunst could not be found. It is required to display graphical notifications."
		exit 1
	}

	# Check if Hyprland is the active Wayland compositor.
	[ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || {
		dunstify "Error: This program menu can only be used with the Hyprland Wayland compositor."
		echo "${err}: This program menu can only be used with the ${exe}Hyprland${c} Wayland compositor."
		exit 1
	}

	# Check if Tofi is installed.
	command -v tofi || {
		dunstify "Error: Tofi could not be found. It is necessary to display the graphical menu."
		echo "${err}: ${exe}Tofi${c} could not be found. It is necessary to display the graphical menu."
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

	command -v alacritty && Programs="
$Programs
  Alacritty            GPU-accelerated terminal emulator"

	command -v lxterminal && Programs="
$Programs
  LXTerminal           Lightweight VTE terminal emulator"

	command -v amfora && Programs="
$Programs
  Amfora               CLI Gemini client"

	command -v lagrange && Programs="
$Programs
  Lagrange             GUI Gemini client"

	command -v audacious && Programs="
$Programs
  Audacious            Music player"

	command -v easyeffects && Programs="
$Programs
  EasyEffects          Effects to inputs or outputs"

	command -v easytag && Programs="
$Programs
  EasyTAG              Audio tag editor"

	command -v pavucontrol && Programs="
$Programs
  Pavucontrol          Audio volume manager"

	command -v qpwgraph && Programs="
$Programs
󰤽  qpwgraph             Audio patchbay"

	command -v tenacity && Programs="
$Programs
  Tenacity             Audio editor"

	command -v blender && Programs="
$Programs
󰂫  Blender              3D modeling"

	command -v cura && Programs="
$Programs
  Cura                 3D printing"

	command -v btop && Programs="
$Programs
  BTOP                 Terminal-based system monitor"

	command -v cpu-x && Programs="
$Programs
  CPU-X                Detailed processor information"

	command -v missioncenter && Programs="
$Programs
  Mission Center       GUI-based system monitor"

	command -v bottles && Programs="
$Programs
󱌐  Bottles              Run Windows programs in Bottles"

	command -v calcurse && Programs="
$Programs
  Calcurse             Calendar"

	command -v gnome-clocks && Programs="
$Programs
  Clock                GNOME's clock"

	Programs="
$Programs
  CUPS                 Printer configuration"

	[ -f "/etc/nixos/Scripts/Crosshair/Crosshair.sh" ] && Programs="
$Programs
  Enable crosshair     A simple red-dot crosshair
󰽅  Disable crosshair    Kills the active crosshair/s"

	command -v desmume && Programs="
$Programs
  DeSmuME              Nintendo DS/I emulator"

	command -v duckstation-qt && Programs="
$Programs
  DuckStation          Playstation 1 emulator"

	command -v pcsx2-qt && Programs="
$Programs
  PCSX2                PlayStation 2 emulator"

	command -v rpcs3 && Programs="
$Programs
  RPCS3                PlayStation 3 emulator"

	command -v prismlauncher && Programs="
$Programs
󰍳  PrismLauncher        Minecraft Launcher"

	command -v mcpelauncher-ui-qt && Programs="
$Programs
󰍳  MC Bedrock Launcher  Minecraft Bedrock"

	command -v luanti && Programs="
$Programs
󰍳  Luanti (minetest)    Open source voxel game engine"

	command -v page.codeberg.JakobDev.jdNBTExplorer && Programs="
$Programs
󰍳  NBT Explorer         NBT Explorer and editor"

	command -v org.vinegarhq.Sober && Programs="
$Programs
  Sober                Roblox client"

	command -v steam && Programs="
$Programs
  Steam                Valve winning by doing nothing"

	[ -d "$HOME/Programs/That's not my neighbor/" ] && Programs="
$Programs
  D.D.D                That's not my neighbor"

	command -v jstest-gtk && Programs="
$Programs
  Jstest               Gamepad / controller tester"

	command -v keymapp && Programs="
$Programs
  Keymapp              Layout tool for ZSA keyboards"

	command -v sc-controller && Programs="
$Programs
  SC-Controller        Remap controllers in userspace"

	command -v xclicker && Programs="
$Programs
󰍽  Xclicker             X11 autocliker (for XWayland)"

	command -v vesktop && Programs="
$Programs
󰙯  Vesktop              Discord, but Vencorded"

	command -v element-desktop && Programs="
$Programs
󰭻  Element               Matrix client"

	[ -f "$SW/fractal" ] && Programs="
$Programs
󰭻  Fractal              GTK Matrix client"

	command -v revolt-desktop && Programs="
$Programs
󰭻  Revolt               FOSS alternative to Discord"

	command -v freetube && Programs="
$Programs
  Freetube             Watch YouTube videos"

	command -v gnome-disks && Programs="
$Programs
󰋊  Gnome disk utility   GNOME's disk utility"

	command -v gparted && Programs="
$Programs
󰋊  Gparted              Partition manager"

	command -v ncdu && Programs="
$Programs
󰋊  ncdu                 Disk usage"

	command -v kbackup && Programs="
$Programs
󰁯  KBackup              Backup user files"

	command -v timeshift && Programs="
$Programs
󰁯  Timeshift           System/File restore"

	command -v ventoy && Programs="
$Programs
  Ventoy               Bootable USB creation tool"

	command -v file-roller && Programs="
$Programs
  File roller          Archive manager"

	command -v thunar && Programs="
$Programs
  Thunar               File manager"

	command -v warpinator && Programs="
$Programs
󰒖  Warpinator           Local file sharing"

	command -v com.github.tchx84.Flatseal && Programs="
$Programs
  Flatseal             Manage flatpak permissions"

	command -v galculator && Programs="
$Programs
  Galculator           Calculator"

	command -v gcolor3 && Programs="
$Programs
  Gcolor               Advanced color picker"

	command -v hyprpicker && Programs="
$Programs
  Hyprpicker           Screen color picker"

	command -v gimp && Programs="
$Programs
  GIMP                 GNU Image Manipulation Program"

	command -v hyprpaper && Programs="
$Programs
  Hyprpaper            Set desktop background/wallpaper"

	command -v inkscape && Programs="
$Programs
  Inkscape             Vector graphics (SVG) editor"

	command -v krita && Programs="
$Programs
  Krita                Digital painting"

	command -v otd && Programs="
$Programs
  OpenTabletDriver     Configure your drawing tablet"

	command -v upscayl && Programs="
$Programs
  Upscayl              Upscale images"

	[ -d "$HOME/Programs/Kurso de Esperanto" ] && Programs="
$Programs
  Kurso de Esperanto   Esperanto learning program"

	command -v keepassxc && Programs="
$Programs
  KeePassXC            Password manager"

	command -v kdenlive && Programs="
$Programs
  Kdenlive             Video editor"

	command -v com.obsproject.Studio && Programs="
$Programs
󰑋  OBS studio           Recording and streaming"

	command -v libreoffice && Programs="
$Programs
󰏆  LibreOffice          Office suite"

	command -v simple-scan && Programs="
$Programs
󰚫  Simple scan          Document scanner"

	command -v librewolf && Programs="
$Programs
  LibreWolf            Web browser"

	command -v librewolf && Programs="
$Programs
  LibreWolf - private  Web browser (private window)"

	command -v tor-browser && Programs="
$Programs
󰗹  Torbrowser launcher  Tor browser"

	command -v nmtui && Programs="
$Programs
󰛳  Network Manager      Manage WiFi and Ethernet"

#	command -v nm-applet && Programs="
#$Programs
#󰛳  NM-applet            NetworkManager applet"

	command -v qbittorrent && Programs="
$Programs
  qBittorrent          Torrent manager"


	command -v xfburn && Programs="
$Programs
  Xfburn               Disc burning"


	command -v speedtest && Programs="
$Programs
󰓅  Speedtest            Test internet speed"

	command -v virt-manager && Programs="
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
		nohup cura -platformtheme gtk3 > /dev/null 2>&1 & exit
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

	[ "$Program" = "󰍳  MC Bedrock Launcher  Minecraft Bedrock" ] && {
		nohup mcpelauncher-ui-qt -platformtheme gtk3 > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰍳  Luanti (minetest)    Open source voxel game engine" ] && {
		nohup luanti > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰍳  NBT Explorer         NBT Explorer and editor" ] && {
		nohup page.codeberg.JakobDev.jdNBTExplorer > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Sober                Roblox client" ] && {
		nohup org.vinegarhq.Sober --bootstrap > /dev/null 2>&1 & exit
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
		nohup vesktop --ozone-platform=wayland > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰭻  Element              Matrix client" ] && {
		nohup element-desktop --ozone-platform=wayland > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰭻  Fractal              GTK Matrix client" ] && {
		nohup fractal > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰭻  Revolt               FOSS alternative to Discord" ] && {
		nohup revolt-desktop --ozone-platform=wayland > /dev/null 2>&1 & exit
	}

	[ "$Program" = "  Freetube             Watch YouTube videos" ] && {
		nohup freetube --ozone-platform=wayland > /dev/null 2>&1 & exit
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

	[ "$Program" = "󰁯  KBackup              Backup user files" ] && {
		nohup kbackup > /dev/null 2>&1 & exit
	}

	[ "$Program" = "󰁯  Timeshift           System/File restore" ] && {
		nohup timeshift-launcher > /dev/null 2>&1 & exit
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

	[ "$Program" = "  Inkscape             Vector graphics (SVG) editor" ] && {
		nohup inkscape > /dev/null 2>&1 & exit
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
echo \
	"${err}: Invalid argument '${arg}$*${c}'.\n" \
	"\nSee the ${arg}--about${c} and the ${arg}--help${c} arguments.\n"

exit 1
