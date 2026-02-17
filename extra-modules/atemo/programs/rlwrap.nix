{ config, lib, pkgs, ... }: let cfg = config.programs.rlwrap; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.rlwrap.install = lib.mkEnableOption ''
		Whether to install rlwrap, a readline wrapper for console programs.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.rlwrap;
}