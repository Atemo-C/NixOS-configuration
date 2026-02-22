{ config, lib, pkgs, ... }: let cfg = config.programs.hydra-check; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.hydra-check.install = lib.mkEnableOption ''
		Whether to install hydra-check, a utility to check hydra for the build status of a package.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.hydra-check;
}