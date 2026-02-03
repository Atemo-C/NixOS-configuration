{ config, lib, pkgs, ... }: let cfg = config.programs.evsieve; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.evsieve.install = lib.mkEnableOption ''
		Whether to install evsieve, an utility for mapping events from Linux event devices.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.evsieve;
}