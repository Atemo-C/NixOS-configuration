{ config, lib, pkgs, ... }: let cfg = config.programs.gnome-epub-thumbnailer; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gnome-epub-thumbnailer.install = lib.mkEnableOption ''
		Whether to install gnome-epub-thumbnailer, a thumbnailer for EPub and MOBI books.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.gnome-epub-thumbnailer;
}