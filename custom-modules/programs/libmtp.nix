{ config, lib, pkgs, ... }: let cfg = config.programs.libmtp; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.libmtp = {
		enable = lib.mkEnableOption ''
			Whether to install libmtp, an implementation of Microsoft's Media Transfer Protocol.
		'';

		package = lib.mkPackageOption pkgs "libmtp" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}