{ config, lib, pkgs, ... }: let cfg = config.programs.heroic; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.heroic.install = lib.mkEnableOption ''
		Whether to install Heroic, a native GOG, Epic, and Amazon Games Launcher for Linux, Windows and Mac.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.heroic;
}