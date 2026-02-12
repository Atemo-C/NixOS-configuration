{ config, lib, pkgs, ... }: let cfg = config.programs.bc; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.bc.install = lib.mkEnableOption ''
		Whether to install bc, the GNU software calculator.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.bc;
}