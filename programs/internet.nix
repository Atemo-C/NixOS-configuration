{ config, lib, pkgs, ... }: {
	programs = {
		# CLI Gemini client.
		amfora.install = true;

		# Matrix client.
		element-desktop.install = true;

		# Graphical Gemini client.
		lagrange.enable = false;

		# BitTorrent client.
		qbittorrent.install = true;

		# Open-source Disocrd-like chat platform.
		revolt-desktop.install = true;

		# Adobe Flash Player emulator.
		ruffle.install = true;

		# Graphical librespeed client.
		speedtest.install = true;

		# Anonymizing overlay network.
		tor.install = true;

		# Privacy-focused, Firefox-based browser routing traffic through the Tor network.
		tor-browser.install = true;

		# Alternative Discord client with Vencord built-in.
		vesktop.install = true;

		firefox = {
			# Whether to install the Firefox web browser.
			enable = true;

			# Which package of Firefox (or fork of it) to install.
			package = pkgs.librewolf;
		};
	};

	# Default web browser to use.
	environment.variables.BROWSER = if
	(config.programs.firefox.enable && config.programs.firefox.package == pkgs.librewolf)
	then "librewolf" else "firefox";
}