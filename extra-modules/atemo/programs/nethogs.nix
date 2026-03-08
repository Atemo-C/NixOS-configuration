{ config, lib, pkgs, ... }: let cfg = config.programs.nethogs; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.nethogs.install = lib.mkEnableOption ''
		Whether to install nethogs, a small 'net top' tool, grouping bandwidth by proces.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.nethogs;
}