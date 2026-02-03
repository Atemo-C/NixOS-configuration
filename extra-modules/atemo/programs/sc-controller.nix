{ config, lib, pkgs, ... }: let cfg = config.programs.sc-controller; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.sc-controller.install = lib.mkEnableOption ''
		Whether to install sc-controller, a user-mode driver and GUI for Steam Controller and other controllers.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.sc-controller;
}