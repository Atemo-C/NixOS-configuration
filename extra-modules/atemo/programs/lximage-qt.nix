{ config, lib, pkgs, ... }: let cfg = config.programs.lximage-qt; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.lximage-qt.install = lib.mkEnableOption ''
		Whether to install LXmage-Qt, an image viewer and screenshot tool for lxqt.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.lxqt.lximage-qt;
}