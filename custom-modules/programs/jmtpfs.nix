{ config, lib, pkgs, ... }: let cfg = config.programs.jmtpfs; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.jmtpfs = {
		enable = lib.mkEnableOption ''
			Whether to install jmtpfs, a FUSE filesystem for MTP devices like Android phones.
		'';

		package = lib.mkPackageOption pkgs "jmtpfs" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}