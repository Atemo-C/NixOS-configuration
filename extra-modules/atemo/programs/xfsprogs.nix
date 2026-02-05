{ config, lib, pkgs, ... }: let cfg = config.programs.xfsprogs; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.xfsprogs.install = lib.mkEnableOption ''
		Whether to install xfsprogs, SGI XFS utilities.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.xfsprogs;
}