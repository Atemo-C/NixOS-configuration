{ config, pkgs, ... }: {

	home-manager.users.${config.Custom.Name}.programs.waybar = {
		# Whether to enable Waybar.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.enable
		enable = true;

		# Waybar package to use.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.package
		package = pkgs.unstable.waybar;

		# General settings for the bar.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.settings
		# https://github.com/Alexays/Waybar/wiki/Configuration
		settings.mainBar = {
			layer = "top";
			position = "top";
			spacing = 8;
			modifier-reset = "press";
			exclusive = true;
			fixed-center = true;
			passthrough = false;
			gtk-layer-shell = true;
		};

		# Whether to enable Waybar systemd integration.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.systemd.enable
		systemd.enable = true;
	};

}
