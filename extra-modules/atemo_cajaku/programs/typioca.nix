{ config, lib, pkgs, ... }: let cfg = config.programs.typioca; in {
	options.programs.typioca.enable = lib.mkEnableOption "typioca, a cozy typing speed tester in terminal.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.typioca;
}