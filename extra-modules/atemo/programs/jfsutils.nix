{ config, lib, pkgs, ... }: let cfg = config.programs.jfsutils; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.jfsutils.install = lib.mkEnableOption ''
		Whether to install jfsutils, IBM JFS utilities.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.jfsutils;
}