{ config, lib, pkgs, ... }: let cfg = config.programs.lzip; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.lzip.install = lib.mkEnableOption ''
		Whether to install lzip, a lossless data compressor based on the LZMA algorithm.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.lzip;
}