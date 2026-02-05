{ config, lib, pkgs, ... }: let cfg = config.programs.lsd; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.lsd.install = lib.mkEnableOption ''
		Whether to install LSD, the next-generation `ls` command.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.lsd;
}