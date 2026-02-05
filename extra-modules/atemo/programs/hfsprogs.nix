{ config, lib, pkgs, ... }: let cfg = config.programs.hfsprogs; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.hfsprogs.install = lib.mkEnableOption ''
		Whether to install hfsprogs, HFS/HFS+ user space utils.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.hfsprogs;
}