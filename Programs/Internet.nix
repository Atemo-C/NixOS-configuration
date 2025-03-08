{ config, pkgs, ... }: {

	environment.systemPackages = [
		# A fancy terminal browser for the Gemini protocol.
		pkgs.amfora

		# A Beautiful Gemini Client.
		pkgs.lagrange

		# A fork of Firefox, focused on privacy, security and freedom.
		pkgs.librewolf

		# Privacy-focused browser routing traffic through the Tor network.
		pkgs.tor-browser

		# A full-featured e-mail client.
		pkgs.thunderbird-bin

		# Featureful free software BitTorrent client.
		pkgs.qbittorrent

		# Command-line program to download image-galleries and collections from several image hosting sites.
		pkgs.gallery-dl

		# A feature-rich client for Matrix.org.
		pkgs.element-desktop

		# An open source user-first chat platform.
		pkgs.revolt-desktop

		# An alternate client for Discord with Vencord built-in.
		pkgs.vesktop
	];

	# Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork).
	home-manager.users.${config.custom.name}.programs.yt-dlp = {
		# Whether to enable yt-dlp.
		enable = true;

		# Configuration written to $XDG_CONFIG_HOME/yt-dlp/config.
		settings.output = ''"%(title)s.%(ext)s"'';
	};

}
