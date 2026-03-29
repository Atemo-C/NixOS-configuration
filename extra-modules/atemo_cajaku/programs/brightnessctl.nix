{ config, lib, pkgs, ... }: let cfg = config.programs.brightnessctl; in {
	options.programs.brightnessctl.enable = lib.mkEnableOption "brightnessctl, a utility to read and control device brightness.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.brightnessctl;
}