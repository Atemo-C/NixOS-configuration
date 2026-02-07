{ config, lib, pkgs, ... }: let cfg = config.programs.clipman; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.clipman.install = lib.mkEnableOption ''
		Whether to enable Clipman, a simple clipboard manager for Wayland.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.clipman;
}