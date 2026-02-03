{ config, lib, pkgs, ... }: let cfg = config.programs.gallery-dl; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gallery-dl.install = lib.mkEnableOption ''
		Whether to install gallery-dl, a command-line program to download image-galleries and collections from several image hosting sites.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.gallery-dl;
}