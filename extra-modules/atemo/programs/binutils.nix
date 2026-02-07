{ config, lib, pkgs, ... }: let cfg = config.programs.binutils; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.binutils.install = lib.mkEnableOption ''
		Whether to install binutils, tools for manipulating binaries (linker, assembler, etc). (wrapper script)
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.binutils;
}