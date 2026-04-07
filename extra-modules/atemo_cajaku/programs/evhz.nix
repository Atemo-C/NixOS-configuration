{ config, lib, pkgs, ... }: let cfg = config.programs.evhz; in {
	options.programs.evhz.enable = lib.mkEnableOption "evhz, a utility to show mouse refresh rate under Linux + evdev.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.evhz;
}