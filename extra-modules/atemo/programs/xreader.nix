{ config, lib, pkgs, ... }: let cfg = config.programs.xreader; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.xreader.install = lib.mkEnableOption ''
		Whether to install Xreader, a document viewer capable of displaying multiple and single page document formats like PDF and Postscript.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.xreader;
}