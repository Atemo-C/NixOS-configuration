{ config, lib, pkgs, ... }: let cfg = config.programs.zenity; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.zenity.install = lib.mkEnableOption ''
		Whether to enable Zenity, a tool to display dialogs from the commandline and shell scripts.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.zenity;
}