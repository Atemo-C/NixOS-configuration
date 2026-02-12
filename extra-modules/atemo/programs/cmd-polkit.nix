{ config, lib, pkgs, ... }: let cfg = config.programs.cmd-polkit; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.cmd-polkit.install = lib.mkEnableOption ''
		Whether to install cmd-polkit, a utility to easily create Polkit authentication agents by using commands.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.cmd-polkit;
}