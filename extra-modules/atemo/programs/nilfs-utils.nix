{ config, lib, pkgs, ... }: let cfg = config.programs.nilfs-utils; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.nilfs-utils.install = lib.mkEnableOption ''
		Whether to install nilfs-utils, NILFS utilities.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.nilfs-utils;
}