{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# A fancy terminal browser for the Gemini protocol.
		amfora

		# A Beautiful Gemini Client.
		lagrange

		# A fork of Firefox, focused on privacy, security and freedom.
		librewolf

		# Graphical librespeed client written using GTK4 + libadwaita.
		speedtest

		# Privacy-focused browser routing traffic through the Tor network.
		tor-browser

		# Featureful free software BitTorrent client.
		qbittorrent

		# Command-line program to download image-galleries and collections from several image hosting sites.
		gallery-dl

		# A feature-rich client for Matrix.org.
		element-desktop

		# An open source user-first chat platform.
		revolt-desktop

		# An alternate client for Discord with Vencord built-in.
		vesktop
	];

	# Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork).
	home-manager.users.${config.custom.name}.programs.yt-dlp = {
		# Whether to enable yt-dlp.
		enable = true;

		# Configuration written to $XDG_CONFIG_HOME/yt-dlp/config.
		settings.output = ''"%(title)s.%(ext)s"'';
	};

}
