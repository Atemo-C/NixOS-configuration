{ config, lib, pkgs, ... }: let cfg = config.programs.cpu-x; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.cpu-x.install = lib.mkEnableOption ''
		Whether to install CPU-X, free software that gathers information on CPU, motherboard and more.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.cpu-x;
}