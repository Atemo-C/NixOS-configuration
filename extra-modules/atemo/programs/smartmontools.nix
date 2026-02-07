{ config, lib, pkgs, ... }: let cfg = config.programs.smartmontools; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.smartmontools.install = lib.mkEnableOption ''
		Whether to install Smartmontools, tools for monitoring the health of hard drives.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.smartmontools;
}