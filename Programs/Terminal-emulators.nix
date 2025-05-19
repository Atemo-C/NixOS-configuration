{ config, lib, pkgs, ... }: let

	# Alacritty terminal emulator; Toggleable in this module.
	alacritty = config.home-manager.users.${config.userName}.programs.alacritty.enable;

	# Hyprland check for autostarting a terminal emulator daemon.
	# Hyprland is toggleable in the `./Hyprland/Enable.nix` module.
	hyprland = config.enableHyprland;

in {

	# Set the default terminal emulator through an environment variable.
	environment.variables = { TERMINAL = "alacritty"; };

	home-manager.users.${config.userName} = {
	programs.alacritty = rec {
		# Whetehr to enable the Alacritty, a cross-platform, GPU-accelerated terminal emulator.
		enable = true;

		# Alacritty configuration.
		settings.window = lib.optionalAttrs enable {
				dynamic_padding = true;
				opacity = 0.8;
			};
		};

		# Start the terminal as a background daemon in the Hyprland if it is used.
		wayland.windowManager.hyprland.settings.exec-once = lib.optionals (alacritty && hyprland) [
			"alacritty --daemon"
		];
	};

}
