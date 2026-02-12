{ config, lib, pkgs, ... }: let cfg = config.programs.libjxl; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.libjxl.install = lib.mkEnableOption ''
		Whether to install libjxl, the JPEG XL image format reference implementation.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.libjxl;
}