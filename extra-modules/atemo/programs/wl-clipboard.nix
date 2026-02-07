{ config, lib, pkgs, ... }: let cfg = config.programs.wl-clipboard; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.wl-clipboard.install = lib.mkEnableOption ''
		Whether to enable wl-clipboard, command-line copy/paste utilities for Wayland.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.wl-clipboard;
}