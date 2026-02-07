{ config, lib, pkgs, ... }: let cfg = config.programs.qtsvg; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.qtsvg = {
		enable = lib.mkEnableOption ''
			Whether to enable qtsvg, a cross-platform application framework for C++.
		'';

		package = lib.mkPackageOption pkgs "kdePackages.qtsvg" {
			default = [ "kdePackages.qtsvg" ];
			example = [ "libsForQt5.qt5.qtsvg" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}