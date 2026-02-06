{ config, lib, pkgs, ... }: let cfg = config.programs.ddcutil; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.ddcutil.install = lib.mkEnableOption ''
		Whether to install ddcutil, a tool to query and change Linux monitor settings using DDC/CI and USB.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.ddcutil;
}