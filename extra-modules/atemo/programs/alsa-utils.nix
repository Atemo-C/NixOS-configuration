{ config, lib, pkgs, ... }: let cfg = config.programs.alsa-utils; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.alsa-utils.install = lib.mkEnableOption ''
		Whether to install alsa-utils, utilities for the Advanced Linux Sound System Architecture.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.alsa-utils;
}