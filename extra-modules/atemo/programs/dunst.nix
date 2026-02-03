{ config, lib, pkgs, ... }: let cfg = config.programs.dunst; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.dunst.install = lib.mkEnableOption ''
		Whether to enable Dunst, a lightweight and customizable notification daemon.
		Start it in your environment of choice by simply running `dunst` on startup.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.dunst;
}