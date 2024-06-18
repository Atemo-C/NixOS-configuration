{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Batch image downloader.
		gallery-dl

		# Torrent manager.
		qbittorrent

		# Audio/Video downloader.
		unstable.yt-dlp
	];

}
