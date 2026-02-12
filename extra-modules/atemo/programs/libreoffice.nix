{ config, lib, pkgs, ... }: let cfg = config.programs.libreoffice; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.libreoffice = {
		enable = lib.mkEnableOption ''
			Whether to enable LibreOffice, a comprehensive, professional-quality productivity suite, a variant of openoffice.org, itself of the old StarOffice.
		'';

		package = lib.mkPackageOption pkgs "libreoffice" {
			default = [ "libreoffice" ];
			example = [ "libreoffice-fresh" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}