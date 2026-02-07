{ config, lib, pkgs, ... }: let cfg = config.programs.lzop; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.lzop.install = lib.mkEnableOption ''
		Whether to install lzop, a fast file compressor.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.lzop;
}