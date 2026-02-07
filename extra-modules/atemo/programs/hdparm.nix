{ config, lib, pkgs, ... }: let cfg = config.programs.hdparm; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.hdparm.install = lib.mkEnableOption ''
		Whether to install hdparm, a tool to get/set ATA/SATA drive parameters under Linux.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.hdparm;
}