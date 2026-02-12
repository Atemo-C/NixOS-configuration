{ config, lib, pkgs, ... }: let cfg = config.programs.libwebp; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.libwebp.install = lib.mkEnableOption ''
		Whether to install libwebp, tools and library for the WebP image format.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.libwebp;
}