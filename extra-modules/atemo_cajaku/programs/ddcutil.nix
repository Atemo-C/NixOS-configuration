{ config, lib, pkgs, ... }: let cfg = config.programs.ddcutil; in {
	options.programs.ddcutil.enable = lib.mkEnableOption "ddcutil, a utility to query and change Linux mointor settings using DDC/CI and USB.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.ddcutil;
}