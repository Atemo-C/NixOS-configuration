{ config, lib, pkgs, ... }: let cfg = config.programs.simple-scan; in {
	options.programs.simple-scan.enable = lib.mkEnableOption "Simple Scan, a simple scanning utility.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.simple-scan;
}