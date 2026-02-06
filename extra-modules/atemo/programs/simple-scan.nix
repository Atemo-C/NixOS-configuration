{ config, lib, pkgs, ... }: let cfg = config.programs.simple-scan; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.simple-scan.install = lib.mkEnableOption ''
		Whether to install Simple Scan, a simple scanning utility.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.simple-scan;
}