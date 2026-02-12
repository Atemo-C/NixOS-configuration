{ config, lib, pkgs, ... }: let cfg = config.programs.libarchive; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.libarchive.install = lib.mkEnableOption ''
		Whether to install libarchive, a multi-format archive and compression library.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.libarchive;
}