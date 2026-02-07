{ config, lib, pkgs, ... }: let cfg = config.programs.p7zip; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.p7zip.install = lib.mkEnableOption ''
		Whether to install p7zip, a new p7zip fork with additional codecs and improvements (forked from https://sourceforge.net/projects/p7zip).
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.p7zip;
}