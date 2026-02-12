{ config, lib, pkgs, ... }: let cfg = config.programs.lz4; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.lz4.install = lib.mkEnableOption ''
		Whether to install lz4, an extremely fast compression algorithm.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.lz4;
}