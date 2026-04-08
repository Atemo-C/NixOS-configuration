{ config, lib, pkgs, ... }: let cfg = config.programs.lz4; in {
	options.programs.lz4.enable = lib.mkEnableOption "lz4, an extremely fast compression algorithm.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.lz4;
}