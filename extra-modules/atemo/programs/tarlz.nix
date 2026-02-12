{ config, lib, pkgs, ... }: let cfg = config.programs.tarlz; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.tarlz.install = lib.mkEnableOption ''
		Whether to install tarlz, a massively parallel combined implementation of the tar archiver and the lzip compressor.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.tarlz;
}