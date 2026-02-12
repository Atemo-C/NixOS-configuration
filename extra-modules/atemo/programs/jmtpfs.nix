{ config, lib, pkgs, ... }: let cfg = config.programs.jmtpfs; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.jmtpfs.install = lib.mkEnableOption ''
		Whether to install jmtpfs, a FUSE filesystem for MTP devices like Android phones.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.jmtpfs;
}