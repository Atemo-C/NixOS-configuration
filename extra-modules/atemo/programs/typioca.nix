{ config, lib, pkgs, ... }: let cfg = config.programs.typioca; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.typioca.install = lib.mkEnableOption ''
		Whether to install Typioca, a cozy typing speed tester in the terminal.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.typioca;
}