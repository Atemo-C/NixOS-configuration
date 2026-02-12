{ config, lib, pkgs, ... }: let cfg = config.programs.wget; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.wget.install = lib.mkEnableOption ''
		Whether to install wget, a tool for retrieving files uing HTTP, HTTPS, and FTP.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.wget;
}