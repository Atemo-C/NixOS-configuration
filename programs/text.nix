{ config, lib, pkgs, ... }: rec {
	programs = {
		# An emoji picker for Linux that can be integrated into various scripts.
		bemoji.enable = true;

		# A simple clipboard manager for Wayland.
		clipman.enable = true;

		# GNOME Character Map, based on the Unicode Character Database.
		gucharmap.enable = true;

		# Whether to let enabled the GNU NANO text editor.
		nano.enable = lib.mkIf programs.micro.enable false;

		# Command-line copy/paste utilities for Wayland.
		wl-clipboard.enable = true;

		aspell = {
			# Whether to enable Aspell dictionaries.
			enable = true;

			# Which Aspell dictionaries to install.
			dictionaries = with pkgs.aspellDicts; [
				en
				eo
				fr
				uk
			];
		};

		hunspell = {
			# Whether to enable Hunspell dictionaries.
			enable = true;

			# Which Hunspell dictionaries to install.
			dictionaries = with pkgs.hunspellDicts; [
				en_GB-ize
				en_US
				fr-any
			];
		};

		micro = {
			# Whether to install the Micro text editor.
			enable = true;

			# Which package of Micro to install.
			package = pkgs.micro-with-wl-clipboard;
		};

		# Shell abbreviation to start Micro.
		fish.shellAbbrs.m = lib.mkIf programs.micro.enable "micro";
	};

	# Set the default text editor.
	variables.EDITOR = lib.mkIf programs.micro.enable "micro";

	# Link Micro's configuration files.
	systemd.user.tmpfiles.users.${config.userName}.rules = [
		"L %h/.config/micro/settings.json - - - - /etc/nixos/programs/files/micro/settings.json"
		"L %h/.config/micro/init.lua - - - - /etc/nixos/programs/files/micro/init.lua"
		"L %h/.config/micro/colorschemes/atemo-colors.micro - - - - /etc/nixos/programs/files/micro/colors.micro"
		"L %h/.config/micro/bindings.json - - - - /etc/nixos/programs/files/micro/bindings.json"
		"L %h/.config/micro/syntax/nix.yaml - - - - /etc/nixos/programs/files/micro/nix.yaml"
	] ++ lib.optional programs.foot.enable
		"L %h/.local/share/applications/micro-footclient.desktop - - - - /etc/nixos/programs/files/micro/micro-footclient.desktop";

	services.languagetool = {
		# Whether to enable the LanguageTool server, a multilingual spelling, style, and grammar checker.
		enable = true;

		# Which clients to allow access from.
		allowOrigin = "*";

		# Whether to make the server listen on all interfaces.
		public = false;

		# Port to listen to.
		port = 2222;

		# Limit the maximum memory usage of the JVM running LanguageTool.
		jvmOptions = lib.optional config.services.languagetool.enable "-Xmx3072m";
	};

	# Open the relevant firewall port used by the LanguageTool server.
	networking.firewall.allowedTCPPorts = lib.optional (
		services.languagetool.enable
		&& services.languatetool.public
	) services.languagetool.port;
}