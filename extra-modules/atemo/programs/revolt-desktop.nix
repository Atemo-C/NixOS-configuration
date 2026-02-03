{ config, lib, pkgs, ... }: let cfg = config.programs.revolt-desktop; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.revolt-desktop.install = lib.mkEnableOption ''
		Whether to install Revolt, an open source user-first chat platform.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.revolt-desktop;
}