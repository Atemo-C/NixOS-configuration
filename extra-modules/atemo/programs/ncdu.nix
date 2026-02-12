{ config, lib, pkgs, ... }: let cfg = config.programs.ncdu; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.ncdu.install = lib.mkEnableOption ''
		Whether to install ncdu, a disk usage analyzer with an ncurses interface.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.ncdu;
}