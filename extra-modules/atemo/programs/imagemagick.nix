{ config, lib, pkgs, ... }: let cfg = config.programs.imagemagick; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.imagemagick = {
		enable = lib.mkEnableOption ''
			Whether to enable ImageMagick, a software suite to create, edit, compose, or convert bitmap images.
		'';

		package = lib.mkPackageOption pkgs "imagemagick" {
			default = [ "imagemagick" ];
			example = [ "imagemagick6" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}