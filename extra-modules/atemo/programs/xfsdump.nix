{ config, lib, pkgs, ... }: let cfg = config.programs.xfsdump; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.xfsdump.install = lib.mkEnableOption ''
		Whether to install xfsdump, an XFS filesystem incremental dump utility.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.xfsdump;
}