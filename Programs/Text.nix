{ config, pkgs, ... }: {

	environment = {
		systemPackages = with pkgs; [
			# A simple clipboard manager for Wayland.
			clipman

			# Command-line copy/paste utilities for Wayland.
			wl-clipboard

			# An emoji picker for linux, with custom tags support and localization.
			smile

			# GNOME Character Map, based on the Unicode Character Database.
			gucharmap

			# Modern and intuitive terminal-based text editor.
			micro-with-wl-clipboard

			# Aspell dictionaries.
			aspell
			aspellDicts.uk
			aspellDicts.fr
			aspellDicts.en
			aspellDicts.eo

			# Hunspell dictionaries.
			hunspell
			hunspellDicts.en_GB-ize
			hunspellDicts.en_US
			hunspellDicts.fr-any
		];

		# Set Micro as the default text editor.
		variables = { EDITOR = "micro"; };
	};

	# Whether to enable the GNU NANO text editor that is enabled by default.
	programs.nano.enable = false;

}
