{ config, pkgs, ... }: let

	Alacritty = config.home-manager.users.${config.userName}.programs.alacritty.enable;
	Hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

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

		# Start the terminal as a background daemon in the Hyprland if it is used.
		wayland.windowManager.hyprland.settings.exec-once = if Alacritty && Hyprland then [
			"alacritty --daemon"
		] else [];
	};

}
