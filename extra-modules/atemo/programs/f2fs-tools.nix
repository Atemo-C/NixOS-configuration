{ config, lib, pkgs, ... }: let cfg = config.programs.f2fs-tools; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.f2fs-tools.install = lib.mkEnableOption ''
		Whether to install f2fs-tools, userland tools for the f2fs filesystem.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.f2fs-tools;
}