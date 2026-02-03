{ config, lib, pkgs, ... }: let cfg = config.programs.swaylock; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.swaylock.install = lib.mkEnableOption ''
		Whether to enable Swaylock, a screen/session locker for Wayland.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.swaylock;
}