# Documentation:
#───────────────
# • https://github.com/yt-dlp/yt-dlp#configuration
#
# Used NixOS packages:
#─────────────────────
# • [amfora]
#   https://github.com/makeworld-the-better-one/amfora
#
# • [lagrange]
#   https://gmi.skyjake.fi/lagrange/
#
# • [librewolf]
#   https://librewolf.net/
#
# • [tor-browser]
#   https://www.torproject.org/
#
# • [thunderbird]
#   https://thunderbird.net/
#
# • [qbittorrent]
#   https://www.qbittorrent.org/
#
# • [gallery-dl]
#   https://github.com/mikf/gallery-dl
#
# • [element-desktop]
#   https://element.io/
#
# • [revolt-desktop]
#   https://revolt.chat/
#
# • [vesktop]
#   https://github.com/Vencord/Vesktop
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.yt-dlp.enable
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.yt-dlp.package
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.yt-dlp.settings

{ config, pkgs, ... }: {

	environment.systemPackages = [
		# Gemini browsers.
		## A fancy terminal browser for the Gemini protocol.
		pkgs.amfora

		## A Beautiful Gemini Client.
		pkgs.lagrange

		# Web browsers.
		## A fork of Firefox, focused on privacy, security and freedom.
		pkgs.librewolf

		## Privacy-focused browser routing traffic through the Tor network.
		pkgs.tor-browser

		# A full-featured e-mail client.
		pkgs.thunderbird-bin

		# Featureful free software BitTorrent client.
		pkgs.unstable.qbittorrent

		# Command-line program to download image-galleries and collections from several image hosting sites.
		pkgs.gallery-dl

		# A feature-rich client for Matrix.org.
		pkgs.element-desktop

		# An open source user-first chat platform.
		pkgs.revolt-desktop

		# An alternate client for Discord with Vencord built-in.
		pkgs.unstable.vesktop
	];

	# Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork).
	home-manager.users.${config.custom.name}.programs.yt-dlp = {
		# Whether to enable yt-dlp.
		enable = true;

		# Package providing yt-dlp.
		package = pkgs.unstable.yt-dlp;

		# Configuration written to $XDG_CONFIG_HOME/yt-dlp/config.
		settings.output = ''"%(title)s.%(ext)s"'';
	};

}
