{ config, lib, pkgs, ... }: let cfg = config.programs.nufraw-thumbnailer; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.nufraw-thumbnailer.install = lib.mkEnableOption ''
		Whether to install the nufraw thumbnailer, a utility to read and manipulate raw images from digital cameras.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.nufraw-thumbnailer;
}