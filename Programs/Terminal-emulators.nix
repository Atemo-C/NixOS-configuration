{ config, pkgs, ... }: let

	alacritty = config.home-manager.users.${config.userName}.programs.alacritty.enable;
	hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	# Set the default terminal emulator through an environment variable.
	environment.variables = { TERMINAL = "alacritty"; };

	home-manager.users.${config.userName} = {
	programs.alacritty = {
		# Whetehr to enable the Alacritty, a cross-platform, GPU-accelerated terminal emulator.
		enable = true;

		# Alacritty configuration.
		settings.window = if alacritty then {
				dynamic_padding = true;
				opacity = 0.8;
			} else {};
		};

		# Start the terminal as a background daemon in the Hyprland if it is used.
		wayland.windowManager.hyprland.settings.exec-once = if alacritty && hyprland then [
			"alacritty --daemon"
		] else [];
	};

}
