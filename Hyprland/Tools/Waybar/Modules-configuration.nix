{ config, ... }: {

	# Configuration of Waybar's modules.
	# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.settings
	# https://github.com/Alexays/Waybar/wiki/Configuration
	home-manager.users.${config.Custom.Name}.programs.waybar.settings.mainBar = {
		"custom/Spacer" = {
			format = " ";
			tooltip = false;
			interval = "once";
		};

		"image#Program_launcher" = {
			path = "/etc/nixos/Hyprland/Icons/Program launcher.png";
			size = 22;
			on-click = "bash /etc/nixos/Hyprland/Scripts/Program\\ launcher.sh";
			on-click-right = "tofi-drun --drun-launch=true";
		};

		"image#Power_menu" = {
			path = "/etc/nixos/Hyprland/Icons/Power menu.png";
			size = 22;
			on-click = "bash /etc/nixos/Hyprland/Scripts/Power\\ menu.sh";
		};

		"hyprland/workspaces" = {
			persistent-workspaces = { "*" = 8; };
		};

		"tray" = {
			size = 22;
			spacing = 8;
			reverse-direction = false;
		};

		"image#Screenshot" = {
			path = "/etc/nixos/Hyprland/Icons/Screenshot.png";
			size = 22;
			on-click = "bash /etc/nixos/Hyprland/Scripts/Hyprshot.sh";
			on-click-right = "bash /etc/nixos/Hyprland/Scripts/Hyprshot\\ single.sh";
			on-scroll-up = "hyprctl keyword decoration:screen_shader /etc/nixos/Hyprland/Shaders/crt.frag";
			on-scroll-down = "hyprctl keyword decoration:screen_shader ''";
		};

		"image#Clipboard" = {
			path = "/etc/nixos/Hyprland/Icons/Clipboard.png";
			size = 22;
			on-click = "clipman pick -t CUSTOM -T tofi";
			on-click-right = "st -e micro $HOME/Documents/Clipboard.txt";
			on-click-middle = "clipman clear --all & notify-send -t 1000 'Clipboard cleared'";
		};

		"image#Files" = {
			path = "/etc/nixos/Hyprland/Icons/Files.png";
			size = 22;
			on-click = "thunar";
		};

		"clock" = {
			format = "{:%d/%m/%Y %H:%M}";
			on-click = "st -e calcurse";
		};

		"image#CPU" = {
			path = "/etc/nixos/Hyprland/Icons/CPU.png";
			size = 22;
			on-click = "st -e btop";
			on-click-right = "missioncenter";
		};

		"cpu" = {
			interval = 2;
			format = "{usage}% ";
			on-click = "st -e btop";
			on-click-right = "missioncenter";
		};

		"temperature" = {
			critical-threshold = 75;
			interval = 2;
			hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
			format = "{temperatureC}°C";
			format-critical = "[!!!] {temperatureC}°C";
			on-click = "st -e btop";
			on-click-right = "missioncenter";
		};

		"image#RAM" = {
			path = "/etc/nixos/Hyprland/Icons/RAM.png";
			size = 22;
			on-click = "st -e btop";
			on-click-right = "missioncenter";
		};

		"memory" = {
			interval = 1;
			format = "{percentage}%";
			on-click = "st -e btop";
			on-click-right = "missioncenter";
		};

		"image#Volume" = {
			path = "/etc/nixos/Hyprland/Icons/Output volume.png";
			size = 22;
			on-click = "pavucontrol";
			on-click-right = "qpwgraph";
			on-click-middle = "amixr -q sset Master toggle";
			on-scroll-up = "amixer -q sset Master 1%+";
			on-scroll-down = "amixer -q sset Master 1%-";
		};

		"wireplumber" = {
			format = "{volume}%";
			format-muted = "Muted";
			on-click = "pavucontrol";
			on-click-right = "qpwgraph";
			on-click-middle = "amixer -q sset Master toggle";
		};

		"battery" = {
			format = "{capacity}% {icon}";
			format-icons = [
				" "
				" "
				" "
				" "
				" "
			];
		};

		"image#Reload" = {
			path = "/etc/nixos/Hyprland/Icons/Reload.png";
			size = 22;
			on-click = "hyprctl reload";
		};

		"image#Exit" = {
			path = "/etc/nixos/Hyprland/Icons/Exit.png";
			size = 22;
			on-click-right = "hyprctl dispatch exit";
		};

		"image#Close" = {
			path = "/etc/nixos/Hyprland/Icons/Close.png";
			size = 22;
			on-click = "hyprctl dispatch killactive";
			on-click-right = "hyprctl kill";
		};
	};

}
