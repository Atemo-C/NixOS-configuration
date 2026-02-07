{ config, lib, pkgs, ... }: let cfg = config.programs.webp-pixbuf-loader; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.webp-pixbuf-loader.install = lib.mkEnableOption ''
		Whether to install the WebP GTK Pixbuf Loader library.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.webp-pixbuf-loader;
}