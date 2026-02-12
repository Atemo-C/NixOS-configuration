{ config, lib, pkgs, ... }: let cfg = config.programs.audacity; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.audacity.install = lib.mkEnableOption ''
		Whether to install Audacity, a sound editor with graphical UI.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.audacity;
}