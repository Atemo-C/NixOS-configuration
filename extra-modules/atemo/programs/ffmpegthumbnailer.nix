{ config, lib, pkgs, ... }: let cfg = config.programs.ffmpegthumbnailer; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.ffmpegthumbnailer.install = lib.mkEnableOption ''
		Whether to install ffmpegthumbnailer, a lightweight video thumbnailer.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.ffmpegthumbnailer;
}