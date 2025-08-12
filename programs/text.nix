{ config, lib, pkgs, ... }: let
	# Shortcut to check if Micro is installed.
	micro = lib.elem pkgs.micro-with-wl-clipboard config.environment.systemPackages;

	# Shortcuts to check if the Foot terminal is installed.
	foot = config.home-manager.users.${config.userName}.programs.foot.enable;
	footserver = config.home-manager.users.${config.userName}.programs.foot.server.enable;

in {
	environment = {
		systemPackages = with pkgs; [
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

			# Micro text editor.
			micro-with-wl-clipboard
		] ++ lib.optionals config.programs.niri.enable (with pkgs; [
			# An emoji picker for linux that can be integrated into various scripts.
			bemoji

			# A simple clipboard manager for Wayland.
			clipman

			# GNOME Character Map, based on the Unicode Character Database.
			gucharmap

			# Command-line copy/paste utilities for Wayland.
			# It currently needs to be manually added in the `./desktop/files/niri.kdl` file:
			# `wl-paste -t text --watch clipman store --no-persist --max-items=100`
			wl-clipboard
		]);

		# Set the default text editor.
		variables = lib.mkIf micro { EDITOR = "micro"; };
	};

	# Link the configuration files of the Micro text editor to the right places.
	home-manager.users.${config.userName}.systemd.user.tmpfiles.rules = lib.optionals micro [
		"L %h/.config/micro/settings.json - - - - /etc/nixos/programs/files/micro/settings.json"
		"L %h/.config/micro/init.lua - - - - /etc/nixos/programs/files/micro/init.lua"
		"L %h/.config/micro/colorschemes/atemo-colors.micro - - - - /etc/nixos/programs/files/micro/colors.micro"
		"L %h/.config/micro/bindings.json - - - - /etc/nixos/programs/files/micro/bindings.json"
	] ++ (if footserver then [
		"L %h/.local/share/applications/micro-footclient.desktop - - - - /etc/nixos/programs/files/micro/micro-footclient.desktop"
	] else if foot then [
		"L %h/.local/share/applications/micro-foot.desktop - - - - /etc/nixos/programs/files/micro/micro-foot.desktop"
	] else []);

	programs = {
		# Whether to let enabled the GNU NANO text editor.
		nano.enable = false;

		# Add a shell abbreviation for Micro.
		fish.shellAbbrs = lib.mkIf (config.programs.fish.enable && micro) { m = "micro"; };
	};

	services.languagetool = rec {
		# Whether to enable the LanguageTool server, a multilingual spelling, style, and grammar checker.
		enable = false;

		# Limit the maximum memory usage of the JVM running LanguageTool.
		jvmOptions = lib.optional enable "-Xmx2048m";
	};
}