{ config, lib, pkgs, ... }: let cfg = config.programs.gparted; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gparted.install = lib.mkEnableOption ''
		Whether to install GParted, a graphical disk partitioning tool.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.gparted;
}