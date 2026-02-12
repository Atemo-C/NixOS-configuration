{ config, lib, pkgs, ... }: let cfg = config.programs.minder; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.minder.install = lib.mkEnableOption ''
		Whether to install Minder, a mind-mapping application for elementary OS.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.minder;
}