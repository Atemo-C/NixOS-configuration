{ config, lib, pkgs, ... }: {
	programs = {
		# CLI Gemini client.
		amfora.enable = true;

		# Matrix client.
		element-desktop.enable = true;

		# Graphical Gemini client.
		lagrange.enable = true;

		# BitTorrent client.
		qbittorrent.enable = true;

		# Open-source Disocrd-like chat platform.
		revolt-desktop.enable = true;

		# Adobe Flash Player emulator.
		ruffle.enable = true;

		# Graphical librespeed client.
		speedtest.enable = true;

		# Anonymizing overlay network.
		tor.enable = true;

		# Privacy-focused, Firefox-based browser routing traffic through the Tor network.
		tor-browser.enable = true;

		# Alternative Discord client with Vencord built-in.
		vesktop.enable = true;

		firefox = {
			# Whether to install the Firefox web browser.
			enable = true;

			# Which package of Firefox (or fork of it) to install.
			package = pkgs.librewolf;
		};
	};

	# Default web browser to use.
	environment.variables.BROWSER = lib.mkIf (
		config.programs.firefox.enable
		&& config.programs.firefox.package == pkgs.librewolf
	) "librewolf" || lib.mkIf config.programs.firefox.enable "firefox";
}