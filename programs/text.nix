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
			bemoji       # An emoji picker for linux that can be integrated into various scripts.
			clipman      # A simple clipboard manager for Wayland.
			gucharmap    # GNOME Character Map, based on the Unicode Character Database.
			wl-clipboard # Command-line copy/paste utilities for Wayland.
		]);

		# Set the default text editor.
		variables.EDITOR = lib.mkIf micro "micro";
	};

	# Link configuration files linked to the Micro text editor.
	home-manager.users.${config.userName}.systemd.user.tmpfiles.rules = lib.optionals micro [
		"L %h/.config/micro/settings.json - - - - /etc/nixos/programs/files/micro/settings.json"
		"L %h/.config/micro/init.lua - - - - /etc/nixos/programs/files/micro/init.lua"
		"L %h/.config/micro/colorschemes/atemo-colors.micro - - - - /etc/nixos/programs/files/micro/colors.micro"
		"L %h/.config/micro/bindings.json - - - - /etc/nixos/programs/files/micro/bindings.json"
		"L %h/.config/micro/syntax/nix.yaml - - - - /etc/nixos/programs/files/micro/nix.yaml"
	] ++ (if footserver then [
		"L %h/.local/share/applications/micro-footclient.desktop - - - - /etc/nixos/programs/files/micro/micro-footclient.desktop"
	] else if foot then [
		"L %h/.local/share/applications/micro-foot.desktop - - - - /etc/nixos/programs/files/micro/micro-foot.desktop"
	] else []);

	# Whether to let enabled the GNU NANO text editor.
	programs.nano.enable = false;

	# Add a shell abbreviation for Micro.
	programs.fish.shellAbbrs = lib.mkIf (config.programs.fish.enable && micro) { m = "micro"; };

	services.languagetool = {
		# Whether to enable the LanguageTool server, a multilingual spelling, style, and grammar checker.
		enable = true;

		# Which clients to allow access from.
		allowOrigin = lib.mkIf config.services.languagetool.enable "*";

		# Whether to make the server listen on all interfaces.
		public = lib.mkIf config.services.languagetool.enable false;

		# Port to listen to.
		port = lib.mkIf (config.services.languagetool.enable && config.services.languagetool.public) 4321;

		# Limit the maximum memory usage of the JVM running LanguageTool.
		jvmOptions = lib.optional config.services.languagetool.enable "-Xmx2048m";
	};

	networking.firewall.allowedTCPPorts = lib.optional (
		config.services.languagetool.enable && config.services.languagetool.public
	) config.services.languagetool.port;
}