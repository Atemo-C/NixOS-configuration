{ config, pkgs, ... }: { home-manager.users.${config.userName}.programs.waybar = {

	# Enable the Waybar bar.
	enable = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

	# Whether to enable Waybar systemd integration.
	systemd.enable = true;

	# Waybar configuration.
	settings.mainBar = {
		# Whether the bar is displayed in front of (top) or behind (bottom) the windows.
		layer = "top";

		# Modules to be displayed on the left of the bar.
		modules-left = [
			"image#programs"   "custom/spacer"
			"image#files"      "custom/spacer"
			"image#screenshot" "custom/spacer"
			"image#clipboard"  "custom/spacer"
			"image#picker"     "custom/spacer"
			"tray"             "custom/bigspacer"
			"image#power"
		];

		# Modules to be displayed in the center of the bar.
		modules-center = [
			"hyprland/workspaces"
		];

		# Modules to be displayed on the right of the bar.
		modules-right = [
			"image#cpu"   "cpu"    "temperature" "custom/spacer"
			"image#ram"   "memory" "custom/spacer"
#			"battery"     "custom/spacer"
#			"backlight"   "custom/spacer"
			"wireplumber" "custom/spacer"
			"clock"       "custom/bigspacer"
			"image#close"
		];

		# Spacer module. A normal spacer to be but between modules.
		"custom/spacer" = {
			format = "  ";
			interval = "once";
			tooltip = false;
		};

		# Big spacer module. A bigger spacer when the normal spacer is not thicc enough.
		"custom/bigspacer" = {
			format = "    ";
			interval = "once";
			tooltip = false;
		};

		# Program launcher module.
		# • [LMB] Opens a program launcher.
		# • [RMB] Opens a generic run launcher.
		"image#programs" = {
			on-click = "dash /etc/nixos/Scripts/Programs.sh";
			on-click-right = "tofi-drun --drun-launch=true";
			path = "/etc/nixos/Icons/Programs.svg";
			size = 22;
		};

		# File manager shortcut module.
		# • [LMB] Opens a file manager in the default directory.
		# • [RMB] Opens a file manager in the Downloads directory.
		"image#files" = {
			on-click = "thunar";
			on-click-right = "thunar $HOME/Downloads/";
			path = "/etc/nixos/Icons/Files.svg";
			size = 22;
		};

		# Screenshots shortcut module.
		# • [LMB] Select a region to screenshot without saving.
		# • [RMB] Take a single-monitor screenshot without saving.
		# • [MMB] Take an all-monitors screenshot without saving.
		# • [BMB] Select a region to screeshot.
		# • [FMB] Take a single-monitor screenshot.
		# • [U/D] Take an all-monitors screenshot.
		"image#screenshot" = rec {
			on-click = "dash /etc/nixos/Scripts/Screenshot.sh --copy area";
			on-click-right = "dash /etc/nixos/Scripts/Screenshot.sh --copy monitor";
			on-click-middle = "dash /etc/nixos/Scrpts/Screenshot.sh --copy all";
			on-click-backward = "dash /etc/nixos/Scripts/Screenshot.sh --save area";
			on-click-forward = "dash /etc/nixos/Scripts/Screenshot.sh --save monitor";
			on-scroll-down = "dash /etc/nixos/Scripts/Screenshot.sh --save all";
			on-scroll-up = on-scroll-down;
			path = "/etc/nixos/Icons/Screenshot.svg";
			size = 22;
		};

		# Clipboard module.
		# • [LMB] Opens a clipboard manager.
		# • [RMB] Opens a clipboard text file.
		# • [MMB] Clears the clipboard content of the clipboard manager.
		# • [F/BMB] Opens a bookmarks text file.
		"image#clipboard" = rec {
			on-click = "clipman pick -t CUSTOM -T tofi";
			on-click-right = "alacritty -e micro $HOME/Documents/Clipboard.txt";
			on-click-middle = "clipman clear --all & notify-send -t 1500 'Clipboard cleared.'";
			on-click-backward = "alacritty -e micro $HOME/Documents/Bookmarks.txt";
			on-click-forward = on-click-backward;
			path = "/etc/nixos/Icons/Clipboard.svg";
			size = 22;
		};

		# Color picker module.
		# • [LMB] Pick a color anywhere on the desktop.
		# • [RMB] Opens a graphical color picker.
		"image#picker" = {
			on-click = "dash /etc/nixos/Scripts/Picker.sh";
			on-click-right = "gcolor3";
			path = "/etc/nixos/Icons/Picker.svg";
			size = 22;
		};

		# System tray module.
		tray = {
			icon-size = 22;
			reverse-direction = true;
			spacing = 8;
		};

		# Power menu module.
		"image#power" = {
			on-click = "dash /etc/nixos/Scripts/Power.sh";
			path = "/etc/nixos/Icons/Power.svg";
			size = 22;
		};

		# Hyprland workspaces module.
#		"hyprland/workspaces" = { persistent-workspaces = { "*" = 8; }; };

		# CPU monitoring modules.
		# • [LMB] Opens a system resources monitor.
		# • [RMB] Shows detailed current system temperatures at a glance.
		# • [MMB] Shows detailed current memory usage at a glance.
		"image#cpu" = {
			on-click = "alacritty -e btop";
			on-click-right = ''notify-send "$(sensors)"'';
			on-click-middle = ''notify-send "$(free -mht)"'';
			path = "/etc/nixos/Icons/CPU.svg";
			size = 22;
		};
		"cpu" = {
			format = "{usage}% ";
			interval = 1;
			on-click = "alacritty -e btop";
			on-click-right = ''notify-send "$(sensors)"'';
			on-click-middle = ''notify-send "$(free -mht)"'';
		};
		"temperature" = {
			critical-threshold = 75;
			format = "{temperatureC}°C";
			hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
			interval = 1;
			on-click = "alacritty -e btop";
			on-click-right = ''notify-send "$(sensors)"'';
			on-click-middle = ''notify-send "$(free -mht)"'';
		};

		# RAM monitoring modules.
		# • [LMB] Opens a system resources monitor.
		# • [RMB] Shows detailed current memory usage at a glance.
		# • [MMB] Shows detailed current system temperatures at a glance.
		"image#ram" = {
			on-click = "alacritty -e btop";
			on-click-right = ''notify-send "$(sensors)"'';
			on-click-middle = ''notify-send "$(free -mht)"'';
			path = "/etc/nixos/Icons/RAM.svg";
			size = 22;
		};
		"memory" = {
			format = "{percentage}%";
			interval = 1;
			on-click = "alacritty -e btop";
			on-click-right = ''notify-send "$(sensors)"'';
			on-click-middle = ''notify-send "$(free -mht)"'';
		};

		# Battery monitoring module.
		# Not yet implemented: Feel free to donate a laptop if you want.
		# It only needs to be good enough to run this NixOS configuration.
		# • [LMB] Would open a menu to select a power profile mode on compatible systems.
		# • [RMB] Would show a detailed battery readout at a glance.

		# Backlight module.
		# Not yet implemented, same reason as above.
		# • [SCRL UP] Would increase the screen brightness.
		# • [SCRL DN] Would decrease the screen brightness.
		# Note: A similar module could be made for compatible backlit keyboards.

		# Audio output monitoring and control module.
		# • [LMB] Opens a sound control program.
		# • [RMB] Opens an audio patchbay.
		# • [MMB] Toggles muting the output volume.
		# • [SCRL UP] Increases the output volume by 1%.
		# • [SCRL DN] Decreases the output volume by 1%.
		"wireplumber" = {
			format = "{icon} {volume}%";
			format-icons = [ "󰕿 "  "󰖀 " "󰕾 "];
			format-muted = " ";
			on-click = "pwvucontrol";
			on-click-right = "qpwgraph";
			on-click-middle = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
		};

		# Date and time module.
		# • [LMB] Opens a calendar.
		"clock" = {
			format = "{:%d/%m/%Y %H:%M:%S}";
			interval = 1;
			on-click = "alacritty -e calcurse";
		};

		# Close/kill button module.
		# • [LMB] Closes the focused window.
		# • [RMB (hold)] Select a window to kill/force quit.
		"image#close" = {
			on-click = "hyprctl dispatch killactive";
			on-click-right = "hyprctl kill";
			path = "/etc/nixos/Icons/Close.svg";
			size = 22;
		};
	};

	# CSS styling of the bar and its modules.
	style = ''
		* {
			font-family: UbuntuMono Nerd Font;
			font-size: 16px;
			margin: 0;
			padding: 0;
			border-radius: 0px;
		}

		#image {
			background-color: rgba(0, 0, 0, 0);
			margin: 2px 2px;
			padding: 2px 2px;
		}

		window#waybar {
			background: rgba(0, 0, 0, 0.8);
			color: #ffffff;
			border-bottom: 2px solid transparent;
		}

		tooltip {
			background: #1d1d1d;
			border: 2px solid #0080ff;
		}

		tooltip label {
			color: #ffffff;
		}

		#workspaces button {
			border-bottom: 2px solid transparent;
			color: #005ab3;
			padding: 0 8px;
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
