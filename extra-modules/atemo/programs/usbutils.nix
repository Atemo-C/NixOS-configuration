{ config, lib, pkgs, ... }: let cfg = config.programs.usbutils; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.usbutils.install = lib.mkEnableOption ''
		Whether to install usbutils, a suite of tools for working with USB devices, such as lsusb.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.usbutils;
}