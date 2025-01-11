{ config, pkgs, ... }: {

	environment = {
		systemPackages = [
			# A simple clipboard manager for Wayland.
			pkgs.clipman

			# Command-line copy/paste utilities for Wayland.
			pkgs.wl-clipboard

			# An emoji picker for linux, with custom tags support and localization.
			pkgs.smile

			# GNOME Character Map, based on the Unicode Character Database.
			pkgs.gucharmap

			# Modern and intuitive terminal-based text editor.
			pkgs.micro-with-wl-clipboard

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

}
