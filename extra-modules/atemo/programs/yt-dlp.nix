{ config, lib, pkgs, ... }: let cfg = config.programs.yt-dlp; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.yt-dlp = {
		enable = lib.mkEnableOption ''
			Whether to install yt-dlp, a feature-rich command-line audio/video downloader.
		'';

		package = lib.mkPackageOption pkgs "yt-dlp" {
			default = [ "yt-dlp" ];
			example = [ "yt-dlp-light" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}