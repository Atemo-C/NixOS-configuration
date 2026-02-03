{ config, lib, pkgs, ... }: let cfg = config.programs.dash; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.dash.install = lib.mkEnableOption ''
		Whether to install DASH, a POSIX-compliant implementation of /bin/sh that aims to be as small as possible.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.dash;
}