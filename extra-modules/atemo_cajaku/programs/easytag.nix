{ config, lib, pkgs, ... }: let cfg = config.programs.easytag; in {
	options.programs.easytag.enable = lib.mkEnableOption "EasyTag, a utility to view and edit tags for various audio files.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.easytag;
}