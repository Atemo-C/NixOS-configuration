{ config, lib, pkgs, ... }: let cfg = config.programs.mprime; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.mprime.install = lib.mkEnableOption ''
		Whether to install Mprime, a persenne prime search / System stability tester.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.mprime;
}