{ config, lib, pkgs, ... }: let cfg = config.programs.element-desktop; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.element-desktop.install = lib.mkEnableOption ''
		Whether to install Element, a feature-rich client for Matrix.org.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.element-desktop;
}