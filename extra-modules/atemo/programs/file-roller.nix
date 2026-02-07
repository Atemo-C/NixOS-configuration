{ config, lib, pkgs, ... }: let cfg = config.programs.file-roller; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.file-roller.install = lib.mkEnableOption ''
		Whether to install File Roller, an archive manager for the GNOME desktop environment.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.file-roller;
}