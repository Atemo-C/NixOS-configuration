{ config, lib, pkgs, ... }: let cfg = config.programs.swayidle; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.swayidle.install = lib.mkEnableOption ''
		Whether to install Swayidle, an idle management daemon for Wayland.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.swayidle;
}