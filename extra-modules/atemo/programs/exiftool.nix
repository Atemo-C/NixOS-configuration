{ config, lib, pkgs, ... }: let cfg = config.programs.exiftool; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.exiftool.install = lib.mkEnableOption ''
		Whether to install exiftool, a tool to read, write, and edit EXIF meta information.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.exiftool;
}