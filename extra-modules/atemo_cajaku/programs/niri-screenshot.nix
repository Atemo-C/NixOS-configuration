{ config, lib, pkgs, ... }: let cfg = config.programs.niri-screenshot; in {
	options.programs.niri-screenshot.enable = lib.mkEnableOption "the niri-screenshot utility, a small shell script to enhance Niri's built-in screenshot utility.";

	config.imports = lib.optional cfg.enable ../packages/niri-screenshot.nix;
}