{ config, lib, pkgs, ... }: let cfg = config.programs.noctalia-shell; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.noctalia-shell.install = lib.mkEnableOption ''
		Whether to install the Noctalia Shell, a sleek and minimal desktop shell thoughtfully crafted for Wayland, built with Quickshell.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.noctalia-shell;
}