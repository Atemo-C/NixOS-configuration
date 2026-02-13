{ config, lib, pkgs, ... }: let cfg = config.programs.keypunch; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.keypunch.install = lib.mkEnableOption ''
		Whether to install Keypunch, a keyboard typing utility to practice your typing skills.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.keypunch;
}