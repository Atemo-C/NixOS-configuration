{ config, pkgs, ... }: rec {

	environment = {
		# Set the default terminal emulator through an environment variable.
		variables = { TERMINAL = "alacritty"; };

		# The standard terminal emulator of LXDE, for compatiblity purposes.
		systemPackages = [ pkgs.lxterminal ];
	};

	# Start the terminal as a background daemon in the Hyprland Wayland compositor.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once = [
		(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable &&
		home-manager.users.${config.userName}.programs.alacritty then
			"alacritty --daemon" else null)

	# A cross-platform, GPU-accelerated terminal emulator.
	home-manager.users.${config.userName}.programs.alacritty = {
		# Enable the Alacritty terminal emulator.
		enable = true;

		# Alacritty configuration.
		settings = {
			window = {
				dynamic_padding = true;
				opacity = 0.8;
			};
			colors = {
				primary = {
					background = "#000000";
					foreground = "#eeeeee";
				};
				dim = {
					black = "#000000";
					blue = "#005ab3";
					cyan = "#00b3b3";
					green = "#00b300";
					magenta = "#b3005a";
					red = "#b30000";
					white = "#b3b3b3";
					yellow = "#b38600";
				};
				normal = {
					black = "#141414";
					blue = "#0080ff";
					cyan = "#00ffff";
					green = "#00ff00";
					magenta = "#ff0080";
					red = "#ff0000";
					white = "#e6e6e6";
					yellow = "#ffc000";
				};
				bright = {
					black = "#333333";
					blue = "#66b3ff";
					cyan = "#66ffff";
					green = "#66ff66";
					magenta = "#ff66b3";
					red = "#ff6666";
					white = "#ffffff";
					yellow = "#ffd966";
				};
			};
		};
	};

}
