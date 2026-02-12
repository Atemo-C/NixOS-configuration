{ config, lib, pkgs, ... }: let cfg = config.programs.gucharmap; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gucharmap.install = lib.mkEnableOption ''
		Whether to install Gucharmap, the GNOME Character Map, based on the Unicode Character Database.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.gucharmap;
}