{ config, lib, pkgs, ... }: let cfg = config.programs.v4l-utils; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.v4l-utils.install = lib.mkEnableOption ''
		Whether to install V4L utils and libv4l, providing common image formats regarless of the v4l device.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.v4l-utils;
}