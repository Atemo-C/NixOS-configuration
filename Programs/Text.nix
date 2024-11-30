# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=environment.variables
# • https://search.nixos.org/options?channel=24.11&show=programs.nano.enable
#
# Used NixOS packages:
#─────────────────────
# • [clipman]
#   https://github.com/chmouel/clipman
#
# • [wl-clipboard]
#   https://github.com/bugaevc/wl-clipboard
#
# • [smile]
#   https://mijorus.it/projects/smile/
#
# • [gucharmap]
#   https://gitlab.gnome.org/GNOME/gucharmap
#
# • [micro]
#   https://micro-editor.github.io/
#
# • [aspell]
#   http://aspell.net/
#
# • [hunspell]
#   https://hunspell.sourceforge.net/

{ config, pkgs, ... }: {

	environment = {
		systemPackages = [
			# Clipboard.
			## A simple clipboard manager for Wayland.
			pkgs.clipman

			## Command-line copy/paste utilities for Wayland.
			pkgs.wl-clipboard

			# Special characters.
			## An emoji picker for linux, with custom tags support and localization.
			pkgs.smile

			## GNOME Character Map, based on the Unicode Character Database.
			pkgs.gucharmap

			# Modern and intuitive terminal-based text editor.
			pkgs.micro

			# Spell-checking.
			## Aspell dictionaries.
			pkgs.aspell
			pkgs.aspellDicts.uk
			pkgs.aspellDicts.fr
			pkgs.aspellDicts.en
			pkgs.aspellDicts.eo

			## Hunspell dictionaries.
			pkgs.hunspell
			pkgs.hunspellDicts.en_GB-ize
			pkgs.hunspellDicts.en_US
			pkgs.hunspellDicts.fr-any
		];

		# Set Micro as the default text editor.
		variables = { EDITOR = "micro"; };
	};

	# Disabling the GNU NANO text editor that is enabled by default.
	## https://search.nixos.org/options?channel=24.11&show=programs.nano.enable
	programs.nano.enable = false;

}
