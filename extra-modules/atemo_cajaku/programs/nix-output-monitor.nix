{ config, lib, pkgs, ... }: let cfg = config.programs.nix-output-monitor; in {
	options.programs.nix-output-monitor.enable = lib.mkEnableOption "nix-output-monitor, a utility that processes output of Nix commands to show helpful and pretty information.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.nix-output-monitor;
}