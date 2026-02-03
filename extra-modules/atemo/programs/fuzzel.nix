{ config, lib, pkgs, ... }: let cfg = config.programs.fuzzel; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.fuzzel.install = lib.mkEnableOption ''
		Whether to enable Fuzzel, a Wayland-native application launcher similar to rofi's drun mode.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.fuzzel;
}