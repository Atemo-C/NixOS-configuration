{ config, lib, pkgs, ... }: let cfg = config.programs.kimageformats; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.kimageformats.install = lib.mkEnableOption ''
		Whether to install kimageformats, additional image formats provided by KDE.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.kdePackages.kimageformats;
}