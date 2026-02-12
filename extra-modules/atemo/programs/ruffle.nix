{ config, lib, pkgs, ... }: let cfg = config.programs.ruffle; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.ruffle.install = lib.mkEnableOption ''
		Whether to install ruffle, a cross platform Adobe Flash Player emulator.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.ruffle;
}