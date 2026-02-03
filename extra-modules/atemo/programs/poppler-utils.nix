{ config, lib, pkgs, ... }: let cfg = config.programs.poppler-utils; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.poppler-utils.install = lib.mkEnableOption ''
		Whether to install the Poppler utils, a PDF rendering library.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.poppler-utils;
}