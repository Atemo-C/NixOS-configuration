{ config, lib, pkgs, ... }: let cfg = config.programs.fd; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.fd.install = lib.mkEnableOption ''
		Whether to install fd, a simple, fast and user-friendly alternative to find.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.fd;
}