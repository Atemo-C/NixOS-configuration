{ config, lib, pkgs, ... }: let cfg = config.programs.lshw; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.lshw.install = lib.mkEnableOption ''
		Whether to install lshw, a tool providing detailed information on the hardware configuration of the machine.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.lshw;
}