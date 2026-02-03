{ config, lib, pkgs, ... }: let cfg = config.programs.keepassxc; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.keepassxc.install = lib.mkEnableOption ''
		Whether to install KeePassXC, an offline password manager with many features.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.keepassxc;
}