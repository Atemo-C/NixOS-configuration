{ config, lib, pkgs, ... }: let cfg = config.programs.poppler; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.poppler.install = lib.mkEnableOption ''
		Whether to install poppler, a PDF rendering library.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.poppler;
}