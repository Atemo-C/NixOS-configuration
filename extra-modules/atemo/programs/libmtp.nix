{ config, lib, pkgs, ... }: let cfg = config.programs.libmtp; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.libmtp.install = lib.mkEnableOption ''
		Whether to install libmtp, an implementation of Microsft's Media Transfer Protocol.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.libmtp;
}