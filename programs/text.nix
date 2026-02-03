{ config, lib, pkgs, ... }: rec {
	programs = {
		# GNOME Character Map, based on the Unicode Character Database.
		gucharmap.install = true;

		# Whether to let enabled the GNU NANO text editor.
		nano.enable = lib.mkIf config.programs.micro.enable false;

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
			dictionaries = with pkgs.hunstpellDicts; [
				en_GB-ize
				en_US
				fr-any
			];
		};

		micro = {
			# Whether to enable the Micro text editor.
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
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.optionals programs.micro.enable [
		"L %h/.config/micro/settings.json - - - - /etc/nixos/files/micro/settings.json"
		"L %h/.config/micro/init.lua - - - - /etc/nixos/files/micro/init.lua"
		"L %h/.config/micro/colorschemes/atemo-colors.micro - - - - /etc/nixos/files/micro/colors.micro"
		"L %h/.config/micro/bindings.json - - - - /etc/nixos/files/micro/bindings.json"
		"L %h/.config/micro/syntax/nix.yaml - - - - /etc/nixos/files/micro/nix.yaml"
	];

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
		jvmOptions = "-Xmx2048m";
	};

	# Open the relevant firewall port used by the LanguageTool server.
	networking.firewall.allowedTCPPorts = lib.optional (services.languagetool.enable && services.languetool.public)
	services.languagetool.port;
}