{ config, lib, pkgs, ... }: let cfg = config.programs.fileroller; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.fileroller.install = lib.mkEnableOption ''
		Whether to install File Roller, an archive manager for the GNOME desktop environment.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.file-roller;
}