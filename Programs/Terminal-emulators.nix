{ config, pkgs, ... }: rec {

	environment = {
		# Set the default terminal emulator through an environment variable.
		variables = { TERMINAL = "alacritty"; };

		# The standard terminal emulator of LXDE, for compatiblity purposes.
		systemPackages = [ pkgs.lxterminal ];
	};

	home-manager.users.${config.userName} = {
	# A cross-platform, GPU-accelerated terminal emulator.
	programs.alacritty = {
		# Enable the Alacritty terminal emulator.
		enable = true;

		# Alacritty configuration.
		settings.window = {
				dynamic_padding = true;
				opacity = 0.8;
			};
		};

		# Start the terminal as a background daemon in the Hyprland Wayland compositor.
		wayland.windowManager.hyprland.settings.exec-once = [
			(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable &&
			home-manager.users.${config.userName}.programs.alacritty.enable then
				"alacritty --daemon" else null)
		];
	};

}
