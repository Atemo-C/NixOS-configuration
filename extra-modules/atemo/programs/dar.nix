{ config, lib, pkgs, ... }: let cfg = config.programs.dar; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.dar.install = lib.mkEnableOption ''
		Whether to install tha DAR Disk Archiver, allowing backing up files into indexed archives.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.dar;
}