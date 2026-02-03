{ config, lib, pkgs, ... }: let cfg = config.programs.calcurse; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.calcurse.install = lib.mkEnableOption ''
		Whether to install Calcurse, a calendar and scheduling application for the command line.
	'';

	config.environment.systemPackages = lib.optional cfg.enable pkgs.calcurse;
}