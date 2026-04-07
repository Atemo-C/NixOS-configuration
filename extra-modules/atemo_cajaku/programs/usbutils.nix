{ config, lib, pkgs, ... }: let cfg = config.programs.usbutils; in {
	options.programs.usbutils.enable = lib.mkEnableOption "usbutils, a collection of tools for working with USB devices, such as lsusb.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.usbutils;
}