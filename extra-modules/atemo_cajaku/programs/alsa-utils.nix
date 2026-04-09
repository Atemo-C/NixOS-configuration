{ config, lib, pkgs, ... }: let cfg = config.programs.alsa-utils; in {
	options.programs.alsa-utils.enable = lib.mkEnableOption "utilities for ALSA, the Advanced Linux Sound Architecture.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.alsa-utils;
}