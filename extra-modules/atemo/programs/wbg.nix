{ config, lib, pkgs, ... }: let cfg = config.programs.wbg; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.wbg.install = lib.mkEnableOption ''
		Whether to install wbg, a very minimalistic wallpaper application for Wayland compositors.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.wbg;
}