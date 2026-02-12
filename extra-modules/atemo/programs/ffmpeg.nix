{ config, lib, pkgs, ... }: let cfg = config.programs.ffmpeg; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.ffmpeg = {
		enable = lib.mkEnableOption ''
			Whether to enable FFmpeg, a complete, cross-platform solution to record, convert, and stream audio and video.
		'';

		package = lib.mkPackageOption pkgs "ffmpeg-full" {
			default = [ "ffmpeg-full" ];
			example = [ "ffmpeg_7_headless" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}