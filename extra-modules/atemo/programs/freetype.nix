{ config, lib, pkgs, ... }: let cfg = config.programs.freetype; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.freetype.install = lib.mkEnableOption ''
		Whether to install FreeType, a font rendering engine.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.freetype;
}