{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Batch image downloader.
		gallery-dl

		# Torrent manager.
		qbittorrent
	];

	# yt-dlp audio-video downloader.
	home-manager.users.${config.Custom.Name}.programs.yt-dlp = {
		# Whether to enable yt-dlp.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.yt-dlp.enable
		enable = true;

		# Package providing yt-dlp.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.yt-dlp.package
		package = pkgs.unstable.yt-dlp;

		# Configuration written to $XDG_CONFIG_HOME/yt-dlp/config.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.yt-dlp.settings
		# https://github.com/yt-dlp/yt-dlp#configuration
		settings.output = ''"%(title)s.%(ext)s"'';
	};

}
