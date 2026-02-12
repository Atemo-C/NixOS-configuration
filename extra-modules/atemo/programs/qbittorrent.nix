{ config, lib, pkgs, ... }: let cfg = config.programs.qbittorrent; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.qbittorrent.install = lib.mkEnableOption ''
		Whether to install qBittorrent, a BitTorrent client.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.qbittorrent;
}