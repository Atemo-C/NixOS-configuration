# Documentation:
#───────────────
# • https://github.com/Alexays/Waybar/wiki
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.enable
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.package
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.systemd.enable
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.settings
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.settings
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.style

{ config, pkgs, ... }: { home-manager.users.${config.custom.name}.programs.waybar = {

	# Whether to enable Waybar.
	enable = true;

	# Waybar package to use.
	package = pkgs.unstable.waybar;

	# Whether to enable Waybar systemd integration.
	systemd.enable = true;

	# Configuration for Waybar.
	settings.mainBar = {
		# Decide if the bar is displayed in front (top) of the windows or behind (bottom) them.
		layer = "top";

		# Modules that will be displayed on the left.
		modules-left = [
			"image#Program_launcher" "custom/Spacer"
			"image#Power_menu"       "custom/Spacer"
			"hyprland/workspaces"
		];

		# Modules that will be displayed in the center.
		modules-center = [
			"tray"             "custom/Spacer"
			"image#Screenshot" "custom/Spacer"
			"image#Clipboard"  "custom/Spacer"
			"image#Files"      "custom/Spacer" "custom/Spacer"
			"clock"            "custom/Spacer" "custom/Spacer"
			"image#CPU"        "cpu"           "temperature"   "custom/Spacer"
			"image#RAM"        "memory"        "custom/Spacer"
			"image#Volume"     "wireplumber"   "custom/Spacer"
			"battery"          "custom/Spacer"
		];

		# Modules that will be displayed on the right.
		modules-right = [
			"image#Reload" "custom/Spacer"
			"image#Exit"   "custom/Spacer"
			"image#Close"
		];

		# Configuration of Waybar's modules.
		"custom/Spacer" = {
			format = " ";
			tooltip = false;
			interval = "once";
		};

		"image#Program_launcher" = {
			path = "/etc/nixos/Desktop/Icons/Program launcher.png";
			size = 22;
			on-click = "bash /etc/nixos/Desktop/Scripts/Program\\ launcher.sh";
			on-click-right = "tofi-drun --drun-launch=true";
		};

		"image#Power_menu" = {
			path = "/etc/nixos/Desktop/Icons/Power menu.png";
			size = 22;
			on-click = "bash /etc/nixos/Desktop/Scripts/Power\\ menu.sh";
		};

		"hyprland/workspaces" = {
			persistent-workspaces = { "*" = 8; };
		};

		"tray" = {
			icon-size = 22;
			spacing = 8;
			reverse-direction = false;
		};

		"image#Screenshot" = {
			path = "/etc/nixos/Desktop/Icons/Screenshot.png";
			size = 22;
			on-click = "bash /etc/nixos/Desktop/Scripts/Hyprshot.sh";
			on-click-right = "bash /etc/nixos/Desktop/Scripts/Hyprshot\\ single.sh";
			on-scroll-up = "hyprctl keyword decoration:screen_shader /etc/nixos/Desktop/Shaders/crt.frag";
			on-scroll-down = "hyprctl keyword decoration:screen_shader ''";
		};

		"image#Clipboard" = {
			path = "/etc/nixos/Desktop/Icons/Clipboard.png";
			size = 22;
			on-click = "clipman pick -t CUSTOM -T tofi";
			on-click-right = "alacritty -e micro $HOME/Documents/Clipboard.txt";
			on-click-middle = "clipman clear --all & notify-send -t 1000 'Clipboard cleared'";
		};

		"image#Files" = {
			path = "/etc/nixos/Desktop/Icons/Files.png";
			size = 22;
			on-click = "thunar";
		};

		"clock" = {
			format = "{:%d/%m/%Y %H:%M}";
			on-click = "alacritty -e calcurse";
		};

		"image#CPU" = {
			path = "/etc/nixos/Desktop/Icons/CPU.png";
			size = 22;
			on-click = "alacritty -e btop";
			on-click-right = "missioncenter";
		};

		"cpu" = {
			interval = 2;
			format = "{usage}% ";
			on-click = "alacritty -e btop";
			on-click-right = "missioncenter";
		};

		"temperature" = {
			critical-threshold = 75;
			interval = 2;
			hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
			format = "{temperatureC}°C";
			format-critical = "[!!!] {temperatureC}°C";
			on-click = "alacritty -e btop";
			on-click-right = "missioncenter";
		};

		"image#RAM" = {
			path = "/etc/nixos/Desktop/Icons/RAM.png";
			size = 22;
			on-click = "alacritty -e btop";
			on-click-right = "missioncenter";
		};

		"memory" = {
			interval = 1;
			format = "{percentage}%";
			on-click = "alacritty -e btop";
			on-click-right = "missioncenter";
		};

		"image#Volume" = {
			path = "/etc/nixos/Desktop/Icons/Output volume.png";
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
			path = "/etc/nixos/Desktop/Icons/Reload.png";
			size = 22;
			on-click = "hyprctl reload";
		};

		"image#Exit" = {
			path = "/etc/nixos/Desktop/Icons/Exit.png";
			size = 22;
			on-click-right = "hyprctl dispatch exit";
		};

		"image#Close" = {
			path = "/etc/nixos/Desktop/Icons/Close.png";
			size = 22;
			on-click = "hyprctl dispatch killactive";
			on-click-right = "hyprctl kill";
		};
	};

	# CSS style of the bar.
	style = ''
		* {
			font-family: UbuntuMono Nerd Font;
			font-size: 16px;
			margin: 0;
			padding: 0;
		}

		#battery {
			font-size: 16px;
		}

		#button {
			border-radius: 0;
		}

		#custom-* {
			font-size: 20px;
		}

		#image {
			background-color: #000000;
			margin: 2px 2px;
			padding: 2px 2px;
		}

		tooltip {
			background: #242424;
			border: 2px solid #0080ff;
		}

		tooltip label {
			color: #ffffff;
		}

		window#waybar {
			background: #000000;
			color: #ffffff;
			border-bottom: 2px solid transparent;
		}

		#workspaces button {
			border-bottom: 2px solid transparent;
			color: #005ab3;
			padding: 0 10px;
			font-weight: bold;
		}

		#workspaces button.active {
			background-color: rgba(255, 255, 255, 0.2);
			border-bottom: 2px solid #ffffff;
			color: #00ffff;
		}

		#workspaces button.empty {
			color: #555555;
		}

		#workspaces button.urgent {
			background-color: rgba (255, 0, 0, 0.4);
		}
	'';

}; }
