{ config, lib, pkgs, ... }: let cfg = config.programs.exfatprogs; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.exfatprogs.install = lib.mkEnableOption ''
		Whether to install exfatprogs, exFAT filesystem userspace utilities.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.exfatprogs;
}