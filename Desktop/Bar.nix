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

{ config, pkgs, ... }: { home-manager.users.${config.custom.name}.programs.waybar = {

	# Whether to enable Waybar.
	enable = true;

	# Waybar package to use.
	package = pkgs.unstable.waybar;

	# Whether to enable Waybar systemd integration.
	systemd.enable = true;

	# Waybar configuration.
	settings.mainBar = {
		# Decide if the bar is displayed in front (top) of the windows or behind (bottom) them.
		layer = "top";

		# Modules that will be displayed on the left.
		modules-left = [
			"image#Programs"   "custom/Spacer"
#			"image#Settings"   "custom/Spacer"
			"image#Files"      "custom/Spacer"
			"image#Screenshot" "custom/Spacer"
			"image#Clipboard"  "custom/Spacer"
			"image#Picker"     "custom/Spacer"
			"image#Tray"       "custom/Bigspacer"
			"image#Power"
		];

		# Modules that will be displayed in the center.
		modules-center = [ "hyprland/workspaces" ];

		# Modules that will be displayed on the right.
		modules-right = [
			"image#CPU"   "cpu"           "temperature"   "custom/Spacer"
			"image#RAM"   "memory"        "custom/Spacer"
#			"battery"     "custom/Spacer"
#			"backlight"   "custom/Spacer"
			"wireplumber" "custom/Spacer"
			"clock"       "custom/Bigspacer"
			"image#Close"
		];

		# Modules configuration.

		## Spacer.
		##────────
		## A normal spacer to be put between modules.
		"custom/Spacer" = {
			format   = "  ";
			interval = "once";
			tooltip  = false;
		};

		## Big spacer.
		##────────────
		## A bigg spacer to separate modules further and prevent accidental clicks.
		"custom/Bigspacer" = {
			format   = "    ";
			interval = "once";
			tooltip  = false;
		};

		## Program launcher.
		##──────────────────
		## A program launcher icon.
		## • Left click opens a custom program launcher.
		## • Right click opens a generic run launcher.
		"image#Programs" = {
			on-click       = "bash /etc/nixos/Desktop/Scripts/Programs.sh";
			on-click-right = "tofi-drun --drun-launch=true";
			path           = "/etc/nixos/Desktop/Icons/Programs.png";
			size           = 22;
			tooltip-format = "Program launcher";
		};

#		## Settings.
#		##──────────
#		## A quick-settings icon to temporarily change settings.
#		"image#Settings" = {
#			interval       = "once";
#			on-click       = "bash /etc/nixos/Desktop/Scripts/Settings.sh";
#			path           = "/etc/nixos/Desktop/Icons/Settings.png";
#			size           = 22;
#			tooltip-format = "Quick settings";
#		};

		## Files.
		##───────
		## A simple file manager shortcut.
		## • Left click opens the default file manager.
		## • Right click opens the download directory in the default file manager.
		"image#Files" = {
			on-click       = "thunar";
			on-click-right = "thunar $HOME/Downloads/";
			path           = "/etc/nixos/Desktop/Icons/Files.png";
			size           = 22;
			tooltip-format = "Files";
		};

		## Screenshots.
		##─────────────
		## A screenshot shortcut.
		## • Left click lets you select a region to screenshot.
		## • Right click takes a full-screen screenshot.
		## • Middle click lets you select a window to screenshot.
		## • Forward click lets you select a region to screenshot without saving.
		## • Backward click takes a full-screen screenshot without saving.
		## •
		"image#Screenshot" = {
			on-click          = "bash /etc/nixos/Desktop/Scripts/Screenshots/Region.sh";
			on-click-right    = "bash /etc/nixos/Desktop/Scripts/Screenshots/Fullscreen.sh";
			on-click-middle   = "bash /etc/nixos/Desktop/Scripts/Screenshots/Window.sh";
			on-click-backward = "bash /etc/nixos/Desktop/Scripts/Screenshots/Region-clipboard.sh";
			on-click-forward  = "bash /etc/nixos/Desktop/Scripts/Screenshots/Fullscreen-clipboard.sh";
			path              = "/etc/nixos/Desktop/Icons/Screenshot.png";
			size              = 22;
			tooltip-format    = "Take a screenshot";
		};

		## Clipboard.
		##───────────
		## A clipboard shortcut.
		## • Left click opens the clipboard manager (temporary clipboard).
		## • Right click opens the clipboard file (permanent clipboard).
		## • Middle click clears the temporary clipboard.
		"image#Clipboard" = {
			on-click        = "clipman pick -t CUSTOM -T tofi";
			on-click-right  = "alacritty -e micro $HOME/Documents/Clipboard.txt";
			on-click-middle = "clipman clear --all & notify-send -t 1500 'Clipboard cleared'";
			path            = "/etc/nixos/Desktop/Icons/Clipboard.png";
			size            = 22;
			tooltip-format  = "Clipboard";
		};

		## Color picker.
		##──────────────
		## A color picker shortcut.
		## • Left click lets you pick a color from the screen.
		## • Right click opens a more complete color picker.
		"image#Picker" = {
			on-click       = "bash /etc/nixos/Desktop/Scripts/Picker.sh";
			on-click-right = "gcolor3";
			path           = "/etc/nixos/Desktop/Icons/Picker.png";
			size           = 22;
			tooltip-format = "Color picker";
		};

		## System tray.
		##─────────────
		tray = {
			icon-size         = 22;
			spacing           = 8;
			reverse-direction = true;
		};

		## Power menu.
		##────────────
		## A power menu with power and logout options.
		"image#Power" = {
			on-click       = "bash /etc/nixos/Desktop/Scripts/Power.sh";
			path           = "/etc/nixos/Desktop/Icons/Power.png";
			size           = 22;
			tooltip-format = "Power menu";
		};

		## Hyprland workspaces.
		##─────────────────────
		## Settings for Hyprland's workspaces.
		"hyprland/workspaces" = {
			persistent-workspaces = { "*" = 8; };
			on-scroll-up          = "hyprctl dispatch workspace e+1";
			on-scroll-down        = "hyprctl dispatch workspace e-1";
		};

		## CPU monitor.
		##─────────────
		## A CPU usage and temperature monitor.
		## • Left click opens a system resource monitor.
		## • Right click shows a detailed temperature readout.
		"image#CPU" = {
			on-click       = "alacritty -e btop";
			on-click-right = "notify-send '$(sensors)'";
			path           = "/etc/nixos/Desktop/Icons/CPU.png";
			size           = 22;
			tooltip        = false;
		};
		"cpu" = {
			interval       = 1;
			format         = "{usage}% ";
			on-click       = "alacritty -e btop";
			on-click-right = "notify-send '$(sensors)'";
		};
		"temperature" = {
			critical-threshold = 75;
			interval           = 1;
			hwmon-path         = "/sys/class/hwmon/hwmon1/temp1_input";
			format             = "{temperatureC}°C";
			on-click           = "alacritty -e btop";
			on-click-right     = "notify-send '$(sensors)'";
		};

		## RAM monitor.
		##─────────────
		## A RAM usage monitor.
		## • Left click opens a system resource monitor.
		## • Right click shows a detailed memory readout.
		"image#RAM" = {
			on-click       = "alacritty -e btop";
			on-click-right = ''notify-send "$(free -mh)"'';
			path           = "/etc/nixos/Desktop/Icons/RAM.png";
			size           = 22;
			tooltip        = false;
		};
		"memory" = {
			interval       = 1;
			format         = "{percentage}%";
			on-click       = "alacritty -e btop";
			on-click-right = ''notify-send "$(free -mh)"'';
		};

		## Battery.
		##─────────
		## A battery monitor.
		## • Left click opens a menu to select a power profile mode on compatible systems.
		## • Right click shows a detailed battery readout.
		##─────────
		## Not implemented yet: I have no device to test it on.
		## Feel free to donate a laptop, heh :p

		## Backlight.
		##───────────
		## Backlight control.
		## • Scrolling up increases the screen brightness.
		## • Scrolling down decreases the screen brightness.
		##───────────
		## Not implemented yet: I have no device to test it on.
		## Feel free to donate a laptop, heh :p²

		## Audio output.
		##──────────────
		## Audio output monitor and control (if only it supported input as well).
		## • Left click opens the pavucontrol sound control.
		## • Right click opens the qpwgraph PipeWire patchbay.
		## • Middle click toggles muting the output volume.
		## • Scrolling up increases the output volume.
		## • Scrolling down decreases the output volume.
		"wireplumber" = {
			format          = "{icon} {volume}%";
			format-icons    = [ "󰕿 "  "󰖀 " "󰕾 "];
			format-muted    = " ";
			on-click        = "pavucontrol";
			on-click-right  = "qpwgraph";
			on-click-middle = "amixer -q sset Master toggle";
		};

		## Date and time.
		##───────────────
		## Displays the date and time.
		## • Left click opens a calendar.
		"clock" = {
			format   = "{:%d/%m/%Y %H:%M:%S}";
			interval = 1;
			on-click = "alacritty -e calcurse";
		};

		## Close/kill button.
		##───────────────────
		## A button to close/kill a program.
		## • Left click closes the focused window.
		## • Right click and hold lets you select a window to kill.
		"image#Close" = {
			path           = "/etc/nixos/Desktop/Icons/Close.png";
			size           = 22;
			on-click       = "hyprctl dispatch killactive";
			on-click-right = "hyprctl kill";
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
			background: #242424;
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
