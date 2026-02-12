{ config, lib, pkgs, ... }: let cfg = config.programs.desktop-file-utils; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.desktop-file-utils.install = lib.mkEnableOption ''
		Whether to install desktop-file-utils, command line utilities for working with .desktop files.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.desktop-file-utils;
}