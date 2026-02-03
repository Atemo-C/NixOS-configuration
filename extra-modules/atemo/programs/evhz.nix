{ config, lib, pkgs, ... }: let cfg = config.programs.evhz; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.evhz.install = lib.mkEnableOption ''
		Whether to install evhz, an utility to show mouse refresh rate under Linux + evdev.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.evhz;
}