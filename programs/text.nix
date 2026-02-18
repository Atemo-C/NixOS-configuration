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
			dictionaries = with pkgs.hunspellDicts; [
				en_GB-ize
				en_US
				fr-any
			];
		};

		micro = {
			# Whether to enable the Micro text editor.
			enable = true;

			# Which Micro package to install.
			package = pkgs.micro-full;
		};

		# Shell abbreviation to start Micro.
		fish.shellAbbrs.m = lib.mkIf programs.micro.enable "micro";
	};

	# Set the default text editor.
	environment.variables.EDITOR = lib.mkIf programs.micro.enable "micro";

	# Link Micro's configuration directory.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.optional programs.micro.enable
	"L %h/.config/micro/ - - - - /etc/nixos/files/micro/";

	services.languagetool = {
		# Whether to enable the LanguageTool server, a multilingual spelling, style, and grammar checker.
		enable = if (lib.elem config.networking.hostName [ "R5-PC" ]) then true else false;

		# Which clients to allow access from.
		allowOrigin = "*";

		# Whether to make the server listen on all interfaces.
		public = false;

		# Port to listen to.
		port = 2222;

		# Limit the maximum memory usage of the JVM running LanguageTool.
		jvmOptions = [ "-Xmx2048m" ];
	};

	# Open the relevant firewall port used by the LanguageTool server.
	networking.firewall.allowedTCPPorts = lib.optional (services.languagetool.enable && services.languagetool.public)
	services.languagetool.port;
}