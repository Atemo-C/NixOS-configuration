{ config, lib, pkgs, ... }: let cfg = config.programs.libgsf; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.libgsf.install = lib.mkEnableOption ''
		Whether to install libgsf, GNOME's Structured File Library.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.libgsf;
}