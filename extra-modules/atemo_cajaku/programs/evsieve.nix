{ config, lib, pkgs, ... }: let cfg = config.programs.evsieve; in {
	options.programs.evsieve.enable = lib.mkEnableOption "evsieve, a utility for mapping events from Linux event devices.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.evsieve;
}