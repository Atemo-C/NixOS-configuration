{ config, lib, pkgs, ... }: let cfg = config.programs.libde265; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.libde265.install = lib.mkEnableOption ''
		Whether to install libde265, an open h.265 video codec implementation.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.libde265;
}