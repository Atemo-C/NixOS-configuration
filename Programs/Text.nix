{ config, pkgs, ... }: {

	environment = {
		systemPackages = [
			# A simple clipboard manager for Wayland.
			(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
				pkgs.clipman else null)

			# Command-line copy/paste utilities for Wayland.
			(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
				pkgs.wl-clipboard else null)

			# An emoji picker for linux, with custom tags support and localization.
			pkgs.smile

			# GNOME Character Map, based on the Unicode Character Database.
			pkgs.gucharmap

			# Modern and intuitive terminal-based text editor.
			(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
				pkgs.micro-with-wl-clipboard else pkgs.micro)

			# Aspell dictionaries.
			pkgs.aspell
			pkgs.aspellDicts.uk
			pkgs.aspellDicts.fr
			pkgs.aspellDicts.en
			pkgs.aspellDicts.eo

			# Hunspell dictionaries.
			pkgs.hunspell
			pkgs.hunspellDicts.en_GB-ize
			pkgs.hunspellDicts.en_US
			pkgs.hunspellDicts.fr-any
		];

		# Set Micro as the default text editor.
		variables = { EDITOR = "micro"; };
	};

	# Whether to enable the GNU NANO text editor that is enabled by default.
	programs.nano.enable = false;

	# Start the clipboard manager in the Hyprland Wayland compositor.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once = [
		(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
			"wl-paste -t text --watch clipman store --no-persist --max-items=100" else null)
	];

}
