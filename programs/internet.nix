{ config, lib, pkgs, ... }: {
	programs = {
		# CLI Gemini client.
		amfora.install = true;

		# Matrix client.
		element-desktop.install = true;

		# Graphical Gemini client.
		lagrange.enable = false;

		# Small 'net top' tool, grouping bandwidth by process.
		nethogs.install = true;

		# BitTorrent client.
		qbittorrent.install = true;

		# Qt Tox client.
		qtox.install = true;

		# Adobe Flash Player emulator.
		ruffle.install = true;

		# Graphical librespeed client.
		speedtest.install = true;

		# Anonymizing overlay network.
		tor.install = true;

		# Privacy-focused, Firefox-based browser routing traffic through the Tor network.
		tor-browser.install = true;

		firefox = {
			# Whether to install the Firefox web browser.
			enable = true;

			# Which package of Firefox (or fork of it) to install.
			package = pkgs.librewolf;
		};
	};

	services.tor = {
		# Whether to enable the Tor daemon.
		# By default, it runs without relay, exit, bridge, or client connectivity.
		enable = true;

		# Whether to enable the use of GeoIP databases.
		# Disabling this will disable by-country statistics fro bridges and relays,
		# and some client and third-party software functionality.
		enableGeoIP = false;

		# Whether to enable routing of application connections.
		# You might want to disable this if you plan running a dedicated Tor relay.
		client.enable = true;

		# Whether to build `/etc/tor/torsocks.conf`,
		# containing the specificed global torsocks configruation.
		torsocks.enable = true;
	};

	# Default web browser to use.
	environment.variables.BROWSER = if
	(config.programs.firefox.enable && config.programs.firefox.package == pkgs.librewolf)
	then "librewolf" else "firefox";
}