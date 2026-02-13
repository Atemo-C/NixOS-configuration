{ config, lib, pkgs, ... }: let cfg = config.programs.trashy; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.trashy.install = lib.mkEnableOption ''
		Whether to install Trashy, a simple, fast, and featureful alternative to rm and trash-cli.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.trashy;
}