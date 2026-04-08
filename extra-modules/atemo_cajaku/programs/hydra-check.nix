{ config, lib, pkgs, ... }: let cfg = config.programs.hydra-check; in {
	options.programs.hydra-check.enable = lib.mkEnableOption "hydra-check, a utility to check hydra for the build status of a package.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.hydra-check;
}