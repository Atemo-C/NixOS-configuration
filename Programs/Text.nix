{ config, lib, pkgs, ... }: let

	# Hyprland check for clipboard management.
	# Hyprland is toggleable in the `./Hyprland/Enable.nix` module.
	hyprland = config.enableHyprland;

in {

	environment = {
		systemPackages = [
			# An emoji picker for linux, with custom tags support and localization.
			pkgs.smile

			# GNOME Character Map, based on the Unicode Character Database.
			pkgs.gucharmap

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
		] ++ (
			# Only install these utilities if Hyprland is used.
			if hyprland then [
				# A simple clipboard manager for Wayland.
				pkgs.clipman

				# Command-line copy/paste utilities for Wayland.
				pkgs.wl-clipboard

				# Modern and intuitive terminal based text editor with Wayland clipboard support.
				pkgs.micro-with-wl-clipboard
			] else [ pkgs.micro ]
		);

		# Set Micro as the default text editor.
		variables = { EDITOR = "micro"; };
	};

	# Whether to enable the GNU NANO text editor that is enabled by default.
	programs.nano.enable = false;

	# Start the clipboard manager in Hyprland if it is used.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once =
		lib.optionalAttrs hyprland [ "wl-paste -t text --watch clipman store --no-persist --max-items=100" ];

}
