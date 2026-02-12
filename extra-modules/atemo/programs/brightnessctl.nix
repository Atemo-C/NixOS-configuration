{ config, lib, pkgs, ... }: let cfg = config.programs.brightnessctl; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.brightnessctl.install = lib.mkEnableOption ''
		Whether to install brightnessctl, a program to read and control device brightness.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.brightnessctl;
}