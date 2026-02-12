{ config, lib, pkgs, ... }: let cfg = config.programs.mission-center; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.mission-center.install = lib.mkEnableOption ''
		Whether to install Mission Center, a tool to monitor your CPU, Memomry, Disk, Network and GPU usage.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.mission-center;
}