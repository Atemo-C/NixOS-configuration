{ config, lib, pkgs, ... }: let cfg = config.programs.gcolor3; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gcolor3.install = lib.mkEnableOption ''
		Whether to install Gcolor3, a simple color chooser written in GTK3.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.gcolor3;
}