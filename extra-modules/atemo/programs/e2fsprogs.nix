{ config, lib, pkgs, ... }: let cfg = config.programs.e2fsprogs; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.e2fsprogs.install = lib.mkEnableOption ''
		Whether to install e2fsprogs, tools for creating and checking ext2/ext3/ext4 filesystems.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.e2fsprogs;
}