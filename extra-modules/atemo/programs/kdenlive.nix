{ config, lib, pkgs, ... }: let cfg = config.programs.kdenlive; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.kdenlive.install = lib.mkEnableOption ''
		Whether to install Kdenlive, a free and open source video editor, based on MLT Framework and KDE Frameworks.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.kdePackages.kdenlive;
}